$Assemblies = [System.AppDomain]::CurrentDomain.GetAssemblies() 
"Assemblies loaded: {0:n0}" -f $Assemblies.Count

# 2. Viewing first 10
$Assemblies | Select-Object -First 10

# 3. Checking assemblies in Windows PowerShell
$ScriptBlock = {
  [System.AppDomain]::CurrentDomain.GetAssemblies() 
} 
# 5. Exploring the Microsoft.PowerShell.Management module
$AllTheModulesOnThisSystem = 
  Get-Module -Name Microsoft.PowerShell.Management -ListAvailable
$AllTheModulesOnThisSystem  | Format-List

# 8. Viewing associated loaded assembly
$Assemblies2 = [System.AppDomain]::CurrentDomain.GetAssemblies() 

# 9. Getting details of a PowerShell command inside a module DLL
$Commands = $Assemblies |
               Where-Object Location -match Commands.Management\.dll
$Commands.GetTypes() | 
  Where-Object Name -match "Addcontentcommand$" 

