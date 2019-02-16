@echo off&mode con:cols=79 lines=26&set V=3.1&set B=3112&set RU=2.2&set year=2019
set N=echo __________________________________________________________&set M=echo.&set R=title IconRepair %V%&set update=&set up=&set ton=Default
%R%&%M%&echo Loading...&%M%
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
if exist "%userprofile%\IconRepair\options.cmd" (call "%userprofile%\IconRepair\options.cmd")
if not "%udc%"=="Enabled" (if not "%udc%"=="Aktiviert" (set udc=Disabled))
if "%so%"=="Enabled" (if not "%ton%"=="Default" (for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if /I "%%H" neq "RUNNING" (set ton=Enabled) else (set ton=Disabled))))
if "%so%"=="Aktiviert" (if not "%ton%"=="Standard" (for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if /I "%%H" neq "RUNNING" (set ton=Aktiviert) else (set ton=Deaktiviert))))
if "%so%"=="Aktiviert" (goto b) else (if "%so%"=="Enabled" (goto b))
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set winver=%%j.%%k) else (set winver=%%i.%%j))
for /f "tokens=3 delims= " %%G in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (if [%%G] equ [0407] (set lang=Deutsch) else (set lang=English))
goto b
:U
set new=new
if not exist "%userprofile%\IconRepair\" (mkdir %userprofile%\IconRepair\)
echo %~dpnx0>%userprofile%\IconRepair\loc.txt
echo %~nx0>%userprofile%\IconRepair\name.txt
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/iconrepairupdater.cmd "%userprofile%\IconRepair\iconrepairupdater.cmd" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto b)
call "%userprofile%\IconRepair\iconrepairupdater.cmd"&goto b
:U2
if exist "%userprofile%\IconRepair\iconrepairupdater.cmd" (call "%userprofile%\IconRepair\iconrepairupdater.cmd")
:b
if "%winver%"=="10.0" (set L=Windows 10&if "%lang%"=="Deutsch" (goto DEl) else (goto ENl))
if "%winver%"=="6.3" (set L=Windows 8.1&if "%lang%"=="Deutsch" (goto DEl) else (goto ENl))
if "%winver%"=="6.2" (set L=Windows 8&if "%lang%"=="Deutsch" (goto DEl) else (goto ENl))
if "%winver%"=="6.1" (set L=Windows 7&if "%lang%"=="Deutsch" (goto DEl) else (goto ENl))
if "%lang%"=="Deutsch" (goto DEsuppv) else (goto ENsuppv)
:ENsuppv
set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E&set W1=1&set W2=2&set W3=3&set W4=4&set L=
cls&%R%&echo ^> Unknown Windows version
%M%&echo Not available. Only suitable for Windows 7-10!&%N%&%M%&%M%&echo Press o to set your Windows version and language manualy.&%M%&%N%&%M%&echo Options (o) - %exit%
choice /C O%ext% /N >NUL
if %errorlevel% equ 1 goto o
if %errorlevel% equ 2 goto ENE
:DEsuppv
set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B&set W1=1&set W2=2&set W3=3&set W4=4&set L=
cls&%R%&echo ^> Unbekannte Windows Version
%M%&echo Nicht verfuegbar. Nur fuer Windows 7-10 geeignet!&%N%&%M%&%M%&echo Druecke o um die Windows Version und Sprache manuell&echo einzustellen.&%M%&%N%&%M%&echo Optionen (o) - %exit%
choice /C O%ext% /N >NUL
if %errorlevel% equ 1 goto o
if %errorlevel% equ 2 goto DEE
:l
cls&echo ^> Changelog&%M%&echo Version %V% (%B%)&echo  +Experimental options&echo  +Fixes&%N%&%M%&echo %back% - %exit%
choice /C %bck%L%ext% /N >NUL
if %errorlevel% equ 1 goto about
if %errorlevel% equ 2 goto about
if %errorlevel% equ 3 if %lang%==Deutsch (goto DEE) else (goto ENE)
:about
cls&echo ^> About - Changelog (l)&%M%&echo Version %V%&echo Build %B%&echo Re. Updater %RU%&echo Year %year%&%M%&echo by dennios&echo https://github.com/dennios/iconrepair/&%N%&%M%&echo %back% - %exit%
choice /C %bck%AL%ext% /N >NUL
if %errorlevel% equ 1 goto b
if %errorlevel% equ 2 goto b
if %errorlevel% equ 3 goto l
if %errorlevel% equ 4 if %lang%==Deutsch (goto DEE) else (goto ENE)
:o
if %lang%==Deutsch (goto DEo) else (goto ENo)
:ENo
set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E
if /I "%so%" neq "Enabled" (if "%so%"=="Aktiviert" (set so=Enabled) else (set so=Disabled))
if /I "%cf%" neq "Enabled" (if "%cf%"=="Aktiviert" (set cf=Enabled) else (set cf=Disabled))
if /I "%udc%" neq "Enabled" (if "%udc%"=="Aktiviert" (set udc=Enabled) else (set udc=Disabled))
if /I "%adc%" neq "Disabled" (if "%adc%"=="Deaktiviert" (set adc=Disabled) else (set adc=Enabled))
if /I "%ton%" equ "Standard" (set ton=Default) else (if "%ton%"=="Deaktiviert" (set ton=Disabled) else (if "%ton%"=="Aktiviert" (set ton=Enabled)))
if /I "%echoon%" neq "Enabled" (if "%echoon%"=="Aktiviert" (set echoon=Enabled) else (set echoon=Disabled))
if %so%==Enabled (if not exist "%userprofile%\IconRepair\options.cmd" (echo. >%userprofile%\IconRepair\options.cmd) else (if exist %userprofile%\IconRepair\options.cmd (echo set so=%so%>%userprofile%\IconRepair\options.cmd&echo set lang=%lang%>>%userprofile%\IconRepair\options.cmd&echo set winver=%winver%>>%userprofile%\IconRepair\options.cmd&echo set adc=%adc%>>%userprofile%\IconRepair\options.cmd&echo set udc=%udc%>>%userprofile%\IconRepair\options.cmd&echo set cf=%cf%>>%userprofile%\IconRepair\options.cmd&echo set ton=%ton%>>%userprofile%\IconRepair\options.cmd) else (goto CTE)))
if %so%==Disabled (set re=&set opr=) else (set set re=R&"opr=- Reset (r)")
if "%opr%"=="" (if %cf%==Disabled (set re=&set opr=) else set re=R&set "opr=- Reset (r)")
if "%opr%"=="" (if %adc%==Enabled (set re=&set opr=) else set re=R&set "opr=- Reset (r)")
cls&echo ^> Options - Check for updates (u) %opr%
%M%&echo Press the number of your choice to change options.&%N%&%M%&%M%
if %cf%==Enabled goto ENocf
echo  1 ^> Save settings             - %so%&echo  2 ^> Language                  - %lang%&echo  3 ^> Windows version           - %L%&echo  4 ^> Administrator check       - %adc%&echo  5 ^> Colored font              - %cf%&echo  6 ^> Experimental options&goto ENocf1
:ENocf
call :CT 07 " 1. Save settings             -"&if %so%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
call :CT 07 " 2. Language                  - %lang%"&%M%&call :CT 07 " 3. Windows version           - %L%"&%M%
call :CT 07 " 4. Administrator check       -"&if %adc%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
call :CT 07 " 5. Colored font              -"&if %cf%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
call :CT 07 " 6. Experimental options"&%M%
:ENocf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%O%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 if "%ob%"=="s" (goto ENS) else (if "%ob%"=="s3" (goto ENS3) else (if "%ob%"=="s4a" (goto ENS4a) else (goto b)))
if %errorlevel% equ 2 if "%ob%"=="s" (goto ENS) else (if "%ob%"=="s3" (goto ENS3) else (if "%ob%"=="s4a" (goto ENS4a) else (goto b)))
if %errorlevel% equ 3 goto ENE
if %errorlevel% equ 4 goto ENso
if %errorlevel% equ 5 if %lang%==Deutsch (set lang=English&goto o) else (set lang=Deutsch&goto o)
if %errorlevel% equ 6 goto ENwinvero
if %errorlevel% equ 7 goto ENadc
if %errorlevel% equ 8 if %cf%==Enabled (set cf=Disabled&goto o) else (set cf=Enabled&goto o)
if %errorlevel% equ 9 goto ENExperimentalOptions
if %errorlevel% equ 10 goto enus
if %errorlevel% equ 11 goto ENr
:ENExperimentalOptions
if "%opr%"=="" (if %udc%==Disabled (set re=&set opr= ) else set re=R&set "opr=- Reset (r)")
if "%opr%"=="" (if %ton%==Default (set re=&set opr=) else set re=R&set "opr=- Reset (r)")
if "%opr%"=="" (if %echoon%==Disabled (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
cls&echo ^> Experimental options %opr%
%M%&echo Press the number of your choice to change options.&%N%&%M%&%M%
if %cf%==Enabled goto ENeocf
echo  1 ^> Auto update check         - %udc%&echo  2 ^> Sound                     - %ton%&echo  3 ^> Echo on                   - %echoon%&goto ENeocf1
:ENeocf
call :CT 07 " 1. Auto update check         -"&if %udc%==Enabled (call :CT 0C " Enabled"&%M%) else (call :CT 0a " Disabled"&%M%)
call :CT 07 " 2. Sound                     -"&if %ton%==Default (call :CT 0a " Default"&%M%) else (if %ton%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%))
call :CT 07 " 3. Echo on                   -"&if %echoon%==Enabled (call :CT 0C " Enabled"&%M%) else (call :CT 0a " Disabled"&%M%)
:ENeocf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto ENo
if %errorlevel% equ 2 goto ENo
if %errorlevel% equ 3 goto ENE
if %errorlevel% equ 4 if %udc%==Enabled (set udc=Disabled&set update=&set up=&goto ENExperimentalOptions) else (set udc=Enabled&set np=&goto ENExperimentalOptions)
if %errorlevel% equ 5 goto ENton
if %errorlevel% equ 6 if %echoon%==Enabled (@echo off&set echoon=Disabled&goto ENExperimentalOptions) else (@echo on&set echoon=Enabled&goto ENExperimentalOptions)
if %errorlevel% equ 7 goto DEr
:enus
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1) else (set np=0&cls&%M%&echo Error!&timeout 2&goto o)
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build "%userprofile%\IconRepair\build" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto o)
set /p NB=<%userprofile%\IconRepair\build
if not "%V% (%B%)"=="%NB%" (goto U) else (cls&%M%&echo No updates available!&timeout 2&goto o)
:ENr
cls&%M%&echo Reset settings?&%M%&echo Important: Settings will be deleted!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENr1
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto ENE
:ENr1
set ton=Default&set cf=Disabled&set udc=Disabled&set adc=Enabled&set so=Disabled&del /f /q "%userprofile%\IconRepair\options.cmd"&goto o
:ENton
cls&%M%&echo Checking for administrator rights...&%M%
if %adc%==Enabled (goto ENton2)
net session >NUL 2>&1
if %errorlevel% equ 0 (set NA=A) else (set NA=NA)
:ENton2
if %NA%==NA (goto ENtone)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if /I "%%H" neq "RUNNING" (set ton=Enabled) else (set ton=Disabled))
if %ton%==Enabled (goto ENtond)
if %ton%==Disabled (goto ENtona)
:ENtond
cls&%M%&echo Disable sound...&%M%
sc stop beep >NUL
if %errorlevel% neq 0 (goto ENtone)
if %so%==Enabled (sc config beep start= disabled >NUL)
set ton=Disabled&goto o
:ENtona
cls&%M%&echo Enable sound...&%M%
if %so%==Enabled (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto ENtone)
set ton=Enabled&goto o
:ENtone
cls&%M%&echo Error! Please try it again.&%M%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%N%&timeout 4&goto o
:ENwinvero
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%L%)&echo ^> Windows version ^> %L%
%M%&echo Press the number of your choice to change options.&%N%&%M%&%M%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%M%&%N%&%M%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set L=Windows 10&goto ENwinvero) else (set winver=6.3&set L=Windows 8.1&goto ENwinvero)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set L=Windows 8.1&goto ENwinvero) else (set winver=6.2&set L=Windows 8&goto ENwinvero)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set L=Windows 8&goto ENwinvero) else (set winver=6.1&set L=Windows 7&goto ENwinvero)
if %errorlevel% equ 4 goto o
if %errorlevel% equ 5 goto ENE
if %errorlevel% equ 6 set winver=6.1&set L=Windows 7&goto ENwinvero
:ENadc
if %adc%==Disabled (set adc=Enabled&goto o)
cls&%M%&echo %acde% administrator check?&%M%&echo Important: Disabling this can lead to problems!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 set adc=Disabled&goto o
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto ENE
:ENso
if %so%==Enabled (goto ENsoda) else (set so=Enabled&if not exist "%userprofile%\IconRepair\" (mkdir %userprofile%\IconRepair\))
if not exist "%userprofile%\IconRepair\options.cmd" (echo >%userprofile%\IconRepair\options.cmd)
if not exist "%userprofile%\IconRepair\options.cmd" (goto CTE)
goto o
:ENsoda
cls&%M%&echo Disable save settings?&%M%&echo Important: Settings will be deleted if this option is&echo            deactivated!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENsoda1
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto ENE
:ENsoda1
set so=Disabled&del /f /q "%userprofile%\IconRepair\options.cmd"
if %errorlevel% neq 0 (goto CTE)
goto o
:DEo
set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B
if /I "%so%" neq "Aktiviert" (if "%so%"=="Enabled" (set so=Aktiviert) else (set so=Deaktiviert))
if /I "%cf%" neq "Aktiviert" (if "%cf%"=="Enabled" (set cf=Aktiviert) else (set cf=Deaktiviert))
if /I "%udc%" neq "Aktiviert" (if "%udc%"=="Enabled" (set udc=Aktiviert) else (set udc=Deaktiviert))
if /I "%adc%" neq "Deaktiviert" (if "%adc%"=="Disabled" (set adc=Deaktiviert) else (set adc=Aktiviert))
if /I "%ton%" equ "Default" (set ton=Standard) else (if "%ton%"=="Disabled" (set ton=Deaktiviert) else (if "%ton%"=="Enabled" (set ton=Aktiviert)))
if /I "%echoon%" neq "Aktiviert" (if "%echoon%"=="Enabled" (set echoon=Aktiviert) else (set echoon=Deaktiviert))
if %so%==Aktiviert (if not exist "%userprofile%\IconRepair\options.cmd" (echo. >%userprofile%\IconRepair\options.cmd) else (if exist "%userprofile%\IconRepair\options.cmd" (echo set so=%so%>%userprofile%\IconRepair\options.cmd&echo set lang=%lang%>>%userprofile%\IconRepair\options.cmd&echo set winver=%winver%>>%userprofile%\IconRepair\options.cmd&echo set adc=%adc%>>%userprofile%\IconRepair\options.cmd&echo set udc=%udc%>>%userprofile%\IconRepair\options.cmd&echo set cf=%cf%>>%userprofile%\IconRepair\options.cmd&echo set ton=%ton%>>%userprofile%\IconRepair\options.cmd) else (goto CTE)))
if %so%==Deaktiviert (set re=&set opr=) else (set re=R&set "opr=- Zuruecksetzen (r)")
if "%opr%"=="" (if %cf%==Deaktiviert (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
if "%opr%"=="" (if %adc%==Aktiviert (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
cls&echo ^> Optionen - Nach Updates suchen (u) %opr%
%M%&echo Druecke die Nummer deiner Auswahl um Optionen zu aendern.&%N%&%M%&%M%
if %cf%==Aktiviert goto DEocf
echo  1 ^> Einstellungen speichern   - %so%&echo  2 ^> Sprache                   - %lang%&echo  3 ^> Windows Version           - %L%&echo  4 ^> Administrator check       - %adc%&echo  5 ^> Farbige Schrift           - %cf%&echo  6 ^> Experimentelle Optionen&goto DEocf1
:DEocf
call :CT 07 " 1. Einstellungen speichern   -"&if %so%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
call :CT 07 " 2. Sprache                   - %lang%"&%M%&call :CT 07 " 3. Windows Version           - %L%"&%M%
call :CT 07 " 4. Administrator check       -"&if %adc%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
call :CT 07 " 5. Farbige Schrift           -"&if %cf%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
call :CT 07 " 6. Experimentelle Optionen"&%M%
:DEocf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%O%ext%123456U%re% /N >NUL
if %errorlevel% equ 1 if "%ob%"=="s" (goto DES) else (if "%ob%"=="s3" (goto DES3) else (if "%ob%"=="s4a" (goto DES4a) else (goto b)))
if %errorlevel% equ 2 if "%ob%"=="s" (goto DES) else (if "%ob%"=="s3" (goto DES3) else (if "%ob%"=="s4a" (goto DES4a) else (goto b)))
if %errorlevel% equ 3 goto DEE
if %errorlevel% equ 4 goto DEso
if %errorlevel% equ 5 if %lang%==Deutsch (set lang=English&goto o) else (set lang=Deutsch&goto o)
if %errorlevel% equ 6 goto DEwinvero
if %errorlevel% equ 7 goto DEadc
if %errorlevel% equ 8 if %cf%==Aktiviert (set cf=Deaktiviert&goto o) else (set cf=Aktiviert&goto o)
if %errorlevel% equ 9 goto DEExperimentalOptions
if %errorlevel% equ 10 goto deus
if %errorlevel% equ 11 goto DEr
:DEExperimentalOptions
if "%opr%"=="" (if %udc%==Deaktiviert (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
if "%opr%"=="" (if %ton%==Standard (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
if "%opr%"=="" (if %echoon%==Deaktiviert (set re=&set opr=) else set re=R&set "opr=- Zuruecksetzen (r)")
cls&echo ^> Experimentelle Optionen %opr%
%M%&echo Druecke die Nummer deiner Auswahl um Optionen zu aendern.&%N%&%M%&%M%
if %cf%==Aktiviert goto DEeocf
echo  1 ^> Auto Update check         - %udc%&echo  2 ^> Ton                       - %ton%&echo  3 ^> Echo on                   - %echoon%&goto DEeocf1
:DEeocf
call :CT 07 " 1. Auto Update check         -"&if %udc%==Aktiviert (call :CT 0C " Aktiviert"&%M%) else (call :CT 0a " Deaktiviert"&%M%)
call :CT 07 " 2. Ton                       -"&if %ton%==Standard (call :CT 0a " Standard"&%M%) else (if %ton%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%))
call :CT 07 " 3. Echo on                   -"&if %echoon%==Aktiviert (call :CT 0C " Aktiviert"&%M%) else (call :CT 0a " Deaktiviert"&%M%)
:DEeocf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%8%ext%123%re% /N >NUL
if %errorlevel% equ 1 goto DEo
if %errorlevel% equ 2 goto DEo
if %errorlevel% equ 3 goto DEE
if %errorlevel% equ 4 if %udc%==Aktiviert (set udc=Deaktiviert&set update=&set up=&goto DEExperimentalOptions) else (set udc=Aktiviert&set np=&goto DEExperimentalOptions)
if %errorlevel% equ 5 goto DEton
if %errorlevel% equ 6 if %echoon%==Aktiviert (@echo off&set echoon=Deaktiviert&goto DEExperimentalOptions) else (@echo on&set echoon=Aktiviert&goto DEExperimentalOptions)
if %errorlevel% equ 7 goto DEr
:deus
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1) else (set np=0&cls&%M%&echo Error!&timeout 2&goto o)
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build "%userprofile%\IconRepair\build" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto o)
set /p NB=<%userprofile%\IconRepair\build
if not "%V% (%B%)"=="%NB%" (goto U) else (cls&%M%&echo Keine Updates verfuegbar!&timeout 2&goto o)
:DEr
cls&%M%&echo Einstellungen zuruecksetzen?&%M%&echo Wichtig: Einstellungen werden geloescht!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEr1
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto DEE
:DEr1
set ton=Standard&set cf=Deaktiviert&set udc=Deaktiviert&set adc=Aktiviert&set so=Deaktiviert&del /f /q "%userprofile%\IconRepair\options.cmd"&goto o
:DEton
cls&%M%&echo Pruefe auf Administratorrechte...&%N%
if %adc%==Aktiviert (goto DEton2)
net session >NUL 2>&1
if %errorlevel% equ 0 (set NA=A) else (set NA=NA)
:DEton2
if %NA%==NA (goto DEtone)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if /I "%%H" neq "RUNNING" (set ton=Aktiviert) else (set ton=Deaktiviert))
if %ton%==Aktiviert (goto DEtond)
if %ton%==Deaktiviert (goto DEtona)
:DEtond
cls&%M%&echo Ton deaktivieren...&%N%
sc stop beep >NUL
if %errorlevel% neq 0 (goto DEtone)
if %so%==Aktiviert (sc config beep start= disabled >NUL)
set ton=Deaktiviert&goto o
:DEtona
cls&%M%&echo Ton aktivieren...&%N%
if %so%==Aktiviert (sc config beep start= auto >NUL)
sc start beep >NUL
if %errorlevel% neq 0 (goto DEtone)
set ton=Aktiviert&goto o
:DEtone
cls&%M%&echo Fehler! Bitte versuche es erneut.&%M%&echo Wichtig: Um diese Einstellung zu aendern muss IconRepair&echo          als Administrator gestartet werden!&%N%&timeout 4&goto o
:DEwinvero
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%L%)&echo ^> Windows version ^> %L%
%M%&echo Druecke die Nummer deiner Auswahl um Optionen zu aendern.&%N%&%M%&%M%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%M%&%N%&%M%&echo %back% - %exit%
choice /C %W1%%W2%%W3%%bck%%ext%%W4% /N >NUL
if %errorlevel% equ 1 if %W1%==1 (set winver=10.0&set L=Windows 10&goto DEwinvero) else (set winver=6.3&set L=Windows 8.1&goto DEwinvero)
if %errorlevel% equ 2 if %W2%==2 (set winver=6.3&set L=Windows 8.1&goto DEwinvero) else (set winver=6.2&set L=Windows 8&goto DEwinvero)
if %errorlevel% equ 3 if %W3%==3 (set winver=6.2&set L=Windows 8&goto DEwinvero) else (set winver=6.1&set L=Windows 7&goto DEwinvero)
if %errorlevel% equ 4 goto o
if %errorlevel% equ 5 goto DEE
if %errorlevel% equ 6 set winver=6.1&set L=Windows 7&goto DEwinvero
:DEadc
if %adc%==Deaktiviert (set adc=Aktiviert&goto o)
cls&%M%&echo Administrator check deaktivieren?&%M%&echo Wichtig: Das deaktivieren kann zu Problemen fuehren!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 set adc=Deaktiviert&goto o
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto DEE
:DEso
if %so%==Aktiviert (goto DEsoda) else (set so=Aktiviert&if not exist "%userprofile%\IconRepair\" (mkdir %userprofile%\IconRepair\))
if not exist "%userprofile%\IconRepair\options.cmd" (echo >%userprofile%\IconRepair\options.cmd)
if not exist "%userprofile%\IconRepair\options.cmd" (goto CTE)
goto o
:DEsoda
cls&%M%&echo Einstellungen speichern deaktivieren?&%M%&echo Wichtig: Einstellungen werden geloescht wenn diese Option&echo          deaktiviert wird!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEsoda1
if %errorlevel% equ 2 goto o
if %errorlevel% equ 3 goto DEE
:DEsoda1
set so=Deaktiviert&del /f /q "%userprofile%\IconRepair\options.cmd"
if %errorlevel% neq 0 (goto CTE)
goto o
:ENl
set back=Back (b)&set exit=Exit (e)&set bck=B&set ext=E&set ob=
cls&%R% (%L%)&echo About (a) - Options (o)%update%
%M%&echo Press the number of your choice to continue.&echo For more information press i!&%N%&%M%&%M%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> System options&%M%&%N%&%M%&echo %exit%
if "%udc%"=="Disabled" (goto ENNP)
if not "%np%"=="" (goto ENNP)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1) else (set np=0&goto ENNP)
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build "%userprofile%\IconRepair\build" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto b)
set /p NB=<%userprofile%\IconRepair\build
if not "%V% (%B%)"=="%NB%" (goto U)
:ENNP
if "%adc%"=="Disabled" (goto ENNAC)
if not "%NA%"=="" (goto ENNAC)
net session >NUL 2>&1
if %errorlevel% equ 0 (set NA=A) else (set NA=NA)
:ENNAC
choice /C 1234%ext%IAO%up% /N >NUL
if %errorlevel% equ 1 goto ENIR
if %errorlevel% equ 2 goto ENNR
if %errorlevel% equ 3 goto ENAR
if %errorlevel% equ 4 goto ENS
if %errorlevel% equ 5 goto ENE
if %errorlevel% equ 6 goto ENi
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto o
if %errorlevel% equ 9 goto U2
:ENIR
cls&%M%&echo Start IconRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto EN7IR) else (goto EN10IR)
if %errorlevel% equ 2 if %winver%==6.1 (goto EN7IR) else (goto EN10IR)
if %errorlevel% equ 3 goto ENl
if %errorlevel% equ 4 goto ENE
:EN10IR
cls&%M%&echo Clearing icon cache...&%M%
taskkill /f /im explorer.exe
del /f /s /q %userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.* >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
del /f /s /q %userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.* >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
start explorer.exe
cls&%M%&echo Finished&%M%&%IRe%
echo If your problem is not solved yet,&echo try to restart your PC.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S1%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENl
:EN7IR
cls&%M%&echo Clearing icon cache...&%M%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Please try again with administrator rights!) else (set IRe=)
start explorer.exe
cls&%M%&echo Finished&%M%&%IRe%
echo If your problem is not solved yet,&echo try to restart your PC.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S1%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENl
:ENNR
if "%adc%"=="Disabled" (goto ENNRa)
if %NA%==NA (goto ENNRna) else (goto ENNRa)
:ENNRna
cls&%M%&echo No permission!&echo Start IconRepair as an Administrator.&echo Continue anyway?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENNRa
if %errorlevel% equ 2 goto ENNRa
if %errorlevel% equ 3 goto ENl
if %errorlevel% equ 4 goto ENE
:ENNRa
cls&%M%&echo Start NetworkRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENNR1
if %errorlevel% equ 2 goto ENNR1
if %errorlevel% equ 3 goto ENl
if %errorlevel% equ 4 goto ENE
:ENNR1
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
cls&%M%&echo Finished&%NRe%
%M%&echo If your problem is not solved yet,&echo try to restart your router and your PC.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S2%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENl
:ENAR
if "%adc%"=="Disabled" (goto ENARa)
if %NA%==NA (goto ENARna) else (goto ENARa)
:ENARna
cls&%M%&echo No permission!&echo Start IconRepair as an Administrator.&echo Continue anyway?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENARa
if %errorlevel% equ 2 goto ENARa
if %errorlevel% equ 3 goto ENl
if %errorlevel% equ 4 goto ENE
:ENARa
cls&%M%&echo Start AudioRepair? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENAR1
if %errorlevel% equ 2 goto ENAR1
if %errorlevel% equ 3 goto ENl
if %errorlevel% equ 4 goto ENE
:ENAR1
cls&%M%&echo Restarting audio drivers...&%M%
net stop audiosrv /y >NUL
if %errorlevel% equ 0 (net start audiosrv >NUL&set ARe=) else (set ARe=echo Please try again with administrator rights!)
net stop AudioEndpointBuilder /y >NUL
if %errorlevel% neq 0 (net start AudioEndpointBuilder >NUL&set ARe=) else (set ARe=echo Please try again with administrator rights!)
net stop RzSurroundVADStreamingService >NUL
net start RzSurroundVADStreamingService >NUL
cls&%M%&echo Finished&%ARe%
%M%&echo If your problem is not solved yet,&echo try to restart your router and your PC.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S3%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto ENl
:ENi
cls&echo ^> Information&%M%&echo IconRepair&echo  Tries to fix invisible icons on the desktop and in the&echo  taskbar by renewing the icon cache.&%N%&%M%&echo NetworkRepair&echo  Tries to fix network disconnections by renewing the&echo  network connection.&%N%&%M%&echo AudioRepair&echo  Tries to fix audio problems by restarting all audio&echo  drivers.&%N%&%M%&echo System options&echo  Ability to quickly restart Windows Explorer or cancel&echo  planned shutdown from Windows and more.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto b
if %errorlevel% equ 2 goto b
if %errorlevel% equ 3 goto ENE
:ENS
set sd=&set sda=&set sdM=
cls&set ob=s&echo ^> System options - Options (o)%update%
%M%&echo Press the number of your choice to continue.&echo For more information press i!&%N%&%M%&%M%&echo  1 ^> Restart windows explorer&echo  2 ^> Start windows CMD&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO1234%up% /N >NUL
if %errorlevel% equ 1 goto ENl
if %errorlevel% equ 2 goto ENE
if %errorlevel% equ 3 goto ENIE
if %errorlevel% equ 4 goto o
if %errorlevel% equ 5 goto ENS1
if %errorlevel% equ 6 goto ENS2
if %errorlevel% equ 7 goto ENS3
if %errorlevel% equ 8 goto ENS4a
if %errorlevel% equ 9 goto U2
:ENS1
cls&%M%&echo Restart Windows Explorer?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS1y
if %errorlevel% equ 2 goto ENS1y
if %errorlevel% equ 3 goto ENS
if %errorlevel% equ 4 goto ENE
:ENS1y
taskkill /f /IM explorer.exe
if %errorlevel% neq 0 (goto ENS12e)
timeout 1&start explorer.exe
if %errorlevel% neq 0 (goto ENS12e)
goto ENSF
:ENS2
start
if %errorlevel% neq 0 (if %errorlevel% neq 5 (goto ENS12e))
goto ENS
:ENS12e
cls&%M%&echo An error occurred!&%N%&timeout 4&goto ENS
:ENS3
cls&set ob=s3&echo ^> Shutdown menu - Options (o)%update%&%M%&echo Press the number of your choice to continue.&%N%&%M%&%M%&echo  1 ^> Instand shutdown&echo  2 ^> Shutdown PC in the next few minutes&echo  3 ^> Enter time yourself&echo  4 ^> Instand restart&echo  5 ^> Cancel shutdown&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%O12345%up% /N >NUL
if %errorlevel% equ 1 goto ENS
if %errorlevel% equ 2 goto ENE
if %errorlevel% equ 3 goto o
if %errorlevel% equ 4 goto ENS31
if %errorlevel% equ 5 goto ENS32
if %errorlevel% equ 6 goto ENS33
if %errorlevel% equ 7 goto ENS34
if %errorlevel% equ 8 goto ENS35
if %errorlevel% equ 9 goto U2
:ENS31
cls&%M%&echo Shutdown PC immediately?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS31s
if %errorlevel% equ 2 goto ENS31s
if %errorlevel% equ 3 goto ENS3
if %errorlevel% equ 4 goto ENE
:ENS31s
timeout 1&shutdown
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENS3
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENS3
set sd=Cancel shutdown (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSF
:ENS32
cls&%M%&echo Shutdown PC in the next few minutes?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS32s
if %errorlevel% equ 2 goto ENS32s
if %errorlevel% equ 3 goto ENS3
if %errorlevel% equ 4 goto ENE
:ENS32s
timeout 1&shutdown /s
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENS3
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENS3
set sd=Cancel shutdown (c)&set sd=echo Set time: In the next few minutes&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSF
:ENS33
cls&%M%&echo Specify time in seconds (numbers only/max. 99999).&echo Confirm with enter!&%N%&%M%&echo %back%&%M%
set /p sdz=
if /i '%sdz%' == 'b' goto ENS3
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto ENS33)
cls&%M%&echo Shutdown PC in %sdz% seconds?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS33s
if %errorlevel% equ 2 goto ENS33
if %errorlevel% equ 3 goto ENE
:ENS33s
shutdown -s -t %sdz%
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENS3
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&echo Please use only numbers (max. 99999).&%N%&timeout 4&goto ENS3
set sd2=echo Cancel shutdown (c)&set sd=echo Set time: %sdz%s&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSF
:ENS34
cls&%M%&echo Restart PC immediately?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS34s
if %errorlevel% equ 2 goto ENS34s
if %errorlevel% equ 3 goto ENS3
if %errorlevel% equ 4 goto ENE
:ENS34s
timeout 1&shutdown -r
if %errorlevel% equ 1190 cls&%M%&echo An operation is already planned!&%N%&timeout 4&goto ENS3
if %errorlevel% neq 0 cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENS3
set sd2=Cancel restart (c)&set sd=echo Set time: Immediately&set sda=C&set sdM=%M%&set sdM2=%N%&goto ENSF
:ENS35
shutdown /a
if %errorlevel% equ 1116 cls&%M%&echo No operation aborted&%N%&timeout 4&goto ENS3
if %errorlevel% equ 0 cls&%M%&echo Operation canceled&%N%&timeout 4&goto ENS3
cls&%M%&echo An error has occurred!&%N%&timeout 4&goto ENS3
goto ENS3
:ENS4a
if exist "%windir%\perfc.dll" (set C1=Enabled) else (set C1=Disabled)
if exist "%windir%\cscc.dat" (set C3=Enabled) else (set C3=Disabled)
cls&set ob=s4a&echo ^> Security menu - Options (o)%update%&%M%&echo Press the number of your choice to continue.&echo For more information press i!&%N%&%M%&%M%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Enabled) else (set C2=Disabled)
if "%cf%"=="Enabled" goto ENS4cf
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%
:ENS4cf
if "%cf%"=="Disabled" goto ENS4cf1
call :CT 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
call :CT 07 " 2. Petya 2 Patch             -"&if %C2%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
call :CT 07 " 3. BadRabbit Patch           -"&if %C3%==Enabled (call :CT 0a " Enabled"&%M%) else (call :CT 0C " Disabled"&%M%)
:ENS4cf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO123%up% /N >NUL
if %errorlevel% equ 1 goto ENS
if %errorlevel% equ 2 goto ENE
if %errorlevel% equ 3 goto ENS4cfi
if %errorlevel% equ 4 goto o
if %errorlevel% equ 5 if %C1%==Enabled (goto ENS4d) else (goto ENS4e)
if %errorlevel% equ 6 if %C2%==Enabled (goto ENS42d) else (goto ENS42e)
if %errorlevel% equ 7 if %C2%==Enabled (goto ENS43d) else (goto ENS43e)
if %errorlevel% equ 8 goto U2
:ENS4cfi
cls&echo ^> Security menu ^> Information&%M%&echo Petya/NotPetya&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%N%&%M%&echo Petya 2&echo  Protects Windows from the Blackmail Trojan which encrypts&echo  files on the computer.&echo  Read: https://en.wikipedia.org/wiki/Petya_(malware)&%N%&%M%&echo BadRabbit&echo  Protects Windows from BadRabbit ransomware.&echo  Read: https://securelist.com/bad-rabbit-ransomware/82851/&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENS4a
if %errorlevel% equ 2 goto ENS4a
if %errorlevel% equ 3 goto ENE
:ENS4e
cls&%M%&echo Patch your Windows against Petya/NotPetya?&%M%&echo Note: This is NO guarantee to save you from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS4e2
if %errorlevel% equ 2 goto ENS4e2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS4e2
cls&%M%&echo Enabling Petya/NotPetya patch...&%M%
echo Generated by IconRepair > %windir%\perfc.dll
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENS4np)
echo Generated by IconRepair > %windir%\perfc.dat
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENS4np)
echo Generated by IconRepair > %windir%\perfc
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENS4np)
goto ENS4a
:ENS4d
cls&%M%&echo Disable patch against Petya/NotPetya?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS4d2
if %errorlevel% equ 2 goto ENS4d2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS4d2
cls&%M%&echo Disabling Petya/NotPetya patch...&%M%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENS4np)
del /f /q %windir%\perfc.dll >NUL
if %errorlevel% neq 0 (goto ENS4np)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc.dat >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc >NUL
goto ENS4a
:ENS42e
cls&%M%&echo Patch your Windows against Petya 2?&%M%&echo Note: This is NO guarantee to save you from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS42e2
if %errorlevel% equ 2 goto ENS42e2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS42e2
cls&%M%&echo Enabling Petya 2 patch...&%M%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto ENS4a) else (goto ENS4np)
:ENS42d
cls&%M%&echo Disable patch against Petya 2?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS42d2
if %errorlevel% equ 2 goto ENS42d2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS42d2
cls&%M%&echo Disabling Petya 2 patch...&%M%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto ENS4a) else (goto ENS4np)
:ENS43e
cls&%M%&echo Patch your Windows against BadRabbit?&%M%&echo Note: This is NO guarantee to save you from any kind&echo       of infection or similar!&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS43e2
if %errorlevel% equ 2 goto ENS43e2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS43e2
cls&%M%&echo Enabling BadRabbit patch...&%M%
echo Generated by IconRepair > %windir%\cscc.dat
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENS4np)
echo Generated by IconRepair > %windir%\infpub.dat
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto ENS4np)
goto ENS4a
:ENS43d
cls&%M%&echo Disable patch against BadRabbit?&%N%&%M%&echo Yes (y) - %back% - %exit%
choice /C Y3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto ENS43d2
if %errorlevel% equ 2 goto ENS43d2
if %errorlevel% equ 3 goto ENS4a
if %errorlevel% equ 4 goto ENE
:ENS43d2
cls&%M%&echo Disabling BadRabbit patch...&%M%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto ENS4np)
del /f /q %windir%\cscc.dat >NUL
if %errorlevel% neq 0 (goto ENS4np)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\infpub.dat >NUL
goto ENS4a
:ENS4np
cls&%M%&echo An error occurred!&%M%&echo Note: To change this setting, IconRepair must be&echo       started as administrator!&%N%&timeout 4&goto ENS4a
:ENSF
cls&%M%&echo Finished&%sdM2%
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
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENS
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto ENS35
:ENIE
cls&echo ^> System options ^> Information&%M%&echo Restart windows explorer&echo  Restarts Windows Explorer to solve minor problems.&%N%&%M%&echo Start windows CMD&echo  Starts the command prompt to execute commands manually.&%N%&%M%&echo Shutdown menu&echo  Shutdown the PC.&%N%&%M%&echo Security menu&echo  Create .dat files in the system32 folder and edit the&echo  registry which could prevent you against malware.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto ENS
if %errorlevel% equ 2 goto ENS
if %errorlevel% equ 3 goto ENE
:ENE
cls&%M%&echo Canceled...&%N%&timeout 2&exit
:DEl
set back=Zurueck (z)&set exit=Beenden (b)&set bck=Z&set ext=B&set ob=
cls&%R% (%L%)&echo About (a) - Optionen (o)%update%
%M%&echo Druecke die Nummer deiner Auswahl um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> Systemoptionen&%M%&%N%&%M%&echo %exit%
if "%udc%"=="Deaktiviert" (goto DENP) else (if "%udc%"=="Disabled" (goto DENP))
if not "%np%"=="" (goto DENP)
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set np=1) else (set np=0&goto DENP)
bitsadmin /transfer /download /priority high https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build "%userprofile%\IconRepair\build" >NUL
if not %errorlevel%==0 (cls&%M%&echo Error!&timeout 2&goto b)
set /p NB=<%userprofile%\IconRepair\build
if not "%V% (%B%)"=="%NB%" (goto U)
:DENP
if "%adc%"=="Deaktiviert" (goto DENAC)
if not "%NA%"=="" (goto DENAC)
net session >NUL 2>&1
if %errorlevel% equ 0 (set NA=A) else (set NA=NA)
:DENAC
choice /C 1234%ext%IAO%up% /N >NUL
if %errorlevel% equ 1 goto DEIR
if %errorlevel% equ 2 goto DENR
if %errorlevel% equ 3 goto DEAR
if %errorlevel% equ 4 goto DES
if %errorlevel% equ 5 goto DEE
if %errorlevel% equ 6 goto DEi
if %errorlevel% equ 7 goto about
if %errorlevel% equ 8 goto o
if %errorlevel% equ 9 goto U2
:DEIR
cls&%M%&echo IconRepair starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S1%bck%%ext% /N >NUL
if %errorlevel% equ 1 if %winver%==6.1 (goto DE7IR) else (goto DE10IR)
if %errorlevel% equ 2 if %winver%==6.1 (goto DE7IR) else (goto DE10IR)
if %errorlevel% equ 3 goto DEl
if %errorlevel% equ 4 goto DEE
:DE10IR
cls&%M%&echo Loesche Iconcaches...&%N%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /s /q %userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.* >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /s /q %userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.* >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
start explorer.exe
cls&%M%&echo Fertig&%IRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S1%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEl
:DE7IR
cls&%M%&echo Loesche Iconcache...&%N%
taskkill /f /im explorer.exe
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set IRe=echo Bitte mit administrator rechten erneut versuchen!) else (set IRe=)
start explorer.exe
cls&%M%&echo Fertig&%IRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den PC neu zu starten.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S1%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEl
:DENR
if "%adc%"=="Deaktiviert" (goto DENRa)
if %NA%==NA (goto DENRna) else (goto DENRa)
:DENRna
cls&%M%&echo Keine berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DENRa
if %errorlevel% equ 2 goto DENRa
if %errorlevel% equ 3 goto DEl
if %errorlevel% equ 4 goto DEE
:DENRa
cls&%M%&echo NetworkRepair starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DENR1
if %errorlevel% equ 2 goto DENR1
if %errorlevel% equ 3 goto DEl
if %errorlevel% equ 4 goto DEE
:DENR1
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
cls&%M%&echo Fertig&%NRe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den Router und PC neu zu starten.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S2%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEl
:DEAR
if "%adc%"=="Deaktiviert" (goto DEARa)
if %NA%==NA (goto DEARna) else (goto DEARa)
:DEARna
cls&%M%&echo Keine berechtigung! Starte IconRepair als Administrator.&echo Trotzdem fortfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEARa
if %errorlevel% equ 2 goto DEARa
if %errorlevel% equ 3 goto DEl
if %errorlevel% equ 4 goto DEE
:DEARa
cls&%M%&echo AudioReapir starten? (%L%)&%N%&%M%&echo Start (s) - %back% - %exit%
choice /C S3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DEAR1
if %errorlevel% equ 2 goto DEAR1
if %errorlevel% equ 3 goto DEl
if %errorlevel% equ 4 goto DEE
:DEAR1
cls&%M%&echo Audiotreiber neu starten...&%N%
net stop audiosrv /y >NUL
if %errorlevel% equ 0 (net start audiosrv >NUL&set ARe=) else (set ARe=echo Bitte mit administrator rechten erneut versuchen!)
net stop AudioEndpointBuilder /y >NUL
if %errorlevel% neq 0 (net start AudioEndpointBuilder >NUL&set ARe=) else (set ARe=echo Bitte mit administrator rechten erneut versuchen!)
net stop RzSurroundVADStreamingService >NUL
net start RzSurroundVADStreamingService >NUL
cls&%M%&echo Fertig&%ARe%
%M%&echo Falls das Problem immer noch vorhanden ist,&echo versuche den Router und PC neu zu starten.&%N%&%M%&echo %back% - %exit%
choice /C %ext%S3%bck% /N >NUL
if %errorlevel% equ 1 exit
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 exit
if %errorlevel% equ 4 goto DEl
:DEi
cls&echo ^> Information&%M%&echo IconRepair&echo  Versucht, unsichtbare Symbole auf dem Desktop und in der&echo  Taskleiste zu beheben, indem der icon cache erneuert&echo  wird.&%N%&%M%&echo NetworkRepair&echo  Versucht, Netzwerkunterbrechungen zu beheben, indem die&echo  Netzwerkverbindung erneuert wird.&%N%&%M%&echo AudioRepair&echo  Versucht, Audioprobleme durch einen Neustart der&echo  Audiotreiber zu beheben.&%N%&%M%&echo Systemoptionen&echo  Moeglichkeit zum schnellen Neustart von Windows Explorer&echo  oder Abbrechen des geplanten Herunterfahrens von Windows&echo  und mehr.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto b
if %errorlevel% equ 2 goto b
if %errorlevel% equ 3 goto DEE
:DES
set sd=&set sda=&set sdM=&set ob=s
cls&echo ^> Systemoptionen - Optionen (o)%update%
%M%&echo Druecke die Nummer deiner Auswahl um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%&echo  1 ^> Windows Explorer neu starten&echo  2 ^> Windows CMD starten&echo  3 ^> Shutdown menu&echo  4 ^> Security menu&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%IO1234%up% /N >NUL
if %errorlevel% equ 1 goto DEl
if %errorlevel% equ 2 goto DEE
if %errorlevel% equ 3 goto DEIE
if %errorlevel% equ 4 goto o
if %errorlevel% equ 5 goto DES1
if %errorlevel% equ 6 goto DES2
if %errorlevel% equ 7 goto DES3
if %errorlevel% equ 8 goto DES4a
if %errorlevel% equ 9 goto U2
:DES1
cls&%M%&echo Windows Explorer neu starten?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES1y
if %errorlevel% equ 2 goto DES1y
if %errorlevel% equ 3 goto DES
if %errorlevel% equ 4 goto DEE
:DES1y
taskkill /f /IM explorer.exe
if %errorlevel% neq 0 (goto DES12e)
timeout 1&start explorer.exe
if %errorlevel% neq 0 (goto DES12e)
goto DESF
:DES2
start
if %errorlevel% neq 0 (if %errorlevel% neq 5 (goto DES12e))
goto DES
:DES12e
cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DES
:DES3
cls&set ob=s3&echo ^> Shutdown menu - Optionen (o)%update%&%M%&echo Druecke die Nummer deiner Auswahl um fortzufahren.&%N%&%M%&%M%&echo  1 ^> Sofort herunterfahren&echo  2 ^> Innerhalb der naechsten Minuten&echo  3 ^> Zeit selbst eingeben&echo  4 ^> Sofort neu starten&echo  5 ^> Herunterfahren abbrechen&%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%O12345%up% /N >NUL
if %errorlevel% equ 1 goto DES
if %errorlevel% equ 2 goto DEE
if %errorlevel% equ 3 goto o
if %errorlevel% equ 4 goto DES31
if %errorlevel% equ 5 goto DES32
if %errorlevel% equ 6 goto DES33
if %errorlevel% equ 7 goto DES34
if %errorlevel% equ 8 goto DES35
if %errorlevel% equ 9 goto U2
:DES31
cls&%M%&echo PC sofort herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES31s
if %errorlevel% equ 2 goto DES31s
if %errorlevel% equ 3 goto DES3
if %errorlevel% equ 4 goto DEE
:DES31s
timeout 1&shutdown
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DES3
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DES3
set sd2=Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESF
:DES32
cls&%M%&echo PC innerhalb der naechsten Minuten herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES32s
if %errorlevel% equ 2 goto DES32s
if %errorlevel% equ 3 goto DES3
if %errorlevel% equ 4 goto DEE
:DES32s
timeout 1&shutdown /s
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DES3
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DES3
set sd2=Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: In den naechsten Minuten&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESF
:DES33
cls&%M%&echo Zeit in Sekunden angeben (nur Zahlen/max. 99999).&echo Mit enter bestaetigen!&%N%&%M%&echo %back%&%M%
set /p sdz=
if /i '%sdz%' == 'z' goto DES3
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto DES33)
cls&%M%&echo PC in %sdz% Sekunden herunterfahren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES33s
if %errorlevel% equ 2 goto DES33
if %errorlevel% equ 3 goto DEE
:DES33s
shutdown -s -t %sdz%
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DES3
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&echo Bitte verwende nur Zahlen (max. 99999).&%N%&timeout 4&goto DES3
set sd2=echo Herunterfahren abbrechen (a)&set sd=echo Eingestellte Zeit: %sdz%s&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESF
:DES34
cls&%M%&echo PC sofort neu starten?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J4%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES34s
if %errorlevel% equ 2 goto DES34s
if %errorlevel% equ 3 goto DES3
if %errorlevel% equ 4 goto DEE
:DES34s
timeout 1&shutdown -r
if %errorlevel% equ 1190 cls&%M%&echo Es ist bereits ein vorgang geplant!&%N%&timeout 4&goto DES3
if %errorlevel% neq 0 cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DES3
set sd=Neustart abbrechen (a)&set sd=echo Eingestellte Zeit: Sofort&set sda=A&set sdM=%M%&set sdM2=%N%&goto DESF
:DES35
shutdown /a
if %errorlevel% equ 1116 cls&%M%&echo Kein Vorgang abgebrochen!&%N%&timeout 4&goto DES3
if %errorlevel% equ 0 cls&%M%&echo Vorgang abgebrochen!&%N%&timeout 4&goto DES3
cls&%M%&echo Es ist ein Fehler aufgetreten!&%N%&timeout 4&goto DES3
goto DES3
:DES4a
if exist "%windir%\cscc.dat" (set C3=Aktiviert) else (set C3=Deaktiviert)
if exist "%windir%\perfc.dll" (set C1=Aktiviert) else (set C1=Deaktiviert)
cls&set ob=s4a&echo ^> Security menu - Optionen (o)%update%&%M%&echo Druecke die Nummer deiner Auswahl um fortzufahren.&echo Fuer mehr Informationen i druecken!&%N%&%M%&%M%
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" >NUL
if %errorlevel% equ 0 (set C2=Aktiviert) else (set C2=Deaktiviert)
if "%cf%"=="Aktiviert" goto DES4cf
echo  1 ^> Petya/NotPetya Patch      - %C1%&echo  2 ^> Petya 2 Patch             - %C2%&echo  3 ^> BadRabbit Patch           - %C3%
:DES4cf
if "%cf%"=="Deaktiviert" goto DES4cf1
call :CT 07 " 1. Petya & NotPetya Patch    -"&if %C1%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
call :CT 07 " 2. Petya 2 Patch             -"&if %C2%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
call :CT 07 " 3. BadRabbit Patch           -"&if %C3%==Aktiviert (call :CT 0a " Aktiviert"&%M%) else (call :CT 0C " Deaktiviert"&%M%)
:DES4cf1
%M%&%N%&%M%&echo %back% - %exit%
choice /C %bck%%ext%OI123%up% /N >NUL
if %errorlevel% equ 1 goto DES
if %errorlevel% equ 2 goto DEE
if %errorlevel% equ 3 goto o
if %errorlevel% equ 4 goto DES4cfi
if %errorlevel% equ 5 if %C1%==Aktiviert (goto DES4d) else (goto DES4e)
if %errorlevel% equ 6 if %C2%==Aktiviert (goto DES42d) else (goto DES42e)
if %errorlevel% equ 7 if %C3%==Aktiviert (goto DES43d) else (goto DES43e)
if %errorlevel% equ 8 goto U2
:DES4cfi
cls&echo ^> Security menu ^> Information&%M%&echo Petya/NotPetya&echo  Schuetzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschluesselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%N%&%M%&echo Petya 2&echo  Schuetzt Windows vor dem Erpressungstrojaner welcher&echo  Dateien im Computer verschluesselt.&echo  Mehr: https://de.wikipedia.org/wiki/Petya&%N%&%M%&echo BadRabbit&echo  Schuetzt Windows vor der Ransomware BadRabbit.&echo  Mehr: https://securelist.com/bad-rabbit-ransomware/82851/&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DES4a
if %errorlevel% equ 2 goto DES4a
if %errorlevel% equ 3 goto DEE
:DES4e
cls&%M%&echo Wollen Sie ihr Windows gegen Petya/NotPetya schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Sie vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES4e2
if %errorlevel% equ 2 goto DES4e2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES4e2
cls&%M%&echo Aktiviere Petya/NotPetya Patch...&%N%
(echo Generated by IconRepair) > %windir%\perfc.dll
icacls "%windir%\perfc.dll" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DES4np)
(echo Generated by IconRepair) > %windir%\perfc.dat
icacls "%windir%\perfc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DES4np)
(echo Generated by IconRepair) > %windir%\perfc
icacls "%windir%\perfc" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DES4np)
goto DES4a
:DES4d
cls&%M%&echo Wollen Sie ihren schutz gegen Petya/NotPetya deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J1%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES4d2
if %errorlevel% equ 2 goto DES4d2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES4d2
cls&%M%&echo Deaktiviere Petya/NotPetya Patch...&%N%
icacls "%windir%\perfc.dll" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DES4np)
del /f /q %windir%\perfc.dll >NUL
if %errorlevel% neq 0 (goto DES4np)
icacls "%windir%\perfc.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc.dat >NUL
icacls "%windir%\perfc" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\perfc >NUL
goto DES4a
:DES42e
cls&%M%&echo Wollen Sie ihr Windows gegen Petya 2 schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Sie vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES42e2
if %errorlevel% equ 2 goto DES42e2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES42e2
cls&%M%&echo Aktiviere Petya 2 Patch...&%N%
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1 /t REG_DWORD /d 0 >NUL
if %errorlevel% equ 0 (goto DES4a) else (goto DES4np)
:DES42d
cls&%M%&echo Wollen Sie ihren schutz gegen Petya 2 deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J2%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES42d2
if %errorlevel% equ 2 goto DES42d2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES42d2
cls&%M%&echo Deaktiviere Petya 2 Patch...&%N%
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters /f /v SMB1
if %errorlevel% equ 0 (goto DES4a) else (goto DES4np)
:DES43e
cls&%M%&echo Wollen Sie ihr Windows gegen BadRabbit schuetzen?&%M%&echo Wichtig: Dies ist KEINE Garantie, um Sie vor jeglicher&echo          Art von Infektion oder Aehnlichem zu schuetzen!&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES43e2
if %errorlevel% equ 2 goto DES43e2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES43e2
cls&%M%&echo Aktiviere BadRabbit Patch...&%N%
echo Generated by IconRepair > %windir%\cscc.dat
icacls "%windir%\cscc.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DES4np)
echo Generated by IconRepair > %windir%\infpub.dat
icacls "%windir%\infpub.dat" /inheritance:r /remove *S-1-5-32-544 >NUL
if %errorlevel% neq 0 (goto DES4np)
goto DES4a
:DES43d
cls&%M%&echo Wollen Sie ihren schutz gegen BadRabbit deaktivieren?&%N%&%M%&echo Ja (j) - %back% - %exit%
choice /C J3%bck%%ext% /N >NUL
if %errorlevel% equ 1 goto DES43d2
if %errorlevel% equ 2 goto DES43d2
if %errorlevel% equ 3 goto DES4a
if %errorlevel% equ 4 goto DEE
:DES43d2
cls&%M%&echo Deaktiviere BadRabbit Patch...&%N%
icacls "%windir%\cscc.dat" /grant *S-1-5-32-544:F >NUL
if %errorlevel% neq 0 (goto DES4np)
del /f /q %windir%\cscc.dat >NUL
if %errorlevel% neq 0 (goto DES4np)
icacls "%windir%\infpub.dat" /grant *S-1-5-32-544:F >NUL
del /f /q %windir%\infpub.dat >NUL
goto DES4a
:DES4np
cls&%M%&echo Es ist ein Fehler aufgetreten!&%M%&echo Wichtig: Um diese Einstellung zu aendern muss IconRepair&echo          als Administrator gestartet werden!&%N%&timeout 4&goto DES4a
:DESF
cls&%M%&echo Fertig&%sdM2%
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
if %errorlevel% equ 6 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DES
if %errorlevel% equ 7 set sd=&set sd2=&set sda=&set sdM=&set sdM2=&goto DES35
:DEIE
cls&echo ^> Systemoptionen ^> Information&%M%&echo Windows Explorer neu starten&echo  Startet den Windows Explorer neu, um kleinere probleme&echo  zu loesen.&%N%&%M%&echo Windows CMD starten&echo  Startet die Eingabeaufforderung um Befehle manuell&echo  auszufuehren.&%N%&%M%&echo Shutdown menu&echo  Faehrt den PC in ausgewaehlter Zeit herunter.&%N%&%M%&echo Security menu&echo  Erstellt .dat Dateien im system32 Ordner und editiert&echo  die Registry, um den Computer vielleicht vor Malware zu&echo  schuetzen.&%N%&%M%&echo %back% - %exit%
choice /C %bck%I%ext% /N >NUL
if %errorlevel% equ 1 goto DES
if %errorlevel% equ 2 goto DES
if %errorlevel% equ 3 goto DEE
:DEE
cls&%M%&echo Beendet...&%N%&timeout 2&exit
:CTE
if %lang%==Deutsch (goto DECTE) else (goto ENCTE)
:DECTE
if "%so%"=="Aktiviert" (set so=Deaktiviert)
if "%cf%"=="Aktiviert" (set cf=Deaktiviert)
cls&%N%&%M%&echo Fehler! Keine Berechtigung.&echo Optionen wurden deaktiviert.&%N%&timeout 4
goto o
:ENCTE
if "%so%"=="Enabled" (set so=Disabled)
if "%cf%"=="Enabled" (set cf=Disabled)
cls&%N%&%M%&echo Error! No Permission.&echo Options have been disabled.&%N%&timeout 4
goto o
:CT
if not exist "%userprofile%\IconRepair\" (mkdir %userprofile%\IconRepair\)
pushd %userprofile%\IconRepair\
if %errorlevel% neq 0 (goto CTE)
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1