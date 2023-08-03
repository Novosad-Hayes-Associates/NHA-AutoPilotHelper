Set-ExecutionPolicy Bypass
Install-Script Get-WindowsAutoPilotInfo
Get-WindowsAutoPilotInfo.ps1 -online

    <#Category#>'PSProvideDefaultParameterValue', <#CheckId>$null, Scope='Function',
    Justification = 'Reason for suppressing'
)]

<# 

$varLocalRemDrives = get-volume | where drivetype -eq removable | foreach driveletter
if ($varLocalRemDrives.Count -eq '0') {
    Write-Host "Put a drive in and we can do some work."
} elseif ($varLocalRemDrives.Count -eq '1') {
    $varDrive = $varLocalRemDrives
} else {
    Write-Output "You have too many drives, which one do you want?"
    Write-Output $varLocalRemDrives
    $varDrive = Read-Host "What Drive are we looking for?"
}
$varDrive += ':'

$varCurDate = get-date -Format yyyymm

Install-Script -Name Get-WindowsAutoPilotInfo

Get-WindowsAutoPilotInfo $varDrive\$varCurDate\hash.csv

#>