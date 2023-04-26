Get-WindowsFeature | Where-Object {$_. installstate -eq "installed"} | select name 
|  Export-Csv -Path .\getinstalledfeatures.csv -NoTypeInformation