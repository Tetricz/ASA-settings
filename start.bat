rem ___________________
rem BEGIN CONFIGURATION
rem Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯
set SteamCMD_Dir=C:\ArkSAServer
rem ^ Location to dirctory containing steamcmd.exe ^
set Server_Dir=C:\ArkSAServer\server
rem ^ Location to directory that the Ark Server will be installed in ^
set Executable_Dir=C:\ArkSAServer\server\ShooterGame\Binaries\Win64
rem ^ Location to directory containing the following executable ^
set Server_Executable=ArkAscendedServer.exe
rem ________________
rem BEGIN BATCH CODE
rem Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯Â¯
cls
@echo off
title Ark Server Watchdog                                                                                                                                                                  
echo DO NOT CLOSE THIS WINDOW!
echo.
:start
tasklist /nh /fi "Imagename eq %Server_Executable%" | find "ArkServer"
if ERRORLEVEL=1 goto update
if ERRORLEVEL=0 goto close
:update
echo Checking For Update
start "" /b /w /high "%SteamCMD_Dir%\steamcmd.exe" +login anonymous +force_install_dir "%Server_Dir%" +app_update 2430930 validate +quit
echo.
echo If No Errors Exist, The Server Has Been Started!
echo.
echo Waiting For Crash...
cd "%Executable_Dir%"
start "" /w /high "%Server_Executable%" start ArkAscendedServer TheIsland_WP?Listen -NoBattlEye exit &:: Using "-log" Will Prevent Automatic Crash Detection
echo Crash Detected!
echo.
echo CTRL+C To Freeze Before Restarting
timeout /t 15
goto start
:close
echo.
echo !ERROR! SERVER ALREADY RUNNING! SHUTDOWN WILL COMMENCE
taskkill /im "%Server_Executable%" /f /t
timeout /t 3
goto start
