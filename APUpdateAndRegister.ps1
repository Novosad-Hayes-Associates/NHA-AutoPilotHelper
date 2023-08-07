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

# Actually uh, let's see if this is on Windows 10 or Windows 11

# Detect Version, should spit out a True or False
$osSentinal = (Get-ComputerInfo | Select-Object -expand OsName) -match 10

# If True, then let's upgrade to 11. If not, lets just update \o/

if ($osSentinal -eq 'True') {

    # If they are on Win 10 - we don't need to apply updates, lets roll it to 11.

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

    Write-Host "****************************************************************************************************" -ForegroundColor Black -BackgroundColor Red
    Write-Host "* /!\                                                                                          /!\ *" -ForegroundColor Black -BackgroundColor Red
    Write-Host "* /!\ WARNING /!\ DO NOT TURN THIS MACHINE OFF UNTIL WINDOWS UPGRADE ASSISTANT DIRECTS YOU TO! /!\ *" -ForegroundColor Black -BackgroundColor Red
    WRITE-HOST "* /!\               FAIURE TO DO SO CAN RESULT IN A MACHINE THAT WILL NOT BOOT!                /!\ *" -ForegroundColor Black -BackgroundColor Red
    Write-Host "* /!\                                                                                          /!\ *" -ForegroundColor Black -BackgroundColor Red
    Write-Host "****************************************************************************************************" -ForegroundColor Black -BackgroundColor Red

} else {
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
}