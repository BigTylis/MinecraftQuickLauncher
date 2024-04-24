@echo off
setlocal

set "url=%~1"

for /f "tokens=2,3,4 delims=/" %%a in ("%url%") do (
    set "gametype=%%a"
    set "version=%%b"
    set "server=%%c"
)

start "" %~dp0MinecraftQuickLauncher.exe %gametype% %version% %server%
start "" https://bigtylis.github.io/MinecraftQuickLauncher/Webpage.html?arg1=returnEndpointSuccess