# Development Guide

## Repository Structure

```
new-ghproject/
├── .github/
│   ├── dependabot.yml          # Dependabot configuration for automated updates
│   └── workflows/
│       ├── ci-cd.yml           # CI/CD pipeline for testing and linting
│       └── publish.yml         # PowerShell Gallery deployment workflow
├── New-GHProject/              # Main module directory
│   ├── New-GHProject.psd1      # Module manifest
│   ├── New-GHProject.psm1      # Module loader
│   ├── Public/                 # Public functions (exported)
│   │   └── New-GHProject.ps1
│   └── Private/                # Private functions (internal only)
├── Tests/                      # Pester tests
│   └── New-GHProject.Tests.ps1
├── .gitignore                  # Git ignore rules
├── CHANGELOG.md                # Version history
├── LICENSE                     # MIT License
└── README.md                   # Main documentation
```

## Development Workflow

### 1. Local Development

```powershell
# Clone the repository
git clone https://github.com/jfheinrich-eu/new-ghproject.git
cd new-ghproject

# Import the module for testing
Import-Module ./New-GHProject/New-GHProject.psd1 -Force

# Run tests
Invoke-Pester -Path ./Tests

# Run code analysis
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse
```

### 2. Adding New Functions

1. Create a new `.ps1` file in `New-GHProject/Public/` for exported functions
2. Create a new `.ps1` file in `New-GHProject/Private/` for internal helper functions
3. Update the `FunctionsToExport` array in `New-GHProject.psd1`
4. Create corresponding test file in `Tests/`

### 3. Running Tests Locally

```powershell
# Install Pester (if not already installed)
Install-Module -Name Pester -MinimumVersion 5.3.0 -Force

# Run all tests
Invoke-Pester -Path ./Tests -Output Detailed

# Run tests with code coverage
$config = New-PesterConfiguration
$config.Run.Path = './Tests'
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.Path = './New-GHProject/**/*.ps1'
$config.Output.Verbosity = 'Detailed'
Invoke-Pester -Configuration $config
```

### 4. Code Quality

```powershell
# Install PSScriptAnalyzer
Install-Module -Name PSScriptAnalyzer -Force

# Run analysis
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse -Settings PSGallery

# Fix common issues automatically
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse -Fix
```

## CI/CD Pipeline

### Continuous Integration (ci-cd.yml)

Runs on every push and pull request:

- **Test Job**: Runs Pester tests on Windows, Linux, and macOS
- **Lint Job**: Runs PSScriptAnalyzer to ensure code quality
- Generates test results and code coverage reports

### Deployment (publish.yml)

Triggered on:
- **Release creation**: Automatically publishes to PowerShell Gallery
- **Manual dispatch**: Allows manual publishing with version specification

Prerequisites:
- Set `PSGALLERY_API_KEY` secret in repository settings

## Publishing to PowerShell Gallery

### Automatic (Recommended)

1. Update version in `New-GHProject.psd1`
2. Update `CHANGELOG.md`
3. Create a new release on GitHub with tag `vX.Y.Z`
4. The workflow will automatically publish to PowerShell Gallery

### Manual

1. Get your PowerShell Gallery API key from https://www.powershellgallery.com/account/apikeys
2. Add it as a repository secret named `PSGALLERY_API_KEY`
3. Go to Actions → Publish to PowerShell Gallery → Run workflow
4. Enter the version number

## Dependabot

Dependabot is configured to:
- Check for GitHub Actions updates weekly
- Create pull requests automatically
- Add labels: `dependencies`, `github-actions`

## Testing GitHub API Integration

To test the module locally with real GitHub API:

```powershell
# Set your GitHub token
$token = "your-github-token-here"

# Test with WhatIf (safe, doesn't create anything)
New-GHProject -RepositoryName "test-repo" -Owner "yourusername" -Token $token -WhatIf

# Create a test repository
New-GHProject -RepositoryName "test-repo" -Owner "yourusername" -Description "Test repository" -Token $token
```

## Troubleshooting

### Module Not Loading

```powershell
# Remove and reimport
Remove-Module New-GHProject -Force -ErrorAction SilentlyContinue
Import-Module ./New-GHProject/New-GHProject.psd1 -Force
```

### Tests Failing

```powershell
# Run with detailed output
Invoke-Pester -Path ./Tests -Output Detailed

# Run specific test
Invoke-Pester -Path ./Tests/New-GHProject.Tests.ps1 -Output Detailed
```

### PSScriptAnalyzer Issues

```powershell
# Get detailed information
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse | Format-List

# Auto-fix when possible
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse -Fix
```

## Best Practices

1. **Always add tests** for new functions
2. **Update documentation** when changing functionality
3. **Follow PowerShell naming conventions** (Verb-Noun)
4. **Include comment-based help** for all public functions
5. **Use ShouldProcess** for functions that make changes
6. **Validate parameters** with appropriate attributes
7. **Handle errors gracefully** with try/catch blocks
8. **Write verbose output** for debugging
