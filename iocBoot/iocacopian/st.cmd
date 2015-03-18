#!../../bin/linux-x86_64/acopian

## You may have to change acopian to something else
## everywhere it appears in this file

< envPaths

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

drvAsynIPPortConfigure("Acopian1","10.23.3.61:502",0,1,1)
drvAsynIPPortConfigure("Acopian2","10.23.3.62:502",0,1,1)
drvAsynIPPortConfigure("Acopian3","10.23.3.60:502",0,1,1)

#modbusInterposeConfig(const char *portName, 
#                      modbusLinkType linkType,
#                      int timeoutMsec)

modbusInterposeConfig("Acopian1",0,0)
modbusInterposeConfig("Acopian2",0,0)
modbusInterposeConfig("Acopian3",0,0)

#asynSetTraceIOMask("Acopian3",0,4)   # Enable traceIOHex
#asynSetTraceMask("Acopian3",0,9)     # Enable traceError and traceIODriver

drvModbusAsynConfigure("A1_AI", "Acopian1", 1, 4, 0x0000, 8, 0, 1000, "et-7017-1") 
drvModbusAsynConfigure("A2_AI", "Acopian2", 1, 4, 0x0000, 8, 0, 100, "et-7017-2") 
drvModbusAsynConfigure("A3_BI", "Acopian3", 0, 1, 0x0000, 2, 0, 100, "webrelay") 
drvModbusAsynConfigure("A3_BO", "Acopian3", 0, 5, 0x0000, 1, 0, 100, "webrelay") 

## Load record instances
dbLoadTemplate("$(TOP)/db/et-7017.substitutions")
dbLoadRecords("$(TOP)/db/webrelay.db","INPORT=A3_BI,OUTPORT=A3_BO,Sys=XF:23ID1-ES,Dev={Acopian}")

iocInit()

dbl > /cf-update/xf23id1-ioc2.es-acopian.dbl
