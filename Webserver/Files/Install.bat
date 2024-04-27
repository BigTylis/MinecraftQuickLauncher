@echo off
setlocal

set "minecraftLaunchSchemePath=%USERPROFILE%\MinecraftLaunchScheme"
if exist %minecraftLaunchSchemePath% (
echo The quick launcher is already installed.
pause
exit
)

rem CHECK EXECUTION CONTEXT
mkdir "%SystemRoot%\System32\config\Test" > nul 2>&1

rem Check if the directory creation was successful
if %errorlevel% equ 0 (
    echo Current execution context is administrative.
) else (
    if "%1"=="" (
		echo Set objShell = CreateObject^("Shell.Application"^) > "%temp%\elevate.vbs"
		echo objShell.ShellExecute "cmd", "/c %~dp0Install.bat", "", "runas", 1 >> "%temp%\elevate.vbs"
		cscript "%temp%\elevate.vbs"
		del "%temp%\elevate.vbs"
		rmdir "%SystemRoot%\System32\config\Test" > nul 2>&1
		exit /b
	)
)
rmdir "%SystemRoot%\System32\config\Test" > nul 2>&1

set "checkZip=%~dp0LaunchApplication.zip"
if not exist %checkZip% (exit)

set "scheme=MinecraftJServ"
set "executablePath=%USERPROFILE%\MinecraftLaunchScheme\Launcher.bat"

if "%1"=="" (
	reg add "HKEY_CLASSES_ROOT\%scheme%" /v "URL Protocol" /t REG_SZ /d "" /f > nul
	reg add "HKEY_CLASSES_ROOT\%scheme%\shell\open\command" /ve /d "\"%executablePath%\" \"%%1\"" /f > nul
)

set "extractDir=%USERPROFILE%\MinecraftLaunchScheme"
if not exist "%extractDir%" mkdir "%extractDir%"

powershell -command "Expand-Archive -Path '%checkZip%' -DestinationPath '%extractDir%'"

echo Successfully installed! If there are any issues contact BigTylis.
mshta vbscript:Execute("msgbox ""Successfully installed! If there are any issues contact @bigTylis on discord."":close")
pause