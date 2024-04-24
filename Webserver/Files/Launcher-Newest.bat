@echo off
setlocal

set "url=%~1"

for /f "tokens=2,3,4 delims=/" %%a in ("%url%") do (
    set "gametype=%%a"
    set "version=%%b"
    set "server=%%c"
)

start "" %~dp0MinecraftQuickLauncher.exe %gametype% %version% %server%
start "" http://192.168.40.226:8000/Webpage.html?arg1=returnEndpointSuccess