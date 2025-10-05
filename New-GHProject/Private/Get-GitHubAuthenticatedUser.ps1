function Get-GitHubAuthenticatedUser {
    param(
        # The GitHub personal access token, required for authentication
        [Parameter(Mandatory = $true)]
        [string]$Token
    )

    # Set up the HTTP headers for the API request, including authorization and accepted response format
    $headers = @{
        'Authorization' = "token $Token"
        'Accept' = 'application/vnd.github.v3+json'
    }

    try {
        # Send a GET request to GitHub's API to retrieve the authenticated user's information
        $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers

        # Return the login name (username) of the authenticated user
        return $user.login
    }
    catch {
        # If there is an error (e.g., invalid token), throw a descriptive error message
        throw "Failed to get authenticated user: $_"
    }
}
