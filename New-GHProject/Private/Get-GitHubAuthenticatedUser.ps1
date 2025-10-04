function Get-GitHubAuthenticatedUser {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Token
    )

    $headers = @{
        'Authorization' = "token $Token"
        'Accept' = 'application/vnd.github.v3+json'
    }

    try {
        $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
        return $user.login
    }
    catch {
        throw "Failed to get authenticated user: $_"
    }
}
