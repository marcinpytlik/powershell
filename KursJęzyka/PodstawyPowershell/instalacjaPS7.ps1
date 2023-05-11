# Run using an elevated Windows PowerShell 5.1 host

# 1. Enable scripts to be run
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# 2. Install latest versions of Nuget and PowerShellGet
Install-PackageProvider Nuget -MinimumVersion 2.8.5.201 -Force |Out-Null
Install-Module -Name PowerShellGet -Force -AllowClobber 

# 3. Create local folder C:\installps7
$LFHT = @{
  ItemType    = 'Directory'
  ErrorAction = 'SilentlyContinue' # should it already exist
}
New-Item -Path C:\installps7 @LFHT | Out-Null

# 4. Download PowerShell 7 installation script
Set-Location C:\installps7
$URI = "https://aka.ms/install-powershell.ps1"
Invoke-RestMethod -Uri $URI |  Out-File -FilePath C:\installps7\Install-PowerShell.ps1

# 5. Install PowerShell 7
$EXTHT = @{
  UseMSI                 = $true
  Quiet                  = $true 
  AddExplorerContextMenu = $true
  EnablePSRemoting       = $true
}
C:\installps7\Install-PowerShell.ps1 @EXTHT | Out-Null

# 7. Examine the installation folder
Get-Childitem -Path $env:ProgramFiles\PowerShell\7 -Recurse |Measure-Object -Property Length -Sum

# 8. View Module folders
#  View module folders for autoload
$I = 0
$env:PSModulePath -split ';' |
  Foreach-Object {
    "[{0:N0}]   {1}" -f $I++, $_}


# 10. Run PowerShell 7 console and then...
$PSVersionTable

# 11. View Modules folders
$ModFolders = $Env:PSModulePath -split ';'
$I = 0
$ModFolders | 
  ForEach-Object {"[{0:N0}]   {1}" -f $I++, $_}

# 12. View Profile Locations
$PROFILE | Format-List -Property *Host* -Force
