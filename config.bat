@echo off
REM Oracle Fusion Flight SQL Server Configuration
REM Copy this file and edit with your Oracle Fusion credentials

REM Oracle Fusion Connection Details
set OFJDBC_URL=jdbc:wsdl://your-server.oraclecloud.com/xmlpserver/services/ExternalReportWSSService?WSDL:/Custom/Financials/RP_ARB.xdo
REM Single user or multiple users separated by semicolon for round-robin load balancing
set OFJDBC_USER=your_username
REM OR multiple users: set OFJDBC_USER=user1;user2;user3
set OFJDBC_PASS=your_password
REM OR multiple passwords: set OFJDBC_PASS=pass1;pass2;pass3

REM Optional: Flight SQL Server Port (default: 32010)
set FLIGHT_PORT=32010

REM Required: Java Memory Options
set JAVA_TOOL_OPTIONS=--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED

echo ✅ Oracle Fusion Flight SQL configuration loaded