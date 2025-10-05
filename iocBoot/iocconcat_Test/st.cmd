#!../../bin/linux-x86_64/concat_Test

# File: iocBoot/iocconcat_Test/st.cmd
# DateTime: Sat Oct  4 14:24:42 2025
# Last checked in by: starritt
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
#dbLoadRecords ("db/const.db")
dbLoadRecords ("db/test.db")

cd ${TOP}/iocBoot/${IOC}
iocInit
 
dbl
 
# end
