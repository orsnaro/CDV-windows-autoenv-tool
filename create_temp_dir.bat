@echo off
set "CDV_TEMP_DIR=%ProgramData%\CDV\Temp"

if not exist "%CDV_TEMP_DIR%" (
    echo Creating directory: %CDV_TEMP_DIR%
    mkdir "%CDV_TEMP_DIR%"
    if %errorlevel% neq 0 (
        echo Failed to create CDV Temp directory. This script might require administrative privileges.
    ) 
) 

set CDV_TEMP_DIR=
exit /b

:END