@echo off
setlocal

set "url=%~1"

for /f "tokens=2,3,4,5 delims=/" %%a in ("%url%") do (
    set "requiredlauncherversion=%%a"
    set "gametype=%%b"
    set "version=%%c"
    set "server=%%d"
)

set "currentLauncherVersion="
for /f "delims=" %%x in (%~dp0Launcher-Version.txt) do set "currentLauncherVersion=%%x"

if not "%requiredLauncherVersion%" == "%currentLauncherVersion%" (
    echo New version of launcher is out! Updating...

    set "updateDir=%USERPROFILE%/MinecraftLaunchScheme-Updater"
    if exist %updateDir% (
        rmdir /s /q %updateDir%
    )
    mkdir %updateDir%

    curl -L -o "%updateDir%/Install.bat" "https://bigtylis.github.io/MinecraftQuickLauncher/Files/Install.bat"
    curl -L -o "%updateDir%/LaunchApplication.zip" "https://bigtylis.github.io/MinecraftQuickLauncher/Files/LaunchApplication.zip"
    curl -L -o "%updateDir%/Update.bat" "https://bigtylis.github.io/MinecraftQuickLauncher/Files/Update.bat"

    if not exist "%updateDir%/Install.bat" (
        mshta vbscript:Execute("msgbox ""Update process failed. Try again later."":close")
	exit
    )
    if not exist "%updateDir%/LaunchApplication.zip" (
        mshta vbscript:Execute("msgbox ""Update process failed. Try again later."":close")
	exit
    )
    if not exist "%updateDir%/Update.bat" (
        mshta vbscript:Execute("msgbox ""Update process failed. Try again later."":close")
	exit
    )
    
    call "%updateDir%/Update.bat"
    exit
)

start "" %~dp0MinecraftQuickLauncher.exe %gametype% %version% %server%
start "" https://bigtylis.github.io/MinecraftQuickLauncher/Webpage.html?arg1=returnEndpointSuccess