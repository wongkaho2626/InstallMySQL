xcopy "%~d0\MySQL Server 5.5.zip" "C:\Program Files\MySQL\"
@echo off
setlocal
cd /d %~dp0
Call :UnZipFile "C:\Program Files\MySQL\" "C:\Program Files\MySQL\MySQL Server 5.5.zip"
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqld" --install
net start mysql
"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqladmin" -u root password root
"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysql" -u root -proot < "./local.sql"
echo port=3306> "%USERPROFILE%\Desktop\leeray.config.properties"
echo ip=localhost>> "%USERPROFILE%\Desktop\leeray.config.properties"