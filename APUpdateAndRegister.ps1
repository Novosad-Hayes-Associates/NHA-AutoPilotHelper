Set-ExecutionPolicy Bypass
Install-Script Get-WindowsAutoPilotInfo
Get-WindowsAutoPilotInfo.ps1 -online
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

# TO-DO: This should not also pull in previews.

$varCUHold = Get-WUList

### We actually don't have to get fancy to hide updates.

Hide-WindowsUpdate -Title "Preview"

Install-WindowsUpdate -AcceptAll -AutoReboot