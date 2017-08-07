# $File: //ASP/tec/epics/concat/trunk/concat_TestApp/src/Makefile $
# $Revision: #1 $
# $DateTime: 2016/01/07 16:32:58 $
# Last checked in by: $Author: pozara $
#
TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = concat_Test
# concat_Test.dbd will be created and installed
DBD += concat_Test.dbd

# concat_Test.dbd will be made up from these files:
#
concat_Test_DBD += base.dbd

# Include dbd files from all support applications:
#
concat_Test_DBD += concatRecord.dbd

# Add all the support libraries needed by this IOC
#
concat_Test_LIBS += concatRecord

# concat_Test_registerRecordDeviceDriver.cpp derives from concat_Test.dbd
#
concat_Test_SRCS += concat_Test_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
#
concat_Test_SRCS_DEFAULT += concat_TestMain.cpp
concat_Test_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#concat_Test_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
#
concat_Test_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

# end
