@echo off
REM Oracle Fusion Flight SQL Server GUI - Windows Startup Script

echo 🛩️  Oracle Fusion Flight SQL Server GUI
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java is not installed or not in PATH
    echo    Please install Java 17 or later
    pause
    exit /b 1
)

REM Check if JAR file exists
set JAR_FILE=orfujdbc-1.0-SNAPSHOT.jar
if not exist "%JAR_FILE%" (
    echo ❌ JAR file not found: %JAR_FILE%
    echo    Please ensure the JAR file is in the same directory as this script
    pause
    exit /b 1
)

REM Check for configuration
if "%OFJDBC_URL%"=="" (
    echo ⚠️  Oracle Fusion credentials not found in environment
    echo    Please run: config.bat ^(after editing it with your credentials^)
    pause
    exit /b 1
)

echo 🚀 Starting Flight SQL Server GUI...

REM Start the GUI
java -cp "%JAR_FILE%" my.jdbc.gui.FlightServerGUI