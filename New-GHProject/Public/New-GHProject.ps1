function New-GHProject {
    <#
    .SYNOPSIS
        Creates a new GitHub repository with proper branch setup and protection rules.

    .DESCRIPTION
        This function creates a new GitHub repository and configures it with:
        - Main branch setup
        - Branch protection rules
        - Default branch configuration

    .PARAMETER RepositoryName
        The name of the repository to create.

    .PARAMETER Owner
        The owner (user or organization) of the repository.

    .PARAMETER Description
        A short description of the repository.

    .PARAMETER Private
        If specified, creates a private repository. Default is public.

    .PARAMETER Token
        GitHub personal access token with repo permissions.

    .EXAMPLE
        New-GHProject -RepositoryName "my-new-repo" -Owner "myuser" -Description "My new repository" -Token $token

    .EXAMPLE
        New-GHProject -RepositoryName "private-repo" -Owner "myorg" -Private -Token $token
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepositoryName,

        [Parameter(Mandatory = $true)]
        [string]$Owner,

        [Parameter(Mandatory = $false)]
        [string]$Description = "",

        [Parameter(Mandatory = $false)]
        [switch]$Private,

        [Parameter(Mandatory = $true)]
        [string]$Token
    )

    begin {
        Write-Verbose "Starting New-GHProject function"

        # Set up headers for GitHub API
        $headers = @{
            'Authorization' = "token $Token"
            'Accept' = 'application/vnd.github.v3+json'
        }
    }

    process {
        try {
            if ($PSCmdlet.ShouldProcess($RepositoryName, "Create GitHub repository")) {
                # Create repository
                $repoBody = @{
                    name = $RepositoryName
                    description = $Description
                    private = $Private.IsPresent
                    auto_init = $true
                } | ConvertTo-Json

                $repoUrl = "https://api.github.com/user/repos"
                if ($Owner -ne (Get-GitHubAuthenticatedUser -Token $Token)) {
                    $repoUrl = "https://api.github.com/orgs/$Owner/repos"
                }

                Write-Verbose "Creating repository: $RepositoryName"
                $repo = Invoke-RestMethod -Uri $repoUrl -Method Post -Headers $headers -Body $repoBody -ContentType 'application/json'

                Write-Output "Repository created successfully: $($repo.html_url)"

                # Configure branch protection (if main branch exists)
                if ($PSCmdlet.ShouldProcess("main branch", "Configure branch protection")) {
                    Start-Sleep -Seconds 2  # Give GitHub time to initialize the repo

                    $protectionBody = @{
                        required_status_checks = $null
                        enforce_admins = $true
                        required_pull_request_reviews = @{
                            dismiss_stale_reviews = $true
                            require_code_owner_reviews = $false
                            required_approving_review_count = 1
                        }
                        restrictions = $null
                    } | ConvertTo-Json -Depth 10

                    $protectionUrl = "https://api.github.com/repos/$Owner/$RepositoryName/branches/main/protection"

                    Write-Verbose "Configuring branch protection for main branch"
                    try {
                        Invoke-RestMethod -Uri $protectionUrl -Method Put -Headers $headers -Body $protectionBody -ContentType 'application/json' | Out-Null
                        Write-Output "Branch protection configured for main branch"
                    }
                    catch {
                        Write-Warning "Could not configure branch protection: $_"
                    }
                }

                return $repo
            }
        }
        catch {
            Write-Error "Failed to create repository: $_"
            throw
        }
    }

    end {
        Write-Verbose "Completed New-GHProject function"
    }
}

function Get-GitHubAuthenticatedUser {
    <#
    .SYNOPSIS
        Retrieves the authenticated GitHub user's login name.

    .DESCRIPTION
        This helper function queries the GitHub API to get the login name of the user
        associated with the provided GitHub token. This is used internally to determine
        whether to create a repository under a user account or an organization.

    .PARAMETER Token
        GitHub personal access token with appropriate permissions.

    .OUTPUTS
        System.String
        Returns the login name of the authenticated GitHub user.

    .EXAMPLE
        Get-GitHubAuthenticatedUser -Token $token
        Returns the login name of the user associated with the provided token.

    .NOTES
        This is an internal helper function used by New-GHProject.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Token
    )

    # Set up headers for GitHub API authentication
    $headers = @{
        'Authorization' = "token $Token"
        'Accept' = 'application/vnd.github.v3+json'
    }

    try {
        # Query GitHub API for authenticated user information
        $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
        return $user.login
    }
    catch {
        throw "Failed to get authenticated user: $_"
    }
}
