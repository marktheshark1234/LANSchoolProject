@echo off
title Disabling LanSchool Web Helper...
echo.
echo Stopping LanSchool processes...
taskkill /F /IM student.exe /T
taskkill /F /IM LskHelper.exe /T
taskkill /F /IM Lanschool.exe /T
taskkill /F /IM LanschoolStudent.exe /T

echo Deleting LanSchool Chrome Extension...
set "chromeExtPath=%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions"
for /d %%X in ("%chromeExtPath%\*") do (
    echo Checking %%~nxX
    echo %%~nxX | find /i "lanschool" >nul && (
        echo Removing extension: %%X
        rd /s /q "%%X"
    )
)

echo Blocking LanSchool Web Helper from running...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LskHelper.exe" /v Debugger /t REG_SZ /d "C:\Windows\System32\taskkill.exe" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\student.exe" /v Debugger /t REG_SZ /d "C:\Windows\System32\taskkill.exe" /f

echo LanSchool Web Helper has been disabled.
pause
exit
