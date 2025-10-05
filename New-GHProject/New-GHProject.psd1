@{
    # Script module or binary module file associated with this manifest
    RootModule = 'New-GHProject.psm1'

    # Version number of this module
    ModuleVersion = '1.0.0'

    # ID used to uniquely identify this module
    GUID = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'

    # Author of this module
    Author = 'J.F.Heinrich'

    # Company or vendor of this module
    CompanyName = 'jfheinrich-eu'

    # Copyright statement for this module
    Copyright = '(c) 2025 J.F.Heinrich. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'PowerShell module to create GitHub repositories with proper branch setup and protection rules.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '7.4'

    # Functions to export from this module
    FunctionsToExport = @(
        'New-GHProject'
    )

    # Cmdlets to export from this module
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module
            Tags = @('GitHub', 'Repository', 'Automation', 'Branch-Protection')

            # A URL to the license for this module
            LicenseUri = 'https://github.com/jfheinrich-eu/new-ghproject/blob/master/LICENSE'

            # A URL to the main website for this project
            ProjectUri = 'https://github.com/jfheinrich-eu/new-ghproject'

            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of New-GHProject module'
        }
    }
}
