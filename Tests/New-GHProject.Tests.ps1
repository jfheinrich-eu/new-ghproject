BeforeAll {
    # Import the module
    $ModulePath = Split-Path -Parent $PSScriptRoot
    $ModuleName = 'New-GHProject'
    
    # Remove module if already loaded
    if (Get-Module -Name $ModuleName) {
        Remove-Module -Name $ModuleName -Force
    }
    
    # Import the module
    Import-Module "$ModulePath\$ModuleName\$ModuleName.psd1" -Force
}

Describe 'New-GHProject Module' {
    Context 'Module Setup' {
        It 'Should import the module successfully' {
            $module = Get-Module -Name 'New-GHProject'
            $module | Should -Not -BeNullOrEmpty
        }
        
        It 'Should export the New-GHProject function' {
            $commands = Get-Command -Module 'New-GHProject'
            $commands.Name | Should -Contain 'New-GHProject'
        }
        
        It 'Should have correct module version' {
            $module = Get-Module -Name 'New-GHProject'
            $module.Version | Should -Be '1.0.0'
        }
    }
}

Describe 'New-GHProject Function' {
    Context 'Parameter Validation' {
        It 'Should have mandatory RepositoryName parameter' {
            (Get-Command New-GHProject).Parameters['RepositoryName'].Attributes.Mandatory | Should -Be $true
        }
        
        It 'Should have mandatory Owner parameter' {
            (Get-Command New-GHProject).Parameters['Owner'].Attributes.Mandatory | Should -Be $true
        }
        
        It 'Should have mandatory Token parameter' {
            (Get-Command New-GHProject).Parameters['Token'].Attributes.Mandatory | Should -Be $true
        }
        
        It 'Should have optional Description parameter' {
            (Get-Command New-GHProject).Parameters['Description'].Attributes.Mandatory | Should -Be $false
        }
        
        It 'Should have optional Private parameter' {
            (Get-Command New-GHProject).Parameters['Private'].ParameterType.Name | Should -Be 'SwitchParameter'
        }
        
        It 'Should support ShouldProcess' {
            (Get-Command New-GHProject).Parameters.ContainsKey('WhatIf') | Should -Be $true
            (Get-Command New-GHProject).Parameters.ContainsKey('Confirm') | Should -Be $true
        }
    }
    
    Context 'Function Help' {
        BeforeAll {
            $help = Get-Help New-GHProject
        }
        
        It 'Should have a synopsis' {
            $help.Synopsis | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have a description' {
            $help.Description | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have examples' {
            $help.Examples | Should -Not -BeNullOrEmpty
        }
    }
}

AfterAll {
    # Clean up
    Remove-Module -Name 'New-GHProject' -Force -ErrorAction SilentlyContinue
}
