function New-DirectoryForest {
	param(
		[Parameter(Mandatory)]
		[pscredential]$Credential,

		[Parameter(Mandatory)]
		[string]$SafeModePassword,

		[Parameter(Mandatory)]
		[string]$VMName,

		[Parameter(Mandatory)]
		[string]$DomainName,

		[Parameter()]
		[string]$DomainMode = 'WinThreshold',

		[Parameter()]
		[string]$ForestMode = 'WinThreshold'
	)

	Invoke-Command -VMName $VMName -Credential $Credential -ScriptBlock {

		Install-windowsfeature -Name AD-Domain-Services
		
		$forestParams = @{
			DomainName                    = $using:DomainName
			DomainMode                    = $using:DomainMode
			ForestMode                    = $using:ForestMode
			Confirm                       = $false
			SafeModeAdministratorPassword = (ConvertTo-SecureString -AsPlainText -String $using:SafeModePassword -Force)
			WarningAction                 = 'Ignore'
		}
		$null = Install-ADDSForest @forestParams
	}
}