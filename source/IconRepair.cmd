@echo off&mode 79,26&set V=3.3&set B=3313&set RU=2.5&set year=2019&pushd "%userprofile%"&set "settingspath="%userprofile%\IconRepair\settings.cmd""
set L=echo ____________________________________________________________&set S=echo:&set R=title IconRepair %V%&set update=&set up=
:reload
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
if exist %settingspath% (call %settingspath%)
if "%savesettings%"=="" (set savesettings=Disabled)
if "%udc%"=="" (set udc=Disabled)
if "%coloredfont%"=="" (set coloredfont=Disabled)
if "%echoon%"=="" (set echoon=Disabled)
if "%sound%"=="" (set sound=Default)
if "%adc%"=="" (set adc=Enabled)
if not "%language%"=="Deutsch" (set language=English)
if %savesettings%==Enabled (if not %sound%==Default (%S%&echo Checking sound process...&%S%&for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Enabled) else (set sound=Disabled))))
if %savesettings%==Aktiviert (if not %sound%==Standard (%S%&echo Teste Soundprozess...&%S%&for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Aktiviert) else (set sound=Deaktiviert))))
if %savesettings%==Aktiviert (if not "%winver%"=="" (goto Main)) else (if %savesettings%==Enabled (if not "%winver%"=="" (goto Main)))
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set winver=%%j.%%k) else (set winver=%%i.%%j))
for /f "tokens=3 delims= " %%l in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (if [%%l] equ [0407] (set language=Deutsch) else (set language=English))
:Main
if "%winver%"=="10.0" (set win=Windows 10&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.3" (set win=Windows 8.1&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.2" (set win=Windows 8&if %language%==Deutsch (goto DEMain) else (goto ENMain))
if "%winver%"=="6.1" (set win=Windows 7&if %language%==Deutsch (goto DEMain) else (goto ENMain))
set lastloc=unsupported&if %language%==Deutsch (goto DEunsupported) else (goto ENunsupported)
:ENunsupported
set settings=Settings (s)&set se=S&set back=Back (b)&set exit=Exit (e)&set yes=Yes (y)&set bck=B&set ext=E&set ys=Y&set W1=1&set W2=2&set W3=3&set W4=4&set win=Unknown
%R% (%win%)&cls&echo ^> Unknown Windows version
%S%&echo Not available. Only suitable for Windows 7-10!&%L%&%S%&%S%&echo Press s to set the Windows version and language manually.&%S%&%L%&%S%&echo %settings% - %exit%
choice /C %se%%ext% /N >NUL
if %errorlevel% equ 1 goto settings
if %errorlevel% equ 2 goto end
:DEunsupported
set settings=Einstellungen (e)&set se=E&set back=Zurck (z)&set exit=Beenden (b)&set yes=Ja (j)&set bck=Z&set ext=B&set ys=J&set W1=1&set W2=2&set W3=3&set W4=4&set win=Unbekannt
%R% (%win%)&cls&echo ^> Unbekannte Windows Version
%S%&echo Nicht verfgbar. Nur fr Windows 7-10 geeignet!&%L%&%S%&%S%&echo Drcke e um die Windows Version und Sprache manuell&echo einzustellen.&%S%&%L%&%S%&echo %settings% - %exit%
choice /C %se%%ext% /N >NUL
if %errorlevel% equ 1 goto settings
if %errorlevel% equ 2 goto end
:update
if not "%lastloc%"=="Main" (cls&%S%)
if %language%==Deutsch (%S%&echo Suche nach Updates...) else (%S%&echo Checking for updates...)
if not "%lastloc%"=="Main" (%L%)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1&goto update2)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1&goto update2) else (set np=0&cls&%S%&if %language%==Deutsch (echo Keine Verbindung!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren) else (echo No connection!&%L%&%S%&echo Press any key to continue.))
timeout 3 >NUL&goto %updateloc%
:update2
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
%S%&powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" 'https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build' -outfile '%userprofile%\IconRepair\build' -timeoutsec 3 -usebasicparsing)
if %errorlevel% neq 0 (cls&%S%&if %language%==Deutsch (echo Download fehlgeschlagen!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto %updateloc%) else (echo Download failed!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto %updateloc%))
set /p NB=<%userprofile%\IconRepair\build
if "%V% (%B%)"=="%NB%" (cls&%S%&if %language%==Deutsch (echo Keine Updates verfgbar!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto %updateloc%) else (echo No updates available!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto %updateloc%))
set new=new
echo %~dpnx0>"%userprofile%\IconRepair\loc.txt"
echo %~nx0>"%userprofile%\IconRepair\name.txt"
cls&%S%&if %language%==Deutsch (echo Updater herunterladen...) else (echo Downloading updater...)
%S%&powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" 'https://raw.githubusercontent.com/dennios/iconrepair/master/updater/iconrepairupdater.cmd' -outfile '%userprofile%\IconRepair\iconrepairupdater.cmd' -timeoutsec 3 -usebasicparsing)
if %errorlevel% neq 0 (cls&%S%&if %language%==Deutsch (echo Download fehlgeschlagen!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto %updateloc%) else (echo Download failed!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto %updateloc%))
if exist "%userprofile%\IconRepair\iconrepairupdater.cmd" (call "%userprofile%\IconRepair\iconrepairupdater.cmd")
goto %updateloc%
:update3
if exist "%userprofile%\IconRepair\iconrepairupdater.cmd" (call "%userprofile%\IconRepair\iconrepairupdater.cmd"&if %language%==Deutsch (goto DE%lastloc%) else (goto EN%lastloc%)) else (set update=&if %language%==Deutsch (goto DE%lastloc%) else (goto EN%lastloc%))
:about
cls&echo ^> About - Changelog (l) - Reload (r)&%S%&echo Version %V%&echo Build %B%&echo Re. Updater %RU%&echo Year %year%&%S%&echo by dennios&echo https://github.com/dennios/iconrepair/&%L%&%S%&echo %back% - %exit%
choice /C %bck%ALR%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto changelog
if %errorlevel% equ 4 goto reload
if %errorlevel% equ 5 goto end
:changelog
cls&echo ^> Changelog&%S%&echo Version %V% (%B%)&echo  +Old AudioRepair as alternative&echo  +Reload script button in about&echo  +Better loading progress&echo  +Improvements&%S%&echo Version 3.3 (3303)&echo  +New better ^& faster AudioRepair&echo  +Renamed "Options" to "Settings"&echo  +Admin indicator&echo  +Improvements&echo  +Fixes&%L%&%S%&echo %back% - %exit%
choice /C %bck%L%ext% /N >NUL
if %errorlevel% equ 1 goto about
if %errorlevel% equ 2 goto about
if %errorlevel% equ 3 goto end
pause
:settings
set updateloc=settings&if %language%==Deutsch (goto DEsettings) else (goto ENsettings)
:ENsettings
set settings=Settings (s)&set se=S&set back=Back (b)&set exit=Exit (e)&set yes=Yes (y)&set bck=B&set ext=E&set ys=Y&set retry=Retry (r)&set rty=R
if "%win%"=="Unbekannt" (set win=Unknown)
if %lastloc%==unsupported (if not "%win%"=="Unknown" (set lastloc=Main))
if not %savesettings%==Enabled (if %savesettings%==Aktiviert (set savesettings=Enabled) else (set savesettings=Disabled))
if not %coloredfont%==Enabled (if %coloredfont%==Aktiviert (set coloredfont=Enabled) else (set coloredfont=Disabled))
if not %udc%==Enabled (if %udc%==Aktiviert (set udc=Enabled) else (set udc=Disabled))
if not %adc%==Disabled (if %adc%==Deaktiviert (set adc=Disabled) else (set adc=Enabled))
if %sound%==Standard (set sound=Default) else (if %sound%==Deaktiviert (set sound=Disabled) else (if %sound%==Aktiviert (set sound=Enabled)))
if not %echoon%==Enabled (if %echoon%==Aktiviert (set echoon=Enabled) else (set echoon=Disabled))
if %savesettings%==Disabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)")
if "%opreset%"=="" (if %coloredfont%==Disabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %adc%==Enabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %udc%==Disabled (set re=&set opreset= ) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %sound%==Default (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %echoon%==Disabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if %adc%==Disabled (set astat=) else (if "%admin%"=="1" (set astat=/Administrator) else (if "%admin%"=="0" (set astat=/Restricted) else (set astat=)))
cls&%R% (%win%%astat%)&echo ^> Settings - Check for updates (u) %opreset%
%S%&echo Press the selected number to change settings.&%L%&%S%&%S%
if %coloredfont%==Enabled goto ENsettingscoloredfont
echo  1 ^> Save settings                - %savesettings%&echo  2 ^> Language                     - %language%&echo  3 ^> Windows version              - %win%&echo  4 ^> Administrator check          - %adc%&echo  5 ^> Colored font                 - %coloredfont%&echo  6 ^> Experimental settings&goto ENsettingscoloredfont1
:ENsettingscoloredfont
call :colorfont 07 " 1. Save settings                -"&if %savesettings%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
call :colorfont 07 " 2. Language                     - %language%"&%S%&call :colorfont 07 " 3. Windows version              - %win%"&%S%
call :colorfont 07 " 4. Administrator check          -"&if %adc%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
call :colorfont 07 " 5. Colored font                 -"&if %coloredfont%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
call :colorfont 07 " 6. Experimental settings"&%S%
:ENsettingscoloredfont1
call :writesettings
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%se%%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 goto EN%lastloc%
if %errorlevel% equ 2 goto EN%lastloc%
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENsavesettings
if %errorlevel% equ 5 if %language%==Deutsch (set language=English&goto settings) else (set language=Deutsch&goto settings)
if %errorlevel% equ 6 goto ENwinversion
if %errorlevel% equ 7 if %adc%==Enabled (set adc=Disabled&goto settings) else (set adc=Enabled&goto settings)
if %errorlevel% equ 8 if %coloredfont%==Enabled (set coloredfont=Disabled&goto settings) else (set coloredfont=Enabled&goto settings)
if %errorlevel% equ 9 goto ENexperimentalsettings
if %errorlevel% equ 10 goto update
if %errorlevel% equ 11 goto ENreset
:ENexperimentalsettings
if "%opreset%"=="" (if %coloredfont%==Disabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %adc%==Enabled (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %udc%==Disabled (set re=&set opreset= ) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %sound%==Default (set re=&set opreset=) else (set re=R&set "opreset=- Reset (r)"))
if "%opreset%"=="" (if %echoon%==Disabled (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
cls&echo ^> Experimental settings %opreset%
%S%&echo Press the selected number to change settings.&%L%&%S%&%S%
if %coloredfont%==Enabled (goto ENexperimentalsettingscoloredfont)
echo  1 ^> Auto update check            - %udc%&echo  2 ^> Sound                        - %sound%&echo  3 ^> Echo on                      - %echoon%&goto ENexperimentalsettingscoloredfont1
:ENexperimentalsettingscoloredfont
call :colorfont 07 " 1. Auto update check            -"&if %udc%==Enabled (call :colorfont 0C " Enabled"&%S%) else (call :colorfont 0a " Disabled"&%S%)
call :colorfont 07 " 2. Sound                        -"&if %sound%==Default (call :colorfont 0a " Default"&%S%) else (if %sound%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%))
call :colorfont 07 " 3. Echo on                      -"&if %echoon%==Enabled (call :colorfont 0C " Enabled"&%S%) else (call :colorfont 0a " Disabled"&%S%)
:ENexperimentalsettingscoloredfont1
call :writesettings
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto settings
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %udc%==Enabled (set udc=Disabled&set update=&set up=&goto ENexperimentalsettings) else (set udc=Enabled&set np=&goto ENexperimentalsettings)
if %errorlevel% equ 5 goto ENsound
if %errorlevel% equ 6 if %echoon%==Enabled (@echo off&set echoon=Disabled&goto ENexperimentalsettings) else (@echo on&set echoon=Enabled&goto ENexperimentalsettings)
if %errorlevel% equ 7 goto ENreset
:ENreset
cls&%S%&echo Reset settings?&%S%&echo Important: Settings will be deleted!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%R%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENreset1
if %errorlevel% equ 2 goto ENreset1
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto end
:ENreset1
set sound=Default&set coloredfont=Disabled&set udc=Disabled&set adc=Enabled&set savesettings=Disabled&set echoon=Disabled&del /f /q %settingspath%&goto settings
:ENsound
cls&%S%&echo Checking for administrator rights...&%S%
if %adc%==Enabled (goto ENsound1)
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:ENsound1
if %admin% equ 0 (goto ENsounderror)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Enabled) else (set sound=Disabled))
if %sound%==Enabled (goto ENsounddisable)
if %sound%==Disabled (goto ENsoundenable)
:ENsounddisable
cls&%S%&echo Disable sound...&%S%
sc stop beep >NUL
if %errorlevel% neq 0 (goto ENsounderror)
if %savesettings%==Enabled (sc config beep start= disabled >NUL)
set sound=Disabled&goto ENexperimentalsettings
:ENsoundenable
cls&%S%&echo Enable sound...&%S%
if %savesettings%==Enabled (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto ENsounderror)
set sound=Enabled&goto ENexperimentalsettings
:ENsounderror
cls&%S%&echo Error! No permission.&%S%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%L%&%S%&echo Press any key to continue.&timeout 5 >NUL&goto settings
:ENwinversion
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%win%%astat%)&echo ^> Windows version ^> %win%
%S%&echo Press the selected number to change Windows version.&%L%&%S%&%S%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%S%&%L%&%S%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set win=Windows 10&goto ENwinversion) else (set winver=6.3&set win=Windows 8.1&goto ENwinversion)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set win=Windows 8.1&goto ENwinversion) else (set winver=6.2&set win=Windows 8&goto ENwinversion)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set win=Windows 8&goto ENwinversion) else (set winver=6.1&set win=Windows 7&goto ENwinversion)
if %errorlevel% equ 4 goto settings
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set winver=6.1&set win=Windows 7&goto ENwinversion
:ENsavesettings
if %savesettings%==Enabled (goto ENsavesettingsdisable) else (set savesettings=Enabled&if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\"))
if not exist "%userprofile%\IconRepair\" (goto colorfonterror) else (goto settings)
:ENsavesettingsdisable
cls&%S%&echo Disable save settings?&%S%&echo Important: Settings will be deleted!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENsavesettingsdisable1
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
:ENsavesettingsdisable1
set savesettings=Disabled&del /f /q %settingspath%
if %errorlevel% neq 0 (goto colorfonterror)
goto settings
:DEsettings
set settings=Einstellungen (e)&set se=E&set back=Zurck (z)&set exit=Beenden (b)&set yes=Ja (j)&set bck=Z&set ext=B&set ys=J&set retry=Wiederholen (w)&set rty=W
if "%win%"=="Unknown" (set win=Unbekannt)
if %lastloc%==unsupported (if not "%win%"=="Unbekannt" (set lastloc=Main))
if not %savesettings%==Aktiviert (if %savesettings%==Enabled (set savesettings=Aktiviert) else (set savesettings=Deaktiviert))
if not %coloredfont%==Aktiviert (if %coloredfont%==Enabled (set coloredfont=Aktiviert) else (set coloredfont=Deaktiviert))
if not %udc%==Aktiviert (if %udc%==Enabled (set udc=Aktiviert) else (set udc=Deaktiviert))
if not %adc%==Deaktiviert (if %adc%==Disabled (set adc=Deaktiviert) else (set adc=Aktiviert))
if %sound%==Default (set sound=Standard) else (if %sound%==Disabled (set sound=Deaktiviert) else (if %sound%==Enabled (set sound=Aktiviert)))
if not %echoon%==Aktiviert (if %echoon%==Enabled (set echoon=Aktiviert) else (set echoon=Deaktiviert))
if %savesettings%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)")
if "%opreset%"=="" (if %coloredfont%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %adc%==Aktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %udc%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %sound%==Standard (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %echoon%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if %adc%==Deaktiviert (set astat=) else (if "%admin%"=="1" (set astat=/Administrator) else (if "%admin%"=="0" (set astat=/Eingeschr„nkt) else (set astat=)))
cls&%R% (%win%%astat%)&echo ^> Einstellungen - Nach Updates suchen (u) %opreset%
%S%&echo Drcke die ausgew„hlte Nummer um Einstellungen zu „ndern.&%L%&%S%&%S%
if %coloredfont%==Aktiviert (goto DEsettingscoloredfont)
echo  1 ^> Einstellungen speichern      - %savesettings%&echo  2 ^> Sprache                      - %language%&echo  3 ^> Windows Version              - %win%&echo  4 ^> Administrator check          - %adc%&echo  5 ^> Farbige Schrift              - %coloredfont%&echo  6 ^> Experimentelle Einstellungen&goto DEsettingscoloredfont1
:DEsettingscoloredfont
call :colorfont 07 " 1. Einstellungen speichern      -"&if %savesettings%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
call :colorfont 07 " 2. Sprache                      - %language%"&%S%&call :colorfont 07 " 3. Windows Version              - %win%"&%S%
call :colorfont 07 " 4. Administrator check          -"&if %adc%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
call :colorfont 07 " 5. Farbige Schrift              -"&if %coloredfont%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
call :colorfont 07 " 6. Experimentelle Einstellungen"&%S%
:DEsettingscoloredfont1
call :writesettings
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%se%%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 goto DE%lastloc%
if %errorlevel% equ 2 goto DE%lastloc%
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEsavesettings
if %errorlevel% equ 5 if %language%==Deutsch (set language=English&goto settings) else (set language=Deutsch&goto settings)
if %errorlevel% equ 6 goto DEwinversion
if %errorlevel% equ 7 if %adc%==Aktiviert (set adc=Deaktiviert&goto settings) else (set adc=Aktiviert&goto settings)
if %errorlevel% equ 8 if %coloredfont%==Aktiviert (set coloredfont=Deaktiviert&goto settings) else (set coloredfont=Aktiviert&goto settings)
if %errorlevel% equ 9 goto DEexperimentalsettings
if %errorlevel% equ 10 goto update
if %errorlevel% equ 11 goto DEreset
:DEexperimentalsettings
if "%opreset%"=="" (if %coloredfont%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %adc%==Aktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %udc%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %sound%==Standard (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
if "%opreset%"=="" (if %echoon%==Deaktiviert (set re=&set opreset=) else (set re=R&set "opreset=- Zurcksetzen (r)"))
cls&echo ^> Experimentelle Einstellungen %opreset%
%S%&echo Drcke die ausgew„hlte Nummer um Einstellungen zu „ndern.&%L%&%S%&%S%
if %coloredfont%==Aktiviert goto DEexperimentalsettingscoloredfont
echo  1 ^> Auto Update check            - %udc%&echo  2 ^> Ton                          - %sound%&echo  3 ^> Echo on                      - %echoon%&goto DEexperimentalsettingscoloredfont1
:DEexperimentalsettingscoloredfont
call :colorfont 07 " 1. Auto Update check            -"&if %udc%==Aktiviert (call :colorfont 0C " Aktiviert"&%S%) else (call :colorfont 0a " Deaktiviert"&%S%)
call :colorfont 07 " 2. Ton                          -"&if %sound%==Standard (call :colorfont 0a " Standard"&%S%) else (if %sound%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%))
call :colorfont 07 " 3. Echo on                      -"&if %echoon%==Aktiviert (call :colorfont 0C " Aktiviert"&%S%) else (call :colorfont 0a " Deaktiviert"&%S%)
:DEexperimentalsettingscoloredfont1
call :writesettings
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto settings
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %udc%==Aktiviert (set udc=Deaktiviert&set update=&set up=&goto DEexperimentalsettings) else (set udc=Aktiviert&set np=&goto DEexperimentalsettings)
if %errorlevel% equ 5 goto DEsound
if %errorlevel% equ 6 if %echoon%==Aktiviert (@echo off&set echoon=Deaktiviert&goto DEexperimentalsettings) else (@echo on&set echoon=Aktiviert&goto DEexperimentalsettings)
if %errorlevel% equ 7 goto DEreset
:DEreset
cls&%S%&echo Einstellungen zurcksetzen?&%S%&echo Wichtig: Einstellungen werden gel”scht!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%R%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEreset1
if %errorlevel% equ 2 goto DEreset1
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto end
:DEreset1
set sound=Standard&set coloredfont=Deaktiviert&set udc=Deaktiviert&set adc=Aktiviert&set savesettings=Deaktiviert&set echoon=Deaktiviert&del /f /q %settingspath%&goto settings
:DEsound
cls&%S%&echo Prfe auf Administratorrechte...&%L%
if %adc%==Aktiviert (goto DEsound1)
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1) else (set admin=0)
:DEsound1
if %admin% equ 0 (goto DEsounderror)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Aktiviert) else (set sound=Deaktiviert))
if %sound%==Aktiviert (goto DEsounddisable)
if %sound%==Deaktiviert (goto DEsoundenable)
:DEsounddisable
cls&%S%&echo Ton deaktivieren...&%L%
sc stop beep >NUL
if %errorlevel% neq 0 (goto DEsounderror)
if %savesettings%==Aktiviert (sc config beep start= disabled >NUL)
set sound=Deaktiviert&goto DEexperimentalsettings
:DEsoundenable
cls&%S%&echo Ton aktivieren...&%L%
if %savesettings%==Aktiviert (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto DEsounderror)
set sound=Aktiviert&goto DEexperimentalsettings
:DEsounderror
cls&%S%&echo Fehler! Keine Berechtigung.&%S%&echo Wichtig: Um diese Einstellung zu „ndern muss IconRepair&echo          als Administrator gestartet werden!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 5 >NUL&goto settings
:DEwinversion
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%win%%astat%)&echo ^> Windows Version ^> %win%
%S%&echo Drcke die ausgew„hlte Nummer um die Windows Version zu „ndern.&%L%&%S%&%S%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%S%&%L%&%S%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set win=Windows 10&goto DEwinversion) else (set winver=6.3&set win=Windows 8.1&goto DEwinversion)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set win=Windows 8.1&goto DEwinversion) else (set winver=6.2&set win=Windows 8&goto DEwinversion)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set win=Windows 8&goto DEwinversion) else (set winver=6.1&set win=Windows 7&goto DEwinversion)
if %errorlevel% equ 4 goto settings
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set winver=6.1&set win=Windows 7&goto DEwinversion
:DEsavesettings
if %savesettings%==Aktiviert (goto DEsavesettingsdisable) else (set savesettings=Aktiviert&if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\"))
if not exist "%userprofile%\IconRepair\" (goto colorfonterror) else (goto settings)
:DEsavesettingsdisable
cls&%S%&echo Einstellungen speichern deaktivieren?&%S%&echo Wichtig: Einstellungen werden gel”scht!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEsavesettingsdisable1
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
:DEsavesettingsdisable1
set savesettings=Deaktiviert&del /f /q %settingspath%
if %errorlevel% neq 0 (goto colorfonterror)
goto settings
:ENMain
set lastloc=Main&set updateloc=ENMain&set settings=Settings (s)&set se=S&set back=Back (b)&set exit=Exit (e)&set yes=Yes (y)&set bck=B&set ext=E&set ys=Y&set retry=Retry (r)&set rty=R
cls&echo About (a) - %settings%%update%
%S%&echo Press the selected number to continue.&echo For more information press i!&%L%&%S%&%S%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> System options&%S%&%L%&%S%&echo %exit%
if %udc%==Enabled (if "%np%"=="" (goto update))
if %adc%==Disabled (set astat=&if "%admin%"=="" (set admin=0&goto ENadmincheckdisabled) else (goto ENadmincheckdisabled)) else (if not "%admin%"=="" (goto ENadmincheckdisabled))
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1&set astat=/Administrator) else (set admin=0&set astat=/Restricted)
:ENadmincheckdisabled
%R% (%win%%astat%)
choice /C 1234%ext%IA%se%%up% /N >NUL
if %errorlevel% equ 1 goto ENiconrepair
if %errorlevel% equ 2 goto ENnetworkrepairperm
if %errorlevel% equ 3 goto ENaudiorepairperm
if %errorlevel% equ 4 goto ENSystem
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 goto ENMinformation
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto settings
if %errorlevel% equ 9 goto update3
:ENMinformation
cls&echo ^> Information&%S%&echo IconRepair&echo  Tries to fix invisible icons on the desktop and in the&echo  taskbar by renewing the icon cache.&%L%&%S%&echo NetworkRepair&echo  Tries to fix network disconnections by renewing the&echo  network connection.&%L%&%S%&echo AudioRepair&echo  Tries to fix audio problems by restarting all audio&echo  drivers.&%L%&%S%&echo System options&echo  Ability to quickly restart Windows Explorer or cancel&echo  planned shutdown from Windows and more.&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto end
:ENiconrepair
cls&%S%&echo Run IconRepair?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto EN7iconrepair) else (goto EN10iconrepair)
if %errorlevel% equ 2 if %winver%==6.1 (goto EN7iconrepair) else (goto EN10iconrepair)
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:EN10iconrepair
cls&%S%&echo Stopping explorer.exe...&%S%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
cls&%S%&echo Clearing icon cache...&%S%
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
cls&%S%&echo Starting explorer.exe...&%S%
start explorer.exe
cls&%S%&echo Finished!&%S%&%IRe%
echo If the problem is not solved yet,&echo try to restart the PC.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S1%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto EN10iconrepair
:EN7iconrepair
cls&%S%&echo Clearing icon cache...&%S%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
start explorer.exe
cls&%S%&echo Finished!&%S%&%IRe%
echo If the problem is not solved yet,&echo try to restart the PC.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S1%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto EN7iconrepair
:ENnetworkrepairperm
if %adc%==Disabled (goto ENnetworkrepair) else (if %admin% equ 1 (goto ENnetworkrepair))
cls&%S%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENnetworkrepair
if %errorlevel% equ 2 goto ENnetworkrepair
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENnetworkrepair
cls&%S%&echo Run NetworkRepair?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENnetworkrepair1
if %errorlevel% equ 2 goto ENnetworkrepair1
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENnetworkrepair1
cls&%S%&echo Releasing IPv4-Address...&%S%
ipconfig /release >NUL
if %errorlevel% neq 0 (set NRe=echo Please try again with administrator rights!) else (set NRe=)
cls&%S%&echo Empty DNS cache...&%S%
ipconfig /flushdns >NUL
if %errorlevel% neq 0 (set NRe=echo Please try again with administrator rights!) else (set NRe=)
cls&%S%&echo Updating DHCP leases and re-registering DNS names...&%S%
ipconfig /registerdns >NUL
cls&%S%&echo Renewing IPv4-Address...&%S%
ipconfig /renew >NUL
cls&%S%&echo Activating adapter...&%S%
netsh interface set interface Ethernet disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Ethernet enabled >NUL)
netsh interface set interface Wi-Fi disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Wi-Fi enabled >NUL)
cls&%S%&echo Finished!&%NRe%
%S%&echo If the problem is not solved yet,&echo try to restart the router and the PC.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S2%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto ENnetworkrepair1
:ENaudiorepairperm
if %adc%==Disabled (goto ENaudiorepair) else (if %admin% equ 1 (goto ENaudiorepair))
cls&%S%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENaudiorepair
if %errorlevel% equ 2 goto ENaudiorepair
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
:ENaudiorepair
cls&%S%&echo Run AudioRepair (v2)?&%S%&echo Press o to run AudioRepair (v1).&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext%O /N >NUL
if %errorlevel% equ 1 goto ENaudiorepair1
if %errorlevel% equ 2 goto ENaudiorepair1
if %errorlevel% equ 3 goto ENMain
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 goto ENaudiorepairold1
:ENaudiorepair1
cls&%S%&echo Stopping audio service...&%S%
set process=audiosrv&call :getprocessid
if "%processid%"=="Es" (goto ENaudiorepair2) else (if "%processid%"=="" (cls&%S%&echo An error has occurred!&echo Please use AudioRepair v1.&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENaudiorepair))
taskkill /T /F /PID %processid% >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
cls&%S%&echo Stopping AudioEndpointBuilder...&%S%
set process=AudioEndpointBuilder&call :getprocessid
if "%processid%"=="Es" (goto ENaudiorepair2) else (if "%processid%"=="" (cls&%S%&echo An error has occurred!&echo Please use AudioRepair v1.&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENaudiorepair))
taskkill /T /F /PID %processid% >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
:ENaudiorepair2
cls&%S%&echo Starting audio service...&%S%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 2 /nobreak >NUL&goto ENaudiorepair2) else (set "ARe=echo Please try again with administrator rights!"))
set process=RzSurroundVADStreamingService&call :getprocessid
if not "%processid%"=="Es" (taskkill /T /F /PID %processid% >NUL&timeout 2 /nobreak >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%S%&echo Finished!&%ARe%
%S%&echo If the problem is not solved yet,&echo try to restart the PC.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S3%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto ENaudiorepair1
:ENaudiorepairold1
cls&%S%&echo Stopping audio service...&%S%
sc query audiosrv | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto ENaudiorepairold2)
sc stop audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
cls&%S%&echo Stopping AudioEndpointBuilder...&%S%
sc query AudioEndpointBuilder | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto ENaudiorepairold2)
sc stop AudioEndpointBuilder >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Please try again with administrator rights!")
:ENaudiorepairold2
cls&%S%&echo Starting audio service...&%S%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 1 /nobreak >NUL&goto ENaudiorepairold2) else (set "ARe=echo Please try again with administrator rights!"))
sc query RzSurroundVADStreamingService | FIND "STATE" | FIND "RUNNING"
if %errorlevel% equ 0 (sc stop RzSurroundVADStreamingService >NUL&timeout 2 /nobreak >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%S%&echo Finished!&%ARe%
%S%&echo If the problem is not solved yet,&echo try to restart the PC.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S3%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto ENMain
if %errorlevel% equ 5 goto ENaudiorepairold1
:ENSystem
set lastloc=System&set sd=&set sda=&set sdM=
cls&echo ^> System options - %settings%%update%
%S%&echo Press the selected number to continue.&echo For more information press i!&%L%&%S%&%S%&echo  1 ^> Restart Windows explorer&echo  2 ^> Start Windows CMD&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&echo  5 ^> Delete Windows update&%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%I%se%12345%up% /N >NUL
if %errorlevel% equ 1 goto ENMain
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto ENSinformation
if %errorlevel% equ 4 goto settings
if %errorlevel% equ 5 goto ENSrestartexplorer
if %errorlevel% equ 6 goto ENSstartcmd
if %errorlevel% equ 7 goto ENSShutdown
if %errorlevel% equ 8 goto ENSPatchperm
if %errorlevel% equ 9 goto ENSdeleteupdateperm
if %errorlevel% equ 10 goto update3
:ENSinformation
cls&echo ^> System options ^> Information&%S%&echo Restart Windows explorer&echo  Restarts Windows Explorer to solve minor problems.&%L%&%S%&echo Start Windows CMD&echo  Starts the command prompt to execute commands manually.&%L%&%S%&echo Shutdown menu&echo  Shutdown the PC.&%L%&%S%&echo Security menu&echo  Create .dat files in the System32 folder and edit the&echo  registry which could prevent Windows against malware.&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto ENSystem
if %errorlevel% equ 3 goto end
:ENSrestartexplorer
cls&%S%&echo Restart Windows Explorer?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSrestartexplorer1
if %errorlevel% equ 2 goto ENSrestartexplorer1
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSrestartexplorer1
cls&%S%&echo Restarting explorer.exe...&%S%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL&timeout 1 /nobreak >NUL)
start explorer.exe
if %errorlevel% neq 0 (goto ENSerror)
goto ENSPfinish
:ENSstartcmd
start "IconRepair %V% (cmd)"
if %errorlevel% neq 0 (if %errorlevel% neq 6 (goto ENSerror))
goto ENSystem
:ENSShutdown
set lastloc=SShutdown
cls&echo ^> Shutdown menu - %settings%%update%&%S%&echo Press the selected number to continue.&%L%&%S%&%S%&echo  1 ^> Instand shutdown&echo  2 ^> Shutdown in the next few minutes&echo  3 ^> Set custom time till shutdown&echo  4 ^> Instand restart&echo  5 ^> Cancel shutdown&%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%%se%12345%up% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto ENSSimmediately
if %errorlevel% equ 5 goto ENSSshutdown
if %errorlevel% equ 6 goto ENSScustom
if %errorlevel% equ 7 goto ENSSrestart
if %errorlevel% equ 8 goto ENSScancel
if %errorlevel% equ 9 goto update3
:ENSSimmediately
cls&%S%&echo Shutdown PC immediately?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSimmediately1
if %errorlevel% equ 2 goto ENSSimmediately1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSimmediately1
shutdown /s /t 1
if %errorlevel% equ 1190 cls&%S%&echo An operation is already planned!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
if %errorlevel% neq 0 cls&%S%&echo An error has occurred!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
set sd2=Cancel shutdown (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%S%&set sdM2=%L%&goto ENSPfinish
:ENSSshutdown
cls&%S%&echo Shutdown PC in the next few minutes?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSshutdown1
if %errorlevel% equ 2 goto ENSSshutdown1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSshutdown1
shutdown /s
if %errorlevel% equ 1190 cls&%S%&echo An operation is already planned!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
if %errorlevel% neq 0 cls&%S%&echo An error has occurred!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
set sd2=Cancel shutdown (c)&set sd=echo Set time: In the next few minutes&set sda=C&set sdM=%S%&set sdM2=%L%&goto ENSPfinish
:ENSScustom
cls&%S%&echo Specify time in seconds (numbers only/max. 99999).&echo Confirm with enter!&%L%&%S%&echo %back%&%S%
set /p sdz=
if "%sdz%"=="b" goto ENSShutdown
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto ENSScustom)
cls&%S%&echo Shutdown PC in %sdz% seconds?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSScustom1
if %errorlevel% equ 2 goto ENSScustom
if %errorlevel% equ 3 goto end
:ENSScustom1
shutdown /s /t %sdz%
if %errorlevel% equ 1190 cls&%S%&echo An operation is already planned!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
if %errorlevel% neq 0 cls&%S%&echo An error has occurred!&echo Please use only numbers (max. 99999).&%L%&%S%&echo Press any key to continue.&timeout 5 >NUL&goto ENSShutdown
set sd2=echo Cancel shutdown (c)&set sd=echo Set time: %sdz%s&set sda=C&set sdM=%S%&set sdM2=%L%&goto ENSPfinish
:ENSSrestart
cls&%S%&echo Restart PC immediately?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSSrestart1
if %errorlevel% equ 2 goto ENSSrestart1
if %errorlevel% equ 3 goto ENSShutdown
if %errorlevel% equ 4 goto end
:ENSSrestart1
shutdown /r
if %errorlevel% equ 1190 cls&%S%&echo An operation is already planned!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
if %errorlevel% neq 0 cls&%S%&echo An error has occurred!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
set sd2=echo Cancel restart (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%S%&set sdM2=%L%&goto ENSPfinish
:ENSScancel
shutdown /a
if %errorlevel% equ 1116 cls&%S%&echo No operation aborted&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
if %errorlevel% equ 0 cls&%S%&echo Operation canceled&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
cls&%S%&echo An error has occurred!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSShutdown
:ENSPatchperm
if %adc%==Disabled (goto ENSPatch) else (if %admin% equ 1 (goto ENSPatch))
cls&%S%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPatch
if %errorlevel% equ 2 goto ENSPatch
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSPatch
set lastloc=SPatch
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Enabled) else (set C2=Disabled)
cls&echo ^> Security menu - %settings%%update%&%S%&echo Press the selected number to continue.&echo For more information press i!&%L%&%S%&%S%
if exist "%windir%\perfc.dll" (set C1=Enabled) else (set C1=Disabled)
if exist "%windir%\cscc.dat" (set C3=Enabled) else (set C3=Disabled)
if %coloredfont%==Enabled (goto ENSPatchcoloredfont)
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%&goto ENSPatchcoloredfont1
:ENSPatchcoloredfont
call :colorfont 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
call :colorfont 07 " 2. Petya 2 Patch             -"&if %C2%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
call :colorfont 07 " 3. BadRabbit Patch           -"&if %C3%==Enabled (call :colorfont 0a " Enabled"&%S%) else (call :colorfont 0C " Disabled"&%S%)
:ENSPatchcoloredfont1
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%%se%I123%up% /N >NUL
if %errorlevel% equ 1 goto ENSystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto ENSPinformation
if %errorlevel% equ 5 if %C1%==Enabled (goto ENSPpetyadisable) else (goto ENSPpetyaenable)
if %errorlevel% equ 6 if %C2%==Enabled (goto ENSPpetya2disable) else (goto ENSPpetya2enable)
if %errorlevel% equ 7 if %C2%==Enabled (goto ENSPbadrabbitdisable) else (goto ENSPbadrabbitenable)
if %errorlevel% equ 8 goto update3
:ENSPinformation
cls&echo ^> Security menu ^> Information&%S%&echo Petya/NotPetya&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%L%&%S%&echo Petya 2&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%L%&%S%&echo BadRabbit&echo  Protects Windows from BadRabbit ransomware.&echo  Read: https://securelist.com/bad-rabbit-ransomware/82851/&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPatch
if %errorlevel% equ 2 goto ENSPatch
if %errorlevel% equ 3 goto end
:ENSPpetyaenable
cls&%S%&echo Patch Windows against Petya/NotPetya?&%S%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetyaenable1
if %errorlevel% equ 2 goto ENSPpetyaenable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetyaenable1
cls&%S%&echo Enabling Petya/NotPetya patch...&%S%
echo Generated by IconRepair >"%windir%\perfc.dll"
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair >"%windir%\perfc.dat"
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair >"%windir%\perfc"
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
goto ENSPatch
:ENSPpetyadisable
cls&%S%&echo Disable patch against Petya/NotPetya?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetyadisable1
if %errorlevel% equ 2 goto ENSPpetyadisable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetyadisable1
cls&%S%&echo Disabling Petya/NotPetya patch...&%S%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENSPerror)
del /f /q "%windir%\perfc.dll" >NUL
if %errorlevel% neq 0 (goto ENSPerror)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\perfc.dat" >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\perfc" >NUL
goto ENSPatch
:ENSPpetya2enable
cls&%S%&echo Patch Windows against Petya 2?&%S%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetya2enable1
if %errorlevel% equ 2 goto ENSPpetya2enable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetya2enable1
cls&%S%&echo Enabling Petya 2 patch...&%S%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto ENSPatch) else (goto ENSPerror)
:ENSPpetya2disable
cls&%S%&echo Disable patch against Petya 2?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPpetya2disable1
if %errorlevel% equ 2 goto ENSPpetya2disable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPpetya2disable1
cls&%S%&echo Disabling Petya 2 patch...&%S%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto ENSPatch) else (goto ENSPerror)
:ENSPbadrabbitenable
cls&%S%&echo Patch Windows against BadRabbit?&%S%&echo Note: This is NO guarantee to save Windows from any kind&echo       of infection or similar!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPbadrabbitenable1
if %errorlevel% equ 2 goto ENSPbadrabbitenable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPbadrabbitenable1
cls&%S%&echo Enabling BadRabbit patch...&%S%
echo Generated by IconRepair >"%windir%\cscc.dat"
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
echo Generated by IconRepair >"%windir%\infpub.dat"
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENSPerror)
goto ENSPatch
:ENSPbadrabbitdisable
cls&%S%&echo Disable patch against BadRabbit?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSPbadrabbitdisable1
if %errorlevel% equ 2 goto ENSPbadrabbitdisable1
if %errorlevel% equ 3 goto ENSPatch
if %errorlevel% equ 4 goto end
:ENSPbadrabbitdisable1
cls&%S%&echo Disabling BadRabbit patch...&%S%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENSPerror)
del /f /q "%windir%\cscc.dat" >NUL
if %errorlevel% neq 0 (goto ENSPerror)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\infpub.dat" >NUL
goto ENSPatch
:ENSPerror
cls&%S%&echo An error occurred!&%S%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%L%&%S%&echo Press any key to continue.&timeout 5 >NUL&goto ENSPatch
:ENSPfinish
cls&%S%&echo Finished!&%sdM2%
%sdM%
%sdM%
%sd%
%sd2%
%sdM%
%L%&%S%&echo %back% - %exit%
choice /C %ext%1234%bck%%sda% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENSystem
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENSScancel
:ENSdeleteupdateperm
if %adc%==Disabled (goto ENSdeleteupdate) else (if %admin% equ 1 (goto ENSdeleteupdate))
cls&%S%&echo No permission! Start IconRepair as an Administrator.&echo Continue anyway?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSdeleteupdate
if %errorlevel% equ 2 goto ENSdeleteupdate
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSdeleteupdate
cls&%S%&echo Delete the downloaded Windows update?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENSdeleteupdate1
if %errorlevel% equ 2 goto ENSdeleteupdate1
if %errorlevel% equ 3 goto ENSystem
if %errorlevel% equ 4 goto end
:ENSdeleteupdate1
if not exist "%systemroot%\SoftwareDistribution\Download\" (cls&%S%&echo No update found.&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSystem)
cls&%S%&echo Delete update...&%L%
sc stop wuauserv >NUL&sc stop bits >NUL
rd /S /Q "%systemroot%\SoftwareDistribution\" >NUL
cls&%S%&echo Finished!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSystem
:ENSerror
cls&%S%&echo An error occurred!&%L%&%S%&echo Press any key to continue.&timeout 3 >NUL&goto ENSystem
:DEMain
set lastloc=Main&set updateloc=DEMain&set settings=Einstellungen (e)&set se=E&set back=Zurck (z)&set exit=Beenden (b)&set yes=Ja (j)&set bck=Z&set ext=B&set ys=J&set retry=Wiederholen (w)&set rty=W
cls&echo About (a) - %settings%%update%
%S%&echo Drcke die ausgew„hlte Nummer um fortzufahren.&echo Fr mehr Informationen i drcken!&%L%&%S%&%S%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> Systemoptionen&%S%&%L%&%S%&echo %exit%
if %udc%==Aktiviert (if "%np%"=="" (goto update))
if %adc%==Deaktiviert (set astat=&if "%admin%"=="" (set admin=0&goto DEadmincheckdisabled) else (goto DEadmincheckdisabled)) else (if not "%admin%"=="" (goto DEadmincheckdisabled))
net session >NUL 2>&1
if %errorlevel% equ 0 (set admin=1&set astat=/Administrator) else (set admin=0&set astat=/Eingeschr„nkt)
:DEadmincheckdisabled
%R% (%win%%astat%)
choice /C 1234%ext%IA%se%%up% /N >NUL
if %errorlevel% equ 1 goto DEiconrepair
if %errorlevel% equ 2 goto DEnetworkrepairperm
if %errorlevel% equ 3 goto DEaudiorepairperm
if %errorlevel% equ 4 goto DESystem
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 goto DEMinformation
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto settings
if %errorlevel% equ 9 goto update3
:DEMinformation
cls&echo ^> Information&%S%&echo IconRepair&echo  Versucht, unsichtbare Symbole auf dem Desktop und in der&echo  Taskleiste zu beheben, indem der Iconcache erneuert&echo  wird.&%L%&%S%&echo NetworkRepair&echo  Versucht, Netzwerkunterbrechungen zu beheben, indem die&echo  Netzwerkverbindung erneuert wird.&%L%&%S%&echo AudioRepair&echo  Versucht, Audioprobleme durch einen Neustart der&echo  Audiotreiber zu beheben.&%L%&%S%&echo Systemoptionen&echo  M”glichkeit zum schnellen Neustart von Windows Explorer&echo  oder Abbrechen des geplanten Herunterfahrens von Windows&echo  und mehr.&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto Main
if %errorlevel% equ 2 goto Main
if %errorlevel% equ 3 goto end
:DEiconrepair
cls&%S%&echo IconRepair ausfhren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto DE7iconrepair) else (goto DE10iconrepair)
if %errorlevel% equ 2 if %winver%==6.1 (goto DE7iconrepair) else (goto DE10iconrepair)
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DE10iconrepair
cls&%S%&echo explorer.exe beenden...&%L%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
cls&%S%&echo Iconcaches l”schen...&%L%
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.*" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
cls&%S%&echo explorer.exe starten...&%L%
start explorer.exe
cls&%S%&echo Fertig!&%IRe%
%S%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S1%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DE10iconrepair
:DE7iconrepair
cls&%S%&echo explorer.exe beenden...&%L%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
cls&%S%&echo Iconcaches l”schen...&%L%
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
cls&%S%&echo explorer.exe starten...&%L%
start explorer.exe
cls&%S%&echo Fertig!&%IRe%
%S%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S1%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DE7iconrepair
:DEnetworkrepairperm
if %adc%==Deaktiviert (goto DEnetworkrepair) else (if %admin% equ 1 (goto DEnetworkrepair))
cls&%S%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEnetworkrepair
if %errorlevel% equ 2 goto DEnetworkrepair
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEnetworkrepair
cls&%S%&echo NetworkRepair ausfhren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEnetworkrepair1
if %errorlevel% equ 2 goto DEnetworkrepair1
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEnetworkrepair1
cls&%S%&echo IPv4-Adresse freigeben...&%L%
ipconfig /release >NUL
if %errorlevel% neq 0 (set NRe=echo Bitte mit administrator rechten erneut versuchen!) else (set NRe=)
cls&%S%&echo DNS Cache leeren...&%L%
ipconfig /flushdns >NUL
if %errorlevel% neq 0 (set NRe=echo Bitte mit administrator rechten erneut versuchen!) else (set NRe=)
cls&%S%&echo DHCP-Leases aktualisieren und DNS-Namen erneut registrieren...&%L%
ipconfig /registerdns >NUL
cls&%S%&echo IPv4-Adresse erneuern...&%L%
ipconfig /renew >NUL
cls&%S%&echo Adapter aktivieren...&%L%
netsh interface set interface Ethernet disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface Ethernet enabled >NUL)
netsh interface set interface WLAN disabled >NUL
if %errorlevel% equ 0 (netsh interface set interface WLAN enabled >NUL)
cls&%S%&echo Fertig!&%NRe%
%S%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den Router und PC neu zu starten.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S2%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DEnetworkrepair1
:DEaudiorepairperm
if %adc%==Deaktiviert (goto DEaudiorepair) else (if %admin% equ 1 (goto DEaudiorepair))
cls&%S%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEaudiorepair
if %errorlevel% equ 2 goto DEaudiorepair
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
:DEaudiorepair
cls&%S%&echo AudioRepair v2 ausfhren?&%S%&echo Drcke a um AudioRepair v1 auszufhren.&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext%A /N >NUL
if %errorlevel% equ 1 goto DEaudiorepair1
if %errorlevel% equ 2 goto DEaudiorepair1
if %errorlevel% equ 3 goto DEMain
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 goto DEaudiorepairold1
:DEaudiorepair1
cls&%S%&echo Audiodienst beenden...&%L%
set process=audiosrv&call :getprocessid
if "%processid%"=="Es" (goto DEaudiorepair2) else (if "%processid%"=="" (cls&%S%&echo Es ist ein Fehler aufgetreten!&echo Bitte AudioRepair v1 verwenden.&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DEaudiorepair))
taskkill /T /F /PID %processid% >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
cls&%S%&echo AudioEndpointBuilder beenden...&%L%
set process=AudioEndpointBuilder&call :getprocessid
if "%processid%"=="Es" (goto DEaudiorepair2) else (if "%processid%"=="" (cls&%S%&echo Es ist ein Fehler aufgetreten!&echo Bitte AudioRepair v1 verwenden.&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DEaudiorepair))
taskkill /T /F /PID %processid% >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
:DEaudiorepair2
cls&%S%&echo Audiodienst starten...&%L%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 2 /nobreak >NUL&goto DEaudiorepair2) else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!"))
set process=RzSurroundVADStreamingService&call :getprocessid
if not "%processid%"=="Es" (taskkill /T /F /PID %processid% >NUL&timeout 2 /nobreak >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%S%&echo Fertig!&%ARe%
%S%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S3%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DEaudiorepair1
:DEaudiorepairold1
cls&%S%&echo Audiodienst beenden...&%L%
sc query audiosrv | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto DEaudiorepairold2)
sc stop audiosrv >NUL
cls&%S%&echo AudioEndpointBuilder beenden...&%L%
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
sc query AudioEndpointBuilder | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto DEaudiorepairold2)
sc stop AudioEndpointBuilder >NUL
if %errorlevel% equ 0 (set "ARe=") else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!")
:DEaudiorepairold2
cls&%S%&echo Audiodienst starten...&%L%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "ARe=") else (if %errorlevel% equ 1056 (timeout 1 /nobreak >NUL&goto DEaudiorepairold2) else (set "ARe=echo Bitte mit administrator rechten erneut versuchen!"))
sc query RzSurroundVADStreamingService | FIND "STATE" | FIND "RUNNING"
if %errorlevel% equ 0 (sc stop RzSurroundVADStreamingService >NUL&timeout 2 /nobreak >NUL&sc start RzSurroundVADStreamingService >NUL)
cls&%S%&echo Fertig!&%ARe%
%S%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%L%&%S%&echo %retry% - %back% - %exit%
choice /C %ext%S3%bck%%rty% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto DEMain
if %errorlevel% equ 5 goto DEaudiorepairold1
:DESystem
set lastloc=System&set sd=&set sda=&set sdM=
cls&echo ^> Systemoptionen - %settings%%update%
%S%&echo Drcke die ausgew„hlte Nummer um fortzufahren.&echo Fr mehr Informationen i drcken!&%L%&%S%&%S%&echo  1 ^> Windows Explorer neu starten&echo  2 ^> Windows CMD starten&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&echo  5 ^> Windows Update l”schen&%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%I%se%12345%up% /N >NUL
if %errorlevel% equ 1 goto DEMain
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto DESinformation
if %errorlevel% equ 4 goto settings
if %errorlevel% equ 5 goto DESrestartexplorer
if %errorlevel% equ 6 goto DESstartcmd
if %errorlevel% equ 7 goto DESShutdown
if %errorlevel% equ 8 goto DESPatchperm
if %errorlevel% equ 9 goto DESdeleteupdateperm
if %errorlevel% equ 10 goto update3
:DESinformation
cls&echo ^> Systemoptionen ^> Information&%S%&echo Windows Explorer neu starten&echo  Startet den Windows Explorer neu, um kleinere Probleme&echo  zu l”sen.&%L%&%S%&echo Windows CMD starten&echo  Startet die Eingabeaufforderung um Befehle manuell&echo  auszufhren.&%L%&%S%&echo Shutdown menu&echo  F„hrt den PC in ausgew„hlter Zeit herunter.&%L%&%S%&echo Security menu&echo  Erstellt .dat Dateien im System32 Ordner und editiert&echo  die Registry, um den Computer vielleicht vor Malware zu&echo  schtzen.&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto DESystem
if %errorlevel% equ 3 goto end
:DESrestartexplorer
cls&%S%&echo Windows Explorer neu starten?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESrestartexplorer1
if %errorlevel% equ 2 goto DESrestartexplorer1
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESrestartexplorer1
cls&%S%&echo explorer.exe neustarten...&%S%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL&timeout 1 /nobreak >NUL)
start explorer.exe
if %errorlevel% neq 0 (goto DESerror)
goto DESPfinish
:DESstartcmd
start "IconRepair %V% (cmd)"
if %errorlevel% neq 0 (if %errorlevel% neq 6 (goto DESerror))
goto DESystem
:DESShutdown
set lastloc=SShutdown
cls&echo ^> Shutdown menu - %settings%%update%&%S%&echo Drcke die ausgew„hlte Nummer um fortzufahren.&%L%&%S%&%S%&echo  1 ^> Sofort herunterfahren&echo  2 ^> In den n„chsten Minuten herunterfahren&echo  3 ^> Herunterfahren in benutzerdefinierter Zeit&echo  4 ^> Sofort neu starten&echo  5 ^> Herunterfahren abbrechen&%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%%se%12345%up% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto DESSimmediately
if %errorlevel% equ 5 goto DESSshutdown
if %errorlevel% equ 6 goto DESScustom
if %errorlevel% equ 7 goto DESSrestart
if %errorlevel% equ 8 goto DESScancel
if %errorlevel% equ 9 goto update3
:DESSimmediately
cls&%S%&echo PC sofort herunterfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSimmediately1
if %errorlevel% equ 2 goto DESSimmediately1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSimmediately1
shutdown /s /t 1
if %errorlevel% equ 1190 cls&%S%&echo Es ist bereits ein vorgang geplant!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
if %errorlevel% neq 0 cls&%S%&echo Es ist ein Fehler aufgetreten!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
set sd2=echo Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%S%&set sdM2=%L%&goto DESPfinish
:DESSshutdown
cls&%S%&echo PC innerhalb der n„chsten Minuten herunterfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSshutdown1
if %errorlevel% equ 2 goto DESSshutdown1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSshutdown1
shutdown /s
if %errorlevel% equ 1190 cls&%S%&echo Es ist bereits ein vorgang geplant!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
if %errorlevel% neq 0 cls&%S%&echo Es ist ein Fehler aufgetreten!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
set sd2=echo Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: In den n„chsten Minuten&set sda=A&set sdM=%S%&set sdM2=%L%&goto DESPfinish
:DESScustom
cls&%S%&echo Zeit in Sekunden angeben (nur Zahlen/max. 99999).&echo Mit enter best„tigen!&%L%&%S%&echo %back%&%S%
set /p sdz=
if "%sdz%"=="z" goto DESShutdown
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto DESScustom)
cls&%S%&echo PC in %sdz% Sekunden herunterfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESScustom1
if %errorlevel% equ 2 goto DESScustom
if %errorlevel% equ 3 goto end
:DESScustom1
shutdown /s /t %sdz%
if %errorlevel% equ 1190 cls&%S%&echo Es ist bereits ein vorgang geplant!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
if %errorlevel% neq 0 cls&%S%&echo Es ist ein Fehler aufgetreten!&echo Bitte verwende nur Zahlen (max. 99999).&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 5 >NUL&goto DESShutdown
set sd2=echo Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: %sdz%s&set sda=A&set sdM=%S%&set sdM2=%L%&goto DESPfinish
:DESSrestart
cls&%S%&echo PC sofort neu starten?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESSrestart1
if %errorlevel% equ 2 goto DESSrestart1
if %errorlevel% equ 3 goto DESShutdown
if %errorlevel% equ 4 goto end
:DESSrestart1
shutdown /r
if %errorlevel% equ 1190 cls&%S%&echo Es ist bereits ein vorgang geplant!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
if %errorlevel% neq 0 cls&%S%&echo Es ist ein Fehler aufgetreten!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
set sd2=Neustart abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%S%&set sdM2=%L%&goto DESPfinish
:DESScancel
shutdown /a
if %errorlevel% equ 1116 cls&%S%&echo Kein Vorgang abgebrochen!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
if %errorlevel% equ 0 cls&%S%&echo Vorgang abgebrochen!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
cls&%S%&echo Es ist ein Fehler aufgetreten!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESShutdown
:DESPatchperm
if %adc%==Deaktiviert (goto DESPatch) else (if %admin% equ 1 (goto DESPatch))
cls&%S%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPatch
if %errorlevel% equ 2 goto DESPatch
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESPatch
set lastloc=SPatch
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Aktiviert) else (set C2=Deaktiviert)
cls&echo ^> Security menu - %settings%%update%&%S%&echo Drcke die ausgew„hlte Nummer um fortzufahren.&echo Fr mehr Informationen i drcken!&%L%&%S%&%S%
if exist "%windir%\cscc.dat" (set C3=Aktiviert) else (set C3=Deaktiviert)
if exist "%windir%\perfc.dll" (set C1=Aktiviert) else (set C1=Deaktiviert)
if %coloredfont%==Aktiviert (goto DESPatchcoloredfont)
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%&goto DESPatchcoloredfont1
:DESPatchcoloredfont
call :colorfont 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
call :colorfont 07 " 2. Petya 2 Patch             -"&if %C2%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
call :colorfont 07 " 3. BadRabbit Patch           -"&if %C3%==Aktiviert (call :colorfont 0a " Aktiviert"&%S%) else (call :colorfont 0C " Deaktiviert"&%S%)
:DESPatchcoloredfont1
%S%&%L%&%S%&echo %back% - %exit%
choice /C %bck%%ext%%se%I123%up% /N >NUL
if %errorlevel% equ 1 goto DESystem
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto settings
if %errorlevel% equ 4 goto DESPinformation
if %errorlevel% equ 5 if %C1%==Aktiviert (goto DESPpetyadisable) else (goto DESPpetyaenable)
if %errorlevel% equ 6 if %C2%==Aktiviert (goto DESPpetya2disable) else (goto DESPpetya2enable)
if %errorlevel% equ 7 if %C3%==Aktiviert (goto DESPbadrabbitdisable) else (goto DESPbadrabbitenable)
if %errorlevel% equ 8 goto update3
:DESPinformation
cls&echo ^> Security menu ^> Information&%S%&echo Petya/NotPetya&echo  Schtzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschlsselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%L%&%S%&echo Petya 2&echo  Schtzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschlsselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%L%&%S%&echo BadRabbit&echo  Schtzt Windows vor der Ransomware BadRabbit.&echo  Mehr: https://securelist.com/bad-rabbit-ransomware/82851/&%L%&%S%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DESPatch
if %errorlevel% equ 2 goto DESPatch
if %errorlevel% equ 3 goto end
:DESPpetyaenable
cls&%S%&echo Windows gegen Petya/NotPetya schtzen?&%S%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schtzen!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetyaenable1
if %errorlevel% equ 2 goto DESPpetyaenable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetyaenable1
cls&%S%&echo Aktiviere Petya/NotPetya Patch...&%L%
echo Generated by IconRepair >"%windir%\perfc.dll"
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
echo Generated by IconRepair >"%windir%\perfc.dat"
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
echo Generated by IconRepair >"%windir%\perfc"
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
goto DESPatch
:DESPpetyadisable
cls&%S%&echo Den Schutz gegen Petya/NotPetya deaktivieren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetyadisable1
if %errorlevel% equ 2 goto DESPpetyadisable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetyadisable1
cls&%S%&echo Deaktiviere Petya/NotPetya Patch...&%L%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DESPerror)
del /f /q "%windir%\perfc.dll" >NUL
if %errorlevel% neq 0 (goto DESPerror)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\perfc.dat" >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\perfc" >NUL
goto DESPatch
:DESPpetya2enable
cls&%S%&echo Windows gegen Petya 2 schtzen?&%S%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schtzen!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetya2enable1
if %errorlevel% equ 2 goto DESPpetya2enable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetya2enable1
cls&%S%&echo Aktiviere Petya 2 Patch...&%L%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto DESPatch) else (goto DESPerror)
:DESPpetya2disable
cls&%S%&echo Den Schutz gegen Petya 2 deaktivieren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPpetya2disable1
if %errorlevel% equ 2 goto DESPpetya2disable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPpetya2disable1
cls&%S%&echo Deaktiviere Petya 2 Patch...&%L%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto DESPatch) else (goto DESPerror)
:DESPbadrabbitenable
cls&%S%&echo Windows gegen BadRabbit schtzen?&%S%&echo Wichtig: Dies ist KEINE Garantie, um Windows vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schtzen!&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPbadrabbitenable1
if %errorlevel% equ 2 goto DESPbadrabbitenable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPbadrabbitenable1
cls&%S%&echo Aktiviere BadRabbit Patch...&%L%
echo Generated by IconRepair >"%windir%\cscc.dat"
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
echo Generated by IconRepair >"%windir%\infpub.dat"
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DESPerror)
goto DESPatch
:DESPbadrabbitdisable
cls&%S%&echo Den Schutz gegen BadRabbit deaktivieren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESPbadrabbitdisable1
if %errorlevel% equ 2 goto DESPbadrabbitdisable1
if %errorlevel% equ 3 goto DESPatch
if %errorlevel% equ 4 goto end
:DESPbadrabbitdisable1
cls&%S%&echo Deaktiviere BadRabbit Patch...&%L%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DESPerror)
del /f /q "%windir%\cscc.dat" >NUL
if %errorlevel% neq 0 (goto DESPerror)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q "%windir%\infpub.dat" >NUL
goto DESPatch
:DESPerror
cls&%S%&echo Es ist ein Fehler aufgetreten!&%S%&echo Wichtig: Um diese Einstellung zu „ndern muss IconRepair&echo          als Administrator gestartet werden!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 5 >NUL&goto DESPatch
:DESPfinish
cls&%S%&echo Fertig!&%sdM2%
%sdM%
%sdM%
%sd%
%sd2%
%sdM%
%L%&%S%&echo %back% - %exit%
choice /C %ext%1234%bck%%sda% /N >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DESystem
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DESScancel
:DESdeleteupdateperm
if %adc%==Deaktiviert (goto DESdeleteupdate) else (if %admin% equ 1 (goto DESdeleteupdate))
cls&%S%&echo Keine Berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESdeleteupdate
if %errorlevel% equ 2 goto DESdeleteupdate
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESdeleteupdate
cls&%S%&echo Das heruntergeladene Windows Update l”schen?&%L%&%S%&echo %yes% - %back% - %exit%
choice /C %ys%5%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DESdeleteupdate1
if %errorlevel% equ 2 goto DESdeleteupdate1
if %errorlevel% equ 3 goto DESystem
if %errorlevel% equ 4 goto end
:DESdeleteupdate1
if not exist "%systemroot%\SoftwareDistribution\Download\" (cls&%S%&echo Kein Update gefunden.&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESystem)
cls&%S%&echo L”sche Update...&%L%
sc stop wuauserv >NUL&sc stop bits >NUL
rd /S /Q "%systemroot%\SoftwareDistribution\" >NUL
cls&%S%&echo Fertig!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESystem
:DESerror
cls&%S%&echo Es ist ein Fehler aufgetreten!&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 3 >NUL&goto DESystem
:end
if %language%==Deutsch (cls&%S%&echo Beendet...&%L%&timeout 2 >NUL&exit) else (cls&%S%&echo Canceled...&%L%&timeout 2 >NUL&exit)
:writesettings
if %savesettings%==Disabled (exit /b) else (if %savesettings%==Deaktiviert (exit /b))
if not exist %settingspath% (echo. >%settingspath%)
if exist %settingspath% (echo set savesettings=%savesettings%>%settingspath%&echo set language=%language%>>%settingspath%&echo set winver=%winver%>>%settingspath%&echo set adc=%adc%>>%settingspath%&echo set udc=%udc%>>%settingspath%&echo set coloredfont=%coloredfont%>>%settingspath%&echo set sound=%sound%>>%settingspath%) else (goto colorfonterror)
exit /b
:getprocessid
for /f "tokens=2" %%m in ('tasklist /SVC /NH /FI "services eq %process%"') do (set processid=%%m)
exit /b
:colorfont
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
pushd "%userprofile%\IconRepair\"
if %errorlevel% neq 0 (goto colorfonterror)
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
exit /b
:colorfonterror
if %language%==Deutsch (goto DEcolorfonterror) else (goto ENcolorfonterror)
:DEcolorfonterror
if "%savesettings%"=="Aktiviert" (set savesettings=Deaktiviert)
if "%coloredfont%"=="Aktiviert" (set coloredfont=Deaktiviert)
cls&%L%&%S%&echo Fehler! Keine Berechtigung.&echo Einstellungen wurden deaktiviert.&%L%&%S%&echo Eine beliebige Taste drcken, um fortzufahren&timeout 5 >NUL&goto settings
:ENcolorfonterror
if "%savesettings%"=="Enabled" (set savesettings=Disabled)
if "%coloredfont%"=="Enabled" (set coloredfont=Disabled)
cls&%L%&%S%&echo Error! No permission.&echo Settings have been disabled.&%L%&%S%&echo Press any key to continue.&timeout 5 >NUL&goto settings