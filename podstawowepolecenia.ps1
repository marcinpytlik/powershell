get-alias
get-command -name get-alias
get-command -verb get -noun Content
get-help add-Content
update-help
set-strictmode -version latest
set-variable -name color -value niebieski
get-variable -name color
get-variable -name *Preference
$errorActionPreference='SilentyContinue'
$num=1
$num
$num.GetType().name
select-object -inputobject $color -Property *
get-member -inputobject $color
[int] num2
# tablice
$colorPicker=@('niebieski','bialy','czarny')
$colorPicker
$colorPicker[2]
$colorPicker[1..2]
$colorPicker[3]='nowy'
$colorPicker=$colorPicker+'pomaranczowy'
$colorPicker+='brazowy'
$colorPicker+=@('rozowy','turkusowy')
$colorPicker=[System.Collections.ArrayList]@('niebieski','bialy')
$colorPicker.Add('szary')
$users=@{
    abertam='Wartosc'
    rembo='Wartosc'
    zheng='Zheng'
}
$users
$users['rembo']
$users.Keys
$users.Values
select-object -inputobject $users -Property *
$users.Add('natice','wartosc')
$users['ok']='nowa wartosc'
$users.ContainsKey('klucz')
$users.Remove('klucz')
$myFirstCustomObject=new-object -typename pscustomobject
$myFirstCustomObject=[PSCustomObject]@{OSbuild='x';OSVersion='y'}
get-member -inputobject $myFirstCustomObject
# potoki
get-service -name 'wuauserv' | start-service
'wuauserv'|get-service|start-service
get-content -path c:\plik.txt
get-content -path c:\plik.txt| get-service
get-executionpolicy


