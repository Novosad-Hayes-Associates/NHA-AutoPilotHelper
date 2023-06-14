@ECHO OFF
echo Enable WimRM
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command Enable-PSRemoting -SkipNetworkProfileCheck -Force
echo Getting Hash
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command %~dp0Get-WindowsAutoPilotInfo.ps1 -ComputerName $env:COMPUTERNAME -OutputFile %~dp0compHash.csv -append
echo All done.
pause