## custom module
New-Item -Path c:\hw -ItemType Directory
$module=@'
function Get-HelloWorld {'Hello world'}
set-alias ghw get-HelloWorld
'@
$module| out-file c:\hw\hw.psm1
import-module -name c:\hw -Verbose
ghw
$manifest=@{
    Path="c:\hw\hw.psd1"
    RootModule='hw.psm1'
    Description="Hello World module"
    Author='Marcin Pytlik'
    FunctionsToExport='Get-HelloWorld'
    ModuleVersion='1.0.0.0'
}
New-ModuleManifest @manifest