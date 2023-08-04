# Make sure that we are in bypass, a lot of this will not work unless we are in bypass

Set-ExecutionPolicy Bypass

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

# Ok, 
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

# Grab the list of updates,

Get-WUList

### We actually don't have to get fancy to hide updates.

Hide-WindowsUpdate -Title "Preview"

# Install Updates and We are Done!

Install-WindowsUpdate -AcceptAll -AutoReboot