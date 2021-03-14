#!../../bin/linux-x86_64/concat_Test

# $File: //ASP/tec/epics/concat/trunk/iocBoot/iocconcat_Test/st.cmd $
# $Revision: #3 $
# $DateTime: 2021/03/14 14:49:47 $
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
dbLoadRecords ("db/const.db")

cd ${TOP}/iocBoot/${IOC}
iocInit
 
dbl
 
# end
