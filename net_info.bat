@echo off
setlocal enabledelayedexpansion

REM Function to get public IP
set "public_ip="
for /f "tokens=2 delims=[]" %%A in ('ping -4 -n 1 8.8.8.8 ^| findstr "["') do set "public_ip=%%A"
if "%public_ip%"=="" set "public_ip=N/A"

REM Function to get DHCP info
set "dhcp_enabled=N/A"
for /f "tokens=2 delims=:" %%A in ('ipconfig /all ^| findstr /i "DHCP Enabled"') do set "dhcp_enabled=%%A"

REM Function to get DNS servers
set "dns_servers=N/A"
for /f "tokens=2 delims=:" %%A in ('ipconfig /all ^| findstr /i "DNS Servers"') do set "dns_servers=%%A"

REM Function to get VPN info
set "vpn_enabled=No"
ipconfig | findstr /i "TAP" >nul && set "vpn_enabled=Yes"

REM Function to get MAC address
set "mac_address="
for /f "tokens=1 delims=-" %%A in ('getmac /v ^| findstr /i "Physical"') do (
    set "mac=%%A"
    set "mac_address=!mac: =!"
)

REM Display network information report
echo Network Information Report:
echo.
echo Host Name: %computername%
echo IP Address: %computerip%
echo Local IP: 127.0.0.1
echo Public IP: %public_ip%
echo DHCP Enabled: %dhcp_enabled%
echo DNS Servers: %dns_servers%
echo VPN Enabled: %vpn_enabled%
echo MAC Address: %mac_address%

pause
