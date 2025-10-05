<#
.SYNOPSIS
    New-GHProject PowerShell Module Loader

.DESCRIPTION
    This module loader script imports all public and private functions for the New-GHProject module.
    It automatically discovers and loads all PowerShell scripts from the Public and Private directories,
    then exports only the public functions for use by module consumers.

.NOTES
    Module Name: New-GHProject
    Author: J.F.Heinrich
    Version: 1.0.0
#>

# Get public and private function definition files
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

# Dot source the files
foreach ($import in @($Public + $Private)) {
    try {
        . $import.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}

# Export only public functions to module consumers
Export-ModuleMember -Function $Public.BaseName
