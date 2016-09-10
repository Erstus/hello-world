#!/bin/bash
#%0 & @ECHO OFF & CLS & GOTO :windows

#### BASH SCRIPT STARTS HERE ####

# Check for OS name, but can't trust uname -a for arch.
OS=`uname`

# Detect architecture by abusing an integer overflow.
if ((1<<32)); then
    ARCH=64 # 64-bit architecture
else
    ARCH=32 # 32-bit architecture
fi

# $OS contains OS name, and $ARCH architecture.
echo -e "Detected system: $OS $ARCH-bit"

# "App" should be replaced with a path of the application.
if [ ! -x "$(command -v App)" ]; then
  echo "App not found."
else
  echo -e "Starting App.\n"
  App
  echo -e "\nApp has closed.\n"
fi

# Prevent terminal from closing.
exec $SHELL

# Exit before we run into the Windows code.
exit

:windows
::#### WINDOWS SCRIPT STARTS HERE ####

:: Determine the architecture by checking Windows' env vars.
IF %PROCESSOR_ARCHITECTURE% == x86 (
    SET ARCH=32
) ELSE (
    SET ARCH=64
)

:: %ARCH% contains the architecture of the OS.
ECHO Detected system: Windows %ARCH%-bit

:: "App" should be replaced with a path of the application.
START App

:: Exit so the script will not continue into the Linux code.
EXIT