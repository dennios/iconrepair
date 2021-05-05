@echo off&mode 79,26&set V=4.0&set B=4007&set RU=3.0&set year=2021&set "settingspath="%userprofile%\IconRepair\settings.cmd""&set "iconrepairfile=%~n0.exe"&set "iconrepairloc=%~dpn0.exe"
set "L=echo ____________________________________________________________"&set "S=echo:"&set "R=title IconRepair"&set update=&set up=&set locked=0
for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do (set space=%%a)
for /f "tokens=1,2 delims=#" %%c in ('"prompt #$H#$E#&echo on&for %%d in (1) do rem"') do (set "DEL=%%c")
:setup
call :checksettings
call :checklanguage
if not %sound%==Default (%S%&echo %checkingsoundprocess%&for /f "tokens=3 delims=:" %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Disabled)))
if "%winver%"=="" (call :checkwinver) else (call :setwinver)
goto main
:checksettings
if exist %settingspath% (call %settingspath%)
if not "%savesettings%"=="Enabled" (set savesettings=Disabled)
if not "%udc%"=="Enabled" (set udc=Disabled)
if not "%coloredfont%"=="Enabled" (set coloredfont=Disabled)
if not "%echoon%"=="Enabled" (set echoon=Disabled)
if not "%sound%"=="Disabled" (set sound=Default)
if not "%adc%"=="Disabled" (set adc=Enabled)
exit /b
:checklanguage
if "%language%"=="" (for /f "tokens=3 delims= " %%l in ('reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage') do (if "%%l"=="0407" (set language=Deutsch) else (set language=English)))
if "%language%"=="Deutsch" (goto checklanguageDE)
set skey=s
set bkey=b
set ekey=e
set ykey=y
set rkey=w
set setresetkey=r
set cancelshutdownkey=c
set ukey=u

set "settings=Settings (%skey%)"
set "back=Back (%bkey%)"
set "exit=Exit (%ekey%)"
set "yes=Yes (%ykey%)"
set "retry=Retry (%rkey%)"
set "setreset=Reset (%setresetkey%)"
set "cancelshutdown=Cancel shutdown (%cancelshutdownkey%)"
set "checkforupdates=Check for update (%ukey%)"

set "unknown=Unknown"
set "unknownwinver=Unknown Windows version"
set "onlysupported=IconRepair is made for Windows 7-10!"
set "setwinvermanually=Press s to set the Windows version manually."
set "setwinvermanually=The Windows version can be set manually in the settings (s)."

set "pressselected=Select an associated number to continue."
set "nopermission=Missing permissions!"
set "settingsdisabled=Some settings have been disabled."
set "pressany=Press any key to continue."
set "noadmin=Restricted"

set "checkingupdate=Checking for update..."
set "noconnection=No connection!"
set "downloadfailed=Download failed!"
set "buildfilenotfound=Build file not found!"
set "updaterfilenotfound=Updater file not found!"
set "noupdate=No update available!"
set "dlupdater=Downloading updater..."
set "irupdateq=Update IconRepair to the latest version?"
set "installedversion=Installed version         "
set "latestversion=Latest version            "
set "loadingupdate=Loading update..."
set "updatesuccess=Successfully updated IconRepair."
set "closeallirprocesses=Please close all IconRepair processes&echo and try it again!"

set "settingstop=Settings"
set "pressset=Select an associated number to change settings."
set "optionsavesettings=Save settings                "
set "optionlanguage=Language                     "
set "optionwindowsversion=Windows version              "
set "optionadc=Administrator check          "
set "optioncoloredfont=Colored font                 "
set "experimentalsettings=Experimental settings"
set "reset=Reset"
set "optionudc=Auto update check            "
set "optionsound=Sound                        "
set "optionechoon=Echo on                      "

set "resetsetq=Reset settings?"
set "disablesavesettingsq=Disable save settings?"
set "note=Note"
set "importantsettingsdeleted=All settings will be deleted!"
set "windowsversionset=Windows version"
set "checkingadministratorrights=Checking for administrator permissions..."
set "esenablesound=Enable sound..."
set "esdisablesound=Disable sound..."
set "notesettingadmin=IconRepair has to be started as&echo       administrator to change this setting!"
set "checkingsoundprocess=Checking sound process..."

set "runiconrepair=Run IconRepair?&%S%&echo  Invisible icons on the desktop, in the Taskbar and in the&echo  Startmenu could be made visible again."
set "stoppingexplorer=Stopping explorer.exe..."
set "irclearingiconcache=Clearing icon cache..."
set "startingexplorer=Starting explorer.exe..."
set "finished=Finished!"
set "successfull=Successfull!"
set "tryrestartpc=The PC should be rebooted&echo if the problem still persists."
set "tryagainadmin=Please try again with administrator permissions!"
set "nopermissioncontinueanyway=IconRepair should be started as an Administrator.&%S%&echo Continue anyway?"
set "runnetworkrepair=Run NetworkRepair?&%S%&echo  Network disconnects could be solved by renewing&echo  the network connection."
set "nrreleasing=Releasing IP-Address..."
set "nremptycache=Empty DNS cache..."
set "nrupdateingdhcp=Updating DHCP leases and re-registering DNS..."
set "nrrenewing=Renewing IP-Address..."
set "runaudiorepair=Run AudioRepair (v2)?&echo Press o to run AudioRepair (v1).&%S%&echo  Audio problems could be solved by restarting all&echo  audio drivers."
set "arstoppingaudioservice=Stopping audio service..."
set "arstoppingaudioendpointbuilder=Stopping AudioEndpointBuilder..."
set "arstartingaudioservice=Starting audio service..."
set "arerrorusearold=Please try AudioRepair v1!"

set "srestartexplorer=Restart Windows explorer"
set "sstartwindowscmd=Start Windows CMD"
set "sshutdownmenu=Shutdown"
set "sdeletewinupdate=Delete Windows update"
set "sshowbios=Show BIOS version"
set "sshowwifi=Show WiFi information"
set "schoosewifi=Choose a network to continue.&echo Confirm with the enter key!"

set "restartexplorerq=Restart Windows Explorer?&%S%&echo  Restarts the graphical user interface."
set "erroroccurred=An error has occurred."
set "deletewinupdateq=Delete already downloaded Windows updates?"
set "stopingwuauserv=Stopping Windows update service..."
set "deletingupdate=Deleting Windows update..."
set "startingwuauserv=Starting Windows update service..."
set "nowinupdatefound=No downloaded Windows updates found."

set "sinstandshutdown=Instand shutdown"
set "sshutdownnext=Shutdown in the next few minutes"
set "scustomshutdown=Set custom time till shutdown"
set "sinstandrestart=Instand restart"
set "scancelshutdown=Cancel shutdown"
set "instandshutdownq=Shutdown PC immediately?"
set "shutdownnextq=Shutdown PC in the next few minutes?"
set "shutdowncustomq=Specify time in seconds (numbers only/max. 99999).&echo Confirm with the enter key!"
set "shutdowncustomqconfirm=Shutdown PC in"
set "instandrestartq=Restart PC immediately?"
set "shutdownalreadyplanned=A shutdown is already planned!"
set "noshutdownaborted=No shutdown was aborted."
set "shutdowncanceled=Shutdown canceled."
set "useonlynumbers=Please use only numbers (max. 99999)."
set "shutdowntypeset=Time set"
set "shutdowntypeimmediately=Immediately"
set "shutdowntypenext=In the next few minutes"

set "enabled=Enabled"
set "disabled=Disabled"
set "default=Default"
set "ended=Ended..."
exit /b
:checklanguageDE
set skey=e
set bkey=z
set ekey=b
set ykey=j
set rkey=w
set setresetkey=r
set cancelshutdownkey=a
set ukey=u

set "settings=Einstellungen (%skey%)"
set "back=Zurck (%bkey%)"
set "exit=Beenden (%ekey%)"
set "yes=Ja (%ykey%)"
set "retry=Wiederholen (%rkey%)"
set "setreset=Zurcksetzen (%setresetkey%)"
set "cancelshutdown=Herunterfahren abbrechen (%cancelshutdownkey%)"
set "checkforupdates=Nach Updates suchen (%ukey%)"

set "unknown=Unbekannt"
set "unknownwinver=Unbekannte Windows Version"
set "onlysupported=IconRepair ist fr Windows 7-10 geeignet!"
set "setwinvermanually=Die Windows Version kann ber die Einstellungen (e)&echo manuell festgelegt werden."

set "pressselected=Um fortzufahren muss eine zugeh”rige Nummer gedrckt werden."
set "nopermission=Fehlende Berechtigung!"
set "settingsdisabled=Einige Einstellungen wurden deaktiviert."
set "pressany=Eine beliebige Taste drcken, um fortzufahren."
set "noadmin=Eingeschr„nkt"

set "checkingupdate=Suche nach Updates..."
set "noconnection=Keine Verbindung!"
set "downloadfailed=Download fehlgeschlagen!"
set "buildfilenotfound=Build Datei nicht gefunden!"
set "updaterfilenotfound=Updater Datei nicht gefunden!"
set "noupdate=Keine Updates verfgbar!"
set "dlupdater=Updater herunterladen..."
set "irupdateq=IconRepair auf die neueste Version updaten?"
set "installedversion=Installierte Version      "
set "latestversion=Neuste Version            "
set "loadingupdate=Lade Update..."
set "updatesuccess=IconRepair wurde erfolgreich geupdatet."
set "closeallirprocesses=Bitte beende alle IconRepair Prozesse&echo und versuche es erneut!"

set "settingstop=Einstellungen"
set "pressset=Um Einstellungen zu „ndern muss die zugeh”rige Nummer&echo gedrckt werden."
set "optionsavesettings=Einstellungen speichern      "
set "optionlanguage=Sprache                      "
set "optionwindowsversion=Windows Version              "
set "optionadc=Administrator check          "
set "optioncoloredfont=Farbige Schrift              "
set "experimentalsettings=Experimentelle Einstellungen"
set "reset=Zurcksetzen"
set "optionudc=Auto Update check            "
set "optionsound=Ton                          "
set "optionechoon=Echo on                      "

set "resetsetq=Einstellungen zurcksetzen?"
set "disablesavesettingsq=Einstellungen speichern deaktivieren?"
set "note=Wichtig"
set "importantsettingsdeleted=Alle Einstellungen werden gel”scht!"
set "windowsversionset=Windows Version"
set "checkingadministratorrights=Prfe auf Administratorrechte..."
set "esenablesound=Ton aktivieren..."
set "esdisablesound=Ton deaktivieren..."
set "notesettingadmin=IconRepair muss als Administrator gestartet&echo          werden, um diese Einstellung zu „ndern!"
set "checkingsoundprocess=Teste Soundprozess..."

set "runiconrepair=IconRepair ausfhren?&%S%&echo  Unsichtbare Symbole auf dem Desktop, in der Taskbar und&echo  im Startmenu k”nnten wieder Sichtbar werden."
set "stoppingexplorer=explorer.exe beenden..."
set "irclearingiconcache=Iconcache l”schen..."
set "startingexplorer=explorer.exe starten..."
set "finished=Fertig!"
set "successfull=Erfolgreich!"
set "tryrestartpc=Falls das Problem noch vorhanden ist,&echo muss m”glicherweise der PC neu gestartet werden."
set "tryagainadmin=Bitte mit Administratorrechten erneut versuchen!"
set "nopermissioncontinueanyway=IconRepair sollte als Administrator gestartet werden.&%S%&echo Trotzdem fortfahren?"
set "runnetworkrepair=NetworkRepair ausfhren?&%S%&echo  Netzwerkunterbrechungen k”nnten behoben werden, indem die&echo  Netzwerkverbindung erneuert wird."
set "nrreleasing=IP-Adresse freigeben..."
set "nremptycache=DNS Cache leeren..."
set "nrupdateingdhcp=DHCP-Leases aktualisieren und DNS erneut registrieren..."
set "nrrenewing=IP-Adresse erneuern..."
set "runaudiorepair=AudioRepair v2 ausfhren?&echo Drcke a, um AudioRepair v1 auszufhren.&%S%&echo  Audioprobleme k”nnten durch einen Neustart der&echo  Audiotreiber behoben werden."
set "arstoppingaudioservice=Audiodienst beenden..."
set "arstoppingaudioendpointbuilder=AudioEndpointBuilder beenden..."
set "arstartingaudioservice=Audiodienst starten..."
set "arerrorusearold=Bitte AudioRepair v1 versuchen!"

set "srestartexplorer=Windows Explorer neu starten"
set "sstartwindowscmd=Windows CMD starten"
set "sshutdownmenu=Shutdown"
set "sdeletewinupdate=Windows Update l”schen"
set "sshowbios=BIOS Version anzeigen"
set "sshowwifi=WLAN Informationen anzeigen"
set "schoosewifi=Um fortzufahren muss ein Netzwerk ausw„hlt werden.&echo Die Eingabe muss mit der Enter-Taste best„tigt werden."

set "restartexplorerq=Windows Explorer neu starten?&%S%&echo  Startet die grafische Benutzeroberfl„che neu."
set "erroroccurred=Es ist ein Fehler aufgetreten."
set "deletewinupdateq=Bereits heruntergeladene Windows Updates l”schen?"
set "stopingwuauserv=Stoppe Windows Update Prozess..."
set "deletingupdate=L”sche Windows Update..."
set "startingwuauserv=Starte Windows Update Prozess..."
set "nowinupdatefound=Es wurden keine heruntergeladenen Windows Updates gefunden."

set "sinstandshutdown=Sofort herunterfahren"
set "sshutdownnext=In den n„chsten Minuten herunterfahren"
set "scustomshutdown=Herunterfahren in benutzerdefinierter Zeit"
set "sinstandrestart=Sofort neu starten"
set "scancelshutdown=Herunterfahren abbrechen"
set "instandshutdownq=PC sofort herunterfahren?"
set "shutdownnextq=PC innerhalb der n„chsten Minuten herunterfahren?"
set "shutdowncustomq=Zeit in Sekunden angeben (nur Zahlen/max. 99999).&echo Die Eingabe muss mit der Enter-Taste best„tigt werden."
set "shutdowncustomqconfirm=PC herunterfahren in"
set "instandrestartq=PC sofort neu starten?"
set "shutdownalreadyplanned=Es ist bereits ein Vorgang geplant."
set "noshutdownaborted=Kein Vorgang wurde abgebrochen."
set "shutdowncanceled=Vorgang abgebrochen."
set "useonlynumbers=Bitte nur Zahlen verwenden (max. 99999)."
set "shutdowntypeset=Festgelegte Zeit"
set "shutdowntypeimmediately=Sofort"
set "shutdowntypenext=In den n„chsten Minuten"

set "enabled=Aktiviert"
set "disabled=Deaktiviert"
set "default=Standard"
set "ended=Beendet..."
exit /b
:checkwinver
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set winver=%%j.%%k) else (set winver=%%i.%%j))
:setwinver
if "%winver%"=="10.0" (set "win=Windows 10"&exit /b)
if "%winver%"=="6.3" (set "win=Windows 8.1"&exit /b)
if "%winver%"=="6.2" (set "win=Windows 8"&exit /b)
if "%winver%"=="6.1" (set "win=Windows 7"&exit /b)
:unsupported
set W1=1&set W2=2&set W3=3&set W4=4&set "win=%unknown%"
%R% (%win%)&cls&echo ^> %unknownwinver%
%S%&echo %onlysupported%&echo %setwinvermanually%&%L%&%S%&echo %settings% - %exit%
choice /c %skey%%ekey% >NUL
if %errorlevel% equ 1 call :settings
if %errorlevel% equ 2 goto end
goto setwinver
:about
cls&echo ^> About - Changelog (l) - %checkforupdates%
%S%&echo Version %V%&echo Build %B%&echo Re. Updater %RU%&echo Year %year%&%S%&echo Reload (r)&%S%&echo by dennios&echo https://github.com/dennios/iconrepair/&%L%&%S%&echo %back% - %exit%
choice /c %bkey%ALR%ekey%%ukey% >NUL
if %errorlevel% equ 1 goto main
if %errorlevel% equ 2 goto main
if %errorlevel% equ 3 goto changelog
if %errorlevel% equ 4 goto setup
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 call :checkupdate&goto about
:changelog
cls&echo ^> Changelog&%S%&echo Version %V% (4006 ^& %B%)&echo  +Fix update&%S%&echo Version 4.0 (4005)&echo  +New feature: Show WiFi information&echo  +New feature: Show BIOS version&echo  +Implemented Updater 3.0&echo  +Many Improvements&%L%&%S%&echo %back% - %exit%
choice /c %bkey%L%ekey% >NUL
if %errorlevel% equ 1 goto about
if %errorlevel% equ 2 goto about
if %errorlevel% equ 3 goto end
:checkupdate
set "npcurrent=Update"&set updatestat=-1&%S%&echo %checkingupdate%
:update1
ping -n 1 -l 0 -w 1 github.com >NUL
if %errorlevel% equ 0 (set updatestat=1&goto update2) else (if "%updatestat%"=="0" (set "statuspar1=%noconnection%"&call :status&exit /b) else (set updatestat=0&goto update1))
:update2
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" 'https://raw.githubusercontent.com/dennios/iconrepair/master/updater/build' -outfile '%userprofile%\IconRepair\build' -timeoutsec 3 -usebasicparsing)
if %errorlevel% neq 0 (set "statuspar1=%downloadfailed%"&call :status&exit /b)
if exist "%userprofile%\IconRepair\build" (set /p newbuild=<"%userprofile%\IconRepair\build") else (set "statuspar1=%buildfilenotfound%"&call :status&exit /b)
if "%V% (%B%)"=="%newbuild%" (set "statuspar1=%noupdate%"&call :status&exit /b)
echo %dlupdater%&powershell.exe -c (invoke-webrequest -ContentType "application/octet-stream" 'https://raw.githubusercontent.com/dennios/iconrepair/master/updater/iconrepairupdater3.cmd' -outfile '%userprofile%\IconRepair\iconrepairupdater.cmd' -timeoutsec 3 -usebasicparsing)
if %errorlevel% neq 0 (set "statuspar1=%downloadfailed%"&call :status&exit /b)
:update3
cls&echo ^>Update&%S%&echo %irupdateq%&%L%&%S%&%S%&echo  %installedversion%- %V% (%B%)&echo  %latestversion%- %newbuild%&%S%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%%bkey%%ekey% >NUL
if %errorlevel% equ 1 goto Update4
if %errorlevel% equ 2 set "update= - Update (%ukey%)"&set "up=%ukey%"&exit /b
if %errorlevel% equ 3 goto end
:update4
set "iconrepairdl=https://raw.githubusercontent.com/dennios/iconrepair/master/IconRepair.exe"
if exist "%userprofile%\IconRepair\iconrepairupdater.cmd" (start "" "%userprofile%\IconRepair\iconrepairupdater.cmd"&exit) else (set "statuspar1=%updaterfilenotfound%"&call :status&exit /b)
:updatesuccess
cls&echo ^>Update&%S%&echo %updatesuccess%&%L%&%S%&%S%&echo  %installedversion%- %V% (%B%)&%S%&%L%&%S%&echo %pressany%&set updatestat=&timeout 5 >NUL&exit /b
:updatefailed
cls&echo ^>Update&%S%&echo %erroroccurred%&echo %closeallirprocesses%&%L%&%S%&echo %retry% - %back% - %exit%
choice /c %rkey%%bkey%%ekey% >NUL
if %errorlevel% equ 1 set updatestat=1&call :update4&exit /b
if %errorlevel% equ 2 exit /b
if %errorlevel% equ 3 goto end
:settings
call :writesettings
if %savesettings%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%)
if "%resetsettings%"=="" (if %adc%==Enabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %coloredfont%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %udc%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %sound%==Default (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %echoon%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if %adc%==Disabled (set astat=) else (if "%adminswitch%"=="" (call :administratorcheck) else (call :administratorset))
if %savesettings%==Enabled (set savesettingsd=%enabled%) else (set savesettingsd=%disabled%)
if %adc%==Enabled (set adcd=%enabled%) else (set adcd=%disabled%)
if %coloredfont%==Enabled (set coloredfontd=%enabled%) else (set coloredfontd=%disabled%)
cls&%R% (%win%%astat%)&echo ^> %settingstop%%resetsettings%
%S%&echo %pressset%&%L%&%S%&%S%
if %coloredfont%==Enabled (goto settingcoloredfont)
echo  1 ^> %optionsavesettings%- %savesettingsd%&echo  2 ^> %optionlanguage%- %language%&echo  3 ^> %optionwindowsversion%- %win%&echo  4 ^> %optionadc%- %adcd%&echo  5 ^> %optioncoloredfont%- %coloredfontd%&echo  6 ^> %experimentalsettings%&goto settingcoloredfontdisabled
:settingcoloredfont
<nul set /p="%space% 1 > %optionsavesettings%- "&if %savesettings%==Enabled (call :colorfont 0a "%enabled%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
<nul set /p="%space% 2 > %optionlanguage%- %language%"&%S%&<nul set /p="%space% 3 > %optionwindowsversion%- %win%"&%S%
<nul set /p="%space% 4 > %optionadc%- "&if %adc%==Enabled (call :colorfont 0a "%enabled%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
<nul set /p="%space% 5 > %optioncoloredfont%- "&if %coloredfont%==Enabled (call :colorfont 0a "%enabled%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
<nul set /p="%space% 6 > %experimentalsettings%"&%S%
:settingcoloredfontdisabled
%S%&%L%&%S%&echo %back% - %exit%
choice /c %bkey%%skey%%ekey%123456%re% >NUL
if %errorlevel% equ 1 exit /b
if %errorlevel% equ 2 exit /b
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %savesettings%==Enabled (goto savesettingsdisable) else (set savesettings=Enabled)
if %errorlevel% equ 5 if %language%==Deutsch (set language=English&call :checklanguage) else (set language=Deutsch&call :checklanguage)
if %errorlevel% equ 6 goto winversion
if %errorlevel% equ 7 if %adc%==Enabled (set adc=Disabled) else (set adc=Enabled)
if %errorlevel% equ 8 if %coloredfont%==Enabled (set coloredfont=Disabled) else (set coloredfont=Enabled)
if %errorlevel% equ 9 goto experimentalsettings
if %errorlevel% equ 10 goto reset
goto settings
:experimentalsettings
call :writesettings
if %savesettings%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%)
if "%resetsettings%"=="" (if %adc%==Enabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %coloredfont%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %udc%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %sound%==Default (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if "%resetsettings%"=="" (if %echoon%==Disabled (set resetsettings=&set re=) else (set "resetsettings= - %setreset%"&set re=%setresetkey%))
if %udc%==Enabled (set udcd=%enabled%) else (set udcd=%disabled%)
if %sound%==Default (set soundd=%default%) else (set soundd=%disabled%)
if %echoon%==Enabled (set echoond=%enabled%) else (set echoond=%disabled%)
cls&echo ^> %experimentalsettings%%resetsettings%
%S%&echo %pressset%&%L%&%S%&%S%
if %coloredfont%==Enabled (goto experimentalsettingcoloredfont)
echo  1 ^> %optionudc%- %udcd%&echo  2 ^> %optionsound%- %soundd%&echo  3 ^> %optionechoon%- %echoond%&goto experimentalsettingcoloredfontdisabled
:experimentalsettingcoloredfont
<nul set /p="%space% 1 > %optionudc%- "&if %udc%==Enabled (call :colorfont 0a "%enabled%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
<nul set /p="%space% 2 > %optionsound%- "&if %sound%==Default (call :colorfont 0a "%default%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
<nul set /p="%space% 3 > %optionechoon%- "&if %echoon%==Enabled (call :colorfont 0a "%enabled%"&%S%) else (call :colorfont 0C "%disabled%"&%S%)
:experimentalsettingcoloredfontdisabled
%S%&%L%&%S%&echo %back% - %exit%
choice /c %bkey%6%ekey%123%re% >NUL
if %errorlevel% equ 1 goto settings
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 if %udc%==Enabled (set udc=Disabled) else (set udc=Enabled&set updatestat=)
if %errorlevel% equ 5 goto sound
if %errorlevel% equ 6 if %echoon%==Enabled (@echo off&set echoon=Disabled) else (@echo on&set echoon=Enabled)
if %errorlevel% equ 7 goto reset
goto experimentalsettings
:reset
cls&echo ^> %reset%&%S%&echo %resetsetq%&%S%
if %coloredfont%==Enabled (call :colorfont 0C "%note%"&echo : %importantsettingsdeleted%) else (echo %note%: %importantsettingsdeleted%)
%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%%bkey%%ekey% >NUL
if %errorlevel% equ 1 set savesettings=Disabled&set adc=Enabled&set coloredfont=Disabled&set udc=Disabled&set sound=Default&set echoon=Disabled&del /f /q %settingspath%&goto settings
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
:savesettingsdisable
cls&echo ^> %optionsavesettings%&%S%&echo %disablesavesettingsq%&%S%
if %coloredfont%==Enabled (call :colorfont 0C "%note%"&echo : %importantsettingsdeleted%) else (echo %note%: %importantsettingsdeleted%)
%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%%bkey%%ekey% >NUL
if %errorlevel% equ 1 set savesettings=Disabled&del /f /q %settingspath%&goto settings
if %errorlevel% equ 2 goto settings
if %errorlevel% equ 3 goto end
:winversion
if "%winver%"=="10.0" (set "W10=^<---"&set W81=&set W8=&set W7=&set W1=2&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.3" (set W10=&set "W81=^<---"&set W8=&set W7=&set W1=1&set W2=3&set W3=4&set W4=)
if "%winver%"=="6.2" (set W10=&set W81=&set "W8=^<---"&set W7=&set W1=1&set W2=2&set W3=4&set W4=)
if "%winver%"=="6.1" (set W10=&set W81=&set W8=&set "W7=^<---"&set W1=1&set W2=2&set W3=3&set W4=)
cls&%R% (%win%%astat%)&echo ^> %windowsversionset% ^> %win%
%S%&echo %pressset%&%L%&%S%&%S%&echo  1 ^> Windows 10   %W10%&echo  2 ^> Windows 8.1  %W81%&echo  3 ^> Windows 8    %W8%&echo  4 ^> Windows 7    %W7%&%S%&%L%&%S%&echo %back% - %exit%
choice /c %W1%%W2%%W3%%bkey%%ekey%%W4% >NUL
if %errorlevel% equ 1 if %W1% equ 1 (set winver=10.0&set win=Windows 10) else (set winver=6.3&set win=Windows 8.1)
if %errorlevel% equ 2 if %W2% equ 2 (set winver=6.3&set win=Windows 8.1) else (set winver=6.2&set win=Windows 8)
if %errorlevel% equ 3 if %W3% equ 3 (set winver=6.2&set win=Windows 8) else (set winver=6.1&set win=Windows 7)
if %errorlevel% equ 4 goto settings
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 set winver=6.1&set win=Windows 7
goto winversion
:sound
set "npcurrent=%optionsound%"
if %adc%==Disabled (cls&echo ^> %npcurrent%&%S%&echo %checkingadministratorrights%&call :administratorcheck)
if "%adminswitch%"=="0" (goto sounderror)
for /F "tokens=3 delims=: " %%H in ('sc query "beep" ^| findstr "        STATE"') do (if not "%%H"=="RUNNING" (set sound=Disabled))
if %sound%==Default (goto sounddisable)
:soundenable
cls&echo ^> %npcurrent%&%S%&echo %esenablesound%
if %savesettings%==Enabled (sc config beep start=auto >NUL)
sc start beep >NUL
if %errorlevel% equ 0 (set sound=Default&goto experimentalsettings) else (goto sounderror)
:sounddisable
cls&echo ^> %npcurrent%&%S%&echo %esdisablesound%
sc stop beep >NUL
if %errorlevel% neq 0 (goto sounderror)
if %savesettings%==Enabled (sc config beep start=disabled >NUL)
set sound=Disabled&goto experimentalsettings
:sounderror
cls&echo ^> %npcurrent%&%S%&echo %nopermission%&%S%
if %coloredfont%==Enabled (call :colorfont 0C "%note%"&echo : %notesettingadmin%) else (echo %note%: %notesettingadmin%)
%L%&%S%&echo %pressany%&timeout 5 >NUL&goto settings
:main
%R% (%win%%astat%)
if "%updatestat%"=="2" (call :updatesuccess) else (if "%updatestat%"=="3" (call :updatefailed))
cls&echo About (a) - %settings%%update%
%S%&echo %pressselected%&%L%&%S%&%S%&echo  1 ^> IconRepair&echo  2 ^> NetworkRepair&echo  3 ^> AudioRepair&echo  4 ^> System&%S%&%L%&%S%&echo %exit%
if %udc%==Enabled (if "%updatestat%"=="" (set noswitch=true&call :checkupdate))
if %adc%==Enabled (if "%adminswitch%"=="" (call :administratorcheck))
choice /c 1234%ekey%A%skey%%up% >NUL
if %errorlevel% equ 1 goto iconrepair
if %errorlevel% equ 2 goto networkrepair
if %errorlevel% equ 3 goto audiorepair
if %errorlevel% equ 4 goto system
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 goto about
if %errorlevel% equ 7 call :settings
if %errorlevel% equ 8 call :update3
goto main
:iconrepair
set "npcurrent=IconRepair"
cls&echo ^> %npcurrent% - %settings%&%S%&echo %runiconrepair%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%1%bkey%%ekey%%skey% >NUL
if %errorlevel% equ 1 goto iconrepairstart
if %errorlevel% equ 2 goto iconrepairstart
if %errorlevel% equ 3 goto main
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 call :settings
goto iconrepair
:iconrepairstart
if %winver%==6.1 (goto iconrepairwin7)
:iconrepairwin10
cls&echo ^> %npcurrent%&%S%&echo %stoppingexplorer%
tasklist /fi "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
cls&echo ^> %npcurrent%&%S%&echo %irclearingiconcache%
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache*.*" >NUL
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache*.*" >NUL
if %errorlevel% neq 0 (set "repairstatus=%tryagainadmin%") else (set "repairstatus=%successfull%")
cls&echo ^> %npcurrent%&%S%&echo %startingexplorer%
start explorer.exe&goto Mfinish
:iconrepairwin7
cls&echo ^> %npcurrent%&%S%&echo %stoppingexplorer%
tasklist /fi "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL)
cls&echo ^> %npcurrent%&%S%&echo %irclearingiconcache%
del /f /q /a "%userprofile%\AppData\Local\iconcache.db" >NUL
if %errorlevel% neq 0 (set "repairstatus=%tryagainadmin%") else (set "repairstatus=%successfull%")
cls&echo ^> %npcurrent%&%S%&echo %startingexplorer%&start explorer.exe
call :finish&goto main
:networkrepair
set "npcurrent=NetworkRepair"
if %adc%==Enabled (if not "%adminswitch%"=="1" (call :nopermission))
if %locked% equ 1 (goto main)
cls&echo ^> %npcurrent% - %settings%&%S%&echo %runnetworkrepair%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%2%bkey%%ekey%%skey% >NUL
if %errorlevel% equ 1 goto networkrepair1
if %errorlevel% equ 2 goto networkrepair1
if %errorlevel% equ 3 goto main
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 call :settings
goto networkrepair
:networkrepair1
cls&echo ^> %npcurrent%&%S%&echo %nrreleasing%
ipconfig /release >NUL
ipconfig /release6 >NUL
cls&echo ^> %npcurrent%&%S%&echo %nremptycache%
ipconfig /flushdns >NUL
cls&echo ^> %npcurrent%&%S%&echo %nrupdateingdhcp%
ipconfig /registerdns >NUL
cls&echo ^> %npcurrent%&%S%&echo %nrrenewing%
ipconfig /renew >NUL
if %errorlevel% neq 0 (set "repairstatus=%tryagainadmin%") else (set "repairstatus=%successfull%")
ipconfig /renew6 >NUL
call :finish&goto main
:audiorepair
set "npcurrent=AudioRepair"
if %adc%==Enabled (if not "%adminswitch%"=="1" (call :nopermission))
if %locked% equ 1 (goto main)
cls&echo ^> %npcurrent% - %settings%&%S%&echo %runaudiorepair%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%3%bkey%%ekey%%skey% >NUL
if %errorlevel% equ 1 goto audiorepair1
if %errorlevel% equ 2 goto audiorepair1
if %errorlevel% equ 3 goto main
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 call :settings
goto audiorepair
:audiorepair1
cls&echo ^> %npcurrent%&%S%&echo %arstoppingaudioservice%
set process=audiosrv&call :getprocessid
if "%processid%"=="Es" (goto audiorepair2) else (if "%processid%"=="" (cls&echo ^> %npcurrent%&%S%&echo %erroroccurred%&echo %arerrorusearold%&%L%&%S%&echo %pressany%&timeout 5 >NUL&goto audiorepair))
taskkill /t /f /oid %processid% >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (set "repairstatus=%tryagainadmin%")
cls&echo ^> %npcurrent%&%S%&echo %arstoppingaudioendpointbuilder%
set process=AudioEndpointBuilder&call :getprocessid
if "%processid%"=="Es" (goto audiorepair2) else (if "%processid%"=="" (cls&echo ^> %npcurrent%&%S%&echo %erroroccurred%&echo %arerrorusearold%&%L%&%S%&echo %pressany%&timeout 5 >NUL&goto audiorepair))
taskkill /t /f /pid %processid% >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (set "repairstatus=%tryagainadmin%")
:audiorepair2
cls&echo ^> %npcurrent%&%S%&echo %arstartingaudioservice%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (if %errorlevel% equ 1056 (timeout 2 /nobreak >NUL&goto audiorepair2) else (set "repairstatus=%tryagainadmin%"))
goto Mfinish
:audiorepairold1
cls&echo ^> %npcurrent%&%S%&echo %arstoppingaudioservice%
sc query audiosrv | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto audiorepairold2)
sc stop audiosrv >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (set "repairstatus=%tryagainadmin%")
cls&echo ^> %npcurrent%&%S%&echo %arstoppingaudioendpointbuilder%
sc query AudioEndpointBuilder | FIND "STATE" | FIND "STOPPED"
if %errorlevel% equ 0 (goto audiorepairold2)
sc stop AudioEndpointBuilder >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (set "repairstatus=%tryagainadmin%")
:audiorepairold2
cls&echo ^> %npcurrent%&%S%&echo %arstartingaudioservice%
sc start audiosrv >NUL
if %errorlevel% equ 0 (set "repairstatus=%successfull%") else (if %errorlevel% equ 1056 (timeout 1 /nobreak >NUL&goto audiorepairold2) else (set "repairstatus=%tryagainadmin%"))
call :finish&goto main
:system
cls&echo ^> System - %settings%%update%
%S%&echo %pressselected%&%L%&%S%&%S%&echo  1 ^> %srestartexplorer%&echo  2 ^> %sstartwindowscmd%&echo  3 ^> %sshutdownmenu%&echo  4 ^> %sdeletewinupdate%&echo  5 ^> %sshowbios%&echo  6 ^> %sshowwifi%&%S%&%L%&%S%&echo %back% - %exit%
choice /c %bkey%%ekey%123456%skey%%up% >NUL
if %errorlevel% equ 1 goto main
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto Srestartexplorer
if %errorlevel% equ 4 goto Sstartcmd
if %errorlevel% equ 5 goto Sshutdown
if %errorlevel% equ 6 goto Sdeleteupdate
if %errorlevel% equ 7 goto Sshowbiosversion
if %errorlevel% equ 8 goto Sshowwifiinfo
if %errorlevel% equ 9 call :settings
if %errorlevel% equ 10 call :update3
goto system
:Srestartexplorer
set "npcurrent=%srestartexplorer%"
cls&echo ^> %npcurrent% - %settings%&%S%&echo %restartexplorerq%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%1%bkey%%ekey%%skey% >NUL
if %errorlevel% equ 1 goto Srestartexplorer1
if %errorlevel% equ 2 goto Srestartexplorer1
if %errorlevel% equ 3 goto system
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 call :settings
goto Srestartexplorer
:Srestartexplorer1
cls&echo ^> %npcurrent%&%S%&echo %stoppingexplorer%
tasklist /FI "IMAGENAME eq explorer.exe" >NUL
if %errorlevel% equ 0 (taskkill /f /im explorer.exe >NUL&timeout 1 /nobreak >NUL)
cls&echo ^> %npcurrent%&%S%&echo %startingexplorer%
start explorer.exe
if %errorlevel% neq 0 (set "statuspar1=%erroroccurred%"&call :status&goto system)
set "repairstatus=%finished%"&call :finish&goto system
:Sstartcmd
set "npcurrent=%sstartwindowscmd%"
start "IconRepair %V% (cmd)"
if %errorlevel% neq 0 (if %errorlevel% neq 6 (set "statuspar1=%erroroccurred%"&call :status&goto system))
goto system
:Sshutdown
cls&echo ^> %sshutdownmenu% - %settings%%update%&%S%&echo %pressselected%&%L%&%S%&%S%&echo  1 ^> %sinstandshutdown%&echo  2 ^> %scustomshutdown%&echo  3 ^> %sinstandrestart%&echo  4 ^> %scancelshutdown%&%S%&%L%&%S%&echo %back% - %exit%
choice /c %bkey%%ekey%1234%skey%%up% >NUL
if %errorlevel% equ 1 goto system
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto Simmediately
if %errorlevel% equ 4 goto Scustom
if %errorlevel% equ 5 goto Srestart
if %errorlevel% equ 6 goto Scancel
if %errorlevel% equ 7 call :settings
if %errorlevel% equ 8 call :update3
goto Sshutdown
:Simmediately
set "npcurrent=%sinstandshutdown%"
cls&echo ^> %npcurrent%&%S%&echo %instandshutdownq%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%1%bkey%%ekey% >NUL
if %errorlevel% equ 1 goto Simmediately1
if %errorlevel% equ 2 goto Simmediately1
if %errorlevel% equ 3 goto Sshutdown
if %errorlevel% equ 4 goto end
:Simmediately1
shutdown /s /t 1
if %errorlevel% equ 1190 set "Serrorpar1=%shutdownalreadyplanned%"&goto Sshutdownerror
if %errorlevel% neq 0 set "Serrorpar1=%erroroccurred%"&goto Sshutdownerror
set "sd=%shutdowntypeimmediately%"&goto Sshutdownfinish
:Scustom
set "npcurrent=%scustomshutdown%"
cls&echo ^> %npcurrent%&%S%&echo %shutdowncustomq%&%L%&%S%&echo %back%&%S%
set /p sdz="> "
if /i "%sdz%"=="%bkey%" goto Sshutdown
echo %sdz%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto Scustom)
cls&echo ^> %npcurrent%&%S%&echo %shutdowncustomqconfirm% %sdz%s?&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%%bkey%%ekey% >NUL
if %errorlevel% equ 1 goto Scustom1
if %errorlevel% equ 2 goto Scustom
if %errorlevel% equ 3 goto end
:Scustom1
shutdown /s /t %sdz%
if %errorlevel% equ 1190 set "Serrorpar1=%shutdownalreadyplanned%"&goto Sshutdownerror
if %errorlevel% neq 0 set "Serrorpar1=%useonlynumbers%"&goto Sshutdownerror
set "sd=%sdz%s"&goto Sshutdownfinish
:Srestart
set "npcurrent=%sinstandrestart%"
cls&echo ^> %npcurrent%&%S%&echo %instandrestartq%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%3%bkey%%ekey% >NUL
if %errorlevel% equ 1 goto Srestart1
if %errorlevel% equ 2 goto Srestart1
if %errorlevel% equ 3 goto Sshutdown
if %errorlevel% equ 4 goto end
:Srestart1
shutdown /r
if %errorlevel% equ 1190 set "Serrorpar1=%shutdownalreadyplanned%"&goto Sshutdownerror
if %errorlevel% neq 0 set "Serrorpar1=%erroroccurred%"&goto Sshutdownerror
set "sd=%shutdowntypeimmediately%"&goto Sshutdownfinish
:Scancel
set "npcurrent=%scancelshutdown%"
shutdown /a >NUL
if %errorlevel% equ 1116 set "Serrorpar1=%noshutdownaborted%"&goto Sshutdownerror
if %errorlevel% equ 0 set "Serrorpar1=%shutdowncanceled%"&goto Sshutdownerror
set "Serrorpar1=%erroroccurred%"&goto Sshutdownerror
:Sshutdownfinish
cls&echo ^> %npcurrent%&%S%&echo %finished%&%L%&%S%&%S%&echo %shutdowntypeset%: %sd%&echo %cancelshutdown%&%S%&%L%&%S%&echo %back% - %exit%
choice /c %ekey%123%bkey%%cancelshutdownkey% >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 set sd=&goto system
if %errorlevel% equ 6 set sd=&goto Scancel
:Sshutdownerror
cls&echo ^> %npcurrent%&%S%&echo %Serrorpar1%&%L%&%S%&echo %pressany%&timeout 5 >NUL&set Serrorpar1=&goto Sshutdown
:Sdeleteupdate
set "npcurrent=%sdeletewinupdate%"
if %adc%==Enabled (if not "%adminswitch%"=="1" (call :nopermission))
if %locked% equ 1 (goto system)
cls&echo ^> %npcurrent% - %settings%&%S%&echo %deletewinupdateq%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%4%bkey%%ekey%%skey% >NUL
if %errorlevel% equ 1 goto Sdeleteupdate1
if %errorlevel% equ 2 goto Sdeleteupdate1
if %errorlevel% equ 3 goto system
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 call :settings
goto Sdeleteupdate
:Sdeleteupdate1
if not exist "%systemroot%\SoftwareDistribution\Download\" (set "repairstatus=%nowinupdatefound%"&call :status&goto system)
cls&echo ^> %npcurrent%&%S%&echo %stopingwuauserv%
sc stop wuauserv >NUL
if %errorlevel% equ 0 (set startwuauserv=1) else (set startwuauserv=0)
cls&echo ^> %npcurrent%&%S%&echo %deletingupdate%
rd /s /q "%systemroot%\SoftwareDistribution\Download" >NUL
if %errorlevel% equ 0 (if %startwuauserv% equ 1 (cls&echo ^> %npcurrent%&%S%&echo %startingwuauserv%&sc start wuauserv >NUL)) else (if %startwuauserv% equ 1 (cls&echo ^> %npcurrent%&%S%&echo %startingwuauserv%&sc start wuauserv >NUL&goto Serror) else (goto Serror))
set "repairstatus=%finished%"&call :finish&goto system
:Sshowbiosversion
cls&echo ^> %sshowbios% - %settings%&%S%&wmic bios get smbiosbiosversion&%L%&%S%&echo %back% - %exit%
choice /c %ekey%5%bkey%%skey% >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto system
if %errorlevel% equ 4 call :settings
goto Sshowbiosversion
:Sshowwifiinfo
cls&echo ^> %sshowwifi%&%S%&echo %schoosewifi%&%L%&%S%&set numbers=0&set choices=
setLocal EnableDelayedExpansion
for /f "skip=2 tokens=5*" %%A in ('netsh wlan show profiles') do (set /a numbers+=1&set int!numbers!=%%B&set choices=!choices!!numbers!&echo  !numbers! ^> %%B)
%L%&%S%&echo %back%&%S%
set /p ifn="> "
if /i "%ifn%"=="%bkey%" setLocal DisableDelayedExpansion&goto system
echo %ifn%| findstr /r "^[0-9]*$" >NUL
if %errorlevel% neq 0 (goto Sshowwifiinfo)
set profile=!int%ifn%!
setLocal DisableDelayedExpansion
cls&echo ^> %sshowwifi%&%S%
netsh wlan show profile "%profile%" key=clear
%L%&%S%&echo %back% - %exit%
choice /c %ekey%6%bkey% >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto Sshowwifiinfo
:status
if "%noswitch%"=="true" (set noswitch=false&echo %statuspar1%&exit /b)
cls&echo ^> %npcurrent%&%S%&echo %statuspar1%&%L%&%S%&echo %pressany%&timeout 5 >NUL&set statuspar1=&exit /b
:finish
cls&echo ^> %npcurrent%&%S%&echo %repairstatus%&%S%&echo %tryrestartpc%&%L%&%S%&echo %back% - %exit%
choice /c %ekey%S12345%bkey% >NUL
if %errorlevel% equ 1 goto end
if %errorlevel% equ 2 goto end
if %errorlevel% equ 3 goto end
if %errorlevel% equ 4 goto end
if %errorlevel% equ 5 goto end
if %errorlevel% equ 6 exit /b
:nopermission
cls&echo ^> %npcurrent%&%S%&echo %nopermission%&echo %nopermissioncontinueanyway%&%L%&%S%&echo %yes% - %back% - %exit%
choice /c %ykey%234%bkey%%ekey% >NUL
if %errorlevel% equ 1 set locked=0&exit /b
if %errorlevel% equ 2 set locked=0&exit /b
if %errorlevel% equ 3 set locked=0&exit /b
if %errorlevel% equ 4 set locked=0&exit /b
if %errorlevel% equ 5 set locked=1&exit /b
if %errorlevel% equ 6 goto end
:end
cls&%S%&echo %ended%&timeout 2 >NUL&exit
:writesettings
if %savesettings%==Disabled (exit /b)
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
if not exist %settingspath% (echo >%settingspath%)
if exist %settingspath% (echo set savesettings=%savesettings%>%settingspath%&echo set language=%language%>>%settingspath%&echo set winver=%winver%>>%settingspath%&echo set adc=%adc%>>%settingspath%&echo set udc=%udc%>>%settingspath%&echo set coloredfont=%coloredfont%>>%settingspath%&echo set sound=%sound%>>%settingspath%) else (goto colorfonterror)
exit /b
:getprocessid
for /f "tokens=2" %%m in ('tasklist /svc /nh /fi "services eq %process%"') do (set processid=%%m)
exit /b
:administratorcheck
net session >NUL 2>&1
if %errorlevel% equ 0 (set adminswitch=1) else (set adminswitch=0)
:administratorset
if not "%adminswitch%"=="1" (set "astat=/%noadmin%")
%R% (%win%%astat%)
exit /b
:colorfont
if not exist "%userprofile%\IconRepair\" (mkdir "%userprofile%\IconRepair\")
cd /d "%userprofile%\IconRepair\"
if %errorlevel% neq 0 (goto colorfonterror)
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /r "^$" "%~2" nul
if %errorlevel% neq 0 (goto colorfonterror)
del "%~2"
exit /b
:colorfonterror
if "%savesettings%"=="Enabled" (set savesettings=Disabled)
if "%coloredfont%"=="Enabled" (set coloredfont=Disabled)
cls&%S%&echo %nopermission%&echo %settingsdisabled%&%L%&%S%&echo %pressany%&timeout 5 >NUL&exit /b