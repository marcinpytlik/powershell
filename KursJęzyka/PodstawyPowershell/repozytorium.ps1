$localPath='c:\repo'
New-Item -Path $localPath -ItemType Directory | Out-Null
$shareSMB=@{
    Name='Repozytorium'
    Path=$localPath
    Description="Repozytorium kodu"
    FullAccess='Everyone'
}
New-SmbShare @shareSMB
#New-SmbShare -Path $localPath -Description "Repozytorium kodu" -FullAccess 'Everyone' -Name "Repozytorium"
$repoPath="\\fulcrum\repozytorium"
$repo=@{
    Name='Repozytorium'
    SourceLocation=$repoPath
    PublishLocation=$repoPath
    InstallationPolicy='Trusted'
}
Register-PSRepository @repo
