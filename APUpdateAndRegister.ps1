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

Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White
Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White
Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White
Write-Host "***                                        ***" -ForegroundColor Black -BackgroundColor White
Write-Host "*** We are installing PSWindowsUpdate now. ***" -ForegroundColor Black -BackgroundColor White
Write-Host "***                                        ***" -ForegroundColor Black -BackgroundColor White
Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White
Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White
Write-Host "**********************************************" -ForegroundColor Black -BackgroundColor White

# Ok, 
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate

# Grab the list of updates,

Get-WUList

### We actually don't have to get fancy to hide updates.

Hide-WindowsUpdate -Title "Preview"

# Actually uh, let's see if this is on Windows 10 or Windows 11

# Detect Version, should spit out a True or False
$osSentinal = (Get-ComputerInfo | Select-Object -expand OsName) -match 10

# If True, then let's upgrade to 11. If not, lets just update \o/

if ($osSentinal -eq 'True') {
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "***                                                        ***" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "*** This system is on Windows 10, we are rolling it to 11. ***" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "***                                                        ***" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow
    Write-Host "**************************************************************" -ForegroundColor Black -BackgroundColor Yellow

    $dir = 'C:\temp\packages'
    mkdir $dir
    $webClient = New-Object System.Net.WebClient
    $url = 'https://go.microsoft.com/fwlink/?linkid=2171764'
    $file = "$($dir)\Win11Upgrade.exe"
    $webClient.DownloadFile($url,$file)
    Start-Process -FilePath $file -ArgumentList '/quietinstall /skipeula /auto upgrade /copylogs $dir'
} else {
    # We are already on Windows 11, sooo
    # Install Updates and We are Done!
    Install-WindowsUpdate -AcceptAll
}