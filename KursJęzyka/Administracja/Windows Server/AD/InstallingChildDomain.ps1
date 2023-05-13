# Run on UKDC1 - a workgroup computer
# wITH DC1.domena.com is the forest root DC and online

# 1. Import the ServerManager module
Import-Module -Name ServerManager -WarningAction SilentlyContinue

# 2. Check DC1 can be resolved and  can be reached over 445 and 389 from UKDC1
Resolve-DnsName -Name DC1.domena.com -Type A
Test-NetConnection -ComputerName DC1.domena.com -Port 445
Test-NetConnection -ComputerName DC1.domena.com -Port 389

# 3. Add the AD DS features on UKDC1
$Features = 'AD-Domain-Services'
Install-WindowsFeature -Name $Features -IncludeManagementTools

# 4. Create New Domain
Import-Module -Name ADDSDeployment -WarningAction SilentlyContinue
$URK    = "Administrator@domena.com" 
$PW     = 'Pa$$w0rd'
$PSS    = ConvertTo-SecureString -String $PW -AsPlainText -Force
$CredRK = [PSCredential]::New($URK,$PSS)
$installParam    = @{
  NewDomainName                 = 'poddomena'
  ParentDomainName              = 'domena.com'
  DomainType                    = 'ChildDomain'
  SafeModeAdministratorPassword = $PSS
  ReplicationSourceDC           = 'DC1.domena.com'
  Credential                    = $CredRK
  SiteName                      = 'Default-First-Site-Name'
  InstallDNS                    = $false
  Force                         = $true
}
Install-ADDSDomain @INSTALLHT

### after roboot - login as UK\Administrator  

# 5. Look at AD forest
Get-ADForest -Server UKDC1.poddomena.domena.com

# 6. Look at UK domain
Get-ADDomain -Server UKDC1.poddomena.domena.com
