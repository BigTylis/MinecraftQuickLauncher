@echo off
setlocal

set "originalDir=%USERPROFILE%\MinecraftLaunchScheme"

if exist %originalDir% (
    rmdir /s /q %originalDir%
)
echo Launching installer...
call "%~dp0Install.bat" "UPDATING"
exit