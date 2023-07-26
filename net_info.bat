@echo off
title NETWORK RESET SCRIPT
:prompt
color 1f
cls
echo NETWORK RESET SCRIPT
echo.
echo Type r to Reset Network
echo Type p to do a ping test
echo Type c to go to Command Prompt
echo Type q to exit
set /p answer=
if ‘%answer%’ == ‘r’ goto test
if ‘%answer%’ == ‘R’ goto test
if ‘%answer%’ == ‘C’ goto cmd
if ‘%answer%’ == ‘c’ goto cmd
if ‘%answer%’ == ‘q’ goto quit
if ‘%answer%’ == ‘Q’ goto quit
if ‘%answer%’ == ‘P’ goto ping
if ‘%answer%’ == ‘p’ goto ping
pause >nul

:test
cls
echo _____________________
echo - RELEASING IP.... -
echo _____________________
ipconfig /release >nul
echo.
echo Done!
echo.
echo _____________________
echo - RESETTING IP LOG... -
echo _____________________
@netsh int ip reset C:WindowsTEMPIPRESETLOG.txt >nul
echo.
echo Done!
echo.
echo _____________________
echo - FLUSHING ARP TABLES... -
echo _____________________
@arp -d >nul
echo.
echo Done!
echo.
echo _____________________
echo - FLUSHING DNS... -
echo _____________________
@ipconfig /flushdns >nul
echo.
echo Done!
echo.
echo _____________________
echo - RENEWING IP... -
echo _____________________
@ipconfig /renew >nul
echo.
echo Done!
echo.
cls
echo _____________________
echo Heres Your Status: -
echo _____________________
ipconfig /all
echo.
echo Press Any Key to Go To Menu
pause >nul
goto prompt

:ping
cls
echo _____________________
echo Starting Ping Test... -
echo _____________________
echo.
ping google.com
echo.
echo Press Any Key to goto MENU
pause >nul
goto prompt

:quit
cls
echo Exiting...
pause
exit

:cmd
@color 7
cls
cmd
@echo on
