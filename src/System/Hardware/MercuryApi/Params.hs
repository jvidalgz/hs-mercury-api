-- Automatically generated by util/generate-tmr-hsc.pl
{-|
Module      : System.Hardware.MercuryApi.Params
Description : Type-safe parameter access
Copyright   : © Patrick Pelletier, 2017
License     : MIT
Maintainer  : code@funwithsoftware.org
Portability : POSIX

Individual functions to get and set parameters.  These are
type-checked at compile time, unlike 'paramGet' and 'paramSet',
which are type-checked at runtime.
-}
module System.Hardware.MercuryApi.Params
  ( -- * Type-safe getters and setters
    -- ** \/reader
    paramGetBaudRate
  , paramSetBaudRate
  , paramGetCommandTimeout
  , paramSetCommandTimeout
  , paramGetDescription
  , paramSetDescription
  , paramGetExtendedEpc
  , paramSetExtendedEpc
  , paramGetHostname
  , paramSetHostname
  , paramGetLicenseKey
  , paramSetLicenseKey
  , paramGetLicensedFeatures
  , paramSetLicensedFeatures
  , paramGetMetadataflags
  , paramSetMetadataflags
  , paramGetProbeBaudRates
  , paramSetProbeBaudRates
  , paramGetTransportTimeout
  , paramSetTransportTimeout
  , paramGetUri
    -- ** \/reader\/antenna
  , paramGetAntennaCheckPort
  , paramSetAntennaCheckPort
  , paramGetAntennaConnectedPortList
  , paramGetAntennaPortList
  , paramGetAntennaPortSwitchGpos
  , paramSetAntennaPortSwitchGpos
    -- ** \/reader\/gen2
  , paramGetGen2AccessPassword
  , paramSetGen2AccessPassword
  , paramGetGen2WriteEarlyExit
  , paramSetGen2WriteEarlyExit
  , paramGetGen2WriteReplyTimeout
  , paramSetGen2WriteReplyTimeout
    -- ** \/reader\/gpio
  , paramGetGpioInputList
  , paramSetGpioInputList
  , paramGetGpioOutputList
  , paramSetGpioOutputList
    -- ** \/reader\/radio
  , paramGetRadioEnablePowerSave
  , paramSetRadioEnablePowerSave
  , paramGetRadioEnableSJC
  , paramSetRadioEnableSJC
  , paramGetRadioPowerMax
  , paramGetRadioPowerMin
  , paramGetRadioReadPower
  , paramSetRadioReadPower
  , paramGetRadioTemperature
  , paramGetRadioWritePower
  , paramSetRadioWritePower
    -- ** \/reader\/read
  , paramGetReadAsyncOffTime
  , paramSetReadAsyncOffTime
  , paramGetReadAsyncOnTime
  , paramSetReadAsyncOnTime
  , paramGetReadPlan
  , paramSetReadPlan
    -- ** \/reader\/region
  , paramGetRegionHopTable
  , paramSetRegionHopTable
  , paramGetRegionHopTime
  , paramSetRegionHopTime
  , paramGetRegionId
  , paramSetRegionId
  , paramGetRegionSupportedRegions
    -- ** \/reader\/region\/lbt
  , paramGetRegionLbtEnable
  , paramSetRegionLbtEnable
    -- ** \/reader\/status
  , paramGetStatusAntennaEnable
  , paramSetStatusAntennaEnable
  , paramGetStatusFrequencyEnable
  , paramSetStatusFrequencyEnable
  , paramGetStatusTemperatureEnable
  , paramSetStatusTemperatureEnable
    -- ** \/reader\/tagReadData
  , paramGetTagReadDataEnableReadFilter
  , paramSetTagReadDataEnableReadFilter
  , paramGetTagReadDataReadFilterTimeout
  , paramSetTagReadDataReadFilterTimeout
  , paramGetTagReadDataRecordHighestRssi
  , paramSetTagReadDataRecordHighestRssi
  , paramGetTagReadDataReportRssiInDbm
  , paramSetTagReadDataReportRssiInDbm
  , paramGetTagReadDataTagopFailures
  , paramGetTagReadDataTagopSuccesses
  , paramGetTagReadDataUniqueByAntenna
  , paramSetTagReadDataUniqueByAntenna
  , paramGetTagReadDataUniqueByData
  , paramSetTagReadDataUniqueByData
  , paramGetTagReadDataUniqueByProtocol
  , paramSetTagReadDataUniqueByProtocol
    -- ** \/reader\/tagop
  , paramGetTagopAntenna
  , paramSetTagopAntenna
  , paramGetTagopProtocol
  , paramSetTagopProtocol
    -- ** \/reader\/trigger\/read
  , paramGetTriggerReadGpi
  , paramSetTriggerReadGpi
    -- ** \/reader\/version
  , paramGetVersionHardware
  , paramGetVersionModel
  , paramGetVersionProductGroup
  , paramGetVersionProductGroupID
  , paramGetVersionProductID
  , paramGetVersionSerial
  , paramSetVersionSerial
  , paramGetVersionSoftware
  , paramGetVersionSupportedProtocols
    -- * As strings
  , paramGetString
  , paramSetString
  ) where

import Control.Applicative
import Data.ByteString (ByteString)
import Data.Int
import Data.Text (Text)
import qualified Data.Text as T
import Data.Word

import System.Hardware.MercuryApi hiding (read)

-- | Set parameter 'PARAM_BAUDRATE' (@\/reader\/baudRate@)
paramSetBaudRate :: Reader -> Word32 -> IO ()
paramSetBaudRate rdr = paramSet rdr PARAM_BAUDRATE

-- | Get parameter 'PARAM_BAUDRATE' (@\/reader\/baudRate@)
paramGetBaudRate :: Reader -> IO Word32
paramGetBaudRate rdr = paramGet rdr PARAM_BAUDRATE

-- | Set parameter 'PARAM_PROBEBAUDRATES' (@\/reader\/probeBaudRates@)
paramSetProbeBaudRates :: Reader -> [Word32] -> IO ()
paramSetProbeBaudRates rdr = paramSet rdr PARAM_PROBEBAUDRATES

-- | Get parameter 'PARAM_PROBEBAUDRATES' (@\/reader\/probeBaudRates@)
paramGetProbeBaudRates :: Reader -> IO [Word32]
paramGetProbeBaudRates rdr = paramGet rdr PARAM_PROBEBAUDRATES

-- | Set parameter 'PARAM_COMMANDTIMEOUT' (@\/reader\/commandTimeout@) (milliseconds)
paramSetCommandTimeout :: Reader -> Word32 -> IO ()
paramSetCommandTimeout rdr = paramSet rdr PARAM_COMMANDTIMEOUT

-- | Get parameter 'PARAM_COMMANDTIMEOUT' (@\/reader\/commandTimeout@) (milliseconds)
paramGetCommandTimeout :: Reader -> IO Word32
paramGetCommandTimeout rdr = paramGet rdr PARAM_COMMANDTIMEOUT

-- | Set parameter 'PARAM_TRANSPORTTIMEOUT' (@\/reader\/transportTimeout@) (milliseconds)
paramSetTransportTimeout :: Reader -> Word32 -> IO ()
paramSetTransportTimeout rdr = paramSet rdr PARAM_TRANSPORTTIMEOUT

-- | Get parameter 'PARAM_TRANSPORTTIMEOUT' (@\/reader\/transportTimeout@) (milliseconds)
paramGetTransportTimeout :: Reader -> IO Word32
paramGetTransportTimeout rdr = paramGet rdr PARAM_TRANSPORTTIMEOUT

-- | Set parameter 'PARAM_ANTENNA_CHECKPORT' (@\/reader\/antenna\/checkPort@)
paramSetAntennaCheckPort :: Reader -> Bool -> IO ()
paramSetAntennaCheckPort rdr = paramSet rdr PARAM_ANTENNA_CHECKPORT

-- | Get parameter 'PARAM_ANTENNA_CHECKPORT' (@\/reader\/antenna\/checkPort@)
paramGetAntennaCheckPort :: Reader -> IO Bool
paramGetAntennaCheckPort rdr = paramGet rdr PARAM_ANTENNA_CHECKPORT

-- | Get parameter 'PARAM_ANTENNA_PORTLIST' (@\/reader\/antenna\/portList@)
paramGetAntennaPortList :: Reader -> IO [Word8]
paramGetAntennaPortList rdr = paramGet rdr PARAM_ANTENNA_PORTLIST

-- | Get parameter 'PARAM_ANTENNA_CONNECTEDPORTLIST' (@\/reader\/antenna\/connectedPortList@)
paramGetAntennaConnectedPortList :: Reader -> IO [Word8]
paramGetAntennaConnectedPortList rdr = paramGet rdr PARAM_ANTENNA_CONNECTEDPORTLIST

-- | Set parameter 'PARAM_ANTENNA_PORTSWITCHGPOS' (@\/reader\/antenna\/portSwitchGpos@)
paramSetAntennaPortSwitchGpos :: Reader -> [Word8] -> IO ()
paramSetAntennaPortSwitchGpos rdr = paramSet rdr PARAM_ANTENNA_PORTSWITCHGPOS

-- | Get parameter 'PARAM_ANTENNA_PORTSWITCHGPOS' (@\/reader\/antenna\/portSwitchGpos@)
paramGetAntennaPortSwitchGpos :: Reader -> IO [Word8]
paramGetAntennaPortSwitchGpos rdr = paramGet rdr PARAM_ANTENNA_PORTSWITCHGPOS

-- | Set parameter 'PARAM_GPIO_INPUTLIST' (@\/reader\/gpio\/inputList@)
paramSetGpioInputList :: Reader -> [Word8] -> IO ()
paramSetGpioInputList rdr = paramSet rdr PARAM_GPIO_INPUTLIST

-- | Get parameter 'PARAM_GPIO_INPUTLIST' (@\/reader\/gpio\/inputList@)
paramGetGpioInputList :: Reader -> IO [Word8]
paramGetGpioInputList rdr = paramGet rdr PARAM_GPIO_INPUTLIST

-- | Set parameter 'PARAM_GPIO_OUTPUTLIST' (@\/reader\/gpio\/outputList@)
paramSetGpioOutputList :: Reader -> [Word8] -> IO ()
paramSetGpioOutputList rdr = paramSet rdr PARAM_GPIO_OUTPUTLIST

-- | Get parameter 'PARAM_GPIO_OUTPUTLIST' (@\/reader\/gpio\/outputList@)
paramGetGpioOutputList :: Reader -> IO [Word8]
paramGetGpioOutputList rdr = paramGet rdr PARAM_GPIO_OUTPUTLIST

-- | Set parameter 'PARAM_GEN2_ACCESSPASSWORD' (@\/reader\/gen2\/accessPassword@)
paramSetGen2AccessPassword :: Reader -> Word32 -> IO ()
paramSetGen2AccessPassword rdr = paramSet rdr PARAM_GEN2_ACCESSPASSWORD

-- | Get parameter 'PARAM_GEN2_ACCESSPASSWORD' (@\/reader\/gen2\/accessPassword@)
paramGetGen2AccessPassword :: Reader -> IO Word32
paramGetGen2AccessPassword rdr = paramGet rdr PARAM_GEN2_ACCESSPASSWORD

-- | Set parameter 'PARAM_READ_ASYNCOFFTIME' (@\/reader\/read\/asyncOffTime@) (milliseconds)
paramSetReadAsyncOffTime :: Reader -> Word32 -> IO ()
paramSetReadAsyncOffTime rdr = paramSet rdr PARAM_READ_ASYNCOFFTIME

-- | Get parameter 'PARAM_READ_ASYNCOFFTIME' (@\/reader\/read\/asyncOffTime@) (milliseconds)
paramGetReadAsyncOffTime :: Reader -> IO Word32
paramGetReadAsyncOffTime rdr = paramGet rdr PARAM_READ_ASYNCOFFTIME

-- | Set parameter 'PARAM_READ_ASYNCONTIME' (@\/reader\/read\/asyncOnTime@) (milliseconds)
paramSetReadAsyncOnTime :: Reader -> Word32 -> IO ()
paramSetReadAsyncOnTime rdr = paramSet rdr PARAM_READ_ASYNCONTIME

-- | Get parameter 'PARAM_READ_ASYNCONTIME' (@\/reader\/read\/asyncOnTime@) (milliseconds)
paramGetReadAsyncOnTime :: Reader -> IO Word32
paramGetReadAsyncOnTime rdr = paramGet rdr PARAM_READ_ASYNCONTIME

-- | Set parameter 'PARAM_READ_PLAN' (@\/reader\/read\/plan@)
paramSetReadPlan :: Reader -> ReadPlan -> IO ()
paramSetReadPlan rdr = paramSet rdr PARAM_READ_PLAN

-- | Get parameter 'PARAM_READ_PLAN' (@\/reader\/read\/plan@)
paramGetReadPlan :: Reader -> IO ReadPlan
paramGetReadPlan rdr = paramGet rdr PARAM_READ_PLAN

-- | Set parameter 'PARAM_RADIO_ENABLEPOWERSAVE' (@\/reader\/radio\/enablePowerSave@)
paramSetRadioEnablePowerSave :: Reader -> Bool -> IO ()
paramSetRadioEnablePowerSave rdr = paramSet rdr PARAM_RADIO_ENABLEPOWERSAVE

-- | Get parameter 'PARAM_RADIO_ENABLEPOWERSAVE' (@\/reader\/radio\/enablePowerSave@)
paramGetRadioEnablePowerSave :: Reader -> IO Bool
paramGetRadioEnablePowerSave rdr = paramGet rdr PARAM_RADIO_ENABLEPOWERSAVE

-- | Get parameter 'PARAM_RADIO_POWERMAX' (@\/reader\/radio\/powerMax@) (centi-dBm)
paramGetRadioPowerMax :: Reader -> IO Int16
paramGetRadioPowerMax rdr = paramGet rdr PARAM_RADIO_POWERMAX

-- | Get parameter 'PARAM_RADIO_POWERMIN' (@\/reader\/radio\/powerMin@) (centi-dBm)
paramGetRadioPowerMin :: Reader -> IO Int16
paramGetRadioPowerMin rdr = paramGet rdr PARAM_RADIO_POWERMIN

-- | Set parameter 'PARAM_RADIO_READPOWER' (@\/reader\/radio\/readPower@) (centi-dBm)
paramSetRadioReadPower :: Reader -> Int32 -> IO ()
paramSetRadioReadPower rdr = paramSet rdr PARAM_RADIO_READPOWER

-- | Get parameter 'PARAM_RADIO_READPOWER' (@\/reader\/radio\/readPower@) (centi-dBm)
paramGetRadioReadPower :: Reader -> IO Int32
paramGetRadioReadPower rdr = paramGet rdr PARAM_RADIO_READPOWER

-- | Set parameter 'PARAM_RADIO_WRITEPOWER' (@\/reader\/radio\/writePower@) (centi-dBm)
paramSetRadioWritePower :: Reader -> Int32 -> IO ()
paramSetRadioWritePower rdr = paramSet rdr PARAM_RADIO_WRITEPOWER

-- | Get parameter 'PARAM_RADIO_WRITEPOWER' (@\/reader\/radio\/writePower@) (centi-dBm)
paramGetRadioWritePower :: Reader -> IO Int32
paramGetRadioWritePower rdr = paramGet rdr PARAM_RADIO_WRITEPOWER

-- | Get parameter 'PARAM_RADIO_TEMPERATURE' (@\/reader\/radio\/temperature@) (degrees C)
paramGetRadioTemperature :: Reader -> IO Int8
paramGetRadioTemperature rdr = paramGet rdr PARAM_RADIO_TEMPERATURE

-- | Set parameter 'PARAM_TAGREADDATA_RECORDHIGHESTRSSI' (@\/reader\/tagReadData\/recordHighestRssi@)
paramSetTagReadDataRecordHighestRssi :: Reader -> Bool -> IO ()
paramSetTagReadDataRecordHighestRssi rdr = paramSet rdr PARAM_TAGREADDATA_RECORDHIGHESTRSSI

-- | Get parameter 'PARAM_TAGREADDATA_RECORDHIGHESTRSSI' (@\/reader\/tagReadData\/recordHighestRssi@)
paramGetTagReadDataRecordHighestRssi :: Reader -> IO Bool
paramGetTagReadDataRecordHighestRssi rdr = paramGet rdr PARAM_TAGREADDATA_RECORDHIGHESTRSSI

-- | Set parameter 'PARAM_TAGREADDATA_REPORTRSSIINDBM' (@\/reader\/tagReadData\/reportRssiInDbm@)
paramSetTagReadDataReportRssiInDbm :: Reader -> Bool -> IO ()
paramSetTagReadDataReportRssiInDbm rdr = paramSet rdr PARAM_TAGREADDATA_REPORTRSSIINDBM

-- | Get parameter 'PARAM_TAGREADDATA_REPORTRSSIINDBM' (@\/reader\/tagReadData\/reportRssiInDbm@)
paramGetTagReadDataReportRssiInDbm :: Reader -> IO Bool
paramGetTagReadDataReportRssiInDbm rdr = paramGet rdr PARAM_TAGREADDATA_REPORTRSSIINDBM

-- | Set parameter 'PARAM_TAGREADDATA_UNIQUEBYANTENNA' (@\/reader\/tagReadData\/uniqueByAntenna@)
paramSetTagReadDataUniqueByAntenna :: Reader -> Bool -> IO ()
paramSetTagReadDataUniqueByAntenna rdr = paramSet rdr PARAM_TAGREADDATA_UNIQUEBYANTENNA

-- | Get parameter 'PARAM_TAGREADDATA_UNIQUEBYANTENNA' (@\/reader\/tagReadData\/uniqueByAntenna@)
paramGetTagReadDataUniqueByAntenna :: Reader -> IO Bool
paramGetTagReadDataUniqueByAntenna rdr = paramGet rdr PARAM_TAGREADDATA_UNIQUEBYANTENNA

-- | Set parameter 'PARAM_TAGREADDATA_UNIQUEBYDATA' (@\/reader\/tagReadData\/uniqueByData@)
paramSetTagReadDataUniqueByData :: Reader -> Bool -> IO ()
paramSetTagReadDataUniqueByData rdr = paramSet rdr PARAM_TAGREADDATA_UNIQUEBYDATA

-- | Get parameter 'PARAM_TAGREADDATA_UNIQUEBYDATA' (@\/reader\/tagReadData\/uniqueByData@)
paramGetTagReadDataUniqueByData :: Reader -> IO Bool
paramGetTagReadDataUniqueByData rdr = paramGet rdr PARAM_TAGREADDATA_UNIQUEBYDATA

-- | Set parameter 'PARAM_TAGOP_ANTENNA' (@\/reader\/tagop\/antenna@)
paramSetTagopAntenna :: Reader -> Word8 -> IO ()
paramSetTagopAntenna rdr = paramSet rdr PARAM_TAGOP_ANTENNA

-- | Get parameter 'PARAM_TAGOP_ANTENNA' (@\/reader\/tagop\/antenna@)
paramGetTagopAntenna :: Reader -> IO Word8
paramGetTagopAntenna rdr = paramGet rdr PARAM_TAGOP_ANTENNA

-- | Set parameter 'PARAM_TAGOP_PROTOCOL' (@\/reader\/tagop\/protocol@)
paramSetTagopProtocol :: Reader -> TagProtocol -> IO ()
paramSetTagopProtocol rdr = paramSet rdr PARAM_TAGOP_PROTOCOL

-- | Get parameter 'PARAM_TAGOP_PROTOCOL' (@\/reader\/tagop\/protocol@)
paramGetTagopProtocol :: Reader -> IO TagProtocol
paramGetTagopProtocol rdr = paramGet rdr PARAM_TAGOP_PROTOCOL

-- | Get parameter 'PARAM_VERSION_HARDWARE' (@\/reader\/version\/hardware@)
paramGetVersionHardware :: Reader -> IO Text
paramGetVersionHardware rdr = paramGet rdr PARAM_VERSION_HARDWARE

-- | Set parameter 'PARAM_VERSION_SERIAL' (@\/reader\/version\/serial@)
paramSetVersionSerial :: Reader -> Text -> IO ()
paramSetVersionSerial rdr = paramSet rdr PARAM_VERSION_SERIAL

-- | Get parameter 'PARAM_VERSION_SERIAL' (@\/reader\/version\/serial@)
paramGetVersionSerial :: Reader -> IO Text
paramGetVersionSerial rdr = paramGet rdr PARAM_VERSION_SERIAL

-- | Get parameter 'PARAM_VERSION_MODEL' (@\/reader\/version\/model@)
paramGetVersionModel :: Reader -> IO Text
paramGetVersionModel rdr = paramGet rdr PARAM_VERSION_MODEL

-- | Get parameter 'PARAM_VERSION_SOFTWARE' (@\/reader\/version\/software@)
paramGetVersionSoftware :: Reader -> IO Text
paramGetVersionSoftware rdr = paramGet rdr PARAM_VERSION_SOFTWARE

-- | Get parameter 'PARAM_VERSION_SUPPORTEDPROTOCOLS' (@\/reader\/version\/supportedProtocols@)
paramGetVersionSupportedProtocols :: Reader -> IO [TagProtocol]
paramGetVersionSupportedProtocols rdr = paramGet rdr PARAM_VERSION_SUPPORTEDPROTOCOLS

-- | Set parameter 'PARAM_REGION_HOPTABLE' (@\/reader\/region\/hopTable@) (kHz)
paramSetRegionHopTable :: Reader -> [Word32] -> IO ()
paramSetRegionHopTable rdr = paramSet rdr PARAM_REGION_HOPTABLE

-- | Get parameter 'PARAM_REGION_HOPTABLE' (@\/reader\/region\/hopTable@) (kHz)
paramGetRegionHopTable :: Reader -> IO [Word32]
paramGetRegionHopTable rdr = paramGet rdr PARAM_REGION_HOPTABLE

-- | Set parameter 'PARAM_REGION_HOPTIME' (@\/reader\/region\/hopTime@) (milliseconds)
paramSetRegionHopTime :: Reader -> Word32 -> IO ()
paramSetRegionHopTime rdr = paramSet rdr PARAM_REGION_HOPTIME

-- | Get parameter 'PARAM_REGION_HOPTIME' (@\/reader\/region\/hopTime@) (milliseconds)
paramGetRegionHopTime :: Reader -> IO Word32
paramGetRegionHopTime rdr = paramGet rdr PARAM_REGION_HOPTIME

-- | Set parameter 'PARAM_REGION_ID' (@\/reader\/region\/id@)
paramSetRegionId :: Reader -> Region -> IO ()
paramSetRegionId rdr = paramSet rdr PARAM_REGION_ID

-- | Get parameter 'PARAM_REGION_ID' (@\/reader\/region\/id@)
paramGetRegionId :: Reader -> IO Region
paramGetRegionId rdr = paramGet rdr PARAM_REGION_ID

-- | Get parameter 'PARAM_REGION_SUPPORTEDREGIONS' (@\/reader\/region\/supportedRegions@)
paramGetRegionSupportedRegions :: Reader -> IO [Region]
paramGetRegionSupportedRegions rdr = paramGet rdr PARAM_REGION_SUPPORTEDREGIONS

-- | Set parameter 'PARAM_REGION_LBT_ENABLE' (@\/reader\/region\/lbt\/enable@)
paramSetRegionLbtEnable :: Reader -> Bool -> IO ()
paramSetRegionLbtEnable rdr = paramSet rdr PARAM_REGION_LBT_ENABLE

-- | Get parameter 'PARAM_REGION_LBT_ENABLE' (@\/reader\/region\/lbt\/enable@)
paramGetRegionLbtEnable :: Reader -> IO Bool
paramGetRegionLbtEnable rdr = paramGet rdr PARAM_REGION_LBT_ENABLE

-- | Set parameter 'PARAM_LICENSE_KEY' (@\/reader\/licenseKey@)
paramSetLicenseKey :: Reader -> [Word8] -> IO ()
paramSetLicenseKey rdr = paramSet rdr PARAM_LICENSE_KEY

-- | Get parameter 'PARAM_LICENSE_KEY' (@\/reader\/licenseKey@)
paramGetLicenseKey :: Reader -> IO [Word8]
paramGetLicenseKey rdr = paramGet rdr PARAM_LICENSE_KEY

-- | Set parameter 'PARAM_RADIO_ENABLESJC' (@\/reader\/radio\/enableSJC@)
paramSetRadioEnableSJC :: Reader -> Bool -> IO ()
paramSetRadioEnableSJC rdr = paramSet rdr PARAM_RADIO_ENABLESJC

-- | Get parameter 'PARAM_RADIO_ENABLESJC' (@\/reader\/radio\/enableSJC@)
paramGetRadioEnableSJC :: Reader -> IO Bool
paramGetRadioEnableSJC rdr = paramGet rdr PARAM_RADIO_ENABLESJC

-- | Set parameter 'PARAM_EXTENDEDEPC' (@\/reader\/extendedEpc@)
paramSetExtendedEpc :: Reader -> Bool -> IO ()
paramSetExtendedEpc rdr = paramSet rdr PARAM_EXTENDEDEPC

-- | Get parameter 'PARAM_EXTENDEDEPC' (@\/reader\/extendedEpc@)
paramGetExtendedEpc :: Reader -> IO Bool
paramGetExtendedEpc rdr = paramGet rdr PARAM_EXTENDEDEPC

-- | Get parameter 'PARAM_URI' (@\/reader\/uri@)
paramGetUri :: Reader -> IO Text
paramGetUri rdr = paramGet rdr PARAM_URI

-- | Get parameter 'PARAM_PRODUCT_GROUP_ID' (@\/reader\/version\/productGroupID@)
paramGetVersionProductGroupID :: Reader -> IO Word16
paramGetVersionProductGroupID rdr = paramGet rdr PARAM_PRODUCT_GROUP_ID

-- | Get parameter 'PARAM_PRODUCT_GROUP' (@\/reader\/version\/productGroup@)
paramGetVersionProductGroup :: Reader -> IO Text
paramGetVersionProductGroup rdr = paramGet rdr PARAM_PRODUCT_GROUP

-- | Get parameter 'PARAM_PRODUCT_ID' (@\/reader\/version\/productID@)
paramGetVersionProductID :: Reader -> IO Word16
paramGetVersionProductID rdr = paramGet rdr PARAM_PRODUCT_ID

-- | Get parameter 'PARAM_TAGREADATA_TAGOPSUCCESSCOUNT' (@\/reader\/tagReadData\/tagopSuccesses@)
paramGetTagReadDataTagopSuccesses :: Reader -> IO Word16
paramGetTagReadDataTagopSuccesses rdr = paramGet rdr PARAM_TAGREADATA_TAGOPSUCCESSCOUNT

-- | Get parameter 'PARAM_TAGREADATA_TAGOPFAILURECOUNT' (@\/reader\/tagReadData\/tagopFailures@)
paramGetTagReadDataTagopFailures :: Reader -> IO Word16
paramGetTagReadDataTagopFailures rdr = paramGet rdr PARAM_TAGREADATA_TAGOPFAILURECOUNT

-- | Set parameter 'PARAM_STATUS_ENABLE_ANTENNAREPORT' (@\/reader\/status\/antennaEnable@)
paramSetStatusAntennaEnable :: Reader -> Bool -> IO ()
paramSetStatusAntennaEnable rdr = paramSet rdr PARAM_STATUS_ENABLE_ANTENNAREPORT

-- | Get parameter 'PARAM_STATUS_ENABLE_ANTENNAREPORT' (@\/reader\/status\/antennaEnable@)
paramGetStatusAntennaEnable :: Reader -> IO Bool
paramGetStatusAntennaEnable rdr = paramGet rdr PARAM_STATUS_ENABLE_ANTENNAREPORT

-- | Set parameter 'PARAM_STATUS_ENABLE_FREQUENCYREPORT' (@\/reader\/status\/frequencyEnable@)
paramSetStatusFrequencyEnable :: Reader -> Bool -> IO ()
paramSetStatusFrequencyEnable rdr = paramSet rdr PARAM_STATUS_ENABLE_FREQUENCYREPORT

-- | Get parameter 'PARAM_STATUS_ENABLE_FREQUENCYREPORT' (@\/reader\/status\/frequencyEnable@)
paramGetStatusFrequencyEnable :: Reader -> IO Bool
paramGetStatusFrequencyEnable rdr = paramGet rdr PARAM_STATUS_ENABLE_FREQUENCYREPORT

-- | Set parameter 'PARAM_STATUS_ENABLE_TEMPERATUREREPORT' (@\/reader\/status\/temperatureEnable@)
paramSetStatusTemperatureEnable :: Reader -> Bool -> IO ()
paramSetStatusTemperatureEnable rdr = paramSet rdr PARAM_STATUS_ENABLE_TEMPERATUREREPORT

-- | Get parameter 'PARAM_STATUS_ENABLE_TEMPERATUREREPORT' (@\/reader\/status\/temperatureEnable@)
paramGetStatusTemperatureEnable :: Reader -> IO Bool
paramGetStatusTemperatureEnable rdr = paramGet rdr PARAM_STATUS_ENABLE_TEMPERATUREREPORT

-- | Set parameter 'PARAM_TAGREADDATA_ENABLEREADFILTER' (@\/reader\/tagReadData\/enableReadFilter@)
paramSetTagReadDataEnableReadFilter :: Reader -> Bool -> IO ()
paramSetTagReadDataEnableReadFilter rdr = paramSet rdr PARAM_TAGREADDATA_ENABLEREADFILTER

-- | Get parameter 'PARAM_TAGREADDATA_ENABLEREADFILTER' (@\/reader\/tagReadData\/enableReadFilter@)
paramGetTagReadDataEnableReadFilter :: Reader -> IO Bool
paramGetTagReadDataEnableReadFilter rdr = paramGet rdr PARAM_TAGREADDATA_ENABLEREADFILTER

-- | Set parameter 'PARAM_TAGREADDATA_READFILTERTIMEOUT' (@\/reader\/tagReadData\/readFilterTimeout@)
paramSetTagReadDataReadFilterTimeout :: Reader -> Int32 -> IO ()
paramSetTagReadDataReadFilterTimeout rdr = paramSet rdr PARAM_TAGREADDATA_READFILTERTIMEOUT

-- | Get parameter 'PARAM_TAGREADDATA_READFILTERTIMEOUT' (@\/reader\/tagReadData\/readFilterTimeout@)
paramGetTagReadDataReadFilterTimeout :: Reader -> IO Int32
paramGetTagReadDataReadFilterTimeout rdr = paramGet rdr PARAM_TAGREADDATA_READFILTERTIMEOUT

-- | Set parameter 'PARAM_TAGREADDATA_UNIQUEBYPROTOCOL' (@\/reader\/tagReadData\/uniqueByProtocol@)
paramSetTagReadDataUniqueByProtocol :: Reader -> Bool -> IO ()
paramSetTagReadDataUniqueByProtocol rdr = paramSet rdr PARAM_TAGREADDATA_UNIQUEBYPROTOCOL

-- | Get parameter 'PARAM_TAGREADDATA_UNIQUEBYPROTOCOL' (@\/reader\/tagReadData\/uniqueByProtocol@)
paramGetTagReadDataUniqueByProtocol :: Reader -> IO Bool
paramGetTagReadDataUniqueByProtocol rdr = paramGet rdr PARAM_TAGREADDATA_UNIQUEBYPROTOCOL

-- | Set parameter 'PARAM_READER_DESCRIPTION' (@\/reader\/description@)
paramSetDescription :: Reader -> Text -> IO ()
paramSetDescription rdr = paramSet rdr PARAM_READER_DESCRIPTION

-- | Get parameter 'PARAM_READER_DESCRIPTION' (@\/reader\/description@)
paramGetDescription :: Reader -> IO Text
paramGetDescription rdr = paramGet rdr PARAM_READER_DESCRIPTION

-- | Set parameter 'PARAM_READER_HOSTNAME' (@\/reader\/hostname@)
paramSetHostname :: Reader -> Text -> IO ()
paramSetHostname rdr = paramSet rdr PARAM_READER_HOSTNAME

-- | Get parameter 'PARAM_READER_HOSTNAME' (@\/reader\/hostname@)
paramGetHostname :: Reader -> IO Text
paramGetHostname rdr = paramGet rdr PARAM_READER_HOSTNAME

-- | Set parameter 'PARAM_READER_WRITE_REPLY_TIMEOUT' (@\/reader\/gen2\/writeReplyTimeout@) (microseconds)
paramSetGen2WriteReplyTimeout :: Reader -> Word16 -> IO ()
paramSetGen2WriteReplyTimeout rdr = paramSet rdr PARAM_READER_WRITE_REPLY_TIMEOUT

-- | Get parameter 'PARAM_READER_WRITE_REPLY_TIMEOUT' (@\/reader\/gen2\/writeReplyTimeout@) (microseconds)
paramGetGen2WriteReplyTimeout :: Reader -> IO Word16
paramGetGen2WriteReplyTimeout rdr = paramGet rdr PARAM_READER_WRITE_REPLY_TIMEOUT

-- | Set parameter 'PARAM_READER_WRITE_EARLY_EXIT' (@\/reader\/gen2\/writeEarlyExit@)
paramSetGen2WriteEarlyExit :: Reader -> Bool -> IO ()
paramSetGen2WriteEarlyExit rdr = paramSet rdr PARAM_READER_WRITE_EARLY_EXIT

-- | Get parameter 'PARAM_READER_WRITE_EARLY_EXIT' (@\/reader\/gen2\/writeEarlyExit@)
paramGetGen2WriteEarlyExit :: Reader -> IO Bool
paramGetGen2WriteEarlyExit rdr = paramGet rdr PARAM_READER_WRITE_EARLY_EXIT

-- | Set parameter 'PARAM_TRIGGER_READ_GPI' (@\/reader\/trigger\/read\/Gpi@)
paramSetTriggerReadGpi :: Reader -> [Word8] -> IO ()
paramSetTriggerReadGpi rdr = paramSet rdr PARAM_TRIGGER_READ_GPI

-- | Get parameter 'PARAM_TRIGGER_READ_GPI' (@\/reader\/trigger\/read\/Gpi@)
paramGetTriggerReadGpi :: Reader -> IO [Word8]
paramGetTriggerReadGpi rdr = paramGet rdr PARAM_TRIGGER_READ_GPI

-- | Set parameter 'PARAM_METADATAFLAG' (@\/reader\/metadataflags@)
paramSetMetadataflags :: Reader -> [MetadataFlag] -> IO ()
paramSetMetadataflags rdr = paramSet rdr PARAM_METADATAFLAG

-- | Get parameter 'PARAM_METADATAFLAG' (@\/reader\/metadataflags@)
paramGetMetadataflags :: Reader -> IO [MetadataFlag]
paramGetMetadataflags rdr = paramGet rdr PARAM_METADATAFLAG

-- | Set parameter 'PARAM_LICENSED_FEATURES' (@\/reader\/licensedFeatures@)
paramSetLicensedFeatures :: Reader -> [Word8] -> IO ()
paramSetLicensedFeatures rdr = paramSet rdr PARAM_LICENSED_FEATURES

-- | Get parameter 'PARAM_LICENSED_FEATURES' (@\/reader\/licensedFeatures@)
paramGetLicensedFeatures :: Reader -> IO [Word8]
paramGetLicensedFeatures rdr = paramGet rdr PARAM_LICENSED_FEATURES

-- | Version of 'paramSet' which converts its argument from a
-- string to the proper type using 'read'.
paramSetString :: Reader -> Param -> Text -> IO ()
paramSetString rdr param txt = do
  let str = T.unpack txt
  case paramType param of
    ParamTypeBool -> paramSet rdr param (read str :: Bool)
    ParamTypeInt16 -> paramSet rdr param (read str :: Int16)
    ParamTypeInt32 -> paramSet rdr param (read str :: Int32)
    ParamTypeInt8 -> paramSet rdr param (read str :: Int8)
    ParamTypeReadPlan -> paramSet rdr param (read str :: ReadPlan)
    ParamTypeRegion -> paramSet rdr param (read str :: Region)
    ParamTypeTagProtocol -> paramSet rdr param (read str :: TagProtocol)
    ParamTypeText -> paramSet rdr param (read str :: Text)
    ParamTypeWord16 -> paramSet rdr param (read str :: Word16)
    ParamTypeWord32 -> paramSet rdr param (read str :: Word32)
    ParamTypeWord8 -> paramSet rdr param (read str :: Word8)
    ParamTypeMetadataFlagList -> paramSet rdr param (read str :: [MetadataFlag])
    ParamTypeRegionList -> paramSet rdr param (read str :: [Region])
    ParamTypeTagProtocolList -> paramSet rdr param (read str :: [TagProtocol])
    ParamTypeWord32List -> paramSet rdr param (read str :: [Word32])
    ParamTypeWord8List -> paramSet rdr param (read str :: [Word8])
    _ -> paramSet rdr param (undefined :: Bool) -- force ERROR_UNIMPLEMENTED_PARAM

-- | Version of 'paramGet' which converts its result to a
-- string using 'show'.
paramGetString :: Reader -> Param -> IO Text
paramGetString rdr param =
  T.pack <$>
  case paramType param of
    ParamTypeBool -> show <$> (paramGet rdr param :: IO Bool)
    ParamTypeInt16 -> show <$> (paramGet rdr param :: IO Int16)
    ParamTypeInt32 -> show <$> (paramGet rdr param :: IO Int32)
    ParamTypeInt8 -> show <$> (paramGet rdr param :: IO Int8)
    ParamTypeReadPlan -> show <$> (paramGet rdr param :: IO ReadPlan)
    ParamTypeRegion -> show <$> (paramGet rdr param :: IO Region)
    ParamTypeTagProtocol -> show <$> (paramGet rdr param :: IO TagProtocol)
    ParamTypeText -> show <$> (paramGet rdr param :: IO Text)
    ParamTypeWord16 -> show <$> (paramGet rdr param :: IO Word16)
    ParamTypeWord32 -> show <$> (paramGet rdr param :: IO Word32)
    ParamTypeWord8 -> show <$> (paramGet rdr param :: IO Word8)
    ParamTypeMetadataFlagList -> show <$> (paramGet rdr param :: IO [MetadataFlag])
    ParamTypeRegionList -> show <$> (paramGet rdr param :: IO [Region])
    ParamTypeTagProtocolList -> show <$> (paramGet rdr param :: IO [TagProtocol])
    ParamTypeWord32List -> show <$> (paramGet rdr param :: IO [Word32])
    ParamTypeWord8List -> show <$> (paramGet rdr param :: IO [Word8])
    _ -> show <$> (paramGet rdr param :: IO Bool) -- force ERROR_UNIMPLEMENTED_PARAM

