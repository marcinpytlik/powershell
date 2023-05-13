# DC1 
# 1. Explicitly Load The Server Manager Module
Import-Module ServerManager -WarningAction SilentlyContinue
# 2. Install the AD Domain Services feature and management tools
$feature = @{
  Name                   = 'AD-Domain-Services'
  IncludeManagementTools = $True
  WarningAction          = 'SilentlyContinue'
}
Install-WindowsFeature @feature
# 3. Import the AD DS Deployment Module
Import-Module -Name ADDSDeployment -WarningAction SilentlyContinue
# 4. Install Forest Root Domain and DC
$adPassword = @{
  String      = 'Pa$$w0rd'
  AsPlainText = $True
  Force       = $True
}
$securePWD = ConvertTo-SecureString @adPassword
$domain = @{
  DomainName                    = 'domena.com' # Forest Root
  SafeModeAdministratorPassword = $SECUREPW
  InstallDNS                    = $True
  DomainMode                    = 'WinThreshold' # latest
  ForestMode                    = 'WinThreshold' # Latest
  Force                         = $True
  NoRebootOnCompletion          = $True
  WarningAction                 = 'SilentlyContinue'
}
Install-ADDSForest @ADHT 

# 5. Restart computer
Restart-Computer -Force

# 6. After reboot, log back into DC1 as domena\Administrator
Get-ADRootDSE |  Format-Table -Property DNS*, *Functionality

# 7. Examine ADDS forest
Get-AdForest |  Format-Table -Property *master*, global*, Domains

# 8. View details of the domain
Get-ADDomain |  Format-Table -Property DNS*, PDC*, *master, Replica*

# 9. View DNS Settings
Get-Service -Name DNS
Get-DnsServerZone 
Get-DnsServerResourceRecord -ZoneName 'domena.com'
