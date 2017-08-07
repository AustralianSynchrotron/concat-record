# $File: //ASP/tec/epics/concat/trunk/concatRecordSup/Makefile $
# $Revision: #1 $
# $DateTime: 2016/01/07 16:32:58 $
# Last checked in by: $Author: pozara $
#

TOP=..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#========================================

#========================================
# build a support library
#
LIBRARY_IOC += concatRecord

# xxxRecord.h will be created from xxxRecord.dbd
#
DBDINC += concatRecord

# install concatRecord.dbd into <top>/dbd
#
DBD += concatRecord.dbd

# specify all source files to be compiled and added to the library
#
concatRecord_SRCS += concatRecord.c

concatRecord_LIBS += $(EPICS_BASE_IOC_LIBS)

#========================================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

# end
