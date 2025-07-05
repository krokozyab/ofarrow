@echo off
REM Oracle Fusion Flight SQL Server Configuration
REM Copy this file and edit with your Oracle Fusion credentials

REM Oracle Fusion Connection Details
set OFJDBC_URL=jdbc:wsdl://your-server.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo
set OFJDBC_USER=your_username
set OFJDBC_PASS=your_password

REM Optional: Flight SQL Server Port (default: 32010)
set FLIGHT_PORT=32010

REM Required: Java Memory Options
set JAVA_TOOL_OPTIONS=--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED

echo ✅ Oracle Fusion Flight SQL configuration loaded