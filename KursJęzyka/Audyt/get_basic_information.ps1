$domainName =Read-Host "Podaj nazwe domeny (np. pracowniait)"
Write-Host "Testuje domene..."
Get-ADDomain $domainName | format-table PDCEmulator,RIDMaster,InfrastructureMaster | Export-Csv -Path .\FSMO-DOMAIN.csv -NoTypeInformation
Get-ADForest $domainName | Format-Table SchemaMaster,DomainNamingMaster | Export-Csv -Path .\FSMO-FOREST.csv -NoTypeInformation
Get-ADDomain | Export-Csv -Path .\ADDOMAIN.csv -NoTypeInformation
Get-ADForest | Export-Csv -Path .\ADFOREST.csv -NoTypeInformation
Get-ADFineGrainedPasswordPolicy -filter * | Export-Csv -Path .\GRAINEDPASSWORDPOLICY.csv -NoTypeInformation
Get-ADDefaultDomainPasswordPolicy | Export-Csv -Path .\DEFAULTPASSWORDPOLICY.csv -NoTypeInformation
Get-ADDomainController -filter * | select hostname, operatingsystem | Export-Csv -Path .\DOMAINCONTROLLER.csv -NoTypeInformation
Write-Host  "Pobieram informacje o kontach uytkownikw"
Search-ADAccount -AccountDisabled | select name | Export-Csv -Path .\DISABLEACCOUNT.csv -NoTypeInformation
get-aduser -filter * -properties Name, PasswordNeverExpires | where {$_.passwordNeverExpires -eq "true" } | Select-Object DistinguishedName,Name,Enabled | Export-Csv -Path .\PASSWORDNEVEREXPIRES.csv -NoTypeInformation
Search-ADAccount -LockedOut | Export-Csv -Path .\LOCKEDACCOUNT.csv -NoTypeInformation
Get-ADUser -Filter * | Export-Csv -Path .\USERS.csv -NoTypeInformation
Write-Host  "Pobieram informacje o grupach"
Get-ADGroup -filter * | Export-Csv -Path .\GROUPS.csv -NoTypeInformation
Write-Host  "Pobieram informacje o komputerach"
Get-ADComputer -Filter "name -like '*'" -Properties operatingSystem | group -Property operatingSystem | Select Name,Count | Sort Name | Export-Csv -Path .\COMPUTERS.csv -NoTypeInformation 
Write-Host  "Pobieram informacje o GPO"
Get-GPO -all | Export-Csv -Path .\GPO.csv -NoTypeInformation
Write-Host "Sprawdzam zgodnosc BPA"
Invoke-BPAModel “Microsoft/Windows/DirectoryServices”
Get-BpaResult “Microsoft/Windows/DirectoryServices” | Export-Csv -Path .\BPARESULT.csv -NoTypeInformation
Write-Host  "Dziekuje za wspolrace"