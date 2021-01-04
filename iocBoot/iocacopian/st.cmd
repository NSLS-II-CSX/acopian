#!../../bin/linux-x86_64/acopian

## You may have to change acopian to something else
## everywhere it appears in this file

< envPaths
< /epics/common/xf23id1-ioc2-netsetup.cmd

cd("$(TOP)")


## Register all support components
dbLoadDatabase("dbd/acopian.dbd",0,0)
acopian_registerRecordDeviceDriver(pdbbase) 

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName, 
#                       const char *hostInfo,
#                       unsigned int priority, 
#                       int noAutoConnect,
#                       int noProcessEos);

drvAsynIPPortConfigure("Acopian1","xf23id1-psu1-mon1.nsls2.bnl.local:502",0,1,1)
drvAsynIPPortConfigure("Acopian2","xf23id1-psu1-mon2.nsls2.bnl.local:502",0,1,1)

#modbusInterposeConfig(const char *portName, 
#                      modbusLinkType linkType,
#                      int timeoutMsec)

modbusInterposeConfig("Acopian1",0,0)
modbusInterposeConfig("Acopian2",0,0)

#asynSetTraceIOMask("Acopian2",0,4)   # Enable traceIOHex
#asynSetTraceMask("Acopian2",0,9)     # Enable traceError and traceIODriver

drvModbusAsynConfigure("A1_AI", "Acopian1", 1, 4, 0x0000, 8, 0, 100, "et-7017-1") 
drvModbusAsynConfigure("A2_AI", "Acopian2", 1, 4, 0x0000, 8, 0, 100, "et-7017-2") 

## Load record instances
dbLoadTemplate("$(TOP)/db/et-7017.substitutions")

asSetSubstitutions("WS=csxws1")
asSetFilename("/epics/common/xf23id.acf")

dbLoadRecords("$(TOP)/db/iocAdminSoft.db","IOC=XF:23ID1-CT{IOC:ACOPIAN}")

iocInit()

caPutLogInit("xf23id-ca:7004", 0)

dbl > /cf-update/xf23id1-ioc2.es-acopian.dbl
