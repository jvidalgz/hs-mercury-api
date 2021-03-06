{-# LANGUAGE OverloadedStrings, FlexibleInstances, DeriveDataTypeable #-}
module System.Hardware.MercuryApi.ParamValue where

import Control.Applicative ( (<$>) )
import Control.Exception ( bracketOnError )
import qualified Data.ByteString as B ( useAsCString, length )
import Data.Text (Text)
import Data.Word ( Word8, Word16, Word32 )
import Foreign
    ( Int8,
      Int16,
      Int32,
      Ptr,
      Storable(peek, poke),
      castPtr,
      with,
      toBool,
      new,
      fromBool,
      free,
      allocaBytes,
      alloca )

import System.Hardware.MercuryApi.Enums
import System.Hardware.MercuryApi.Records

-- | A class for types which can be used as parameter values.
class ParamValue a where
  pType :: a -> ParamType
  pGet :: (Ptr () -> IO ()) -> IO a
  pSet :: a -> (Ptr () -> IO ()) -> IO ()

instance ParamValue Bool where
  pType _ = ParamTypeBool
  pGet f = alloca $ \p -> f (castPtr (p :: Ptr CBool)) >> toBool <$> peek p
  pSet x f = alloca $ \p -> poke p (fromBool x :: CBool) >> f (castPtr p)

instance ParamValue GEN2_WriteMode where
  pType _ = ParamTypeGEN2_WriteMode
  pGet f = alloca $ \p -> f (castPtr p) >> toWriteMode <$> peek p
  pSet x f = alloca $ \p -> poke p (fromWriteMode x) >> f (castPtr p)

instance ParamValue Int16 where
  pType _ = ParamTypeInt16
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue Int32 where
  pType _ = ParamTypeInt32
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue Int8 where
  pType _ = ParamTypeInt8
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue PowerMode where
  pType _ = ParamTypePowerMode
  pGet f = alloca $ \p -> f (castPtr p) >> toPowerMode <$> peek p
  pSet x f = alloca $ \p -> poke p (fromPowerMode x) >> f (castPtr p)

instance ParamValue ReadPlan where
  pType _ = ParamTypeReadPlan
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  -- Unlike all the other cases, in this case we transfer ownership
  -- to the C code, which will free it later.
  pSet x f = bracketOnError (new x) free (f . castPtr)

instance ParamValue Region where
  pType _ = ParamTypeRegion
  pGet f = alloca $ \p -> f (castPtr p) >> toRegion <$> peek p
  pSet x f = alloca $ \p -> poke p (fromRegion x) >> f (castPtr p)

instance ParamValue TagProtocol where
  pType _ = ParamTypeTagProtocol
  pGet f = alloca $ \p -> f (castPtr p) >> toTagProtocol <$> peek p
  pSet x f = alloca $ \p -> poke p (fromTagProtocol x) >> f (castPtr p)

instance ParamValue Text where
  pType _ = ParamTypeText

  pGet f = do
    let maxLen = maxBound :: Word16
    allocaBytes (fromIntegral maxLen) $ \storage -> do
      let lst = List16
                { l16_list = castPtr storage
                , l16_max = maxLen
                , l16_len = 0 -- unused for TMR_String
                }
      with lst $ \p -> do
        f (castPtr p)
        textFromCString storage

  pSet x f = do
    let bs = textToBS x
    B.useAsCString bs $ \cs -> do
      len' <- castLen "Text" (1 + B.length bs)
      let lst = List16
                { l16_list = castPtr cs
                , l16_max = len'
                , l16_len = 0 -- unused for TMR_String
                }
      with lst $ \p -> f (castPtr p)

instance ParamValue Word16 where
  pType _ = ParamTypeWord16
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue Word32 where
  pType _ = ParamTypeWord32
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue Word8 where
  pType _ = ParamTypeWord8
  pGet f = alloca $ \p -> f (castPtr p) >> peek p
  pSet x f = alloca $ \p -> poke p x >> f (castPtr p)

instance ParamValue [MetadataFlag] where
  pType _ = ParamTypeMetadataFlagList
  pGet f = alloca $ \p -> f (castPtr p) >> unpackFlags <$> peek p
  pSet x f = alloca $ \p -> poke p (packFlags x) >> f (castPtr p)

instance ParamValue [Region] where
  pType _ = ParamTypeRegionList
  pGet f = map toRegion <$> getList8 f
  pSet x f = setList8 "[Region]" (map fromRegion x) f

instance ParamValue [TagProtocol] where
  pType _ = ParamTypeTagProtocolList
  pGet f = map toTagProtocol <$> getList8 f
  pSet x f = setList8 "[TagProtocol]" (map fromTagProtocol x) f

instance ParamValue [Word32] where
  pType _ = ParamTypeWord32List
  pGet = getList16
  pSet = setList16 "[Word32]"

instance ParamValue [Word8] where
  pType _ = ParamTypeWord8List
  pGet = getList16
  pSet = setList16 "[Word8]"

