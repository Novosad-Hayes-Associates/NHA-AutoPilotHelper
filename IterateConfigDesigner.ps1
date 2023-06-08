$curTime = get-date -Format "yyyyMMddHHss"
$sentinal = 0
if ( $env:COMPUTERNAME -eq 'RPRATT-SURF') {
    $varGitRoot = 'C:\Git'
    $varConfigDesignSrc = "C:\Users\rpratt\OneDrive - Novosad Hayes Associates\Documents\Windows Imaging and Configuration Designer (WICD)"
    $varConfigDesginDst = "C:\Users\rpratt\OneDrive - Novosad Hayes Associates\Documents\WICD-Backup\$curTime"
    $varThreads = '1'
    Write-Host "Welcome TinCanCoding"
    $sentinal = '1'
} else {
    Write-Error "Don't recognize this system mate! Sort Your SHIT DUDE!"
}
if ($sentinal -eq '1') {
    Robocopy.exe $varConfigDesignSrc $varConfigDesginDst /MIR /MT:$varTreads
} else {
    Write-Output "Yeah, sorry, can't process."
}