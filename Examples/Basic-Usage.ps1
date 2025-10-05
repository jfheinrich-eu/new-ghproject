<#
.SYNOPSIS
    Examples demonstrating usage of the New-GHProject PowerShell module.

.DESCRIPTION
    This script provides comprehensive examples of how to use the New-GHProject module
    to create GitHub repositories with various configurations. All examples include
    detailed explanations and are designed to demonstrate best practices.

.NOTES
    Author: J.F.Heinrich
    Prerequisites: GitHub Personal Access Token with 'repo' permissions
    Token Creation: https://github.com/settings/tokens
#>

# Example usage of New-GHProject module

# Import the module
Import-Module ./New-GHProject/New-GHProject.psd1 -Force

# Set your GitHub token (replace with your actual token or use environment variable)
$token = $env:GITHUB_TOKEN

# If you don't have a token set, you can create one at:
# https://github.com/settings/tokens
# Required permissions: repo (Full control of private repositories)

# Example 1: Create a public repository with WhatIf (safe, doesn't actually create)
Write-Host "`n=== Example 1: Using WhatIf ===" -ForegroundColor Cyan
New-GHProject -RepositoryName "test-repo" `
    -Owner "yourusername" `
    -Description "Test repository" `
    -Token $token `
    -WhatIf `
    -Verbose

# Example 2: Create a public repository
Write-Host "`n=== Example 2: Create Public Repository ===" -ForegroundColor Cyan
# Uncomment to run:
# New-GHProject -RepositoryName "my-public-repo" `
#               -Owner "yourusername" `
#               -Description "My awesome public project" `
#               -Token $token `
#               -Verbose

# Example 3: Create a private repository
Write-Host "`n=== Example 3: Create Private Repository ===" -ForegroundColor Cyan
# Uncomment to run:
# New-GHProject -RepositoryName "my-private-repo" `
#               -Owner "yourusername" `
#               -Description "My private project" `
#               -Private `
#               -Token $token `
#               -Verbose

# Example 4: Create a repository in an organization (with IsOrganization parameter to avoid extra API call)
Write-Host "`n=== Example 4: Create Organization Repository (Optimized) ===" -ForegroundColor Cyan
# Uncomment to run:
# New-GHProject -RepositoryName "org-repo" `
#               -Owner "myorganization" `
#               -Description "Organization repository" `
#               -IsOrganization `
#               -Token $token `
#               -Verbose

# Example 5: Create a repository in an organization (without IsOrganization parameter)
Write-Host "`n=== Example 5: Create Organization Repository (Auto-detect) ===" -ForegroundColor Cyan
# Uncomment to run:
# New-GHProject -RepositoryName "org-repo" `
#               -Owner "myorganization" `
#               -Description "Organization repository" `
#               -Token $token `
#               -Verbose

# Example 6: Get help
Write-Host "`n=== Example 6: Get Help ===" -ForegroundColor Cyan
Get-Help New-GHProject -Full

# Example 7: View examples
Write-Host "`n=== Example 7: View Examples ===" -ForegroundColor Cyan
Get-Help New-GHProject -Examples
