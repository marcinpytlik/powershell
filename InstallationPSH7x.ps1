#cretae folder for dowbload installation files
$LFHT=@{
    ItemType='Directory'
    ErrorAction='SilentContinue' #if exists
}
$EXTHT=@{
    UseMSI=$true
    Quiet=$true
    AddExplorerContextMenu=$true
    EnablePSRemote=$true
}
$Uri="https://aka.ms/install-powershell.ps1"
$i
New-Item -Path c:\installPSH7 @LFHT | Out-Null
# Download installation of Powershell 7.X
Set-Location c:\installPSH7
Invoke-RestMethod -Uri $Uri | Out-File -FilePath c:\installPSH7\install-powershell.ps1
# install powershell 7.X
c:\installPSH7\install-powershell.ps1 @EXTHT
# check installation
Get-ChildItem -Path $env:ProgramFiles\Powershell\7 -Recurse | Measure-Object -Property Length -Sum
# check modules
$env:PSModulePath -split ';' | ForEach-Object {"[{0:N0}] {1}" -f $i,$_}
# check version
$PSVersionTable
# check profiles path
$PROFILE | Format-List -Property *Host* -Force 
# download VSC
Save-Script -Name Install-VSCode -Path c:\installPSH7




