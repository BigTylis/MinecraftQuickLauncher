@echo off
setlocal

set "originalDir=%USERPROFILE%\MinecraftLaunchScheme"

if exist %originalDir% (
    rmdir /s /q %originalDir%
)
mshta vbscript:Execute("msgbox ""The updated installer will now launch. If the installer fails you may have to re-install from the website."":close")
echo Launching installer...
call %~dp0Install.bat"
exit