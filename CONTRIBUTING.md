# Contributing to New-GHProject

Thank you for considering contributing to New-GHProject! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- A clear and descriptive title
- Detailed steps to reproduce the problem
- Expected behavior
- Actual behavior
- PowerShell version (`$PSVersionTable`)
- Operating system
- Any relevant error messages or logs

### Suggesting Enhancements

Enhancement suggestions are welcome! Please:

- Use a clear and descriptive title
- Provide a detailed description of the proposed enhancement
- Explain why this enhancement would be useful
- Provide examples of how it would be used

### Pull Requests

1. **Fork the repository** and create your branch from `master`
2. **Make your changes** following the coding standards
3. **Add tests** for any new functionality
4. **Update documentation** as needed
5. **Ensure all tests pass** locally
6. **Run PSScriptAnalyzer** and fix any issues
7. **Submit a pull request**

## Development Setup

### Prerequisites

- PowerShell 5.1 or higher
- Git
- Pester (for testing)
- PSScriptAnalyzer (for linting)

### Local Setup

```powershell
# Clone your fork
git clone https://github.com/YOUR-USERNAME/new-ghproject.git
cd new-ghproject

# Install dependencies
Install-Module -Name Pester -MinimumVersion 5.3.0 -Force
Install-Module -Name PSScriptAnalyzer -Force

# Import the module
Import-Module ./New-GHProject/New-GHProject.psd1 -Force
```

## Coding Standards

### PowerShell Style Guide

- Use approved PowerShell verbs (`Get-Verb` for reference)
- Follow PascalCase for function names and parameters
- Use meaningful variable names
- Include comment-based help for all public functions
- Use `[CmdletBinding()]` for advanced functions
- Implement `ShouldProcess` for functions that make changes

### Example Function Structure

```powershell
function Verb-Noun {
    <#
    .SYNOPSIS
        Brief description
    
    .DESCRIPTION
        Detailed description
    
    .PARAMETER ParameterName
        Parameter description
    
    .EXAMPLE
        Verb-Noun -ParameterName "value"
        Description of what this example does
    #>
    
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ParameterName
    )
    
    begin {
        Write-Verbose "Starting Verb-Noun function"
    }
    
    process {
        try {
            if ($PSCmdlet.ShouldProcess($ParameterName, "Action description")) {
                # Implementation
            }
        }
        catch {
            Write-Error "Error message: $_"
            throw
        }
    }
    
    end {
        Write-Verbose "Completed Verb-Noun function"
    }
}
```

### Testing Standards

- Write tests for all new functions
- Use descriptive test names
- Test both success and failure scenarios
- Include parameter validation tests
- Test help documentation completeness

### Example Test Structure

```powershell
Describe 'Function-Name' {
    Context 'Parameter Validation' {
        It 'Should have mandatory parameter' {
            (Get-Command Function-Name).Parameters['ParameterName'].Attributes.Mandatory | Should -Be $true
        }
    }
    
    Context 'Functionality' {
        It 'Should perform expected action' {
            # Test implementation
        }
    }
}
```

## Testing Your Changes

### Run All Tests

```powershell
Invoke-Pester -Path ./Tests -Output Detailed
```

### Run Code Analysis

```powershell
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse -Settings PSGallery
```

### Test Module Import

```powershell
Remove-Module New-GHProject -Force -ErrorAction SilentlyContinue
Import-Module ./New-GHProject/New-GHProject.psd1 -Force
Get-Command -Module New-GHProject
```

## Commit Message Guidelines

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests after the first line

### Examples

```
Add support for organization repositories

- Implement organization detection
- Add organization parameter validation
- Update tests for organization support

Fixes #123
```

## Pull Request Process

1. **Update documentation** for any changed functionality
2. **Add tests** for new features
3. **Update CHANGELOG.md** with your changes
4. **Ensure CI/CD passes** (tests, linting)
5. **Request review** from maintainers
6. **Address feedback** if requested
7. **Squash commits** if requested

## Release Process

Releases are managed by maintainers:

1. Update version in `New-GHProject.psd1`
2. Update `CHANGELOG.md`
3. Create GitHub release with tag `vX.Y.Z`
4. Automatic deployment to PowerShell Gallery

## Questions?

Feel free to open an issue for questions or join discussions in existing issues.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
