@echo off
rem /****************************
rem @brief NSSM wird verwendet um die Remoteview als Service in Windows zu registrieren
rem Als Application ist der Pfad zu nodejs anzugeben z.b. C:\Program Files\nodejs\node.exe
rem StartUp Directory ist das Verzeichnis indem die App liegt.
rem Als Arugmente wird das Script benötigt welches die Logic enthält ./bin/www
rem @Autor Ivo Kunadt
rem *****************************/

pause
if "%NODEDIR%" equ "" (
	echo "Der Pfad zu nodejs ist nicht gesetzt. Bitte überprüfen sie die Umgebungsvariable NODEDIR
	pause
	exit
)

if "%REMOTEVIEWDIR%" equ "" (
	echo "Der Pfad zu RemoteView ist nicht gesetzt. Bitte überprüfen sie die Umgebungsvariable REMOTEVIEWDIR
	pause
	exit
)

pause
cd "%REMOTEVIEWDIR%"
pause
cd service
nssm.exe install RemoteView "%NODEDIR%\node.exe" %REMOTEVIEWDIR%\bin\www
pause
nssm set RemoteView AppDirectory %REMOTEVIEWDIR%
nssm set RemoteView AppStdout %REMOTEVIEWDIR%\service\output.log
nssm set RemoteView AppStderr %REMOTEVIEWDIR%\service\output.log
pause