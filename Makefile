# $File: //ASP/tec/epics/concat/trunk/Makefile $
# $Revision: #1 $
# $DateTime: 2016/01/07 16:32:58 $
# Last checked in by: $Author: pozara $
#
# Makefile at top of application tree

TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), configure)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *Sup))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard *App))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocBoot))
include $(TOP)/configure/RULES_TOP

# end
