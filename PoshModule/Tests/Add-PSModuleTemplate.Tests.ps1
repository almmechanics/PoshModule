$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\..\cmdlets\interface\Add-PSModuleTemplate.ps1"

Describe 'Add-PSModuleTemplate' {    
    Context 'Interface Tests' {
        It 'RootFolder is a mandatory parameter' {
            {Add-PSModuleTemplate -RootFolder $null} | should throw
        }

        It 'RootFolder cannot be empty' {
            {Add-PSModuleTemplate -RootFolder ([string]::empty) } | should throw
        }

        It 'RootFolder must exist as a path'{
            {Add-PSModuleTemplate -RootFolder TestDrive:\\Unknown} | should throw
        }

        New-item TestDrive:\\ValidPath -ItemType  Directory | Out-Null

        It 'ModuleName is a mandatory parameter' {
            {Add-PSModuleTemplate -RootFolder TestDrive:\ValidPath -ModuleName $null} | should throw
        }

        It 'ModuleName cannot be empty' {
            {Add-PSModuleTemplate -RootFolder TestDrive:\ValidPath -ModuleName ([string]::empty) } | should throw
        }       

        It 'Module is created if RootFolder and ModuleName are valid' {
            Mock New-Item {} -Verifiable            
            Mock New-ModuleManifest {} -Verifiable        
            Mock Out-File {} -Verifiable        

            Add-PSModuleTemplate -RootFolder 'TestDrive:\ValidPath' -ModuleName 'ValidModule'

            Assert-MockCalled New-Item -Exactly 4 -Scope It
            Assert-MockCalled New-ModuleManifest -Exactly 1 -Scope It
            Assert-MockCalled Out-File -Times 1 -Scope It
        }

        It 'Module is created with Tests folder if IncludeTestFolder selected'  {
            Mock New-Item {} -Verifiable            
            Mock New-ModuleManifest {} -Verifiable        
            Mock Out-File {} -Verifiable        
            
            Add-PSModuleTemplate -RootFolder 'TestDrive:\ValidPath' -ModuleName 'ValidModule' -IncludeTestsFolder

            Assert-MockCalled New-Item -Exactly 5 -Scope It
            Assert-MockCalled New-ModuleManifest -Exactly 1 -Scope It
            Assert-MockCalled Out-File -Times 1 -Scope It
        }

    }
}
