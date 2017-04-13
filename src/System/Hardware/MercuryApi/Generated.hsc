-- Automatically generated by util/generate-tmr-hsc.pl
module System.Hardware.MercuryApi.Generated where

import Data.Word
import Foreign.C.Types

#include <tm_reader.h>
#include <glue.h>

data StatusType =
    SUCCESS_TYPE
  | ERROR_TYPE_COMM
  | ERROR_TYPE_CODE
  | ERROR_TYPE_MISC
  | ERROR_TYPE_LLRP
  | ERROR_TYPE_BINDING -- ^ An error which originates from the Haskell binding, not the underlying C library.
  | ERROR_TYPE_UNKNOWN -- ^ Not a recognized status type
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

toStatusType :: Word32 -> StatusType
toStatusType #{const TMR_SUCCESS_TYPE} = SUCCESS_TYPE
toStatusType #{const TMR_ERROR_TYPE_COMM} = ERROR_TYPE_COMM
toStatusType #{const TMR_ERROR_TYPE_CODE} = ERROR_TYPE_CODE
toStatusType #{const TMR_ERROR_TYPE_MISC} = ERROR_TYPE_MISC
toStatusType #{const TMR_ERROR_TYPE_LLRP} = ERROR_TYPE_LLRP
toStatusType #{const ERROR_TYPE_BINDING} = ERROR_TYPE_BINDING
toStatusType _ = ERROR_TYPE_UNKNOWN

data Status =
    SUCCESS -- ^ Success!
  | ERROR_MSG_WRONG_NUMBER_OF_DATA -- ^ Invalid number of arguments
  | ERROR_INVALID_OPCODE -- ^ Command opcode not recognized.
  | ERROR_UNIMPLEMENTED_OPCODE -- ^ Command opcode recognized, but is not supported.
  | ERROR_MSG_POWER_TOO_HIGH -- ^ Requested power setting is above the allowed maximum.
  | ERROR_MSG_INVALID_FREQ_RECEIVED -- ^ Requested frequency is outside the allowed range.
  | ERROR_MSG_INVALID_PARAMETER_VALUE -- ^ Parameter value is outside the allowed range.
  | ERROR_MSG_POWER_TOO_LOW -- ^ Requested power setting is below the allowed minimum.
  | ERROR_UNIMPLEMENTED_FEATURE -- ^ Command not supported.
  | ERROR_INVALID_BAUD_RATE -- ^ Requested serial speed is not supported.
  | ERROR_INVALID_REGION -- ^ Region is not supported.
  | ERROR_INVALID_LICENSE_KEY -- ^  License key code is invalid
  | ERROR_BL_INVALID_IMAGE_CRC -- ^ Firmware is corrupt: Checksum doesn't match content.
  | ERROR_BL_INVALID_APP_END_ADDR -- ^ Serial protocol status code for this exception.
  | ERROR_FLASH_BAD_ERASE_PASSWORD -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_BAD_WRITE_PASSWORD -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_UNDEFINED_SECTOR -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_ILLEGAL_SECTOR -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_WRITE_TO_NON_ERASED_AREA -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_WRITE_TO_ILLEGAL_SECTOR -- ^ Internal reader error.  Contact support.
  | ERROR_FLASH_VERIFY_FAILED -- ^ Internal reader error.  Contact support.
  | ERROR_NO_TAGS_FOUND -- ^ Reader was asked to find tags, but none were detected.
  | ERROR_NO_PROTOCOL_DEFINED -- ^ RFID protocol has not been configured.
  | ERROR_INVALID_PROTOCOL_SPECIFIED -- ^ Requested RFID protocol is not recognized.
  | ERROR_WRITE_PASSED_LOCK_FAILED
  | ERROR_PROTOCOL_NO_DATA_READ -- ^ Tag data was requested, but could not be read.
  | ERROR_AFE_NOT_ON
  | ERROR_PROTOCOL_WRITE_FAILED -- ^ Write to tag failed.
  | ERROR_NOT_IMPLEMENTED_FOR_THIS_PROTOCOL -- ^ Command is not supported in the current RFID protocol.
  | ERROR_PROTOCOL_INVALID_WRITE_DATA -- ^ Data does not conform to protocol standards.
  | ERROR_PROTOCOL_INVALID_ADDRESS -- ^ Requested data address is outside the valid range.
  | ERROR_GENERAL_TAG_ERROR -- ^ Unknown error during RFID operation.
  | ERROR_DATA_TOO_LARGE -- ^ Read Tag Data was asked for more data than it supports.
  | ERROR_PROTOCOL_INVALID_KILL_PASSWORD -- ^ Incorrect password was provided to Kill Tag.
  | ERROR_PROTOCOL_KILL_FAILED -- ^ Kill failed for unknown reason.
  | ERROR_PROTOCOL_BIT_DECODING_FAILED -- ^ Internal reader error.  Contact support.
  | ERROR_PROTOCOL_INVALID_EPC -- ^ Internal reader error.  Contact support.
  | ERROR_PROTOCOL_INVALID_NUM_DATA -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_OTHER_ERROR -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_MEMORY_OVERRUN_BAD_PC -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_MEMORY_LOCKED -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_V2_AUTHEN_FAILED -- ^ Authentication failed with specified key.
  | ERROR_GEN2_PROTOCOL_V2_UNTRACE_FAILED -- ^  Untrace operation failed.
  | ERROR_GEN2_PROTOCOL_INSUFFICIENT_POWER -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_NON_SPECIFIC_ERROR -- ^ Internal reader error.  Contact support.
  | ERROR_GEN2_PROTOCOL_UNKNOWN_ERROR -- ^ Internal reader error.  Contact support.
  | ERROR_AHAL_INVALID_FREQ -- ^ A command was received to set a frequency outside the specified range.
  | ERROR_AHAL_CHANNEL_OCCUPIED -- ^ With LBT enabled an attempt was made to set the frequency to an occupied channel.
  | ERROR_AHAL_TRANSMITTER_ON -- ^ Checking antenna status while CW is on is not allowed.
  | ERROR_ANTENNA_NOT_CONNECTED -- ^  Antenna not detected during pre-transmit safety test.
  | ERROR_TEMPERATURE_EXCEED_LIMITS -- ^ Reader temperature outside safe range.
  | ERROR_HIGH_RETURN_LOSS -- ^  Excess power detected at transmitter port, usually due to antenna tuning mismatch.
  | ERROR_INVALID_ANTENNA_CONFIG
  | ERROR_TAG_ID_BUFFER_NOT_ENOUGH_TAGS_AVAILABLE -- ^ Asked for more tags than were available in the buffer.
  | ERROR_TAG_ID_BUFFER_FULL -- ^ Too many tags are in buffer.  Remove some with Get Tag ID Buffer or Clear Tag ID Buffer.
  | ERROR_TAG_ID_BUFFER_REPEATED_TAG_ID -- ^ Internal error -- reader is trying to insert a duplicate tag record.  Contact support.
  | ERROR_TAG_ID_BUFFER_NUM_TAG_TOO_LARGE -- ^ Asked for tags than a single transaction can handle.
  | ERROR_TAG_ID_BUFFER_AUTH_REQUEST -- ^ Blocked response to get additional data from host.
  | ERROR_SYSTEM_UNKNOWN_ERROR -- ^ Internal reader error.  Contact support.
  | ERROR_TM_ASSERT_FAILED -- ^ Internal reader error.  Contact support.
  | ERROR_TIMEOUT
  | ERROR_NO_HOST
  | ERROR_LLRP
  | ERROR_PARSE
  | ERROR_DEVICE_RESET
  | ERROR_CRC_ERROR
  | ERROR_INVALID
  | ERROR_UNIMPLEMENTED
  | ERROR_UNSUPPORTED
  | ERROR_NO_ANTENNA
  | ERROR_READONLY
  | ERROR_TOO_BIG
  | ERROR_NO_THREADS
  | ERROR_NO_TAGS
  | ERROR_NOT_FOUND
  | ERROR_FIRMWARE_FORMAT
  | ERROR_TRYAGAIN
  | ERROR_OUT_OF_MEMORY
  | ERROR_INVALID_WRITE_MODE
  | ERROR_ILLEGAL_VALUE
  | ERROR_END_OF_READING
  | ERROR_UNSUPPORTED_READER_TYPE
  | ERROR_BUFFER_OVERFLOW
  | ERROR_LOADSAVE_CONFIG
  | ERROR_AUTOREAD_ENABLED
  | ERROR_FIRMWARE_UPDATE_ON_AUTOREAD
  | ERROR_TIMESTAMP_NULL
  | ERROR_LLRP_GETTYPEREGISTRY
  | ERROR_LLRP_CONNECTIONFAILED
  | ERROR_LLRP_SENDIO_ERROR
  | ERROR_LLRP_RECEIVEIO_ERROR
  | ERROR_LLRP_RECEIVE_TIMEOUT
  | ERROR_LLRP_MSG_PARSE_ERROR
  | ERROR_LLRP_ALREADY_CONNECTED
  | ERROR_LLRP_INVALID_RFMODE
  | ERROR_LLRP_UNDEFINED_VALUE
  | ERROR_LLRP_READER_ERROR
  | ERROR_LLRP_READER_CONNECTION_LOST
  | ERROR_ALREADY_DESTROYED -- ^ Attempt to use reader after it was destroyed.
  | ERROR_UNKNOWN Word32 -- ^ C API returned an unrecognized status code
  deriving (Eq, Ord, Show, Read)

toStatus :: Word32 -> Status
toStatus #{const TMR_SUCCESS} = SUCCESS
toStatus #{const TMR_ERROR_MSG_WRONG_NUMBER_OF_DATA} = ERROR_MSG_WRONG_NUMBER_OF_DATA
toStatus #{const TMR_ERROR_INVALID_OPCODE} = ERROR_INVALID_OPCODE
toStatus #{const TMR_ERROR_UNIMPLEMENTED_OPCODE} = ERROR_UNIMPLEMENTED_OPCODE
toStatus #{const TMR_ERROR_MSG_POWER_TOO_HIGH} = ERROR_MSG_POWER_TOO_HIGH
toStatus #{const TMR_ERROR_MSG_INVALID_FREQ_RECEIVED} = ERROR_MSG_INVALID_FREQ_RECEIVED
toStatus #{const TMR_ERROR_MSG_INVALID_PARAMETER_VALUE} = ERROR_MSG_INVALID_PARAMETER_VALUE
toStatus #{const TMR_ERROR_MSG_POWER_TOO_LOW} = ERROR_MSG_POWER_TOO_LOW
toStatus #{const TMR_ERROR_UNIMPLEMENTED_FEATURE} = ERROR_UNIMPLEMENTED_FEATURE
toStatus #{const TMR_ERROR_INVALID_BAUD_RATE} = ERROR_INVALID_BAUD_RATE
toStatus #{const TMR_ERROR_INVALID_REGION} = ERROR_INVALID_REGION
toStatus #{const TMR_ERROR_INVALID_LICENSE_KEY} = ERROR_INVALID_LICENSE_KEY
toStatus #{const TMR_ERROR_BL_INVALID_IMAGE_CRC} = ERROR_BL_INVALID_IMAGE_CRC
toStatus #{const TMR_ERROR_BL_INVALID_APP_END_ADDR} = ERROR_BL_INVALID_APP_END_ADDR
toStatus #{const TMR_ERROR_FLASH_BAD_ERASE_PASSWORD} = ERROR_FLASH_BAD_ERASE_PASSWORD
toStatus #{const TMR_ERROR_FLASH_BAD_WRITE_PASSWORD} = ERROR_FLASH_BAD_WRITE_PASSWORD
toStatus #{const TMR_ERROR_FLASH_UNDEFINED_SECTOR} = ERROR_FLASH_UNDEFINED_SECTOR
toStatus #{const TMR_ERROR_FLASH_ILLEGAL_SECTOR} = ERROR_FLASH_ILLEGAL_SECTOR
toStatus #{const TMR_ERROR_FLASH_WRITE_TO_NON_ERASED_AREA} = ERROR_FLASH_WRITE_TO_NON_ERASED_AREA
toStatus #{const TMR_ERROR_FLASH_WRITE_TO_ILLEGAL_SECTOR} = ERROR_FLASH_WRITE_TO_ILLEGAL_SECTOR
toStatus #{const TMR_ERROR_FLASH_VERIFY_FAILED} = ERROR_FLASH_VERIFY_FAILED
toStatus #{const TMR_ERROR_NO_TAGS_FOUND} = ERROR_NO_TAGS_FOUND
toStatus #{const TMR_ERROR_NO_PROTOCOL_DEFINED} = ERROR_NO_PROTOCOL_DEFINED
toStatus #{const TMR_ERROR_INVALID_PROTOCOL_SPECIFIED} = ERROR_INVALID_PROTOCOL_SPECIFIED
toStatus #{const TMR_ERROR_WRITE_PASSED_LOCK_FAILED} = ERROR_WRITE_PASSED_LOCK_FAILED
toStatus #{const TMR_ERROR_PROTOCOL_NO_DATA_READ} = ERROR_PROTOCOL_NO_DATA_READ
toStatus #{const TMR_ERROR_AFE_NOT_ON} = ERROR_AFE_NOT_ON
toStatus #{const TMR_ERROR_PROTOCOL_WRITE_FAILED} = ERROR_PROTOCOL_WRITE_FAILED
toStatus #{const TMR_ERROR_NOT_IMPLEMENTED_FOR_THIS_PROTOCOL} = ERROR_NOT_IMPLEMENTED_FOR_THIS_PROTOCOL
toStatus #{const TMR_ERROR_PROTOCOL_INVALID_WRITE_DATA} = ERROR_PROTOCOL_INVALID_WRITE_DATA
toStatus #{const TMR_ERROR_PROTOCOL_INVALID_ADDRESS} = ERROR_PROTOCOL_INVALID_ADDRESS
toStatus #{const TMR_ERROR_GENERAL_TAG_ERROR} = ERROR_GENERAL_TAG_ERROR
toStatus #{const TMR_ERROR_DATA_TOO_LARGE} = ERROR_DATA_TOO_LARGE
toStatus #{const TMR_ERROR_PROTOCOL_INVALID_KILL_PASSWORD} = ERROR_PROTOCOL_INVALID_KILL_PASSWORD
toStatus #{const TMR_ERROR_PROTOCOL_KILL_FAILED} = ERROR_PROTOCOL_KILL_FAILED
toStatus #{const TMR_ERROR_PROTOCOL_BIT_DECODING_FAILED} = ERROR_PROTOCOL_BIT_DECODING_FAILED
toStatus #{const TMR_ERROR_PROTOCOL_INVALID_EPC} = ERROR_PROTOCOL_INVALID_EPC
toStatus #{const TMR_ERROR_PROTOCOL_INVALID_NUM_DATA} = ERROR_PROTOCOL_INVALID_NUM_DATA
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_OTHER_ERROR} = ERROR_GEN2_PROTOCOL_OTHER_ERROR
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_MEMORY_OVERRUN_BAD_PC} = ERROR_GEN2_PROTOCOL_MEMORY_OVERRUN_BAD_PC
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_MEMORY_LOCKED} = ERROR_GEN2_PROTOCOL_MEMORY_LOCKED
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_V2_AUTHEN_FAILED} = ERROR_GEN2_PROTOCOL_V2_AUTHEN_FAILED
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_V2_UNTRACE_FAILED} = ERROR_GEN2_PROTOCOL_V2_UNTRACE_FAILED
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_INSUFFICIENT_POWER} = ERROR_GEN2_PROTOCOL_INSUFFICIENT_POWER
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_NON_SPECIFIC_ERROR} = ERROR_GEN2_PROTOCOL_NON_SPECIFIC_ERROR
toStatus #{const TMR_ERROR_GEN2_PROTOCOL_UNKNOWN_ERROR} = ERROR_GEN2_PROTOCOL_UNKNOWN_ERROR
toStatus #{const TMR_ERROR_AHAL_INVALID_FREQ} = ERROR_AHAL_INVALID_FREQ
toStatus #{const TMR_ERROR_AHAL_CHANNEL_OCCUPIED} = ERROR_AHAL_CHANNEL_OCCUPIED
toStatus #{const TMR_ERROR_AHAL_TRANSMITTER_ON} = ERROR_AHAL_TRANSMITTER_ON
toStatus #{const TMR_ERROR_ANTENNA_NOT_CONNECTED} = ERROR_ANTENNA_NOT_CONNECTED
toStatus #{const TMR_ERROR_TEMPERATURE_EXCEED_LIMITS} = ERROR_TEMPERATURE_EXCEED_LIMITS
toStatus #{const TMR_ERROR_HIGH_RETURN_LOSS} = ERROR_HIGH_RETURN_LOSS
toStatus #{const TMR_ERROR_INVALID_ANTENNA_CONFIG} = ERROR_INVALID_ANTENNA_CONFIG
toStatus #{const TMR_ERROR_TAG_ID_BUFFER_NOT_ENOUGH_TAGS_AVAILABLE} = ERROR_TAG_ID_BUFFER_NOT_ENOUGH_TAGS_AVAILABLE
toStatus #{const TMR_ERROR_TAG_ID_BUFFER_FULL} = ERROR_TAG_ID_BUFFER_FULL
toStatus #{const TMR_ERROR_TAG_ID_BUFFER_REPEATED_TAG_ID} = ERROR_TAG_ID_BUFFER_REPEATED_TAG_ID
toStatus #{const TMR_ERROR_TAG_ID_BUFFER_NUM_TAG_TOO_LARGE} = ERROR_TAG_ID_BUFFER_NUM_TAG_TOO_LARGE
toStatus #{const TMR_ERROR_TAG_ID_BUFFER_AUTH_REQUEST} = ERROR_TAG_ID_BUFFER_AUTH_REQUEST
toStatus #{const TMR_ERROR_SYSTEM_UNKNOWN_ERROR} = ERROR_SYSTEM_UNKNOWN_ERROR
toStatus #{const TMR_ERROR_TM_ASSERT_FAILED} = ERROR_TM_ASSERT_FAILED
toStatus #{const TMR_ERROR_TIMEOUT} = ERROR_TIMEOUT
toStatus #{const TMR_ERROR_NO_HOST} = ERROR_NO_HOST
toStatus #{const TMR_ERROR_LLRP} = ERROR_LLRP
toStatus #{const TMR_ERROR_PARSE} = ERROR_PARSE
toStatus #{const TMR_ERROR_DEVICE_RESET} = ERROR_DEVICE_RESET
toStatus #{const TMR_ERROR_CRC_ERROR} = ERROR_CRC_ERROR
toStatus #{const TMR_ERROR_INVALID} = ERROR_INVALID
toStatus #{const TMR_ERROR_UNIMPLEMENTED} = ERROR_UNIMPLEMENTED
toStatus #{const TMR_ERROR_UNSUPPORTED} = ERROR_UNSUPPORTED
toStatus #{const TMR_ERROR_NO_ANTENNA} = ERROR_NO_ANTENNA
toStatus #{const TMR_ERROR_READONLY} = ERROR_READONLY
toStatus #{const TMR_ERROR_TOO_BIG} = ERROR_TOO_BIG
toStatus #{const TMR_ERROR_NO_THREADS} = ERROR_NO_THREADS
toStatus #{const TMR_ERROR_NO_TAGS} = ERROR_NO_TAGS
toStatus #{const TMR_ERROR_NOT_FOUND} = ERROR_NOT_FOUND
toStatus #{const TMR_ERROR_FIRMWARE_FORMAT} = ERROR_FIRMWARE_FORMAT
toStatus #{const TMR_ERROR_TRYAGAIN} = ERROR_TRYAGAIN
toStatus #{const TMR_ERROR_OUT_OF_MEMORY} = ERROR_OUT_OF_MEMORY
toStatus #{const TMR_ERROR_INVALID_WRITE_MODE} = ERROR_INVALID_WRITE_MODE
toStatus #{const TMR_ERROR_ILLEGAL_VALUE} = ERROR_ILLEGAL_VALUE
toStatus #{const TMR_ERROR_END_OF_READING} = ERROR_END_OF_READING
toStatus #{const TMR_ERROR_UNSUPPORTED_READER_TYPE} = ERROR_UNSUPPORTED_READER_TYPE
toStatus #{const TMR_ERROR_BUFFER_OVERFLOW} = ERROR_BUFFER_OVERFLOW
toStatus #{const TMR_ERROR_LOADSAVE_CONFIG} = ERROR_LOADSAVE_CONFIG
toStatus #{const TMR_ERROR_AUTOREAD_ENABLED} = ERROR_AUTOREAD_ENABLED
toStatus #{const TMR_ERROR_FIRMWARE_UPDATE_ON_AUTOREAD} = ERROR_FIRMWARE_UPDATE_ON_AUTOREAD
toStatus #{const TMR_ERROR_TIMESTAMP_NULL} = ERROR_TIMESTAMP_NULL
toStatus #{const TMR_ERROR_LLRP_GETTYPEREGISTRY} = ERROR_LLRP_GETTYPEREGISTRY
toStatus #{const TMR_ERROR_LLRP_CONNECTIONFAILED} = ERROR_LLRP_CONNECTIONFAILED
toStatus #{const TMR_ERROR_LLRP_SENDIO_ERROR} = ERROR_LLRP_SENDIO_ERROR
toStatus #{const TMR_ERROR_LLRP_RECEIVEIO_ERROR} = ERROR_LLRP_RECEIVEIO_ERROR
toStatus #{const TMR_ERROR_LLRP_RECEIVE_TIMEOUT} = ERROR_LLRP_RECEIVE_TIMEOUT
toStatus #{const TMR_ERROR_LLRP_MSG_PARSE_ERROR} = ERROR_LLRP_MSG_PARSE_ERROR
toStatus #{const TMR_ERROR_LLRP_ALREADY_CONNECTED} = ERROR_LLRP_ALREADY_CONNECTED
toStatus #{const TMR_ERROR_LLRP_INVALID_RFMODE} = ERROR_LLRP_INVALID_RFMODE
toStatus #{const TMR_ERROR_LLRP_UNDEFINED_VALUE} = ERROR_LLRP_UNDEFINED_VALUE
toStatus #{const TMR_ERROR_LLRP_READER_ERROR} = ERROR_LLRP_READER_ERROR
toStatus #{const TMR_ERROR_LLRP_READER_CONNECTION_LOST} = ERROR_LLRP_READER_CONNECTION_LOST
toStatus #{const ERROR_ALREADY_DESTROYED} = ERROR_ALREADY_DESTROYED
toStatus x = ERROR_UNKNOWN x

data Param =
    PARAM_NONE -- ^ No such parameter - used as a return value from TMR_paramID().
  | PARAM_BAUDRATE -- ^ "/reader/baudRate", uint32_t
  | PARAM_PROBEBAUDRATES -- ^ "/reader/probeBaudRates", TMR_uint32List
  | PARAM_COMMANDTIMEOUT -- ^ "/reader/commandTimeout", uint32_t
  | PARAM_TRANSPORTTIMEOUT -- ^ "/reader/transportTimeout", uint32_t
  | PARAM_POWERMODE -- ^ "/reader/powerMode", TMR_SR_PowerMode
  | PARAM_USERMODE -- ^ "/reader/userMode", TMR_SR_UserMode
  | PARAM_ANTENNA_CHECKPORT -- ^ "/reader/antenna/checkPort", bool
  | PARAM_ANTENNA_PORTLIST -- ^ "/reader/antenna/portList", TMR_uint8List
  | PARAM_ANTENNA_CONNECTEDPORTLIST -- ^ "/reader/antenna/connectedPortList", TMR_uint8List
  | PARAM_ANTENNA_PORTSWITCHGPOS -- ^ "/reader/antenna/portSwitchGpos", TMR_uint8List
  | PARAM_ANTENNA_SETTLINGTIMELIST -- ^ "/reader/antenna/settlingTimeList", TMR_PortValueList
  | PARAM_ANTENNA_RETURNLOSS -- ^ "reader/antenna/returnLoss", TMR_PortValueList
  | PARAM_ANTENNA_TXRXMAP -- ^ "/reader/antenna/txRxMap", TMR_AntennaMapList
  | PARAM_GPIO_INPUTLIST -- ^ "/reader/gpio/inputList", TMR_uint8List
  | PARAM_GPIO_OUTPUTLIST -- ^ "/reader/gpio/outputList", TMR_uint8List
  | PARAM_GEN2_ACCESSPASSWORD -- ^ "/reader/gen2/accessPassword", TMR_GEN2_Password
  | PARAM_GEN2_Q -- ^ "/reader/gen2/q", TMR_GEN2_Q
  | PARAM_GEN2_TAGENCODING -- ^ "/reader/gen2/tagEncoding", TMR_GEN2_TagEncoding
  | PARAM_GEN2_SESSION -- ^ "/reader/gen2/session", TMR_GEN2_Session
  | PARAM_GEN2_TARGET -- ^ "/reader/gen2/target", TMR_GEN2_Target
  | PARAM_GEN2_BLF -- ^ "/reader/gen2/BLF", TMR_Gen2_LinkFrequency
  | PARAM_GEN2_TARI -- ^ "/reader/gen2/tari", TMR_Gen2_Tari
  | PARAM_GEN2_WRITEMODE -- ^ "/reader/gen2/writeMode", TMR_Gen2_WriteMode
  | PARAM_GEN2_BAP -- ^ "/reader/gen2/bap", TMR_Gen2_Bap
  | PARAM_GEN2_PROTOCOLEXTENSION -- ^ "/reader/gen2/protocolExtension", TMR_PARAM_GEN2_PROTOCOLEXTENSION
  | PARAM_ISO180006B_BLF -- ^ "/reader/iso180006b/BLF", TMR_ISO180006B_LinkFrequency
  | PARAM_ISO180006B_MODULATION_DEPTH -- ^ "/reader/iso180006b/modulationDepth", TMR_ISO180006B_ModulationDepth
  | PARAM_ISO180006B_DELIMITER -- ^ "/reader/iso180006b/delimiter", TMR_PARAM_ISO18000_6B_DELIMITER
  | PARAM_READ_ASYNCOFFTIME -- ^ "/reader/read/asyncOffTime", uint32_t
  | PARAM_READ_ASYNCONTIME -- ^ "/reader/read/asyncOnTime", uint32_t
  | PARAM_READ_PLAN -- ^ "/reader/read/plan", TMR_ReadPlan
  | PARAM_RADIO_ENABLEPOWERSAVE -- ^ "/reader/radio/enablePowerSave, bool
  | PARAM_RADIO_POWERMAX -- ^ "/reader/radio/powerMax", int16_t
  | PARAM_RADIO_POWERMIN -- ^ "/reader/radio/powerMin", int16_t
  | PARAM_RADIO_PORTREADPOWERLIST -- ^ "/reader/radio/portReadPowerList", TMR_PortValueList
  | PARAM_RADIO_PORTWRITEPOWERLIST -- ^ "/reader/radio/portWritePowerList", TMR_PortValueList
  | PARAM_RADIO_READPOWER -- ^ "/reader/radio/readPower", int32_t
  | PARAM_RADIO_WRITEPOWER -- ^ "/reader/radio/writePower", int32_t
  | PARAM_RADIO_TEMPERATURE -- ^ "/reader/radio/temperature", int8_t
  | PARAM_TAGREADDATA_RECORDHIGHESTRSSI -- ^ "/reader/tagReadData/recordHighestRssi", bool
  | PARAM_TAGREADDATA_REPORTRSSIINDBM -- ^ "/reader/tagReadData/reportRssiInDbm", bool
  | PARAM_TAGREADDATA_UNIQUEBYANTENNA -- ^ "/reader/tagReadData/uniqueByAntenna", bool
  | PARAM_TAGREADDATA_UNIQUEBYDATA -- ^ "/reader/tagReadData/uniqueByData", bool
  | PARAM_TAGOP_ANTENNA -- ^ "/reader/tagop/antenna", uint8_t
  | PARAM_TAGOP_PROTOCOL -- ^ "/reader/tagop/protocol", TMR_Protocol
  | PARAM_VERSION_HARDWARE -- ^ "/reader/version/hardware", TMR_String
  | PARAM_VERSION_SERIAL -- ^ "/reader/version/serial", TMR_String
  | PARAM_VERSION_MODEL -- ^ "/reader/version/model", TMR_String
  | PARAM_VERSION_SOFTWARE -- ^ "/reader/version/software", TMR_String
  | PARAM_VERSION_SUPPORTEDPROTOCOLS -- ^ "/reader/version/supportedProtocols", TMR_TagProtocolList
  | PARAM_REGION_HOPTABLE -- ^ "/reader/region/hopTable", TMR_uint32List
  | PARAM_REGION_HOPTIME -- ^ "/reader/region/hopTime", uint32_t
  | PARAM_REGION_ID -- ^ "/reader/region/id", TMR_Region
  | PARAM_REGION_SUPPORTEDREGIONS -- ^ "/reader/region/supportedRegions", TMR_RegionList
  | PARAM_REGION_LBT_ENABLE -- ^ "/reader/region/lbt/enable", bool
  | PARAM_LICENSE_KEY -- ^ "/reader/licenseKey", TMR_uint8List
  | PARAM_USER_CONFIG -- ^ "/reader/userConfig", TMR_UserConfigOption
  | PARAM_RADIO_ENABLESJC -- ^ "/reader/radio/enableSJC", bool
  | PARAM_EXTENDEDEPC -- ^ "/reader/extendedEpc", bool
  | PARAM_READER_STATISTICS -- ^ "/reader/statistics", TMR_SR_ReaderStatistics
  | PARAM_READER_STATS -- ^ "/reader/stats", TMR_
  | PARAM_URI -- ^ "/reader/uri", TMR_String
  | PARAM_PRODUCT_GROUP_ID -- ^ "/reader/version/productGroupID", uint16_t
  | PARAM_PRODUCT_GROUP -- ^ "/reader/version/productGroup", TMR_String
  | PARAM_PRODUCT_ID -- ^ "/reader/version/productID", uint16_t
  | PARAM_TAGREADATA_TAGOPSUCCESSCOUNT -- ^ "/reader/tagReadData/tagopSuccesses", uint16_t
  | PARAM_TAGREADATA_TAGOPFAILURECOUNT -- ^ "/reader/tagReadData/tagopFailures",  uint16_t
  | PARAM_STATUS_ENABLE_ANTENNAREPORT -- ^ "/reader/status/antennaEnable", bool
  | PARAM_STATUS_ENABLE_FREQUENCYREPORT -- ^ "/reader/status/frequencyEnable", bool
  | PARAM_STATUS_ENABLE_TEMPERATUREREPORT -- ^ "/reader/status/temperatureEnable", bool
  | PARAM_TAGREADDATA_ENABLEREADFILTER -- ^ "/reader/tagReadData/enableReadFilter", bool
  | PARAM_TAGREADDATA_READFILTERTIMEOUT -- ^ "/reader/tagReadData/readFilterTimeout", int32_t
  | PARAM_TAGREADDATA_UNIQUEBYPROTOCOL -- ^ "/reader/tagReadData/uniqueByProtocol", bool
  | PARAM_READER_DESCRIPTION -- ^ "/reader/description", TMR_String
  | PARAM_READER_HOSTNAME -- ^ "reader/hostname", TMR_String
  | PARAM_CURRENTTIME -- ^ "/reader/currentTime", struct tm
  | PARAM_READER_WRITE_REPLY_TIMEOUT -- ^ "/reader/gen2/writeReplyTimeout", uint16_t
  | PARAM_READER_WRITE_EARLY_EXIT -- ^ "/reader/gen2/writeEarlyExit", bool
  | PARAM_READER_STATS_ENABLE -- ^ "reader/stats/enable", TMR_StatsEnable
  | PARAM_TRIGGER_READ_GPI -- ^ "/reader/trigger/read/Gpi", TMR_uint8List
  | PARAM_METADATAFLAG -- ^ "/reader/metadataflags", TMR_TRD_MetadataFlag
  | PARAM_LICENSED_FEATURES
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

toParam :: CInt -> Param
toParam #{const TMR_PARAM_NONE} = PARAM_NONE
toParam #{const TMR_PARAM_BAUDRATE} = PARAM_BAUDRATE
toParam #{const TMR_PARAM_PROBEBAUDRATES} = PARAM_PROBEBAUDRATES
toParam #{const TMR_PARAM_COMMANDTIMEOUT} = PARAM_COMMANDTIMEOUT
toParam #{const TMR_PARAM_TRANSPORTTIMEOUT} = PARAM_TRANSPORTTIMEOUT
toParam #{const TMR_PARAM_POWERMODE} = PARAM_POWERMODE
toParam #{const TMR_PARAM_USERMODE} = PARAM_USERMODE
toParam #{const TMR_PARAM_ANTENNA_CHECKPORT} = PARAM_ANTENNA_CHECKPORT
toParam #{const TMR_PARAM_ANTENNA_PORTLIST} = PARAM_ANTENNA_PORTLIST
toParam #{const TMR_PARAM_ANTENNA_CONNECTEDPORTLIST} = PARAM_ANTENNA_CONNECTEDPORTLIST
toParam #{const TMR_PARAM_ANTENNA_PORTSWITCHGPOS} = PARAM_ANTENNA_PORTSWITCHGPOS
toParam #{const TMR_PARAM_ANTENNA_SETTLINGTIMELIST} = PARAM_ANTENNA_SETTLINGTIMELIST
toParam #{const TMR_PARAM_ANTENNA_RETURNLOSS} = PARAM_ANTENNA_RETURNLOSS
toParam #{const TMR_PARAM_ANTENNA_TXRXMAP} = PARAM_ANTENNA_TXRXMAP
toParam #{const TMR_PARAM_GPIO_INPUTLIST} = PARAM_GPIO_INPUTLIST
toParam #{const TMR_PARAM_GPIO_OUTPUTLIST} = PARAM_GPIO_OUTPUTLIST
toParam #{const TMR_PARAM_GEN2_ACCESSPASSWORD} = PARAM_GEN2_ACCESSPASSWORD
toParam #{const TMR_PARAM_GEN2_Q} = PARAM_GEN2_Q
toParam #{const TMR_PARAM_GEN2_TAGENCODING} = PARAM_GEN2_TAGENCODING
toParam #{const TMR_PARAM_GEN2_SESSION} = PARAM_GEN2_SESSION
toParam #{const TMR_PARAM_GEN2_TARGET} = PARAM_GEN2_TARGET
toParam #{const TMR_PARAM_GEN2_BLF} = PARAM_GEN2_BLF
toParam #{const TMR_PARAM_GEN2_TARI} = PARAM_GEN2_TARI
toParam #{const TMR_PARAM_GEN2_WRITEMODE} = PARAM_GEN2_WRITEMODE
toParam #{const TMR_PARAM_GEN2_BAP} = PARAM_GEN2_BAP
toParam #{const TMR_PARAM_GEN2_PROTOCOLEXTENSION} = PARAM_GEN2_PROTOCOLEXTENSION
toParam #{const TMR_PARAM_ISO180006B_BLF} = PARAM_ISO180006B_BLF
toParam #{const TMR_PARAM_ISO180006B_MODULATION_DEPTH} = PARAM_ISO180006B_MODULATION_DEPTH
toParam #{const TMR_PARAM_ISO180006B_DELIMITER} = PARAM_ISO180006B_DELIMITER
toParam #{const TMR_PARAM_READ_ASYNCOFFTIME} = PARAM_READ_ASYNCOFFTIME
toParam #{const TMR_PARAM_READ_ASYNCONTIME} = PARAM_READ_ASYNCONTIME
toParam #{const TMR_PARAM_READ_PLAN} = PARAM_READ_PLAN
toParam #{const TMR_PARAM_RADIO_ENABLEPOWERSAVE} = PARAM_RADIO_ENABLEPOWERSAVE
toParam #{const TMR_PARAM_RADIO_POWERMAX} = PARAM_RADIO_POWERMAX
toParam #{const TMR_PARAM_RADIO_POWERMIN} = PARAM_RADIO_POWERMIN
toParam #{const TMR_PARAM_RADIO_PORTREADPOWERLIST} = PARAM_RADIO_PORTREADPOWERLIST
toParam #{const TMR_PARAM_RADIO_PORTWRITEPOWERLIST} = PARAM_RADIO_PORTWRITEPOWERLIST
toParam #{const TMR_PARAM_RADIO_READPOWER} = PARAM_RADIO_READPOWER
toParam #{const TMR_PARAM_RADIO_WRITEPOWER} = PARAM_RADIO_WRITEPOWER
toParam #{const TMR_PARAM_RADIO_TEMPERATURE} = PARAM_RADIO_TEMPERATURE
toParam #{const TMR_PARAM_TAGREADDATA_RECORDHIGHESTRSSI} = PARAM_TAGREADDATA_RECORDHIGHESTRSSI
toParam #{const TMR_PARAM_TAGREADDATA_REPORTRSSIINDBM} = PARAM_TAGREADDATA_REPORTRSSIINDBM
toParam #{const TMR_PARAM_TAGREADDATA_UNIQUEBYANTENNA} = PARAM_TAGREADDATA_UNIQUEBYANTENNA
toParam #{const TMR_PARAM_TAGREADDATA_UNIQUEBYDATA} = PARAM_TAGREADDATA_UNIQUEBYDATA
toParam #{const TMR_PARAM_TAGOP_ANTENNA} = PARAM_TAGOP_ANTENNA
toParam #{const TMR_PARAM_TAGOP_PROTOCOL} = PARAM_TAGOP_PROTOCOL
toParam #{const TMR_PARAM_VERSION_HARDWARE} = PARAM_VERSION_HARDWARE
toParam #{const TMR_PARAM_VERSION_SERIAL} = PARAM_VERSION_SERIAL
toParam #{const TMR_PARAM_VERSION_MODEL} = PARAM_VERSION_MODEL
toParam #{const TMR_PARAM_VERSION_SOFTWARE} = PARAM_VERSION_SOFTWARE
toParam #{const TMR_PARAM_VERSION_SUPPORTEDPROTOCOLS} = PARAM_VERSION_SUPPORTEDPROTOCOLS
toParam #{const TMR_PARAM_REGION_HOPTABLE} = PARAM_REGION_HOPTABLE
toParam #{const TMR_PARAM_REGION_HOPTIME} = PARAM_REGION_HOPTIME
toParam #{const TMR_PARAM_REGION_ID} = PARAM_REGION_ID
toParam #{const TMR_PARAM_REGION_SUPPORTEDREGIONS} = PARAM_REGION_SUPPORTEDREGIONS
toParam #{const TMR_PARAM_REGION_LBT_ENABLE} = PARAM_REGION_LBT_ENABLE
toParam #{const TMR_PARAM_LICENSE_KEY} = PARAM_LICENSE_KEY
toParam #{const TMR_PARAM_USER_CONFIG} = PARAM_USER_CONFIG
toParam #{const TMR_PARAM_RADIO_ENABLESJC} = PARAM_RADIO_ENABLESJC
toParam #{const TMR_PARAM_EXTENDEDEPC} = PARAM_EXTENDEDEPC
toParam #{const TMR_PARAM_READER_STATISTICS} = PARAM_READER_STATISTICS
toParam #{const TMR_PARAM_READER_STATS} = PARAM_READER_STATS
toParam #{const TMR_PARAM_URI} = PARAM_URI
toParam #{const TMR_PARAM_PRODUCT_GROUP_ID} = PARAM_PRODUCT_GROUP_ID
toParam #{const TMR_PARAM_PRODUCT_GROUP} = PARAM_PRODUCT_GROUP
toParam #{const TMR_PARAM_PRODUCT_ID} = PARAM_PRODUCT_ID
toParam #{const TMR_PARAM_TAGREADATA_TAGOPSUCCESSCOUNT} = PARAM_TAGREADATA_TAGOPSUCCESSCOUNT
toParam #{const TMR_PARAM_TAGREADATA_TAGOPFAILURECOUNT} = PARAM_TAGREADATA_TAGOPFAILURECOUNT
toParam #{const TMR_PARAM_STATUS_ENABLE_ANTENNAREPORT} = PARAM_STATUS_ENABLE_ANTENNAREPORT
toParam #{const TMR_PARAM_STATUS_ENABLE_FREQUENCYREPORT} = PARAM_STATUS_ENABLE_FREQUENCYREPORT
toParam #{const TMR_PARAM_STATUS_ENABLE_TEMPERATUREREPORT} = PARAM_STATUS_ENABLE_TEMPERATUREREPORT
toParam #{const TMR_PARAM_TAGREADDATA_ENABLEREADFILTER} = PARAM_TAGREADDATA_ENABLEREADFILTER
toParam #{const TMR_PARAM_TAGREADDATA_READFILTERTIMEOUT} = PARAM_TAGREADDATA_READFILTERTIMEOUT
toParam #{const TMR_PARAM_TAGREADDATA_UNIQUEBYPROTOCOL} = PARAM_TAGREADDATA_UNIQUEBYPROTOCOL
toParam #{const TMR_PARAM_READER_DESCRIPTION} = PARAM_READER_DESCRIPTION
toParam #{const TMR_PARAM_READER_HOSTNAME} = PARAM_READER_HOSTNAME
toParam #{const TMR_PARAM_CURRENTTIME} = PARAM_CURRENTTIME
toParam #{const TMR_PARAM_READER_WRITE_REPLY_TIMEOUT} = PARAM_READER_WRITE_REPLY_TIMEOUT
toParam #{const TMR_PARAM_READER_WRITE_EARLY_EXIT} = PARAM_READER_WRITE_EARLY_EXIT
toParam #{const TMR_PARAM_READER_STATS_ENABLE} = PARAM_READER_STATS_ENABLE
toParam #{const TMR_PARAM_TRIGGER_READ_GPI} = PARAM_TRIGGER_READ_GPI
toParam #{const TMR_PARAM_METADATAFLAG} = PARAM_METADATAFLAG
toParam #{const TMR_PARAM_LICENSED_FEATURES} = PARAM_LICENSED_FEATURES
toParam _ = PARAM_NONE

fromParam :: Param -> CInt
fromParam PARAM_NONE = #{const TMR_PARAM_NONE}
fromParam PARAM_BAUDRATE = #{const TMR_PARAM_BAUDRATE}
fromParam PARAM_PROBEBAUDRATES = #{const TMR_PARAM_PROBEBAUDRATES}
fromParam PARAM_COMMANDTIMEOUT = #{const TMR_PARAM_COMMANDTIMEOUT}
fromParam PARAM_TRANSPORTTIMEOUT = #{const TMR_PARAM_TRANSPORTTIMEOUT}
fromParam PARAM_POWERMODE = #{const TMR_PARAM_POWERMODE}
fromParam PARAM_USERMODE = #{const TMR_PARAM_USERMODE}
fromParam PARAM_ANTENNA_CHECKPORT = #{const TMR_PARAM_ANTENNA_CHECKPORT}
fromParam PARAM_ANTENNA_PORTLIST = #{const TMR_PARAM_ANTENNA_PORTLIST}
fromParam PARAM_ANTENNA_CONNECTEDPORTLIST = #{const TMR_PARAM_ANTENNA_CONNECTEDPORTLIST}
fromParam PARAM_ANTENNA_PORTSWITCHGPOS = #{const TMR_PARAM_ANTENNA_PORTSWITCHGPOS}
fromParam PARAM_ANTENNA_SETTLINGTIMELIST = #{const TMR_PARAM_ANTENNA_SETTLINGTIMELIST}
fromParam PARAM_ANTENNA_RETURNLOSS = #{const TMR_PARAM_ANTENNA_RETURNLOSS}
fromParam PARAM_ANTENNA_TXRXMAP = #{const TMR_PARAM_ANTENNA_TXRXMAP}
fromParam PARAM_GPIO_INPUTLIST = #{const TMR_PARAM_GPIO_INPUTLIST}
fromParam PARAM_GPIO_OUTPUTLIST = #{const TMR_PARAM_GPIO_OUTPUTLIST}
fromParam PARAM_GEN2_ACCESSPASSWORD = #{const TMR_PARAM_GEN2_ACCESSPASSWORD}
fromParam PARAM_GEN2_Q = #{const TMR_PARAM_GEN2_Q}
fromParam PARAM_GEN2_TAGENCODING = #{const TMR_PARAM_GEN2_TAGENCODING}
fromParam PARAM_GEN2_SESSION = #{const TMR_PARAM_GEN2_SESSION}
fromParam PARAM_GEN2_TARGET = #{const TMR_PARAM_GEN2_TARGET}
fromParam PARAM_GEN2_BLF = #{const TMR_PARAM_GEN2_BLF}
fromParam PARAM_GEN2_TARI = #{const TMR_PARAM_GEN2_TARI}
fromParam PARAM_GEN2_WRITEMODE = #{const TMR_PARAM_GEN2_WRITEMODE}
fromParam PARAM_GEN2_BAP = #{const TMR_PARAM_GEN2_BAP}
fromParam PARAM_GEN2_PROTOCOLEXTENSION = #{const TMR_PARAM_GEN2_PROTOCOLEXTENSION}
fromParam PARAM_ISO180006B_BLF = #{const TMR_PARAM_ISO180006B_BLF}
fromParam PARAM_ISO180006B_MODULATION_DEPTH = #{const TMR_PARAM_ISO180006B_MODULATION_DEPTH}
fromParam PARAM_ISO180006B_DELIMITER = #{const TMR_PARAM_ISO180006B_DELIMITER}
fromParam PARAM_READ_ASYNCOFFTIME = #{const TMR_PARAM_READ_ASYNCOFFTIME}
fromParam PARAM_READ_ASYNCONTIME = #{const TMR_PARAM_READ_ASYNCONTIME}
fromParam PARAM_READ_PLAN = #{const TMR_PARAM_READ_PLAN}
fromParam PARAM_RADIO_ENABLEPOWERSAVE = #{const TMR_PARAM_RADIO_ENABLEPOWERSAVE}
fromParam PARAM_RADIO_POWERMAX = #{const TMR_PARAM_RADIO_POWERMAX}
fromParam PARAM_RADIO_POWERMIN = #{const TMR_PARAM_RADIO_POWERMIN}
fromParam PARAM_RADIO_PORTREADPOWERLIST = #{const TMR_PARAM_RADIO_PORTREADPOWERLIST}
fromParam PARAM_RADIO_PORTWRITEPOWERLIST = #{const TMR_PARAM_RADIO_PORTWRITEPOWERLIST}
fromParam PARAM_RADIO_READPOWER = #{const TMR_PARAM_RADIO_READPOWER}
fromParam PARAM_RADIO_WRITEPOWER = #{const TMR_PARAM_RADIO_WRITEPOWER}
fromParam PARAM_RADIO_TEMPERATURE = #{const TMR_PARAM_RADIO_TEMPERATURE}
fromParam PARAM_TAGREADDATA_RECORDHIGHESTRSSI = #{const TMR_PARAM_TAGREADDATA_RECORDHIGHESTRSSI}
fromParam PARAM_TAGREADDATA_REPORTRSSIINDBM = #{const TMR_PARAM_TAGREADDATA_REPORTRSSIINDBM}
fromParam PARAM_TAGREADDATA_UNIQUEBYANTENNA = #{const TMR_PARAM_TAGREADDATA_UNIQUEBYANTENNA}
fromParam PARAM_TAGREADDATA_UNIQUEBYDATA = #{const TMR_PARAM_TAGREADDATA_UNIQUEBYDATA}
fromParam PARAM_TAGOP_ANTENNA = #{const TMR_PARAM_TAGOP_ANTENNA}
fromParam PARAM_TAGOP_PROTOCOL = #{const TMR_PARAM_TAGOP_PROTOCOL}
fromParam PARAM_VERSION_HARDWARE = #{const TMR_PARAM_VERSION_HARDWARE}
fromParam PARAM_VERSION_SERIAL = #{const TMR_PARAM_VERSION_SERIAL}
fromParam PARAM_VERSION_MODEL = #{const TMR_PARAM_VERSION_MODEL}
fromParam PARAM_VERSION_SOFTWARE = #{const TMR_PARAM_VERSION_SOFTWARE}
fromParam PARAM_VERSION_SUPPORTEDPROTOCOLS = #{const TMR_PARAM_VERSION_SUPPORTEDPROTOCOLS}
fromParam PARAM_REGION_HOPTABLE = #{const TMR_PARAM_REGION_HOPTABLE}
fromParam PARAM_REGION_HOPTIME = #{const TMR_PARAM_REGION_HOPTIME}
fromParam PARAM_REGION_ID = #{const TMR_PARAM_REGION_ID}
fromParam PARAM_REGION_SUPPORTEDREGIONS = #{const TMR_PARAM_REGION_SUPPORTEDREGIONS}
fromParam PARAM_REGION_LBT_ENABLE = #{const TMR_PARAM_REGION_LBT_ENABLE}
fromParam PARAM_LICENSE_KEY = #{const TMR_PARAM_LICENSE_KEY}
fromParam PARAM_USER_CONFIG = #{const TMR_PARAM_USER_CONFIG}
fromParam PARAM_RADIO_ENABLESJC = #{const TMR_PARAM_RADIO_ENABLESJC}
fromParam PARAM_EXTENDEDEPC = #{const TMR_PARAM_EXTENDEDEPC}
fromParam PARAM_READER_STATISTICS = #{const TMR_PARAM_READER_STATISTICS}
fromParam PARAM_READER_STATS = #{const TMR_PARAM_READER_STATS}
fromParam PARAM_URI = #{const TMR_PARAM_URI}
fromParam PARAM_PRODUCT_GROUP_ID = #{const TMR_PARAM_PRODUCT_GROUP_ID}
fromParam PARAM_PRODUCT_GROUP = #{const TMR_PARAM_PRODUCT_GROUP}
fromParam PARAM_PRODUCT_ID = #{const TMR_PARAM_PRODUCT_ID}
fromParam PARAM_TAGREADATA_TAGOPSUCCESSCOUNT = #{const TMR_PARAM_TAGREADATA_TAGOPSUCCESSCOUNT}
fromParam PARAM_TAGREADATA_TAGOPFAILURECOUNT = #{const TMR_PARAM_TAGREADATA_TAGOPFAILURECOUNT}
fromParam PARAM_STATUS_ENABLE_ANTENNAREPORT = #{const TMR_PARAM_STATUS_ENABLE_ANTENNAREPORT}
fromParam PARAM_STATUS_ENABLE_FREQUENCYREPORT = #{const TMR_PARAM_STATUS_ENABLE_FREQUENCYREPORT}
fromParam PARAM_STATUS_ENABLE_TEMPERATUREREPORT = #{const TMR_PARAM_STATUS_ENABLE_TEMPERATUREREPORT}
fromParam PARAM_TAGREADDATA_ENABLEREADFILTER = #{const TMR_PARAM_TAGREADDATA_ENABLEREADFILTER}
fromParam PARAM_TAGREADDATA_READFILTERTIMEOUT = #{const TMR_PARAM_TAGREADDATA_READFILTERTIMEOUT}
fromParam PARAM_TAGREADDATA_UNIQUEBYPROTOCOL = #{const TMR_PARAM_TAGREADDATA_UNIQUEBYPROTOCOL}
fromParam PARAM_READER_DESCRIPTION = #{const TMR_PARAM_READER_DESCRIPTION}
fromParam PARAM_READER_HOSTNAME = #{const TMR_PARAM_READER_HOSTNAME}
fromParam PARAM_CURRENTTIME = #{const TMR_PARAM_CURRENTTIME}
fromParam PARAM_READER_WRITE_REPLY_TIMEOUT = #{const TMR_PARAM_READER_WRITE_REPLY_TIMEOUT}
fromParam PARAM_READER_WRITE_EARLY_EXIT = #{const TMR_PARAM_READER_WRITE_EARLY_EXIT}
fromParam PARAM_READER_STATS_ENABLE = #{const TMR_PARAM_READER_STATS_ENABLE}
fromParam PARAM_TRIGGER_READ_GPI = #{const TMR_PARAM_TRIGGER_READ_GPI}
fromParam PARAM_METADATAFLAG = #{const TMR_PARAM_METADATAFLAG}
fromParam PARAM_LICENSED_FEATURES = #{const TMR_PARAM_LICENSED_FEATURES}

paramMin :: CInt
paramMin = #{const TMR_PARAM_MIN}

paramMax :: CInt
paramMax = #{const TMR_PARAM_MAX}

