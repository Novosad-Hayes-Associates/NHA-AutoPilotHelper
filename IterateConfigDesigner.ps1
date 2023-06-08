$curTime = get-date -Format "yyyyMMddHHss"
if ( $env:COMPUTERNAME -eq 'LOONA' ) {
    $varGitRoot = 'D:\Git'
    $varRootPath = 'D:\VOD\OneDrive - Novosad Hayes Associates\ISO-Hive'
    $varBuild = 'c:\build'
    $varWorkhold = 'c:\WorkHold'
    $varThreads = '128'
    Write-Host "Welcome TinCanCoding"
}elseif ( $env:COMPUTERNAME -eq 'JBRADEN-WK') {
    $varGitRoot = 'F:\ISO-Scripts'
    $varRootPath = 'F:\cburditt-onedrive\OneDrive - Novosad Hayes Associates\ISO-Hive'
    $varBuild = 'F:\build'
    $varWorkhold = 'F:\WorkHold'
    $varThreads = '1'
    Write-Host "Welcome user."
}elseif ( $env:COMPUTERNAME -eq 'RPRATT-SURF') {
    $varGitRoot = 'C:\Git'
    $varRootPath = 'C:\users\rpratt\OneDrive - Novosad Hayes Associates\ISO-Hive'
    $varBuild = 'c:\build'
    $varWorkhold = 'c:\WorkHold'
    $varThreads = '128'
    Write-Host "Welcome TinCanCoding"
}else {
    Write-Error "Don't recognize this system mate! Sort Your SHIT DUDE!"
}