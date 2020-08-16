@echo off&title IconRepairUpdater 3.0&if "%udl%"=="" (exit /b)
:Uload
if "%umode%"=="" (mode 79,26) else (mode %umode%)
echo:&if "%language%"=="Deutsch" (echo Lade Update...) else (echo Loading update...)
:Uprocess
tasklist /FI "ImageName eq %ufile%" | find /i "%ufile%" >NUL
if %errorlevel% equ 0 (if not "%ufile%"=="" (timeout 2 >NUL&goto Uprocess))
echo:&powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" '%udl%' -outfile '%urep%' -timeoutsec 3 -usebasicparsing)
if %errorlevel% equ 0 (set ustatus=successfull) else (set ustatus=retry)
call "%urep%"&exit