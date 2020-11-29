TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = acopian
# acopian.dbd will be created and installed
DBD += acopian.dbd

# acopian.dbd will be made up from these files:
acopian_DBD += base.dbd

# Include dbd files from all support applications:
acopian_DBD += caPutLog.dbd
#acopian_DBD += modbus.dbd
acopian_DBD += modbusSupport.dbd
acopian_DBD += asyn.dbd
acopian_DBD += drvAsynIPPort.dbd
acopian_DBD += system.dbd
acopian_DBD += asSupport.dbd
acopian_DBD += devIocStats.dbd

# Add all the support libraries needed by this IOC
acopian_LIBS += modbus
acopian_LIBS += caPutLog
acopian_LIBS += asyn
acopian_LIBS += devIocStats
acopian_LIBS += autosave

# acopian_registerRecordDeviceDriver.cpp derives from acopian.dbd
acopian_SRCS += acopian_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
acopian_SRCS_DEFAULT += acopianMain.cpp
acopian_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#acopian_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
acopian_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

