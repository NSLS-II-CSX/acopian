#!../../bin/linux-x86_64/acopian

## You may have to change acopian to something else
## everywhere it appears in this file

< envPaths

## Register all support components
dbLoadDatabase("../../dbd/acopian.dbd",0,0)
acopian_registerRecordDeviceDriver(pdbbase) 

# Use the following commands for TCP/IP
#drvAsynIPPortConfigure(const char *portName, 
#                       const char *hostInfo,
#                       unsigned int priority, 
#                       int noAutoConnect,
#                       int noProcessEos);

drvAsynIPPortConfigure("Acopian1","10.23.3.50:502",0,1,1)
drvAsynIPPortConfigure("Acopian2","10.23.3.51:502",0,1,1)

#modbusInterposeConfig(const char *portName, 
#                      modbusLinkType linkType,
#                      int timeoutMsec)

modbusInterposeConfig("Acopian1",0,0)

asynSetTraceIOMask("Acopian1",0,4)   # Enable traceIOHex
asynSetTraceMask("Acopian1",0,9)     # Enable traceError and traceIODriver

drvModbusAsynConfigure("A1_AI", "Acopian1", 0, 3, 0x0000, 8, 0, 100, "acopian") 

## Load record instances
dbLoadRecords("../../db/acopian.db","PORT=A1_AI,Sys=XF:23ID1-ES,Dev={Acopian}")

iocInit()

