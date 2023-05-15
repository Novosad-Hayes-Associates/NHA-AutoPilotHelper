$version=(Get-WmiObject -class Win32_OperatingSystem).Caption
$LocationTest = Test-Connection -Computer $env:COMPUTERNAME -Count 1 | Select -ExpandProperty IPV4Address
$LocationIP = ([ipaddress]$LocationTest).GetAddressBytes()[1]

If( ( $version -eq "Microsoft Windows 11 Enterprise" ) -or ( $version -eq "Microsoft Windows 11 Pro" ) -or ( $version -eq "Microsoft Windows 10 Enterprise" ) -or ( $version -eq "Microsoft Windows 10 Pro" ) ) {
	if ( $LocationIP -eq "211" -Or $LocationIP -eq "219" ) {
        Write-Host "Installing OMPI-StevensPoint Command Agent"
        Start-Process msiexec.exe -Wait -ArgumentList '/I ITSPlatform.msi TOKEN=d3cad86a-a4cb-44a6-a481-ce0e22493cc6 /q'
    } elseif ( $LocationIP -eq "213" ) {
        Write-Host "Installing OMPI-Woodstock Command Agent"
        Start-Process msiexec.exe -Wait -ArgumentList '/I ITSPlatform.msi TOKEN=fe91dad2-1f4d-4492-af44-7fb416ae2425 /q'
    } elseif ( $LocationIP -eq "221" ) {
        Write-Host "Installing OMPI-LakeBarrington Command Agent"
        Start-Process msiexec.exe -Wait -ArgumentList '/I ITSPlatform.msi TOKEN=4e017a9b-4240-435f-b1c5-80666d7d1eb9 /q'
    } else {
        Write-Host "Installing OMPI-Colo Command Agent"
        Start-Process msiexec.exe -Wait -ArgumentList '/I ITSPlatform.msi TOKEN=66a27781-8bb2-4764-b365-7b67c28d5fc3 /q'
    } 
} Else {
	Write-Warning "Not a Server what are you doing"
    exit
}