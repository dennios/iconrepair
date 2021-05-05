@echo off&mode 79,26&title IconRepairUpdater 3.0&if "%iconrepairdl%"=="" (exit)
%S%&echo %loadingupdate%
:Udownload
tasklist /fi "ImageName eq %iconrepairfile%" | find /i "%iconrepairfile%" >NUL
if %errorlevel% equ 0 (if updatestat equ 0 (set updatestat=3&goto Uend) else (set updatestat=0&timeout 2 >NUL&goto Udownload))
%S%&powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" 'https://raw.githubusercontent.com/dennios/iconrepair/master/IconRepair.exe' -outfile '%iconrepairloc%' -timeoutsec 3 -usebasicparsing)
if %errorlevel% equ 0 (set updatestat=2) else (set updatestat=3)
:Uend
call "%iconrepairloc%"&exit