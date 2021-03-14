#!../../bin/linux-x86_64/concat_Test

# $File: //ASP/tec/epics/concat/trunk/iocBoot/iocconcat_Test/st.cmd $
# $Revision: #2 $
# $DateTime: 2019/07/01 16:34:35 $
# Last checked in by: $Author: starritt $
#

## You may have to change concat_Test to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/concat_Test.dbd"
concat_Test_registerRecordDeviceDriver pdbbase

## Load record instances
#
dbLoadRecords ("db/test.db")

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=andyHost"

# end
