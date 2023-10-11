$VscPath = 'C:\mppwsh'
$RV      = "2.8.5.208"
Install-PackageProvider -Name 'nuget' -RequiredVersion $RV -Force | Out-Null
Save-Script -Name Install-VSCode -Path $VscPath
Set-Location -Path $VscPath
Get-Help -Name C:\mppwsh\Install-VSCode.ps1
$Extensions =  'Streetsidesoftware.code-spell-checker',
               'yzhang.markdown-all-in-one',
               'hediet.vscode-drawio'
$InstallHT = @{
  BuildEdition         = 'Stable-System'
  AdditionalExtensions = $Extensions
  LaunchWhenDone       = $true
}
.\Install-VSCode.ps1 @InstallHT | Out-Null