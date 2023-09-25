# Make sure that we are in bypass, a lot of this will not work unless we are in bypass

Set-ExecutionPolicy Bypass

# This Script REQUIRES internet. If no internet, not script. Lets trap it.

While (!(Test-Connection -computer google.com -count 1 -quiet)) {
    Write-Host -NoNewline "Connection down! Either connect to Ethernet, or go back to OOBE and connect to WiFi, setup will not continue without internet!`n`r" -ForegroundColor White -BackgroundColor Red 
    Start-Sleep -Seconds 1
}

### OK So any attempt to roll to Windows 11 from here drops us into defaultuser0 - removing the Windows 11 update path for now.

# This will grab the AutoPilot Modules so that we can register the unit to intune

Install-Script Get-WindowsAutoPilotInfo

# Using -online to bypass generating any hashes, we are just going to register this.

Get-WindowsAutoPilotInfo.ps1 -online
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green
Write-Host "***                                                             ***" -ForegroundColor White -BackgroundColor Green
Write-Host "*** This system should be on Intune now. Please check to verify ***" -ForegroundColor White -BackgroundColor Green
Write-Host "***                                                             ***" -ForegroundColor White -BackgroundColor Green
Write-Host "***      Script will continue automatically in two minutes.     ***" -ForegroundColor White -BackgroundColor Green
Write-Host "***                                                             ***" -ForegroundColor White -BackgroundColor Green
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green
Write-Host "*******************************************************************" -ForegroundColor White -BackgroundColor Green

# Sleep for a bit so that we can see the above message

Start-Sleep -Seconds 120

# We are already on Windows 11, sooo
# Install Updates and We are Done!
# In fact, we will only install the PSWindowsUpdate if the dumb thing is on Windows 11 - I think the Upgrader will update to latest. If not, we will figure it out.

Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "***                                        ***" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "***      This system is on Windows 11.     ***" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "***  Let's update it and be done with it!  ***" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "*** We are installing PSWindowsUpdate now. ***" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "***                                        ***" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue
Write-Host "**********************************************" -ForegroundColor DarkGray -BackgroundColor Blue

Install-Module -Name PSWindowsUpdate -Force

Import-Module PSWindowsUpdate

# Grab the list of updates,

Get-WUList

### We actually don't have to get fancy to hide updates.

Hide-WindowsUpdate -Title "Preview"

Install-WindowsUpdate -AcceptAll