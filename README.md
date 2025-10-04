# New-GHProject

[![CI/CD](https://github.com/jfheinrich-eu/new-ghproject/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/jfheinrich-eu/new-ghproject/actions/workflows/ci-cd.yml)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/New-GHProject.svg)](https://www.powershellgallery.com/packages/New-GHProject)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This PowerShell module provides functionality to create GitHub repositories with proper branch setup and protection rules.

## Features

- Create GitHub repositories programmatically
- Configure branch protection rules automatically
- Support for both public and private repositories
- Cross-platform support (Windows, Linux, macOS)
- Comprehensive error handling and validation

## Installation

### From PowerShell Gallery

```powershell
Install-Module -Name New-GHProject -Scope CurrentUser
```

### From Source

```powershell
git clone https://github.com/jfheinrich-eu/new-ghproject.git
cd new-ghproject
Import-Module ./New-GHProject/New-GHProject.psd1
```

## Usage

### Prerequisites

You'll need a GitHub Personal Access Token with `repo` permissions. You can create one at:
https://github.com/settings/tokens

### Basic Example

```powershell
# Create a public repository
New-GHProject -RepositoryName "my-new-repo" -Owner "myusername" -Description "My awesome project" -Token $env:GITHUB_TOKEN
```

### Create a Private Repository

```powershell
# Create a private repository
New-GHProject -RepositoryName "private-repo" -Owner "myusername" -Description "Private project" -Private -Token $env:GITHUB_TOKEN
```

### Using WhatIf

```powershell
# See what would happen without actually creating the repository
New-GHProject -RepositoryName "test-repo" -Owner "myusername" -Token $env:GITHUB_TOKEN -WhatIf
```

## Parameters

- **RepositoryName** (Mandatory): The name of the repository to create
- **Owner** (Mandatory): The owner (user or organization) of the repository
- **Description** (Optional): A short description of the repository
- **Private** (Optional): Switch to create a private repository (default is public)
- **Token** (Mandatory): GitHub Personal Access Token with repo permissions

## Development

### Running Tests

This project uses Pester for testing. To run the tests:

```powershell
# Install Pester if not already installed
Install-Module -Name Pester -MinimumVersion 5.3.0 -Force

# Run tests
Invoke-Pester -Path ./Tests
```

### Code Analysis

The project uses PSScriptAnalyzer for code quality:

```powershell
# Install PSScriptAnalyzer
Install-Module -Name PSScriptAnalyzer -Force

# Run analysis
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse
```

## CI/CD

This project uses GitHub Actions for:

- **Continuous Integration**: Runs tests on every push and pull request across Windows, Linux, and macOS
- **Code Analysis**: Runs PSScriptAnalyzer to ensure code quality
- **Auto-labeling**: Automatically labels PRs based on changed files
- **Automated Releases**: Creates releases based on PR labels (major/minor/patch)
- **Deployment**: Automatically publishes to PowerShell Gallery on release
- **Dependency Updates**: Dependabot keeps GitHub Actions up to date

### Release Process

Releases are automated based on PR labels:
- Add `major release`, `minor release`, or `patch release` label to your PR
- Add `skip release` to skip release creation
- When merged, the workflow automatically bumps the version, creates a tag, and publishes a GitHub release

See [Release Workflow Documentation](.github/RELEASE_WORKFLOW.md) for detailed information.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**J.F.Heinrich** - [jfheinrich-eu](https://github.com/jfheinrich-eu)

## Acknowledgments

- Built with PowerShell
- Tested with Pester
- Analyzed with PSScriptAnalyzer
