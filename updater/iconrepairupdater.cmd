@echo off&set name=IconRepairUpdater&set UV=2.4
if not exist "%userprofile%\IconRepair\" (exit /b)
if not exist "%userprofile%\IconRepair\build" (exit /b)
set /p NB=<"%userprofile%\IconRepair\build"
set UL=echo ___________________________________________________________&set US=echo:
if "%new%"=="new" (if "%V% (%B%)"=="%NB%" (exit /b) else (goto UpdateMain)) else (goto Uset)
:UpdateMain
title %name% %UV%
if "%language%"=="Deutsch" (goto DEUMain) else (goto ENUMain)
:ENUMain
cls&echo ^>Update&%US%&echo Update IconRepair to the latest version?&%UL%&%US%&%US%&echo  Installed version         - %V% (%B%)&echo  Latest version            - %NB%&%US%&%UL%&%US%&echo Yes (y) - No (n)
choice /C YN /N >NUL
if %errorlevel% equ 1 goto Uprepare
if %errorlevel% equ 2 set up=U&set update= - Update (u)&exit /b
:DEUMain
cls&echo ^>Update&%US%&echo IconRepair auf die neueste Version updaten?&%UL%&%US%&%US%&echo  Installierte Version      - %V% (%B%)&echo  Neuste Version            - %NB%&%US%&%UL%&%US%&echo Ja (j) - Nein (n)
choice /C JN /N >NUL
if %errorlevel% equ 1 goto Uprepare
if %errorlevel% equ 2 set up=U&set update= - Update (u)&exit /b
:Uprepare
cls&%US%&if "%language%"=="Deutsch" (echo Bitte warten...) else (echo Please wait...)
echo true>"%userprofile%\IconRepair\update"
set new=
start "" "%userprofile%\IconRepair\iconrepairupdater.cmd"&exit
:Uset
mode 79,26&title %name% %UV%
if not exist "%userprofile%\IconRepair\update" (cls&%US%&echo Error!&timeout 2 >NUL&exit)
:Uload
cls&%US%&if "%language%"=="Deutsch" (echo Lade Update...) else (echo Loading update...)
if not exist "%userprofile%\IconRepair\loc.txt" (cls&%US%&echo Error!&timeout 2 >NUL&exit)
if not exist "%userprofile%\IconRepair\name.txt" (cls&%US%&echo Error!&timeout 2 >NUL&exit)
set /p loc=<"%userprofile%\IconRepair\loc.txt"
set /p IRN=<"%userprofile%\IconRepair\name.txt"
tasklist /FI "ImageName eq %IRN%" >NUL | find /i "%IRN%" >NUL
if %errorlevel% equ 0 (timeout 2 >NUL&goto Udownload) else (goto Udownload)
:Udownload
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/IconRepair.exe "%loc%"
if %errorlevel% equ 0 (goto USuccessfull) else (goto URetry)
:USuccessfull
del /q "%userprofile%\IconRepair\update" >NUL&del /q "%userprofile%\IconRepair\loc.txt" >NUL&del /q "%userprofile%\IconRepair\name.txt" >NUL
if "%language%"=="Deutsch" (goto DEUSuccessfull) else (goto ENUSuccessfull)
:ENUSuccessfull
cls&echo ^>Update&%US%&echo Successfully updatetd IconRepair :)&echo Please restart IconRepair!&%UL%&%US%&%US%&echo  Installed version         - %NB%&%US%&%UL%&%US%&echo Restart (r) - Exit (e)
choice /C RE /N >NUL
if %errorlevel% equ 1 start "" "%loc%"&exit
if %errorlevel% equ 2 exit
:DEUSuccessfull
cls&echo ^>Update&%US%&echo IconRepair wurde erfolgreich geupdatet :)&echo Bitte IconRepair neu starten!&%UL%&%US%&%US%&echo  Installierte Version      - %NB%&&%US%&%UL%&%US%&echo Neu starten (n) - Beenden (b)
choice /C NB /N >NUL
if %errorlevel% equ 1 start "" "%loc%"&exit
if %errorlevel% equ 2 exit
:URetry
if "%language%"=="Deutsch" (goto DEURetry) else (goto ENURetry)
:ENURetry
cls&echo ^>Update&%US%&echo An error has occurred :(&echo Please close all IconRepair processes&echo and try it again!&%UL%&%US%&echo Try again (t) - Exit (e)
choice /C TE /N >NUL
if %errorlevel% equ 1 goto Uload
if %errorlevel% equ 2 exit
:DEURetry
cls&echo ^>Update&%US%&echo Es ist ein Fehler aufgetreten :(&echo Bitte beende alle IconRepair Prozesse&echo und versuche es erneut!&%UL%&%US%&echo Erneut versuchen (e) - Beenden (b)
choice /C EB /N >NUL
if %errorlevel% equ 1 goto Uload
if %errorlevel% equ 2 exit
