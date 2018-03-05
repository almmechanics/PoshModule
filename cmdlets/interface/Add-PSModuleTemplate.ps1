Set-StrictMode -Version latest

function Add-PSModuleTemplate
{
    <#
    .Example
    Add-PSModuleTemplate -RootFolder c:\dev\mod1 -ModuleName 'demo'
    Create a new module 'demo' in the folder c:\dev\mod1

    .Example 
    Add-PSModuleTemplate -RootFolder c:\dev\mod1 -ModuleName 'demo' -IncludeTestsFolder
    Create a new module 'demo' in the folder c:\dev\mod1 and create a Pester tests folder
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path $_})]
        [string]
        $RootFolder,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ModuleName,
        [switch]
        $IncludeTestsFolder
    )
    
    $ModuleFolder = Join-Path $RootFolder $ModuleName

    $Subfolders = @(
                    $ModuleFolder,
                    (Join-Path $ModuleFolder 'cmdlets'),
                    (Join-Path $ModuleFolder 'cmdlets\interface'),
                    (Join-Path $ModuleFolder 'cmdlets\internal')
                   )

    if ($IncludeTestsFolder)
    {
        $Subfolders += @(Join-Path $ModuleFolder 'Tests')        
    }

    $Subfolders | ForEach-Object {        
        Write-Verbose ('Adding folder: "{0}"' -f $_)
        New-Item -Path $_ -ItemType Directory -Force | Out-Null        
    }

    $psd1File = Join-Path $ModuleFolder ('{0}.psd1' -f $ModuleName)

    New-ModuleManifest -Path $psd1File -FunctionsToExport @() -RootModule "$ModuleName.psm1"

    @(  "Set-StrictMode -Version Latest",
        "`$cmdletsPath = Join-Path `$PSScriptRoot 'cmdlets'",
        "`$interfacePath = Join-Path `$cmdletsPath 'interface'",
        "# . (Join-Path `$interfacePath '<interface_sample>.ps1')",        
        "`$internalPath = Join-Path `$cmdletsPath 'internal'",
        "# . (Join-Path `$internalPath '<internal_sample>.ps1')"
        ) | Out-File (Join-Path $ModuleFolder ('{0}.psm1' -f $ModuleName)) -Encoding ascii -Force
        
}
