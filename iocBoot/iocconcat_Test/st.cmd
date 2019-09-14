#!../../bin/linux-x86_64/concat_Test

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
