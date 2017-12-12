Set-StrictMode -Version latest

function Create-Skeleton
{
<#
.Example
Create-Skeleton -RootFolder c:\dev\mod1 -ModuleName 'demo'
#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateScript({Test-Path $_})]
        [string]
        $RootFolder,
        [Parameter(Mandatory)]
        [string]
        $ModuleName
    )

    New-Item -Path $RootFolder\$ModuleName -ItemType Directory -Force | Out-Null
    New-Item -Path "$RootFolder\$ModuleName\cmdlets" -ItemType Directory -Force | Out-Null
    New-Item -Path "$RootFolder\$ModuleName\cmdlets\interface" -ItemType Directory -Force | Out-Null
    New-Item -Path "$RootFolder\$ModuleName\cmdlets\internal" -ItemType Directory -Force | Out-Null

    $psd1File = "$RootFolder\$ModuleName\$ModuleName.psd1"

    New-ModuleManifest -Path $psd1File -FunctionsToExport @() -RootModule "$ModuleName.psm1"

    @(  "Set-StrictMode -Version Latest",
        "`$cmdletsPath = Join-Path `$PSScriptRoot 'cmdlets'",
        "`$interfacePath = Join-Path `$cmdletsPath 'interface'",
        "# . (Join-Path `$interfacePath '<interface_sample>.ps1')",        
        "`$internalPath = Join-Path `$cmdletsPath 'internal'",
        "# . (Join-Path `$internalPath '<internal_sample>.ps1')") | out-file "$RootFolder\$ModuleName\$ModuleName.psm1" -Encoding ascii -Force
}
