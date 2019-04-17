@echo off&set name=IconRepairUpdater&set UV=2.3
if not exist "%userprofile%\IconRepair\" (goto Unothing)
if not exist "%userprofile%\IconRepair\build" (goto Unothing)
set /p NB=<%userprofile%\IconRepair\build
if "%new%"=="new" (if "%V% (%B%)"=="%NB%" (goto Unothing)) else (goto Ulanguage)
:UpdateMain
title %name% %UV%
if "%language%"=="Deutsch" (goto DEUMain) else (goto ENUMain)
:ENUMain
cls&echo ^>Update&%M%&echo Update IconRepair to the latest version?&%N%&%M%&%M%&echo  Installed version         - %V% (%B%)&echo  Latest version            - %NB%&%M%&%N%&%M%&echo Yes (y) - No (n)
choice /C YN /N >NUL
if %errorlevel% equ 1 goto Uprepare
if %errorlevel% equ 2 set up=U&set update= - Update (u)&goto Unothing
:DEUMain
cls&echo ^>Update&%M%&echo IconRepair auf die neueste Version updaten?&%N%&%M%&%M%&echo  Installierte Version      - %V% (%B%)&echo  Neuste Version            - %NB%&%M%&%N%&%M%&echo Ja (j) - Nein (n)
choice /C JN /N >NUL
if %errorlevel% equ 1 goto Uprepare
if %errorlevel% equ 2 set up=U&set update= - Update (u)&goto Unothing
:Uprepare
cls&if "%language%"=="Deutsch" (%M%&echo Bitte warten...&%M%) else (%M%&echo Please wait...&%M%)
echo true>%userprofile%\IconRepair\update
set new=
start %userprofile%\IconRepair\iconrepairupdater.cmd&exit
:Ulanguage
mode 79,26&title %name% %UV%&set N=echo ___________________________________________________________&set M=echo.
if not exist %userprofile%\IconRepair\update (cls&%M%&echo Error!&timeout 2&exit)
for /f "tokens=3 delims= " %%G in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (if [%%G] EQU [0407] (set language=Deutsch) else (set language=English))
:Uload
cls&if "%language%"=="Deutsch" (%M%&echo Lade Update...&%M%) else (%M%&echo Loading update...&%M%)
if not exist %userprofile%\IconRepair\loc.txt (cls&%M%&echo Error!&timeout 2&exit)
if not exist %userprofile%\IconRepair\name.txt (cls&%M%&echo Error!&timeout 2&exit)
set /p loc=<%userprofile%\IconRepair\loc.txt
set /p IRN=<%userprofile%\IconRepair\name.txt
tasklist /FI "IMAGENAME eq %IRN%" 2>NUL | find /I /N "%IRN%">NUL
if %errorlevel% equ 0 (timeout 3 >NUL&goto Udownload) else (goto Udownload)
:Udownload
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/IconRepair.exe "%loc%"
if %errorlevel% equ 0 (goto USuccessfull) else (goto URetry)
:USuccessfull
del /q %userprofile%\IconRepair\update >NUL&del /q %userprofile%\IconRepair\loc.txt >NUL&del /q %userprofile%\IconRepair\name.txt >NUL
if "%language%"=="Deutsch" (goto DEUSuccessfull) else (goto ENUSuccessfull)
:ENUSuccessfull
cls&echo ^>Update&%M%&echo Successfully updatetd IconRepair :)&echo Please restart IconRepair!&%N%&%M%&%M%&echo  Installed version         - %NB%&%M%&%N%&%M%&echo Restart (r) - Exit (e)
choice /C RE /N >NUL
if %errorlevel% equ 1 start "" "%loc%"&exit
if %errorlevel% equ 2 exit
:DEUSuccessfull
cls&echo ^>Update&%M%&echo IconRepair wurde erfolgreich geupdatet :)&echo Bitte IconRepair neu starten!&%N%&%M%&%M%&echo  Installierte Version      - %NB%&&%M%&%N%&%M%&echo Neu starten (n) - Beenden (b)
choice /C NB /N >NUL
if %errorlevel% equ 1 start "" "%loc%"&exit
if %errorlevel% equ 2 exit
:URetry
if "%language%"=="Deutsch" (goto DEURetry) else (goto ENURetry)
:ENURetry
cls&echo ^>Update&%M%&echo An error has occurred :(&echo Please close all IconRepair processes&echo and try it again!&%N%&%M%&echo Try again (t) - Exit (e)
choice /C TE /N >NUL
if %errorlevel% equ 1 goto Uload
if %errorlevel% equ 2 exit
:DEURetry
cls&echo ^>Update&%M%&echo Es ist ein Fehler aufgetreten :(&echo Bitte beende alle IconRepair Prozesse&echo und versuche es erneut!&%N%&%M%&echo Erneut versuchen (e) - Beenden (b)
choice /C EB /N >NUL
if %errorlevel% equ 1 goto Uload
if %errorlevel% equ 2 exit
:Unothing