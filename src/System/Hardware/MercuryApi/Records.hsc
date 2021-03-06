{-# LANGUAGE OverloadedStrings, FlexibleInstances, DeriveDataTypeable #-}
module System.Hardware.MercuryApi.Records where

import Control.Applicative ( Applicative((<*>)), (<$>) )
import Control.Exception ( Exception, throwIO )
import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Data.Maybe ( mapMaybe, fromMaybe )
import Data.Monoid ( (<>) )
import Data.Text (Text)
import qualified Data.Text as T ( pack )
import qualified Data.Text.Encoding as T
    ( encodeUtf8, decodeUtf8With )
import qualified Data.Text.Encoding.Error as T ( lenientDecode )
import Data.Typeable ( Typeable )
import Data.Word ( Word8, Word16, Word32, Word64 )
import Foreign
    ( Int32,
      Ptr,
      nullPtr,
      plusPtr,
      Storable(alignment, peek, peekByteOff, poke, pokeByteOff, sizeOf),
      Bits((.&.), (.|.), shiftL),
      castPtr,
      with,
      toBool,
      fromBool,
      withArrayLen,
      pokeArray,
      peekArray,
      copyArray,
      allocaArray )
import Foreign.C ( CString )

import System.Hardware.MercuryApi.Enums

#include <tm_reader.h>
#include <glue.h>
#include <stdbool.h>

-- | A GPIO pin number.  On the M6e Nano, these are numbered 1-4.
type PinNumber = Word8

-- | An antenna number.  On the
-- <https://www.sparkfun.com/products/14066 SparkFun Simultaneous RFID Reader>,
-- there is a single antenna with the number 1.
type AntennaPort = Word8

-- | A 32-bit password (access or kill) in the Gen2 protocol.
type GEN2_Password = Word32

-- | milliseconds since 1\/1\/1970 UTC
type MillisecondsSinceEpoch = Word64

-- | Version number of the Mercury API C library.
apiVersion :: Text
apiVersion = #{const_str TMR_VERSION}

type CBool = #{type bool}
newtype ReaderEtc = ReaderEtc ()

cFalse, cTrue :: CBool
cFalse = 0
cTrue = 1

toBool' :: CBool -> Bool
toBool' = toBool

fromBool' :: Bool -> CBool
fromBool' = fromBool

sizeofReaderEtc :: Int
sizeofReaderEtc = #{size ReaderEtc}

uriPtr :: Ptr ReaderEtc -> CString
uriPtr = #{ptr ReaderEtc, uri}

-- I'm not sure what encoding MercuryApi uses for its strings.
-- I'm guessing UTF-8 for now, but the encoding is encapsulated in
-- these two functions (textFromBS and textToBS) so it can be
-- easily changed.
textFromBS :: ByteString -> Text
textFromBS = T.decodeUtf8With T.lenientDecode

textToBS :: Text -> ByteString
textToBS = T.encodeUtf8

textFromCString :: CString -> IO Text
textFromCString cs = textFromBS <$> B.packCString cs

-- | Indicates whether to read or write the lock bits in
-- 'TagOp_GEN2_BlockPermaLock'.
data ReadWrite = Read !Int       -- ^ number of words of lock bits to read
               | Write ![Word16] -- ^ lock bits to write
               deriving (Eq, Ord, Show, Read)

fromReadWrite :: ReadWrite -> (Word8, [Word16])
fromReadWrite (Read n) = (0, replicate n 0)
fromReadWrite (Write ws) = (1, ws)

toReadWrite :: (Word8, [Word16]) -> ReadWrite
toReadWrite (0, ws) = Read $ length ws
toReadWrite (1, ws) = Write ws
toReadWrite (x, _)  = error $ "didn't expect ReadWrite to be " ++ show x

-- This exception is never seen by the user.  It is caught
-- internally and turned into a MercuryException (with some added fields).
data ParamException = ParamException StatusType Status Text
  deriving (Eq, Ord, Show, Read, Typeable)

instance Exception ParamException

castLen' :: Integral a => a -> Text -> Int -> IO a
castLen' bound description x = do
  let tShow = T.pack . show
      maxLen = fromIntegral bound
  if x > maxLen
    then throwIO ( ParamException ERROR_TYPE_MISC ERROR_TOO_BIG $
                   description <> " had length " <> tShow x <>
                   " but maximum is " <> tShow maxLen )
    else return $ fromIntegral x

castLen :: (Integral a, Bounded a) => Text -> Int -> IO a
castLen = castLen' maxBound

-- | A ReadPlan record specifies the antennas, protocols, and filters
-- to use for a search (read).
--
-- Currently, only @SimpleReadPlan@ is supported.
data ReadPlan =
  SimpleReadPlan
  { rpWeight        :: !Word32          -- ^ The relative weight of this read plan
  , rpEnableAutonomousRead :: !Bool     -- ^ Option for Autonomous read
  , rpAntennas      :: ![AntennaPort]   -- ^ The list of antennas to read on
  , rpProtocol      :: !TagProtocol     -- ^ The protocol to use for reading
  , rpFilter        :: !(Maybe TagFilter) -- ^ The filter to apply to reading
  , rpTagop         :: !(Maybe TagOp)   -- ^ The tag operation to apply to
                                        -- each read tag
  , rpUseFastSearch :: !Bool            -- ^ Option to use the FastSearch
  , rpStopOnCount   :: !(Maybe Word32)  -- ^ Number of tags to be read
  , rpTriggerRead   :: !(Maybe [Word8]) -- ^ The list of GPI ports which should
                                        -- be used to trigger the read
  } deriving (Eq, Ord, Show, Read)

antennasInfo :: Ptr ReadPlan -> (Ptr List16, Word16, Ptr Word8, Text)
antennasInfo rp =
  ( #{ptr ReadPlanEtc, plan.u.simple.antennas} rp
  , #{const GLUE_MAX_ANTENNAS}
  , #{ptr ReadPlanEtc, antennas} rp
  , "rpAntennas"
  )

gpiListInfo :: Ptr ReadPlan -> (Ptr List16, Word16, Ptr Word8, Text)
gpiListInfo rp =
  ( #{ptr ReadPlanEtc, plan.u.simple.triggerRead.gpiList} rp
  , #{const GLUE_MAX_GPIPORTS}
  , #{ptr ReadPlanEtc, gpiPorts} rp
  , "rpTriggerRead"
  )

readPlanTypeSimple :: #{type TMR_ReadPlanType}
readPlanTypeSimple = #{const TMR_READ_PLAN_TYPE_SIMPLE}

instance Storable ReadPlan where
  sizeOf _ = #{size ReadPlanEtc}
  alignment _ = 8

  poke p x = do
    #{poke ReadPlanEtc, plan.type} p readPlanTypeSimple
    #{poke ReadPlanEtc, plan.weight} p (rpWeight x)
    #{poke ReadPlanEtc, plan.enableAutonomousRead} p
      (fromBool' $ rpEnableAutonomousRead x)
    pokeList16 (antennasInfo p) (rpAntennas x)
    #{poke ReadPlanEtc, plan.u.simple.protocol} p
      (fromTagProtocol $ rpProtocol x)
    case rpFilter x of
      Nothing -> #{poke ReadPlanEtc, plan.u.simple.filter} p nullPtr
      Just f -> do
        #{poke ReadPlanEtc, filter} p f
        #{poke ReadPlanEtc, plan.u.simple.filter} p (#{ptr ReadPlanEtc, filter} p)
    case rpTagop x of
      Nothing -> #{poke ReadPlanEtc, plan.u.simple.tagop} p nullPtr
      Just op -> do
        #{poke ReadPlanEtc, tagop} p op
        #{poke ReadPlanEtc, plan.u.simple.tagop} p (#{ptr ReadPlanEtc, tagop} p)
    #{poke ReadPlanEtc, plan.u.simple.useFastSearch} p
      (fromBool' $ rpUseFastSearch x)
    let (stop, nTags) = case rpStopOnCount x of
                          Nothing -> (cFalse, 0)
                          Just n -> (cTrue, n)
    #{poke ReadPlanEtc, plan.u.simple.stopOnCount.stopNTriggerStatus} p stop
    #{poke ReadPlanEtc, plan.u.simple.stopOnCount.noOfTags} p nTags
    let (enable, ports) = case rpTriggerRead x of
                            Nothing -> (cFalse, [])
                            Just ps -> (cTrue, ps)
    #{poke ReadPlanEtc, plan.u.simple.triggerRead.enable} p enable
    pokeList16 (gpiListInfo p) ports

  peek p = do
    weight <- #{peek ReadPlanEtc, plan.weight} p
    enableAutonomousRead <- #{peek ReadPlanEtc, plan.enableAutonomousRead} p
    antennas <- peekList16 (antennasInfo p)
    protocol <- #{peek ReadPlanEtc, plan.u.simple.protocol} p
    fPtr <- #{peek ReadPlanEtc, plan.u.simple.filter} p
    filt <- if fPtr == nullPtr
            then return Nothing
            else Just <$> peek fPtr
    opPtr <- #{peek ReadPlanEtc, plan.u.simple.tagop} p
    op <- if opPtr == nullPtr
          then return Nothing
          else Just <$> peek opPtr
    useFastSearch <- #{peek ReadPlanEtc, plan.u.simple.useFastSearch} p
    stop <- #{peek ReadPlanEtc, plan.u.simple.stopOnCount.stopNTriggerStatus} p
    stopOnCount <- if toBool' stop
                   then Just <$> #{peek ReadPlanEtc, plan.u.simple.stopOnCount.noOfTags} p
                   else return Nothing
    enable <- #{peek ReadPlanEtc, plan.u.simple.triggerRead.enable} p
    triggerRead <- if toBool' enable
                   then Just <$> peekList16 (gpiListInfo p)
                   else return Nothing
    return $ SimpleReadPlan
      { rpWeight = weight
      , rpEnableAutonomousRead = toBool' enableAutonomousRead
      , rpAntennas = antennas
      , rpProtocol = toTagProtocol protocol
      , rpFilter = filt
      , rpTagop = op
      , rpUseFastSearch = toBool' useFastSearch
      , rpStopOnCount = stopOnCount
      , rpTriggerRead = triggerRead
      }

-- | Filter on EPC length, or on a Gen2 bank.
data FilterOn = FilterOnBank GEN2_Bank
              | FilterOnEpcLength
              deriving (Eq, Ord, Show, Read)

instance Storable FilterOn where
  sizeOf _ = #{size TMR_GEN2_Bank}
  alignment _ = 8

  poke p FilterOnEpcLength = do
    let p' = castPtr p :: Ptr RawBank
    poke p' #{const TMR_GEN2_EPC_LENGTH_FILTER}

  poke p (FilterOnBank bank) = do
    let p' = castPtr p :: Ptr RawBank
    poke p' (fromBank bank)

  peek p = do
    x <- peek (castPtr p)
    if x == #{const TMR_GEN2_EPC_LENGTH_FILTER}
      then return FilterOnEpcLength
      else return $ FilterOnBank $ toBank x

-- | Filter on EPC data, or on Gen2-specific information.
data TagFilter = TagFilterEPC TagData
               | TagFilterGen2
               { tfInvert        :: !Bool        -- ^ Whether to invert the
                                                 -- selection (deselect tags
                                                 -- that meet the comparison)
               , tfFilterOn      :: !FilterOn    -- ^ The memory bank in which
                                                 -- to compare the mask
               , tfBitPointer    :: !Word32      -- ^ The location (in bits) at
                                                 -- which to begin comparing
                                                 -- the mask
               , tfMaskBitLength :: !Word16      -- ^ The length (in bits) of
                                                 -- the mask
               , tfMask          :: !ByteString  -- ^ The mask value to compare
                                                 -- with the specified region
                                                 -- of tag memory, MSB first
               }
               deriving (Eq, Ord, Show, Read)

instance Storable TagFilter where
  sizeOf _ = #{size TagFilterEtc}
  alignment _ = 8

  poke p (TagFilterEPC td) = do
    #{poke TagFilterEtc, filter.type} p
      (#{const TMR_FILTER_TYPE_TAG_DATA} :: #{type TMR_FilterType})
    #{poke TagFilterEtc, filter.u.tagData} p td

  poke p tf@(TagFilterGen2 {}) = do
    #{poke TagFilterEtc, filter.type} p
      (#{const TMR_FILTER_TYPE_GEN2_SELECT} :: #{type TMR_FilterType})
    #{poke TagFilterEtc, filter.u.gen2Select.invert} p (fromBool' $ tfInvert tf)
    #{poke TagFilterEtc, filter.u.gen2Select.bank} p (tfFilterOn tf)
    #{poke TagFilterEtc, filter.u.gen2Select.bitPointer} p (tfBitPointer tf)
    #{poke TagFilterEtc, filter.u.gen2Select.maskBitLength} p (tfMaskBitLength tf)
    let maskLenBytes = fromIntegral $ (tfMaskBitLength tf + 7) `div` 8
        origLen = B.length (tfMask tf)
        bs = if origLen < maskLenBytes
               then tfMask tf <> B.pack (replicate (maskLenBytes - origLen) 0)
               else tfMask tf
    B.useAsCStringLen bs $ \(cs, len) -> do
      len' <- castLen' #{const GLUE_MAX_MASK} "tfMask" len
      copyArray (#{ptr TagFilterEtc, mask} p) cs (fromIntegral len')
    #{poke TagFilterEtc, filter.u.gen2Select.mask} p (#{ptr TagFilterEtc, mask} p)

  peek p = do
    ft <- #{peek TagFilterEtc, filter.type} p :: IO #{type TMR_FilterType}
    case ft of
      #{const TMR_FILTER_TYPE_TAG_DATA} ->
        TagFilterEPC <$> #{peek TagFilterEtc, filter.u.tagData} p
      #{const TMR_FILTER_TYPE_GEN2_SELECT} -> do
        bitLength <- #{peek TagFilterEtc, filter.u.gen2Select.maskBitLength} p
        TagFilterGen2
          <$> (toBool' <$> #{peek TagFilterEtc, filter.u.gen2Select.invert} p)
          <*> #{peek TagFilterEtc, filter.u.gen2Select.bank} p
          <*> #{peek TagFilterEtc, filter.u.gen2Select.bitPointer} p
          <*> return bitLength
          <*> peekMask p bitLength

peekMask :: Ptr TagFilter -> Word16 -> IO ByteString
peekMask p bitLength = do
  let len = fromIntegral $ (bitLength + 7) `div` 8
  maskPtr <- #{peek TagFilterEtc, filter.u.gen2Select.mask} p
  B.packCStringLen (maskPtr, len)

packBits :: Num b => (a -> b) -> [a] -> b
packBits from flags = sum $ map from flags

unpackBits :: (Bounded a, Enum a, Num b, Bits b) => (a -> b) -> b -> [a]
unpackBits from x = mapMaybe f [minBound..maxBound]
  where f flag = if (x .&. from flag) == 0
                 then Nothing
                 else Just flag

packFlags :: [MetadataFlag] -> RawMetadataFlag
packFlags = packBits fromMetadataFlag

unpackFlags :: RawMetadataFlag -> [MetadataFlag]
unpackFlags = unpackBits fromMetadataFlag

packFlags16 :: [MetadataFlag] -> Word16
packFlags16 = fromIntegral . packFlags

unpackFlags16 :: Word16 -> [MetadataFlag]
unpackFlags16 = unpackFlags . fromIntegral

packExtraBanks :: [GEN2_Bank] -> RawBank
packExtraBanks = packBits fromExtraBank

unpackExtraBanks :: RawBank -> [GEN2_Bank]
unpackExtraBanks = unpackBits fromExtraBank

packLockBits :: [GEN2_LockBits] -> RawLockBits
packLockBits = packBits fromLockBits

unpackLockBits :: RawLockBits -> [GEN2_LockBits]
unpackLockBits = unpackBits fromLockBits

packLockBits16 :: [GEN2_LockBits] -> Word16
packLockBits16 = fromIntegral . packLockBits

unpackLockBits16 :: Word16 -> [GEN2_LockBits]
unpackLockBits16 = unpackLockBits . fromIntegral

peekArrayAsByteString :: Ptr Word8 -> Ptr Word8 -> IO ByteString
peekArrayAsByteString arrayPtr lenPtr = do
  len <- peek lenPtr
  B.packCStringLen (castPtr arrayPtr, fromIntegral len)

pokeArrayAsByteString :: Text
                      -> Word8
                      -> Ptr Word8
                      -> Ptr Word8
                      -> ByteString
                      -> IO ()
pokeArrayAsByteString desc maxLen arrayPtr lenPtr bs = do
  B.useAsCStringLen bs $ \(cs, len) -> do
    len' <- castLen' maxLen desc len
    copyArray arrayPtr (castPtr cs) (fromIntegral len')
    poke lenPtr len'

peekListAsByteString :: Ptr List16 -> IO ByteString
peekListAsByteString listPtr = do
  lst <- peek listPtr
  B.packCStringLen (castPtr $ l16_list lst, fromIntegral $ l16_len lst)

peekArrayAsList :: Storable a => Ptr a -> Ptr Word8 -> IO [a]
peekArrayAsList arrayPtr lenPtr = do
  len <- peek lenPtr
  peekArray (fromIntegral len) arrayPtr

peekListAsList :: Storable a => Ptr List16 -> Ptr a -> IO [a]
peekListAsList listPtr _ = do
  lst <- peek listPtr
  peekArray (fromIntegral $ l16_len lst) (castPtr $ l16_list lst)

pokeListAsList :: Storable a
               => Text
               -> Word16
               -> Ptr List16
               -> Ptr a
               -> [a]
               -> IO ()
pokeListAsList desc maxLen listPtr storage xs = do
  withArrayLen xs $ \len tmpPtr -> do
    len' <- castLen' maxLen desc len
    copyArray storage tmpPtr len
    let lst = List16
              { l16_list = castPtr storage
              , l16_max = maxLen
              , l16_len = len'
              }
    poke listPtr lst

peekMaybe :: (Storable a, Storable b)
          => (Ptr a -> IO a)
          -> (b -> Bool)
          -> Ptr a
          -> Ptr b
          -> IO (Maybe a)
peekMaybe oldPeek cond justP condP = do
  c <- peek condP
  if cond c
    then Just <$> oldPeek justP
    else return Nothing

pokeGen2TagData :: Ptr GEN2_TagData
                -> Ptr RawTagProtocol
                -> Maybe GEN2_TagData
                -> IO ()
pokeGen2TagData pGen2 _ mGen2 = do
  let gen2 = fromMaybe (GEN2_TagData B.empty) mGen2
  poke pGen2 gen2

peekSplit64 :: Ptr Word32 -> Ptr Word32 -> IO Word64
peekSplit64 pLow pHigh = do
  lo <- fromIntegral <$> peek pLow
  hi <- fromIntegral <$> peek pHigh
  return $ lo .|. (hi `shiftL` 32)

peekPtr :: Storable a => Ptr (Ptr a) -> Ptr a -> IO a
peekPtr pp _ = do
  p <- peek pp
  peek p

pokePtr :: Storable a => Ptr (Ptr a) -> Ptr a -> a -> IO ()
pokePtr pp p x = do
  poke p x
  poke pp p

pokeOr :: (Storable a, Bits a) => Ptr a -> a -> IO ()
pokeOr p x = do
  old <- peek p
  poke p (x .|. old)

data List16 =
  List16
  { l16_list :: !(Ptr ())
  , l16_max :: !(Word16)
  , l16_len :: !(Word16)
  }

instance Storable List16 where
  sizeOf _ = #{size List16}
  alignment _ = 8
  peek p = List16
           <$> #{peek List16, list} p
           <*> #{peek List16, max} p
           <*> #{peek List16, len} p
  poke p x = do
    #{poke List16, list} p (l16_list x)
    #{poke List16, max} p (l16_max x)
    #{poke List16, len} p (l16_len x)

getList16 :: Storable a => (Ptr () -> IO ()) -> IO [a]
getList16 f = do
  let maxLen = maxBound :: Word16
  allocaArray (fromIntegral maxLen) $ \storage -> do
    let lst = List16
              { l16_list = castPtr storage
              , l16_max = maxLen
              , l16_len = 0
              }
    with lst $ \p -> do
      f (castPtr p)
      lst' <- peek p
      peekArray (fromIntegral (l16_len lst')) storage

setList16 :: Storable a => Text -> [a] -> (Ptr () -> IO ()) -> IO ()
setList16 t x f = do
  withArrayLen x $ \len storage -> do
    len' <- castLen t len
    let lst = List16
              { l16_list = castPtr storage
              , l16_max = len'
              , l16_len = len'
              }
    with lst $ \p -> f (castPtr p)

pokeList16 :: Storable a => (Ptr List16, Word16, Ptr a, Text) -> [a] -> IO ()
pokeList16 (lp, maxLen, storage, name) ws = do
  len <- castLen' maxLen name (length ws)
  poke lp $ List16
    { l16_list = castPtr storage
    , l16_max = maxLen
    , l16_len = len
    }
  pokeArray storage ws

peekList16 :: Storable a => (Ptr List16, Word16, Ptr a, Text) -> IO [a]
peekList16 (lp, _, _, _) = do
  lst <- peek lp
  peekArray (fromIntegral $ l16_len lst) (castPtr $ l16_list lst)

data List8 =
  List8
  { l8_list :: !(Ptr ())
  , l8_max :: !(Word8)
  , l8_len :: !(Word8)
  }

instance Storable List8 where
  sizeOf _ = #{size List8}
  alignment _ = 8
  peek p = List8
           <$> #{peek List8, list} p
           <*> #{peek List8, max} p
           <*> #{peek List8, len} p
  poke p x = do
    #{poke List8, list} p (l8_list x)
    #{poke List8, max} p (l8_max x)
    #{poke List8, len} p (l8_len x)

getList8 :: Storable a => (Ptr () -> IO ()) -> IO [a]
getList8 f = do
  let maxLen = maxBound :: Word8
  allocaArray (fromIntegral maxLen) $ \storage -> do
    let lst = List8
              { l8_list = castPtr storage
              , l8_max = maxLen
              , l8_len = 0
              }
    with lst $ \p -> do
      f (castPtr p)
      lst' <- peek p
      peekArray (fromIntegral (l8_len lst')) storage

setList8 :: Storable a => Text -> [a] -> (Ptr () -> IO ()) -> IO ()
setList8 t x f = do
  withArrayLen x $ \len storage -> do
    len' <- castLen t len
    let lst = List8
              { l8_list = castPtr storage
              , l8_max = len'
              , l8_len = len'
              }
    with lst $ \p -> f (castPtr p)

pokeList8 :: Storable a => (Ptr List8, Word8, Ptr a, Text) -> [a] -> IO ()
pokeList8 (lp, maxLen, storage, name) ws = do
  len <- castLen' maxLen name (length ws)
  poke lp $ List8
    { l8_list = castPtr storage
    , l8_max = maxLen
    , l8_len = len
    }
  pokeArray storage ws

peekList8 :: Storable a => (Ptr List8, Word8, Ptr a, Text) -> IO [a]
peekList8 (lp, _, _, _) = do
  lst <- peek lp
  peekArray (fromIntegral $ l8_len lst) (castPtr $ l8_list lst)

-- | Gen2-specific per-tag data
newtype GEN2_TagData =
  GEN2_TagData
  { g2Pc :: ByteString -- ^ Tag PC
  } deriving (Eq, Ord, Show, Read)

instance Storable GEN2_TagData where
  sizeOf _ = #{size TMR_GEN2_TagData}
  alignment _ = 8

  peek p =
    GEN2_TagData
      <$> peekArrayAsByteString (#{ptr TMR_GEN2_TagData, pc} p) (#{ptr TMR_GEN2_TagData, pcByteCount} p)

  poke p x = do
    pokeArrayAsByteString "pc" #{const TMR_GEN2_MAX_PC_BYTE_COUNT} (#{ptr TMR_GEN2_TagData, pc} p) (#{ptr TMR_GEN2_TagData, pcByteCount} p) (g2Pc x)

-- | A record to represent RFID tags.
data TagData =
  TagData
  { tdEpc :: !ByteString -- ^ Tag EPC
  , tdProtocol :: !TagProtocol -- ^ Protocol of the tag
  , tdCrc :: !Word16 -- ^ Tag CRC
  , tdGen2 :: !(Maybe (GEN2_TagData)) -- ^ Gen2-specific tag information
  } deriving (Eq, Ord, Show, Read)

instance Storable TagData where
  sizeOf _ = #{size TMR_TagData}
  alignment _ = 8

  peek p =
    TagData
      <$> peekArrayAsByteString (#{ptr TMR_TagData, epc} p) (#{ptr TMR_TagData, epcByteCount} p)
      <*> (toTagProtocol <$> #{peek TMR_TagData, protocol} p)
      <*> #{peek TMR_TagData, crc} p
      <*> peekMaybe (peek) (== (#{const TMR_TAG_PROTOCOL_GEN2} :: RawTagProtocol)) (#{ptr TMR_TagData, u.gen2} p) (#{ptr TMR_TagData, protocol} p)

  poke p x = do
    pokeArrayAsByteString "epc" #{const TMR_MAX_EPC_BYTE_COUNT} (#{ptr TMR_TagData, epc} p) (#{ptr TMR_TagData, epcByteCount} p) (tdEpc x)
    #{poke TMR_TagData, protocol} p (fromTagProtocol $ tdProtocol x)
    #{poke TMR_TagData, crc} p (tdCrc x)
    pokeGen2TagData (#{ptr TMR_TagData, u.gen2} p) (#{ptr TMR_TagData, protocol} p) (tdGen2 x)

-- | The identity and state of a single GPIO pin.
data GpioPin =
  GpioPin
  { gpId :: !PinNumber -- ^ The ID number of the pin.
  , gpHigh :: !Bool -- ^ Whether the pin is in the high state.
  , gpOutput :: !Bool -- ^ The direction of the pin
  } deriving (Eq, Ord, Show, Read)

instance Storable GpioPin where
  sizeOf _ = #{size TMR_GpioPin}
  alignment _ = 8

  peek p =
    GpioPin
      <$> #{peek TMR_GpioPin, id} p
      <*> (toBool' <$> #{peek TMR_GpioPin, high} p)
      <*> (toBool' <$> #{peek TMR_GpioPin, output} p)

  poke p x = do
    #{poke TMR_GpioPin, id} p (gpId x)
    #{poke TMR_GpioPin, high} p (fromBool' $ gpHigh x)
    #{poke TMR_GpioPin, output} p (fromBool' $ gpOutput x)

-- | A record to represent a read of an RFID tag.
-- Provides access to the metadata of the read event,
-- such as the time of the read, the antenna that read the tag,
-- and the number of times the tag was seen by the air protocol.
data TagReadData =
  TagReadData
  { trTag :: !TagData -- ^ The tag that was read
  , trMetadataFlags :: ![MetadataFlag] -- ^ The set of metadata items below that are valid
  , trPhase :: !Word16 -- ^ Tag response phase
  , trAntenna :: !AntennaPort -- ^ Antenna where the tag was read
  , trGpio :: ![GpioPin] -- ^ State of GPIO pins at the moment of the tag read
  , trReadCount :: !Word32 -- ^ Number of times the tag was read
  , trRssi :: !Int32 -- ^ Strength of the signal received from the tag
  , trFrequency :: !Word32 -- ^ RF carrier frequency the tag was read with
  , trTimestamp :: !MillisecondsSinceEpoch -- ^ Absolute time of the read, in milliseconds since 1\/1\/1970 UTC
  , trData :: !ByteString -- ^ Data read from the tag
  , trEpcMemData :: !ByteString -- ^ Read EPC bank data bytes  (Only if 'GEN2_BANK_EPC' is present in 'opExtraBanks')
  , trTidMemData :: !ByteString -- ^ Read TID bank data bytes  (Only if 'GEN2_BANK_TID' is present in 'opExtraBanks')
  , trUserMemData :: !ByteString -- ^ Read USER bank data bytes  (Only if 'GEN2_BANK_USER' is present in 'opExtraBanks')
  , trReservedMemData :: !ByteString -- ^ Read RESERVED bank data bytes  (Only if 'GEN2_BANK_RESERVED' is present in 'opExtraBanks')
  } deriving (Eq, Ord, Show, Read)

instance Storable TagReadData where
  sizeOf _ = #{size TMR_TagReadData}
  alignment _ = 8

  peek p =
    TagReadData
      <$> #{peek TMR_TagReadData, tag} p
      <*> (unpackFlags16 <$> #{peek TMR_TagReadData, metadataFlags} p)
      <*> #{peek TMR_TagReadData, phase} p
      <*> #{peek TMR_TagReadData, antenna} p
      <*> peekArrayAsList (#{ptr TMR_TagReadData, gpio} p) (#{ptr TMR_TagReadData, gpioCount} p)
      <*> #{peek TMR_TagReadData, readCount} p
      <*> #{peek TMR_TagReadData, rssi} p
      <*> #{peek TMR_TagReadData, frequency} p
      <*> peekSplit64 (#{ptr TMR_TagReadData, timestampLow} p) (#{ptr TMR_TagReadData, timestampHigh} p)
      <*> peekListAsByteString (#{ptr TMR_TagReadData, data} p)
      <*> peekListAsByteString (#{ptr TMR_TagReadData, epcMemData} p)
      <*> peekListAsByteString (#{ptr TMR_TagReadData, tidMemData} p)
      <*> peekListAsByteString (#{ptr TMR_TagReadData, userMemData} p)
      <*> peekListAsByteString (#{ptr TMR_TagReadData, reservedMemData} p)

  poke p x = error "poke not implemented for TagReadData"

-- | An operation that can be performed on a tag.  Can be used
-- as an argument to 'System.Hardware.MercuryApi.executeTagOp',
-- or can be embedded into a 'System.Hardware.MercuryApi.ReadPlan'.
-- (However, on the M6e Nano, only 'TagOp_GEN2_ReadData' may be
-- embedded in a 'System.Hardware.MercuryApi.ReadPlan'.)
data TagOp =
    TagOp_GEN2_ReadData
    { opBank :: !GEN2_Bank -- ^ Gen2 memory bank to operate on
    , opExtraBanks :: ![GEN2_Bank] -- ^ Additional Gen2 memory banks to read from  (seems buggy, though; I\'ve had strange results with it)
    , opWordAddress :: !Word32 -- ^ Word address to start at
    , opLen :: !Word8 -- ^ Number of words to read
    }
  | TagOp_GEN2_WriteTag
    { opEpc :: !TagData -- ^ Tag EPC
    }
  | TagOp_GEN2_WriteData
    { opBank :: !GEN2_Bank -- ^ Gen2 memory bank to operate on
    , opWordAddress :: !Word32 -- ^ Word address to start at
    , opData :: ![Word16] -- ^ Data to write
    }
  | TagOp_GEN2_Lock
    { opMask :: ![GEN2_LockBits] -- ^ Bitmask indicating which lock bits to change
    , opAction :: ![GEN2_LockBits] -- ^ New values of each bit specified in the mask
    , opAccessPassword :: !GEN2_Password -- ^ Access Password to use to lock the tag
    }
  | TagOp_GEN2_Kill
    { opPassword :: !GEN2_Password -- ^ Kill password to use to kill the tag
    }
  | TagOp_GEN2_BlockWrite
    { opBank :: !GEN2_Bank -- ^ Gen2 memory bank to operate on
    , opWordPtr :: !Word32 -- ^ The word address to start at
    , opData :: ![Word16] -- ^ The data to write
    }
  | TagOp_GEN2_BlockErase
    { opBank :: !GEN2_Bank -- ^ Gen2 memory bank to operate on
    , opWordPtr :: !Word32 -- ^ The word address to start at
    , opWordCount :: !Word8 -- ^ Number of words to erase
    }
  | TagOp_GEN2_BlockPermaLock
    { opBank :: !GEN2_Bank -- ^ Gen2 memory bank to operate on
    , opBlockPtr :: !Word32 -- ^ The starting word address to lock
    , opReadWrite :: !ReadWrite -- ^ Read lock status or write it?
    }
  deriving (Eq, Ord, Show, Read)

instance Storable TagOp where
  sizeOf _ = #{size TagOpEtc}
  alignment _ = 8

  peek p = do
    x <- #{peek TagOpEtc, tagop.type} p :: IO #{type TMR_TagOpType}
    case x of
      #{const TMR_TAGOP_GEN2_READDATA} -> do
        TagOp_GEN2_ReadData
          <$> ((toBank . (.&. 3)) <$> #{peek TagOpEtc, tagop.u.gen2.u.readData.bank} p)
          <*> (unpackExtraBanks <$> #{peek TagOpEtc, tagop.u.gen2.u.readData.bank} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.readData.wordAddress} p
          <*> #{peek TagOpEtc, tagop.u.gen2.u.readData.len} p
      #{const TMR_TAGOP_GEN2_WRITETAG} -> do
        TagOp_GEN2_WriteTag
          <$> peekPtr (#{ptr TagOpEtc, tagop.u.gen2.u.writeTag.epcptr} p) (#{ptr TagOpEtc, u.epc} p)
      #{const TMR_TAGOP_GEN2_WRITEDATA} -> do
        TagOp_GEN2_WriteData
          <$> ((toBank . (.&. 3)) <$> #{peek TagOpEtc, tagop.u.gen2.u.writeData.bank} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.writeData.wordAddress} p
          <*> peekListAsList (#{ptr TagOpEtc, tagop.u.gen2.u.writeData.data} p) (#{ptr TagOpEtc, u.data16} p)
      #{const TMR_TAGOP_GEN2_LOCK} -> do
        TagOp_GEN2_Lock
          <$> (unpackLockBits16 <$> #{peek TagOpEtc, tagop.u.gen2.u.lock.mask} p)
          <*> (unpackLockBits16 <$> #{peek TagOpEtc, tagop.u.gen2.u.lock.action} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.lock.accessPassword} p
      #{const TMR_TAGOP_GEN2_KILL} -> do
        TagOp_GEN2_Kill
          <$> #{peek TagOpEtc, tagop.u.gen2.u.kill.password} p
      #{const TMR_TAGOP_GEN2_BLOCKWRITE} -> do
        TagOp_GEN2_BlockWrite
          <$> ((toBank . (.&. 3)) <$> #{peek TagOpEtc, tagop.u.gen2.u.blockWrite.bank} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.blockWrite.wordPtr} p
          <*> peekListAsList (#{ptr TagOpEtc, tagop.u.gen2.u.blockWrite.data} p) (#{ptr TagOpEtc, u.data16} p)
      #{const TMR_TAGOP_GEN2_BLOCKERASE} -> do
        TagOp_GEN2_BlockErase
          <$> ((toBank . (.&. 3)) <$> #{peek TagOpEtc, tagop.u.gen2.u.blockErase.bank} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.blockErase.wordPtr} p
          <*> #{peek TagOpEtc, tagop.u.gen2.u.blockErase.wordCount} p
      #{const TMR_TAGOP_GEN2_BLOCKPERMALOCK} -> do
        rw <- #{peek TagOpEtc, tagop.u.gen2.u.blockPermaLock.readLock} p
        ws <- peekListAsList (#{ptr TagOpEtc, tagop.u.gen2.u.blockPermaLock.mask} p) (#{ptr TagOpEtc, u.data16} p)
        TagOp_GEN2_BlockPermaLock
          <$> ((toBank . (.&. 3)) <$> #{peek TagOpEtc, tagop.u.gen2.u.blockPermaLock.bank} p)
          <*> #{peek TagOpEtc, tagop.u.gen2.u.blockPermaLock.blockPtr} p
          <*> (return $ toReadWrite (rw, ws))

  poke p x@(TagOp_GEN2_ReadData {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_READDATA} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.readData.bank} p (fromBank $ opBank x)
    pokeOr (#{ptr TagOpEtc, tagop.u.gen2.u.readData.bank} p) (packExtraBanks $ opExtraBanks x)
    #{poke TagOpEtc, tagop.u.gen2.u.readData.wordAddress} p (opWordAddress x)
    #{poke TagOpEtc, tagop.u.gen2.u.readData.len} p (opLen x)

  poke p x@(TagOp_GEN2_WriteTag {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_WRITETAG} :: #{type TMR_TagOpType})
    pokePtr (#{ptr TagOpEtc, tagop.u.gen2.u.writeTag.epcptr} p) (#{ptr TagOpEtc, u.epc} p) (opEpc x)

  poke p x@(TagOp_GEN2_WriteData {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_WRITEDATA} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.writeData.bank} p (fromBank $ opBank x)
    #{poke TagOpEtc, tagop.u.gen2.u.writeData.wordAddress} p (opWordAddress x)
    pokeListAsList "data" #{const GLUE_MAX_DATA16} (#{ptr TagOpEtc, tagop.u.gen2.u.writeData.data} p) (#{ptr TagOpEtc, u.data16} p) (opData x)

  poke p x@(TagOp_GEN2_Lock {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_LOCK} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.lock.mask} p (packLockBits16 $ opMask x)
    #{poke TagOpEtc, tagop.u.gen2.u.lock.action} p (packLockBits16 $ opAction x)
    #{poke TagOpEtc, tagop.u.gen2.u.lock.accessPassword} p (opAccessPassword x)

  poke p x@(TagOp_GEN2_Kill {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_KILL} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.kill.password} p (opPassword x)

  poke p x@(TagOp_GEN2_BlockWrite {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_BLOCKWRITE} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.blockWrite.bank} p (fromBank $ opBank x)
    #{poke TagOpEtc, tagop.u.gen2.u.blockWrite.wordPtr} p (opWordPtr x)
    pokeListAsList "data" #{const GLUE_MAX_DATA16} (#{ptr TagOpEtc, tagop.u.gen2.u.blockWrite.data} p) (#{ptr TagOpEtc, u.data16} p) (opData x)

  poke p x@(TagOp_GEN2_BlockErase {}) = do
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_BLOCKERASE} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.blockErase.bank} p (fromBank $ opBank x)
    #{poke TagOpEtc, tagop.u.gen2.u.blockErase.wordPtr} p (opWordPtr x)
    #{poke TagOpEtc, tagop.u.gen2.u.blockErase.wordCount} p (opWordCount x)

  poke p x@(TagOp_GEN2_BlockPermaLock {}) = do
    let (rw, ws) = fromReadWrite $ opReadWrite x
    #{poke TagOpEtc, tagop.type} p (#{const TMR_TAGOP_GEN2_BLOCKPERMALOCK} :: #{type TMR_TagOpType})
    #{poke TagOpEtc, tagop.u.gen2.u.blockPermaLock.readLock} p rw
    #{poke TagOpEtc, tagop.u.gen2.u.blockPermaLock.bank} p (fromBank $ opBank x)
    #{poke TagOpEtc, tagop.u.gen2.u.blockPermaLock.blockPtr} p (opBlockPtr x)
    pokeListAsList "mask" #{const GLUE_MAX_DATA16} (#{ptr TagOpEtc, tagop.u.gen2.u.blockPermaLock.mask} p) (#{ptr TagOpEtc, u.data16} p) ws

tagOpName :: TagOp -> Text
tagOpName TagOp_GEN2_ReadData {} = "TagOp_GEN2_ReadData"
tagOpName TagOp_GEN2_WriteTag {} = "TagOp_GEN2_WriteTag"
tagOpName TagOp_GEN2_WriteData {} = "TagOp_GEN2_WriteData"
tagOpName TagOp_GEN2_Lock {} = "TagOp_GEN2_Lock"
tagOpName TagOp_GEN2_Kill {} = "TagOp_GEN2_Kill"
tagOpName TagOp_GEN2_BlockWrite {} = "TagOp_GEN2_BlockWrite"
tagOpName TagOp_GEN2_BlockErase {} = "TagOp_GEN2_BlockErase"
tagOpName TagOp_GEN2_BlockPermaLock {} = "TagOp_GEN2_BlockPermaLock"

