Set-StrictMode -Version Latest

$cmdletsPath = Join-Path $PSScriptRoot 'cmdlets'

$interfacePath = Join-Path $cmdletsPath 'interface'
. (Join-Path $interfacePath 'Add-PSModuleTemplate.ps1')