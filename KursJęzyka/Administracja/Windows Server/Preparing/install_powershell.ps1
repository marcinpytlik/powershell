Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
Update-Help -Force | Out-Null
$LFHT = @{
  ItemType    = 'Directory'
  ErrorAction = 'SilentlyContinue' # should it already exist
}
New-Item -Path C:\mppwsh @LFHT | Out-Null
Set-Location -Path C:\mppwsh
$URI = 'https://aka.ms/install-powershell.ps1'
Invoke-RestMethod -Uri $URI |  Out-File -FilePath C:\mppwsh\Install-PowerShell.ps1
Get-Help -Name C:\mppwsh\Install-PowerShell.ps1
$EXTHT = @{
  UseMSI                 = $true
  Quiet                  = $true
  AddExplorerContextMenu = $true
  EnablePSRemoting       = $true
}
C:\mppwsh\Install-PowerShell.ps1 @EXTHT | Out-Null

#C:\mppwsh\Install-PowerShell.ps1 -Preview -Destination C:\PSPreview | Out-Null
#C:\mppwsh\Install-PowerShell.ps1 -Daily   -Destination C:\PSDailyBuild |Out-Null
$ProfileFiles = $PROFILE |  Get-Member -MemberType NoteProperty
$ProfileFiles | Format-Table -Property Name, Definition
Foreach ($ProfileFile in $ProfileFiles){
  "Testing $($ProfileFile.Name)"
  $ProfilePath = $ProfileFile.Definition.split('=')[1]
  if (Test-Path -Path $ProfilePath){
    "$($ProfileFile.Name) DOES EXIST"
    "At $ProfilePath"
  }
  Else {
    "$($ProfileFile.Name) DOES NOT EXIST"
  }
  ""
}
$CUCHProfile = $PROFILE.CurrentUserCurrentHost
"Current User/Current Host profile path: [$CUCHPROFILE]"
##################
$PSVersionTable
Get-ChildItem -Path $env:ProgramFiles\PowerShell\7 -Recurse | Measure-Object -Property Length -Sum
Get-ChildItem -Path $env:ProgramFiles\PowerShell\7\powershell*.json | Get-Content
Get-ExecutionPolicy
$I = 0
$ModPath = $env:PSModulePath -split ';'
$ModPath |
  Foreach-Object {
    "[{0:N0}]   {1}" -f $I++, $_
  }

$TotalCommands = 0
Foreach ($Path in $ModPath){
  Try { 
    $Modules = Get-ChildItem -Path $Path -Directory -ErrorAction Stop
    "Checking Module Path:  [$Path]"
  }
  catch [System.Management.Automation.ItemNotFoundException] {
    "Module path [$path] DOES NOT EXIST ON $(hostname)"
  }
  $TotalCommands = 0
  foreach ($Module in $Modules) {
    $Cmds = Get-Command -Module ($Module.name)
    $TotalCommands += $Cmds.Count
  }
}

$Mods = (Get-Module * -ListAvailable | Measure-Object).count
"{0} modules providing {1} commands" -f $Mods,$TotalCommands