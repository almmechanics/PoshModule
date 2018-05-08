# PoshModule
Creates a uniform PowerShell module format

## Usage

### Add-PSModuleTemplate
1. Create a new module 'demo' in the folder c:\dev\mod1

    Add-PSModuleTemplate -RootFolder c:\dev\mod1 -ModuleName 'demo'

1. Create a new module 'demo' in the folder c:\dev\mod1 and create a Pester tests folder

   Add-PSModuleTemplate -RootFolder c:\dev\mod1 -ModuleName 'demo' -IncludeTestsFolder
     
    
## Build Status
[![AppVeyor status](https://ci.appveyor.com/api/projects/status/8tlrgfy9fbdji20e/branch/master?svg=true)](https://ci.appveyor.com/project/almmechanics/poshmodule/branch/master) ![VSTS status](https://almmechanics.visualstudio.com/_apis/public/build/definitions/0a813601-24f8-412a-8e8a-15aad4c0d629/17/badge) [![codecov](https://codecov.io/gh/almmechanics/poshpasswords/branch/master/graph/badge.svg)](https://codecov.io/gh/almmechanics/poshmodule)
