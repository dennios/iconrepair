@echo off&mode 79,26&set V=3.2&set B=3205&set RU=2.3&set year=2019&set "optionspath="%userprofile%\IconRepair\options.cmd""
set N=echo ___________________________________________________________&set M=echo.&set R=title IconRepair %V%&set update=&set up=
%R%&%M%&echo Loading...&%M%
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
if exist %optionspath% (call %optionspath%)
if "%saveoptions%"=="" (set saveoptions=Disabled)
if "%udc%"=="" (set udc=Disabled)
if "%coloredfont%"=="" (set coloredfont=Disabled)
if "%echoon%"=="" (set echoon=Disabled)
if "%sound%"=="" (set sound=Default)
if "%adc%"=="" (set adc=Enabled)
if not "%language%"=="Deutsch" (set language=English)
if %saveoptions%==Enabled (if not %sound%==Default (for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Enabled) else (set sound=Disabled))))
if %saveoptions%==Aktiviert (if not %sound%==Standard (for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Aktiviert) else (set sound=Deaktiviert))))
if %saveoptions%==Aktiviert (if not "%winver%"=="" (goto Main)) else (if %saveoptions%==Enabled (if not "%winver%"=="" (goto Main)))
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set winver=%%j.%%k) else (set winver=%%i.%%j))
for /f "tokens=3 delims= " %%l in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (if [%%l] equ [0407] (set language=Deutsch) else (set language=English))
:Main
if "%winver%"=="10.0" (set L=Windows 10&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.3" (set L=Windows 8.1&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.2" (set L=Windows 8&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.1" (set L=Windows 7&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if %language%==Deutsch (goto DEunsupported) else (goto ENunsupported)
:ENunsupported
set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E&set W1=1&set W2=2&set W3=3&set W4=4&set L=
cls&%R%&echo ^> Unknown Windows version
%M%&echo Not available. Only suitable for Windows 7-10!&%N%&%M%&%M%&echo Press o to set the Windows version and language manually.&%M%&%N%&%M%&echo Options (o) - %exit%
choice /C O%ext% /N >NUL
if %errorlevel% equ 1 goto options
if %errorlevel% equ 2 goto end
:DEunsupported
set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B&set W1=1&set W2=2&set W3=3&set W4=4&set L=
cls&%R%&echo ^> Unbekannte Windows Version
%M%&echo Nicht verfuegbar. Nur fuer Windows 7-10 geeignet!&%N%&%M%&%M%&echo Druecke o um die Windows Version und Sprache manuell&echo einzustellen.&%M%&%N%&%M%&echo Optionen (o) - %exit%
choice /C O%ext% /N >NUL
if %errorlevel% equ 1 goto options
if %errorlevel% equ 2 goto end
:update
if %language%==Deutsch (echo Suche nach Updates...) else (echo Checking for updates...)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1&goto update2)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1&goto update2) else (goto set np=0&cls&%M%&echo Error!&timeout 2&goto %updateloc%)
:update2
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build "%userprofile%\IconRepair\build" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto %updateloc%)
set /p NB=<%userprofile%\IconRepair\build
if "%V% (%B%)"=="%NB%" (cls&%M%&echo No updates available!&timeout 2&goto %updateloc%)
set new=new
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
echo %~dpnx0>"%userprofile%\IconRepair\loc.txt"
echo %~nx0>"%userprofile%\IconRepair\name.txt"
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/iconrepairupdater.cmd "%userprofile%\IconRepair\iconrepairupdater.cmd" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto %updateloc%)
call "%userprofile%\IconRepair\iconrepairupdater.cmd"&goto %updateloc%
:update3
if exist "%userprofile%\IconRepair\iconrepairupdater.cmd" (call "%userprofile%\IconRepair\iconrepairupdater.cmd"&if %language%==Deutsch (goto DE%lastloc%) else (goto EN%lastloc%)) else (set update=&if %language%==Deutsch (goto DE%lastloc%) else (goto EN%lastloc%))
:about
cls&echo ^> About - Changelog (l)&%M%&echo Version %V%&echo Build %B%&echo Re. Updater %RU%&echo Year %year%&%M%&echo by dennios&echo https://github.com/dennios/iconrepair/&%N%&%M%&echo %back% - %exit%
choice /C %bck%AL%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto changelog
if %errorlevel% equ 4 if %language%==Deutsch (goto end) else (goto end)
:changelog
cls&echo ^> Changelog&%M%&echo Version %V% (%B%)&echo  +New feature: Delete downloaded Windows update&echo  +Improvements to AudioRepair and UI&echo  +Better updates check&echo  +Cleaner code&echo  +Fixes&%N%&%M%&echo %back% - %exit%
choice /C %bck%L%ext% /N >NUL
if %errorlevel% equ 1 goto about
if %errorlevel% equ 2 goto about
if %errorlevel% equ 3 if %language%==Deutsch (goto end) else (goto end)
:options
set updateloc=options&if %language%==Deutsch (goto DEoptions) else (goto ENoptions)
:ENoptions
set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E
if not %saveoptions%==Enabled (if %saveoptions%==Aktiviert (set saveoptions=Enabled) else (set saveoptions=Disabled))
if not %coloredfont%==Enabled (if %coloredfont%==Aktiviert (set coloredfont=Enabled) else (set coloredfont=Disabled))
if not %udc%==Enabled (if %udc%==Aktiviert (set udc=Enabled) else (set udc=Disabled))
if not %adc%==Disabled (if %adc%==Deaktiviert (set adc=Disabled) else (set adc=Enabled))
if %sound%==Standard (set sound=Default) else (if %sound%==Deaktiviert (set sound=Disabled) else (if %sound%==Aktiviert (set sound=Enabled)))
if not %echoon%==Enabled (if %echoon%==Aktiviert (set echoon=Enabled) else (set echoon=Disabled))
if %saveoptions%==Enabled (if not exist %optionspath% (echo. >%optionspath%))
if %saveoptions%==Enabled (if exist %optionspath% (echo set saveoptions=%saveoptions%>%optionspath%&echo set language=%language%>>%optionspath%&echo set winver=%winver%>>%optionspath%&echo set adc=%adc%>>%optionspath%&echo set udc=%udc%>>%optionspath%&echo set coloredfont=%coloredfont%>>%optionspath%&echo set sound=%sound%>>%optionspath%) else (goto colorfonterror))
if %saveoptions%==Disabled (set re=&set opr=) else (set set re=R&"opr=- Reset (r)")
if "%opr%"=="" (if %coloredfont%==Disabled (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %adc%==Enabled (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %udc%==Disabled (set re=&set opr= ) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %sound%==Default (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %echoon%==Disabled (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
cls&echo ^> Options - Check for updates (u) %opr%
%M%&echo Press the selected number to change options.&%N%&%M%&%M%
if %coloredfont%==Enabled goto ENoptionscoloredfont
echo  1 ^> Save settings             - %saveoptions%&echo  2 ^> Language                  - %language%&echo  3 ^> Windows version           - %L%&echo  4 ^> Administrator check       - %adc%&echo  5 ^> Colored font              - %coloredfont%&echo  6 ^> Experimental options&goto ENoptionscoloredfont1
:ENoptionscoloredfont
call :colorfont 07 " 1. Save settings             -"&if %saveoptions%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
call :colorfont 07 " 2. Language                  - %language%"&%M%&call :colorfont 07 " 3. Windows version           - %L%"&%M%
call :colorfont 07 " 4. Administrator check       -"&if %adc%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
call :colorfont 07 " 5. Colored font              -"&if %coloredfont%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
call :colorfont 07 " 6. Experimental options"&%M%
:ENoptionscoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%O%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 goto EN%lastloc%
if %errorlevel% equ 2 goto EN%lastloc%
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENsaveoptions
if %errorlevel% equ 5 if %language%==Deutsch (set language=English&goto options) else (set language=Deutsch&goto options)
if %errorlevel% equ 6 goto ENwinversion
if %errorlevel% equ 7 goto ENadmincheck
if %errorlevel% equ 8 if %coloredfont%==Enabled (set coloredfont=Disabled&goto options) else (set coloredfont=Enabled&goto options)
if %errorlevel% equ 9 goto ENexperimentaloptions
if %errorlevel% equ 10 goto update
if %errorlevel% equ 11 goto ENreset
:ENexperimentaloptions
if %saveoptions%==Enabled (if not exist %optionspath% (echo. >%optionspath%))
if %saveoptions%==Enabled (if exist %optionspath% (echo set saveoptions=%saveoptions%>%optionspath%&echo set language=%language%>>%optionspath%&echo set winver=%winver%>>%optionspath%&echo set adc=%adc%>>%optionspath%&echo set udc=%udc%>>%optionspath%&echo set coloredfont=%coloredfont%>>%optionspath%&echo set sound=%sound%>>%optionspath%) else (goto colorfonterror))
if "%opr%"=="" (if %coloredfont%==Disabled (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %adc%==Enabled (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %udc%==Disabled (set re=&set opr= ) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %sound%==Default (set re=&set opr=) else (set re=R&set "opr=- Reset (r)"))
if "%opr%"=="" (if %echoon%==Disabled (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
cls&echo ^> Experimental options %opr%
%M%&echo Press the selected number to change options.&%N%&%M%&%M%
if %coloredfont%==Enabled (goto ENexperimentaloptionscoloredfont)
echo  1 ^> Auto update check         - %udc%&echo  2 ^> Sound                     - %sound%&echo  3 ^> Echo on                   - %echoon%&goto ENexperimentaloptionscoloredfont1
:ENexperimentaloptionscoloredfont
call :colorfont 07 " 1. Auto update check         -"&if %udc%==Enabled (call :colorfont 0C " Enabled"&%M%) else (call :colorfont 0a " Disabled"&%M%)
call :colorfont 07 " 2. Sound                     -"&if %sound%==Default (call :colorfont 0a " Default"&%M%) else (if %sound%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%))
call :colorfont 07 " 3. Echo on                   -"&if %echoon%==Enabled (call :colorfont 0C " Enabled"&%M%) else (call :colorfont 0a " Disabled"&%M%)
:ENexperimentaloptionscoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto options
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %udc%==Enabled (set udc=Disabled&set update=&set up=&goto ENexperimentaloptions) else (set udc=Enabled&set np=&goto ENexperimentaloptions)
if %errorlevel% equ 5 goto ENsound
if %errorlevel% equ 6 if %echoon%==Enabled (@echo off&set echoon=Disabled&goto ENexperimentaloptions) else (@echo on&set echoon=Enabled&goto ENexperimentaloptions)
if %errorlevel% equ 7 goto ENreset
:ENreset
cls&%M%&echo Reset settings?&%M%&echo Important: Settings will be deleted!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C YR%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENreset1
if %errorlevel% equ 2 goto ENreset1
if %errorlevel% equ 3 goto options
if %errorlevel% equ 4 goto end
:ENreset1
set sound=Default&set coloredfont=Disabled&set udc=Disabled&set adc=Enabled&set saveoptions=Disabled&set echoon=Disabled&del /f /q %optionspath%&goto options
:ENsound
cls&%M%&echo Checking for administrator rights...&%M%
if %adc%==Enabled (goto ENsound1)
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:ENsound1
if %admin% equ 0 (goto ENsounderror)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Enabled) else (set sound=Disabled))
if %sound%==Enabled (goto ENsounddisable)
if %sound%==Disabled (goto ENsoundenable)
:ENsounddisable
cls&%M%&echo Disable sound...&%M%
sc stop beep >NUL
if %errorlevel% neq 0 (goto ENsounderror)
if %saveoptions%==Enabled (sc config beep start= disabled >NUL)
set sound=Disabled&goto ENexperimentaloptions
:ENsoundenable
cls&%M%&echo Enable sound...&%M%
if %saveoptions%==Enabled (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto ENsounderror)
set sound=Enabled&goto ENexperimentaloptions
:ENsounderror
cls&%M%&echo Error! Please try it again.&%M%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%N%&timeout 4&goto options
:ENwinversion
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%L%)&echo ^> Windows version ^> %L%
%M%&echo Press the selected number to change options.&%N%&%M%&%M%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%M%&%N%&%M%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set L=Windows 10&goto ENwinversion) else (set winver=6.3&set L=Windows 8.1&goto ENwinversion)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set L=Windows 8.1&goto ENwinversion) else (set winver=6.2&set L=Windows 8&goto ENwinversion)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set L=Windows 8&goto ENwinversion) else (set winver=6.1&set L=Windows 7&goto ENwinversion)
if %errorlevel% equ 4 goto options
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set winver=6.1&set L=Windows 7&goto ENwinversion
:ENadmincheck
if %adc%==Disabled (set adc=Enabled&goto options)
cls&%M%&echo %acde% administrator check?&%M%&echo Important: Disabling this can lead to problems!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 set adc=Disabled&goto options
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
:ENsaveoptions
if %saveoptions%==Enabled (goto ENsaveoptionsdisable) else (set saveoptions=Enabled&if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\"))
if not exist %optionspath% (echo >%optionspath%)
if not exist %optionspath% (goto colorfonterror) else (goto options)
:ENsaveoptionsdisable
cls&%M%&echo Disable save settings?&%M%&echo Important: Settings will be deleted if this option is&echo            deactivated!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENsaveoptionsdisable1
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
:ENsaveoptionsdisable1
set saveoptions=Disabled&del /f /q %optionspath%
if %errorlevel% neq 0 (goto colorfonterror)
goto options
:DEoptions
set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B
if not %saveoptions%==Aktiviert (if %saveoptions%==Enabled (set saveoptions=Aktiviert) else (set saveoptions=Deaktiviert))
if not %coloredfont%==Aktiviert (if %coloredfont%==Enabled (set coloredfont=Aktiviert) else (set coloredfont=Deaktiviert))
if not %udc%==Aktiviert (if %udc%==Enabled (set udc=Aktiviert) else (set udc=Deaktiviert))
if not %adc%==Deaktiviert (if %adc%==Disabled (set adc=Deaktiviert) else (set adc=Aktiviert))
if %sound%==Default (set sound=Standard) else (if %sound%==Disabled (set sound=Deaktiviert) else (if %sound%==Enabled (set sound=Aktiviert)))
if not %echoon%==Aktiviert (if %echoon%==Enabled (set echoon=Aktiviert) else (set echoon=Deaktiviert))
if %saveoptions%==Aktiviert (if not exist %optionspath% (echo. >%optionspath%))
if %saveoptions%==Aktiviert (if exist %optionspath% (echo set saveoptions=%saveoptions%>%optionspath%&echo set language=%language%>>%optionspath%&echo set winver=%winver%>>%optionspath%&echo set adc=%adc%>>%optionspath%&echo set udc=%udc%>>%optionspath%&echo set coloredfont=%coloredfont%>>%optionspath%&echo set sound=%sound%>>%optionspath%) else (goto colorfonterror))
if %saveoptions%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)")
if "%opr%"=="" (if %coloredfont%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %adc%==Aktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %udc%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %sound%==Standard (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %echoon%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
cls&echo ^> Optionen - Nach Updates suchen (u) %opr%
%M%&echo Druecke die ausgewaehlte Nummer um Optionen zu aendern.&%N%&%M%&%M%
if %coloredfont%==Aktiviert (goto DEoptionscoloredfont)
echo  1 ^> Einstellungen speichern   - %saveoptions%&echo  2 ^> Sprache                   - %language%&echo  3 ^> Windows Version           - %L%&echo  4 ^> Administrator check       - %adc%&echo  5 ^> Farbige Schrift           - %coloredfont%&echo  6 ^> Experimentelle Optionen&goto DEoptionscoloredfont1
:DEoptionscoloredfont
call :colorfont 07 " 1. Einstellungen speichern   -"&if %saveoptions%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
call :colorfont 07 " 2. Sprache                   - %language%"&%M%&call :colorfont 07 " 3. Windows Version           - %L%"&%M%
call :colorfont 07 " 4. Administrator check       -"&if %adc%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
call :colorfont 07 " 5. Farbige Schrift           -"&if %coloredfont%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
call :colorfont 07 " 6. Experimentelle Optionen"&%M%
:DEoptionscoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%O%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 goto DE%lastloc%
if %errorlevel% equ 2 goto DE%lastloc%
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEsaveoptions
if %errorlevel% equ 5 if %language%==Deutsch (set language=English&goto options) else (set language=Deutsch&goto options)
if %errorlevel% equ 6 goto DEwinversion
if %errorlevel% equ 7 goto DEadmincheck
if %errorlevel% equ 8 if %coloredfont%==Aktiviert (set coloredfont=Deaktiviert&goto options) else (set coloredfont=Aktiviert&goto options)
if %errorlevel% equ 9 goto DEexperimentaloptions
if %errorlevel% equ 10 goto update
if %errorlevel% equ 11 goto DEreset
:DEexperimentaloptions
if %saveoptions%==Aktiviert (if not exist %optionspath% (echo. >%optionspath%))
if %saveoptions%==Aktiviert (if exist %optionspath% (echo set saveoptions=%saveoptions%>%optionspath%&echo set language=%language%>>%optionspath%&echo set winver=%winver%>>%optionspath%&echo set adc=%adc%>>%optionspath%&echo set udc=%udc%>>%optionspath%&echo set coloredfont=%coloredfont%>>%optionspath%&echo set sound=%sound%>>%optionspath%) else (goto colorfonterror))
if "%opr%"=="" (if %coloredfont%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %adc%==Aktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %udc%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %sound%==Standard (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
if "%opr%"=="" (if %echoon%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)"))
cls&echo ^> Experimentelle Optionen %opr%
%M%&echo Druecke die ausgewaehlte Nummer um Optionen zu aendern.&%N%&%M%&%M%
if %coloredfont%==Aktiviert goto DEexperimentaloptionscoloredfont
echo  1 ^> Auto Update check         - %udc%&echo  2 ^> Ton                       - %sound%&echo  3 ^> Echo on                   - %echoon%&goto DEexperimentaloptionscoloredfont1
:DEexperimentaloptionscoloredfont
call :colorfont 07 " 1. Auto Update check         -"&if %udc%==Aktiviert (call :colorfont 0C " Aktiviert"&%M%) else (call :colorfont 0a " Deaktiviert"&%M%)
call :colorfont 07 " 2. Ton                       -"&if %sound%==Standard (call :colorfont 0a " Standard"&%M%) else (if %sound%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%))
call :colorfont 07 " 3. Echo on                   -"&if %echoon%==Aktiviert (call :colorfont 0C " Aktiviert"&%M%) else (call :colorfont 0a " Deaktiviert"&%M%)
:DEexperimentaloptionscoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto options
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %udc%==Aktiviert (set udc=Deaktiviert&set update=&set up=&goto DEexperimentaloptions) else (set udc=Aktiviert&set np=&goto DEexperimentaloptions)
if %errorlevel% equ 5 goto DEsound
if %errorlevel% equ 6 if %echoon%==Aktiviert (@echo off&set echoon=Deaktiviert&goto DEexperimentaloptions) else (@echo on&set echoon=Aktiviert&goto DEexperimentaloptions)
if %errorlevel% equ 7 goto DEreset
:DEreset
cls&%M%&echo Einstellungen zuruecksetzen?&%M%&echo Wichtig: Einstellungen werden geloescht!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C JR%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEreset1
if %errorlevel% equ 2 goto DEreset1
if %errorlevel% equ 3 goto options
if %errorlevel% equ 4 goto end
:DEreset1
set sound=Standard&set coloredfont=Deaktiviert&set udc=Deaktiviert&set adc=Aktiviert&set saveoptions=Deaktiviert&set echoon=Deaktiviert&del /f /q %optionspath%&goto options
:DEsound
cls&%M%&echo Pruefe auf Administratorrechte...&%N%
if %adc%==Aktiviert (goto DEsound1)
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:DEsound1
if %admin% equ 0 (goto DEsounderror)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Aktiviert) else (set sound=Deaktiviert))
if %sound%==Aktiviert (goto DEsounddisable)
if %sound%==Deaktiviert (goto DEsoundenable)
:DEsounddisable
cls&%M%&echo Ton deaktivieren...&%N%
sc stop beep >NUL
if %errorlevel% neq 0 (goto DEsounderror)
if %saveoptions%==Aktiviert (sc config beep start= disabled >NUL)
set sound=Deaktiviert&goto DEexperimentaloptions
:DEsoundenable
cls&%M%&echo Ton aktivieren...&%N%
if %saveoptions%==Aktiviert (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto DEsounderror)
set sound=Aktiviert&goto DEexperimentaloptions
:DEsounderror
cls&%M%&echo Fehler! Bitte versuche es erneut.&%M%&echo Wichtig: Um diese Einstellung zu aendern muss IconRepair&echo          als Administrator gestartet werden!&%N%&timeout 4&goto options
:DEwinversion
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%L%)&echo ^> Windows version ^> %L%
%M%&echo Druecke die ausgewaehlte Nummer um Optionen zu aendern.&%N%&%M%&%M%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%M%&%N%&%M%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set L=Windows 10&goto DEwinversion) else (set winver=6.3&set L=Windows 8.1&goto DEwinversion)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set L=Windows 8.1&goto DEwinversion) else (set winver=6.2&set L=Windows 8&goto DEwinversion)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set L=Windows 8&goto DEwinversion) else (set winver=6.1&set L=Windows 7&goto DEwinversion)
if %errorlevel% equ 4 goto options
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set winver=6.1&set L=Windows 7&goto DEwinversion
:DEadmincheck
if %adc%==Deaktiviert (set adc=Aktiviert&goto options)
cls&%M%&echo Administrator check deaktivieren?&%M%&echo Wichtig: Das deaktivieren kann zu Problemen fuehren!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 set adc=Deaktiviert&goto options
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
:DEsaveoptions
if %saveoptions%==Aktiviert (goto DEsaveoptionsdisable) else (set saveoptions=Aktiviert&if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\"))
if not exist %optionspath% (echo >%optionspath%)
if not exist %optionspath% (goto colorfonterror) else (goto options)
:DEsaveoptionsdisable
cls&%M%&echo Einstellungen speichern deaktivieren?&%M%&echo Wichtig: Einstellungen werden geloescht wenn diese Option&echo          deaktiviert wird!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEsaveoptionsdisable1
if %errorlevel% equ 2 goto options
if %errorlevel% equ 3 goto end
:DEsaveoptionsdisable1
set saveoptions=Deaktiviert&del /f /q %optionspath%
if %errorlevel% neq 0 (goto colorfonterror)
goto options
:ENMain
set lastloc=Main&set updateloc=ENMain&set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E
cls&%R% (%L%)&echo About (a) - Options (o)%update%
%M%&echo Press the selected number to continue.&echo For more information press i!&%N%&%M%&%M%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> System options&%M%&%N%&%M%&echo %exit%
if %udc%==Enabled (if "%np%"=="" (goto update))
if %adc%==Disabled (if "%admin%"=="" (set admin=0&goto ENadmincheckdisabled) else (goto ENadmincheckdisabled)) else (if not "%admin%"=="" (goto ENadmincheckdisabled))
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:ENadmincheckdisabled
choice /C 1234%ext%IAO%up% /N >NUL
if %errorlevel% equ 1 goto ENiconrepair
if %errorlevel% equ 2 goto ENnetworkrepairperm
if %errorlevel% equ 3 goto ENaudiorepairperm
if %errorlevel% equ 4 goto ENSystem
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 goto ENMinformation
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto options
if %errorlevel% equ 9 goto update3
:ENMinformation
cls&echo ^> Information&%M%&echo IconRepair&echo  Tries to fix invisible icons on the desktop and in the&echo  taskbar by renewing the icon cache.&%N%&%M%&echo NetworkRepair&echo  Tries to fix network disconnections by renewing the&echo  network connection.&%N%&%M%&echo AudioRepair&echo  Tries to fix audio problems by restarting all audio&echo  drivers.&%N%&%M%&echo System options&echo  Ability to quickly restart Windows Explorer or cancel&echo  planned shutdown from Windows and more.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto end
:ENiconrepair
cls&%M%&echo Start IconRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto EN7iconrepair) else (goto EN10iconrepair)
if %errorlevel% equ 2 if %winver%==6.1 (goto EN7iconrepair) else (goto EN10iconrepair)
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:EN10iconrepair
cls&%M%&echo Clearing icon cache...&%M%
taskkill /f /im explorer.exe
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
start explorer.exe
cls&%M%&echo Finished!&%M%&%IRe%
echo If the problem is not solved yet,&echo try to restart the PC.&%N%&%M%&echo Try again (t) - %back% - %exit%
choice /C %ext%S1%bck%T /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto EN10iconrepair
:EN7iconrepair
cls&%M%&echo Clearing icon cache...&%M%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
start explorer.exe
cls&%M%&echo Finished!&%M%&%IRe%
echo If the problem is not solved yet,&echo try to restart the PC.&%N%&%M%&echo Try again (t) - %back% - %exit%
choice /C %ext%S1%bck%T /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto EN7iconrepair
:ENnetworkrepairperm
if %adc%==Disabled (goto ENnetworkrepair) else (if %admin% equ 1 (goto ENnetworkrepair))
cls&%M%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENnetworkrepair
if %errorlevel% equ 2 goto ENnetworkrepair
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENnetworkrepair
cls&%M%&echo Start NetworkRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENnetworkrepair1
if %errorlevel% equ 2 goto ENnetworkrepair1
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENnetworkrepair1
cls&%M%&echo Renewing the network connection...&%M%
ipconfig /release >NUL
if %errorlevel% neq 0 (set NRe=echo Please try again with administrator rights!) else (set NRe=)
ipconfig /flushdns >NUL
if %errorlevel% neq 0 (set NRe=echo Please try again with administrator rights!) else (set NRe=)
ipconfig /registerdns >NUL&ipconfig /renew >NUL
netsh interface set interface Ethernet disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Ethernet enabled >NUL)
netsh interface set interface Wi-Fi disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Wi-Fi enabled >NUL)
cls&%M%&echo Finished!&%NRe%
%M%&echo If the problem is not solved yet,&echo try to restart the router and the PC.&%N%&%M%&echo Try again (t) - %back% - %exit%
choice /C %ext%S2%bck%T /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto ENnetworkrepair1
:ENaudiorepairperm
if %adc%==Disabled (goto ENaudiorepair) else (if %admin% equ 1 (goto ENaudiorepair))
cls&%M%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENaudiorepair
if %errorlevel% equ 2 goto ENaudiorepair
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENaudiorepair
cls&%M%&echo Start AudioRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENaudiorepair1
if %errorlevel% equ 2 goto ENaudiorepair1
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENaudiorepair1
cls&%M%&echo Restarting audio drivers...&%M%
sc query audiosrv | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto ENaudiorepair2)
sc stop audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
sc query AudioEndpointBuilder | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto ENaudiorepair2)
sc stop AudioEndpointBuilder >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
:ENaudiorepair2
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 1 >NUL&goto ENaudiorepair2) else (set "ARe=echo Please try again with administrator rights!"))
sc query RzSurroundVADStreamingService | FIND "STATE" | FIND "RUNNING"
if %errorlevel% equ 0 (sc stop RzSurroundVADStreamingService >NUL&timeout 2 >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%M%&echo Finished!&%ARe%
%M%&echo If the problem is not solved yet,&echo try to restart the PC.&%N%&%M%&echo Try again (t) - %back% - %exit%
choice /C %ext%S3%bck%T /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto ENaudiorepair1
:ENSystem
set lastloc=System&set sd=&set sda=&set sdM=
cls&echo ^> System options - Options (o)%update%
%M%&echo Press the selected number to continue.&echo For more information press i!&%N%&%M%&%M%&echo  1 ^> Restart windows explorer&echo  2 ^> Start windows CMD&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&echo  5 ^> Delete Windows update&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO12345%up% /N >NUL
if %errorlevel% equ 1 goto ENMain
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto ENSinformation
if %errorlevel% equ 4 goto options
if %errorlevel% equ 5 goto ENSrestartexplorer
if %errorlevel% equ 6 goto ENSstartcmd
if %errorlevel% equ 7 goto ENSShutdown
if %errorlevel% equ 8 goto ENSPatch
if %errorlevel% equ 9 goto ENSdeleteupdateperm
if %errorlevel% equ 10 goto update3
:ENSinformation
cls&echo ^> System options ^> Information&%M%&echo Restart windows explorer&echo  Restarts Windows Explorer to solve minor problems.&%N%&%M%&echo Start windows CMD&echo  Starts the command prompt to execute commands manually.&%N%&%M%&echo Shutdown menu&echo  Shutdown the PC.&%N%&%M%&echo Security menu&echo  Create .dat files in the system32 folder and edit the&echo  registry which could prevent Windows against malware.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto ENSystem
if %errorlevel% equ 3 goto end
:ENSrestartexplorer
cls&%M%&echo Restart Windows Explorer?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSrestartexplorer1
if %errorlevel% equ 2 goto ENSrestartexplorer1
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSrestartexplorer1
taskkill /f /IM explorer.exe
if %errorlevel% neq 0 (goto ENSerror)
timeout 1&start explorer.exe
if %errorlevel% neq 0 (goto ENSerror)
goto ENSPfinish
:ENSstartcmd
start
if %errorlevel% neq 0 (if %errorlevel% neq 6 (goto ENSerror))
goto ENSystem
:ENSShutdown
set lastloc=SShutdown
cls&echo ^> Shutdown menu - Options (o)%update%&%M%&echo Press the selected number to continue.&%N%&%M%&%M%&echo  1 ^> Instand shutdown&echo  2 ^> Shutdown PC in the next few minutes&echo  3 ^> Enter time yourself&echo  4 ^> Instand restart&echo  5 ^> Cancel shutdown&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%O12345%up% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto options
if %errorlevel% equ 4 goto ENSSimmediately
if %errorlevel% equ 5 goto ENSSshutdown
if %errorlevel% equ 6 goto ENSScustom
if %errorlevel% equ 7 goto ENSSrestart
if %errorlevel% equ 8 goto ENSScancel
if %errorlevel% equ 9 goto update3
:ENSSimmediately
cls&%M%&echo Shutdown PC immediately?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSimmediately1
if %errorlevel% equ 2 goto ENSSimmediately1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSimmediately1
timeout 1 >NUL&shutdown
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENSShutdown
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENSShutdown
set sd=Cancel shutdown (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSPfinish
:ENSSshutdown
cls&%M%&echo Shutdown PC in the next few minutes?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSshutdown1
if %errorlevel% equ 2 goto ENSSshutdown1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSshutdown1
timeout 1 >NUL&shutdown /s
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENSShutdown
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENSShutdown
set sd=Cancel shutdown (c)&set sd=echo Set time: In the next few minutes&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSPfinish
:ENSScustom
cls&%M%&echo Specify time in seconds (numbers only/max. 99999).&echo Confirm with enter!&%N%&%M%&echo %back%&%M%
set /p sdz=
if "%sdz%"=="b" goto ENSShutdown
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto ENSScustom)
cls&%M%&echo Shutdown PC in %sdz% seconds?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSScustom1
if %errorlevel% equ 2 goto ENSScustom
if %errorlevel% equ 3 goto end
:ENSScustom1
shutdown -s -t %sdz%
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENSShutdown
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&echo Please use only numbers (max. 99999).&%N%&timeout 4&goto ENSShutdown
set sd2=echo Cancel shutdown (c)&set sd=echo Set time: %sdz%s&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSPfinish
:ENSSrestart
cls&%M%&echo Restart PC immediately?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSrestart1
if %errorlevel% equ 2 goto ENSSrestart1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSrestart1
timeout 1 >NUL&shutdown -r
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENSShutdown
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENSShutdown
set sd2=Cancel restart (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSPfinish
:ENSScancel
shutdown /a
if %errorlevel% equ 1116 cls&%M%&echo No operation aborted&%N%&timeout 4&goto ENSShutdown
if %errorlevel% equ 0 cls&%M%&echo Operation canceled&%N%&timeout 4&goto ENSShutdown
cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENSShutdown
goto ENSShutdown
:ENSPatch
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Enabled) else (set C2=Disabled)
set lastloc=SPatch
cls&echo ^> Security menu - Options (o)%update%&%M%&echo Press the selected number to continue.&echo For more information press i!&%N%&%M%&%M%
if exist "%windir%\perfc.dll" (set C1=Enabled) else (set C1=Disabled)
if exist "%windir%\cscc.dat" (set C3=Enabled) else (set C3=Disabled)
if %coloredfont%==Enabled (goto ENSPatchcoloredfont)
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%&goto ENSPatchcoloredfont1
:ENSPatchcoloredfont
call :colorfont 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
call :colorfont 07 " 2. Petya 2 Patch             -"&if %C2%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
call :colorfont 07 " 3. BadRabbit Patch           -"&if %C3%==Enabled (call :colorfont 0a " Enabled"&%M%) else (call :colorfont 0C " Disabled"&%M%)
:ENSPatchcoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO123%up% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto ENSPinformation
if %errorlevel% equ 4 goto options
if %errorlevel% equ 5 if %C1%==Enabled (goto ENSPpetyadisable) else (goto ENSPpetyaenable)
if %errorlevel% equ 6 if %C2%==Enabled (goto ENSPpetya2disable) else (goto ENSPpetya2enable)
if %errorlevel% equ 7 if %C2%==Enabled (goto ENSPbadrabbitdisable) else (goto ENSPbadrabbitenable)
if %errorlevel% equ 8 goto update3
:ENSPinformation
cls&echo ^> Security menu ^> Information&%M%&echo Petya/NotPetya&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%N%&%M%&echo Petya 2&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%N%&%M%&echo BadRabbit&echo  Protects Windows from BadRabbit ransomware.&echo  Read: https://securelist.com/bad-rabbit-ransomware/82851/&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPatch
if %errorlevel% equ 2 goto ENSPatch
if %errorlevel% equ 3 goto end
:ENSPpetyaenable
cls&%M%&echo Patch Windows against Petya/NotPetya?&%M%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetyaenable1
if %errorlevel% equ 2 goto ENSPpetyaenable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetyaenable1
cls&%M%&echo Enabling Petya/NotPetya patch...&%M%
echo Generated by IconRepair > %windir%\perfc.dll
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair > %windir%\perfc.dat
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair > %windir%\perfc
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
goto ENSPatch
:ENSPpetyadisable
cls&%M%&echo Disable patch against Petya/NotPetya?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetyadisable1
if %errorlevel% equ 2 goto ENSPpetyadisable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetyadisable1
cls&%M%&echo Disabling Petya/NotPetya patch...&%M%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENSPerror)
del /f /q %windir%\perfc.dll >NUL
if %errorlevel% neq 0 (goto ENSPerror)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc.dat >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc >NUL
goto ENSPatch
:ENSPpetya2enable
cls&%M%&echo Patch Windows against Petya 2?&%M%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetya2enable1
if %errorlevel% equ 2 goto ENSPpetya2enable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetya2enable1
cls&%M%&echo Enabling Petya 2 patch...&%M%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto ENSPatch) else (goto ENSPerror)
:ENSPpetya2disable
cls&%M%&echo Disable patch against Petya 2?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetya2disable1
if %errorlevel% equ 2 goto ENSPpetya2disable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetya2disable1
cls&%M%&echo Disabling Petya 2 patch...&%M%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto ENSPatch) else (goto ENSPerror)
:ENSPbadrabbitenable
cls&%M%&echo Patch Windows against BadRabbit?&%M%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPbadrabbitenable1
if %errorlevel% equ 2 goto ENSPbadrabbitenable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPbadrabbitenable1
cls&%M%&echo Enabling BadRabbit patch...&%M%
echo Generated by IconRepair > %windir%\cscc.dat
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair > %windir%\infpub.dat
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
goto ENSPatch
:ENSPbadrabbitdisable
cls&%M%&echo Disable patch against BadRabbit?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPbadrabbitdisable1
if %errorlevel% equ 2 goto ENSPbadrabbitdisable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPbadrabbitdisable1
cls&%M%&echo Disabling BadRabbit patch...&%M%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENSPerror)
del /f /q %windir%\cscc.dat >NUL
if %errorlevel% neq 0 (goto ENSPerror)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\infpub.dat >NUL
goto ENSPatch
:ENSPerror
cls&%M%&echo An error occurred!&%M%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%N%&timeout 4&goto ENSPatch
:ENSPfinish
cls&%M%&echo Finished!&%sdM2%
%sdM%
%sdM%
%sd%
%sd2%
%sdM%
%N%&%M%&echo %back% - %exit%
choice /C %ext%1234%bck%%sda% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 exit
if %errorlevel% equ 5 exit
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENSystem
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENSScancel
:ENSdeleteupdateperm
if %adc%==Disabled (goto ENSdeleteupdate) else (if %admin% equ 1 (goto ENSdeleteupdate))
cls&%M%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSdeleteupdate
if %errorlevel% equ 2 goto ENSdeleteupdate
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSdeleteupdate
cls&%M%&echo Delete the downloaded Windows update?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSdeleteupdate1
if %errorlevel% equ 2 goto ENSdeleteupdate1
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSdeleteupdate1
if not exist "%systemroot%\SoftwareDistribution\Download\" (cls&%M%&echo No update found.&%N%&timeout 4&goto ENSystem)
cls&%M%&echo Delete update...&%N%
sc stop wuauserv >NUL&sc stop bits >NUL
rd /S /Q "%systemroot%\SoftwareDistribution\" >NUL
cls&%M%&echo Finished!&%N%&timeout 4&goto ENSystem
:ENSerror
cls&%M%&echo An error occurred!&%N%&timeout 4&goto ENSystem
:DEMain
set lastloc=Main&set updateloc=DEMain&set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B
cls&%R% (%L%)&echo About (a) - Optionen (o)%update%
%M%&echo Druecke die ausgewaehlte Nummer um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> Systemoptionen&%M%&%N%&%M%&echo %exit%
if %udc%==Aktiviert (if "%np%"=="" (goto update))
if %adc%==Deaktiviert (if "%admin%"=="" (set admin=0&goto DEadmincheckdisabled) else (goto DEadmincheckdisabled)) else (if not "%admin%"=="" (goto DEadmincheckdisabled))
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:DEadmincheckdisabled
choice /C 1234%ext%IAO%up% /N >NUL
if %errorlevel% equ 1 goto DEiconrepair
if %errorlevel% equ 2 goto DEnetworkrepairperm
if %errorlevel% equ 3 goto DEaudiorepairperm
if %errorlevel% equ 4 goto DESystem
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 goto DEMinformation
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto options
if %errorlevel% equ 9 goto update3
:DEMinformation
cls&echo ^> Information&%M%&echo IconRepair&echo  Versucht, unsichtbare Symbole auf dem Desktop und in der&echo  Taskleiste zu beheben, indem der icon cache erneuert&echo  wird.&%N%&%M%&echo NetworkRepair&echo  Versucht, Netzwerkunterbrechungen zu beheben, indem die&echo  Netzwerkverbindung erneuert wird.&%N%&%M%&echo AudioRepair&echo  Versucht, Audioprobleme durch einen Neustart der&echo  Audiotreiber zu beheben.&%N%&%M%&echo Systemoptionen&echo  Moeglichkeit zum schnellen Neustart von Windows Explorer&echo  oder Abbrechen des geplanten Herunterfahrens von Windows&echo  und mehr.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto end
:DEiconrepair
cls&%M%&echo IconRepair starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto DE7iconrepair) else (goto DE10iconrepair)
if %errorlevel% equ 2 if %winver%==6.1 (goto DE7iconrepair) else (goto DE10iconrepair)
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DE10iconrepair
cls&%M%&echo Loesche Iconcaches...&%N%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
start explorer.exe
cls&%M%&echo Fertig!&%IRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%N%&%M%&echo Erneut versuchen (e) - %back% - %exit%
choice /C %ext%S1%bck%E /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DE10iconrepair
:DE7iconrepair
cls&%M%&echo Loesche Iconcache...&%N%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
start explorer.exe
cls&%M%&echo Fertig!&%IRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%N%&%M%&echo Erneut versuchen (e) - %back% - %exit%
choice /C %ext%S1%bck%E /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DE7iconrepair
:DEnetworkrepairperm
if %adc%==Deaktiviert (goto DEnetworkrepair) else (if %admin% equ 1 (goto DEnetworkrepair))
cls&%M%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEnetworkrepair
if %errorlevel% equ 2 goto DEnetworkrepair
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEnetworkrepair
cls&%M%&echo NetworkRepair starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEnetworkrepair1
if %errorlevel% equ 2 goto DEnetworkrepair1
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEnetworkrepair1
cls&%M%&echo Erneuerung der Netzwerkverbindung...&%N%
ipconfig /release >NUL
if %errorlevel% neq 0 (set NRe=echo Bitte mit administrator rechten erneut versuchen!) else (set NRe=)
ipconfig /flushdns >NUL
if %errorlevel% neq 0 (set NRe=echo Bitte mit administrator rechten erneut versuchen!) else (set NRe=)
ipconfig /registerdns >NUL&ipconfig /renew >NUL
netsh interface set interface Ethernet disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Ethernet enabled >NUL)
netsh interface set interface WLAN disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface WLAN enabled >NUL)
cls&%M%&echo Fertig!&%NRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den Router und PC neu zu starten.&%N%&%M%&echo Erneut versuchen (e) - %back% - %exit%
choice /C %ext%S2%bck%E /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DEnetworkrepair1
:DEaudiorepairperm
if %adc%==Deaktiviert (goto DEaudiorepair) else (if %admin% equ 1 (goto DEaudiorepair))
cls&%M%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEaudiorepair
if %errorlevel% equ 2 goto DEaudiorepair
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEaudiorepair
cls&%M%&echo AudioReapir starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEaudiorepair1
if %errorlevel% equ 2 goto DEaudiorepair1
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEaudiorepair1
cls&%M%&echo Audiotreiber neu starten...&%N%
sc query audiosrv | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto DEaudiorepair2)
sc stop audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
sc query AudioEndpointBuilder | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto DEaudiorepair2)
sc stop AudioEndpointBuilder >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
:DEaudiorepair2
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 1 >NUL&goto DEaudiorepair2) else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!"))
sc query RzSurroundVADStreamingService | FIND "STATE" | FIND "RUNNING"
if %errorlevel% equ 0 (sc stop RzSurroundVADStreamingService >NUL&timeout 2 >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%M%&echo Fertig!&%ARe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%N%&%M%&echo Erneut versuchen (e) - %back% - %exit%
choice /C %ext%S3%bck%E /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DEaudiorepair1
:DESystem
set lastloc=System&set sd=&set sda=&set sdM=
cls&echo ^> Systemoptionen - Optionen (o)%update%
%M%&echo Druecke die ausgewaehlte Nummer um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%&echo  1 ^> Windows Explorer neu starten&echo  2 ^> Windows CMD starten&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&echo  5 ^> Windows Update loeschen&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO12345%up% /N >NUL
if %errorlevel% equ 1 goto DEMain
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto DESinformation
if %errorlevel% equ 4 goto options
if %errorlevel% equ 5 goto DESrestartexplorer
if %errorlevel% equ 6 goto DESstartcmd
if %errorlevel% equ 7 goto DESShutdown
if %errorlevel% equ 8 goto DESPatch
if %errorlevel% equ 9 goto DESdeleteupdateperm
if %errorlevel% equ 10 goto update3
:DESinformation
cls&echo ^> Systemoptionen ^> Information&%M%&echo Windows Explorer neu starten&echo  Startet den Windows Explorer neu, um kleinere probleme&echo  zu loesen.&%N%&%M%&echo Windows CMD starten&echo  Startet die Eingabeaufforderung um Befehle manuell&echo  auszufuehren.&%N%&%M%&echo Shutdown menu&echo  Faehrt den PC in ausgewaehlter Zeit herunter.&%N%&%M%&echo Security menu&echo  Erstellt .dat Dateien im system32 Ordner und editiert&echo  die Registry, um den Computer vielleicht vor Malware zu&echo  schuetzen.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto DESystem
if %errorlevel% equ 3 goto end
:DESrestartexplorer
cls&%M%&echo Windows Explorer neu starten?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESrestartexplorer1
if %errorlevel% equ 2 goto DESrestartexplorer1
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESrestartexplorer1
taskkill /f /IM explorer.exe
if %errorlevel% neq 0 (goto DESerror)
timeout 1 >NUL&start explorer.exe
if %errorlevel% neq 0 (goto DESerror)
goto DESPfinish
:DESstartcmd
start
if %errorlevel% neq 0 (if %errorlevel% neq 6 (goto DESerror))
goto DESystem
:DESShutdown
set lastloc=SShutdown
cls&echo ^> Shutdown menu - Optionen (o)%update%&%M%&echo Druecke die ausgewaehlte Nummer um fortzufahren.&%N%&%M%&%M%&echo  1 ^> Sofort herunterfahren&echo  2 ^> Innerhalb der naechsten Minuten&echo  3 ^> Zeit selbst eingeben&echo  4 ^> Sofort neu starten&echo  5 ^> Herunterfahren abbrechen&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%O12345%up% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto options
if %errorlevel% equ 4 goto DESSimmediately
if %errorlevel% equ 5 goto DESSshutdown
if %errorlevel% equ 6 goto DESScustom
if %errorlevel% equ 7 goto DESSrestart
if %errorlevel% equ 8 goto DESScancel
if %errorlevel% equ 9 goto update3
:DESSimmediately
cls&%M%&echo PC sofort herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSimmediately1
if %errorlevel% equ 2 goto DESSimmediately1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSimmediately1
timeout 1 >NUL&shutdown
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DESShutdown
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DESShutdown
set sd2=Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESPfinish
:DESSshutdown
cls&%M%&echo PC innerhalb der naechsten Minuten herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSshutdown1
if %errorlevel% equ 2 goto DESSshutdown1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSshutdown1
timeout 1 >NUL&shutdown /s
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DESShutdown
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DESShutdown
set sd2=Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: In den naechsten Minuten&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESPfinish
:DESScustom
cls&%M%&echo Zeit in Sekunden angeben (nur Zahlen/max. 99999).&echo Mit enter bestaetigen!&%N%&%M%&echo %back%&%M%
set /p sdz=
if "%sdz%"=="z" goto DESShutdown
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto DESScustom)
cls&%M%&echo PC in %sdz% Sekunden herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESScustom1
if %errorlevel% equ 2 goto DESScustom
if %errorlevel% equ 3 goto end
:DESScustom1
shutdown -s -t %sdz%
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DESShutdown
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&echo Bitte verwende nur Zahlen (max. 99999).&%N%&timeout 4&goto DESShutdown
set sd2=echo Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: %sdz%s&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESPfinish
:DESSrestart
cls&%M%&echo PC sofort neu starten?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSrestart1
if %errorlevel% equ 2 goto DESSrestart1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSrestart1
timeout 1 >NUL&shutdown -r
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DESShutdown
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DESShutdown
set sd=Neustart abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESPfinish
:DESScancel
shutdown /a
if %errorlevel% equ 1116 cls&%M%&echo Kein Vorgang abgebrochen!&%N%&timeout 4&goto DESShutdown
if %errorlevel% equ 0 cls&%M%&echo Vorgang abgebrochen!&%N%&timeout 4&goto DESShutdown
cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DESShutdown
goto DESShutdown
:DESPatch
set lastloc=SPatch
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Aktiviert) else (set C2=Deaktiviert)
cls&echo ^> Security menu - Optionen (o)%update%&%M%&echo Druecke die ausgewaehlte Nummer um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%
if exist "%windir%\cscc.dat" (set C3=Aktiviert) else (set C3=Deaktiviert)
if exist "%windir%\perfc.dll" (set C1=Aktiviert) else (set C1=Deaktiviert)
if %coloredfont%==Aktiviert (goto DESPatchcoloredfont)
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%&goto DESPatchcoloredfont1
:DESPatchcoloredfont
call :colorfont 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
call :colorfont 07 " 2. Petya 2 Patch             -"&if %C2%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
call :colorfont 07 " 3. BadRabbit Patch           -"&if %C3%==Aktiviert (call :colorfont 0a " Aktiviert"&%M%) else (call :colorfont 0C " Deaktiviert"&%M%)
:DESPatchcoloredfont1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%OI123%up% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto options
if %errorlevel% equ 4 goto DESPinformation
if %errorlevel% equ 5 if %C1%==Aktiviert (goto DESPpetyadisable) else (goto DESPpetyaenable)
if %errorlevel% equ 6 if %C2%==Aktiviert (goto DESPpetya2disable) else (goto DESPpetya2enable)
if %errorlevel% equ 7 if %C3%==Aktiviert (goto DESPbadrabbitdisable) else (goto DESPbadrabbitenable)
if %errorlevel% equ 8 goto update3
:DESPinformation
cls&echo ^> Security menu ^> Information&%M%&echo Petya/NotPetya&echo  Schuetzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschluesselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%N%&%M%&echo Petya 2&echo  Schuetzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschluesselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%N%&%M%&echo BadRabbit&echo  Schuetzt Windows vor der Ransomware BadRabbit.&echo  Mehr: https://securelist.com/bad-rabbit-ransomware/82851/&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DESPatch
if %errorlevel% equ 2 goto DESPatch
if %errorlevel% equ 3 goto end
:DESPpetyaenable
cls&%M%&echo Windows gegen Petya/NotPetya schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetyaenable1
if %errorlevel% equ 2 goto DESPpetyaenable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetyaenable1
cls&%M%&echo Aktiviere Petya/NotPetya Patch...&%N%
(echo Generated by IconRepair) > %windir%\perfc.dll
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
(echo Generated by IconRepair) > %windir%\perfc.dat
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
(echo Generated by IconRepair) > %windir%\perfc
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
goto DESPatch
:DESPpetyadisable
cls&%M%&echo Den Schutz gegen Petya/NotPetya deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetyadisable1
if %errorlevel% equ 2 goto DESPpetyadisable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetyadisable1
cls&%M%&echo Deaktiviere Petya/NotPetya Patch...&%N%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DESPerror)
del /f /q %windir%\perfc.dll >NUL
if %errorlevel% neq 0 (goto DESPerror)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc.dat >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc >NUL
goto DESPatch
:DESPpetya2enable
cls&%M%&echo Windows gegen Petya 2 schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetya2enable1
if %errorlevel% equ 2 goto DESPpetya2enable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetya2enable1
cls&%M%&echo Aktiviere Petya 2 Patch...&%N%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto DESPatch) else (goto DESPerror)
:DESPpetya2disable
cls&%M%&echo Den Schutz gegen Petya 2 deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetya2disable1
if %errorlevel% equ 2 goto DESPpetya2disable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetya2disable1
cls&%M%&echo Deaktiviere Petya 2 Patch...&%N%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto DESPatch) else (goto DESPerror)
:DESPbadrabbitenable
cls&%M%&echo Windows gegen BadRabbit schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPbadrabbitenable1
if %errorlevel% equ 2 goto DESPbadrabbitenable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPbadrabbitenable1
cls&%M%&echo Aktiviere BadRabbit Patch...&%N%
echo Generated by IconRepair > %windir%\cscc.dat
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
echo Generated by IconRepair > %windir%\infpub.dat
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
goto DESPatch
:DESPbadrabbitdisable
cls&%M%&echo Den Schutz gegen BadRabbit deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPbadrabbitdisable1
if %errorlevel% equ 2 goto DESPbadrabbitdisable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPbadrabbitdisable1
cls&%M%&echo Deaktiviere BadRabbit Patch...&%N%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DESPerror)
del /f /q %windir%\cscc.dat >NUL
if %errorlevel% neq 0 (goto DESPerror)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\infpub.dat >NUL
goto DESPatch
:DESPerror
cls&%M%&echo Es ist ein Fehler aufgetreten!&%M%&echo Wichtig: Um diese Einstellung zu aendern muss IconRepair&echo          als Administrator gestartet werden!&%N%&timeout 4&goto DESPatch
:DESPfinish
cls&%M%&echo Fertig!&%sdM2%
%sdM%
%sdM%
%sd%
%sd2%
%sdM%
%N%&%M%&echo %back% - %exit%
choice /C %ext%1234%bck%%sda% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 exit
if %errorlevel% equ 5 exit
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DESystem
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DESScancel
:DESdeleteupdateperm
if %adc%==Deaktiviert (goto DESdeleteupdate) else (if %admin% equ 1 (goto DESdeleteupdate))
cls&%M%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESdeleteupdate
if %errorlevel% equ 2 goto DESdeleteupdate
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESdeleteupdate
cls&%M%&echo Das heruntergeladene Windows Update loeschen?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESdeleteupdate1
if %errorlevel% equ 2 goto DESdeleteupdate1
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESdeleteupdate1
if not exist "%systemroot%\SoftwareDistribution\Download\" (cls&%M%&echo Kein Update gefunden.&%N%&timeout 4&goto DESystem)
cls&%M%&echo Loesche Update...&%N%
sc stop wuauserv >NUL&sc stop bits >NUL
rd /S /Q "%systemroot%\SoftwareDistribution\" >NUL
cls&%M%&echo Fertig!&%N%&timeout 4&goto DESystem
:DESerror
cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DESystem
:end
if %language%==Deutsch (cls&%M%&echo Beendet...&%N%&timeout 2&exit) else (cls&%M%&echo Canceled...&%N%&timeout 2&exit)
:colorfont
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
pushd "%userprofile%\IconRepair\"
if %errorlevel% neq 0 (goto colorfonterror)
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto nothing
:colorfonterror
if %language%==Deutsch (goto DEcolorfonterror) else (goto ENcolorfonterror)
:DEcolorfonterror
if "%saveoptions%"=="Aktiviert" (set saveoptions=Deaktiviert)
if "%coloredfont%"=="Aktiviert" (set coloredfont=Deaktiviert)
cls&%N%&%M%&echo Fehler! Keine Berechtigung.&echo Optionen wurden deaktiviert.&%N%&timeout 4
goto options
:ENcolorfonterror
if "%saveoptions%"=="Enabled" (set saveoptions=Disabled)
if "%coloredfont%"=="Enabled" (set coloredfont=Disabled)
cls&%N%&%M%&echo Error! No permission.&echo Options have been disabled.&%N%&timeout 4
goto options
:nothing