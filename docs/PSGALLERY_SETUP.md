# PowerShell Gallery Setup Guide

This guide will help you set up automated publishing to the PowerShell Gallery.

## Prerequisites

1. **PowerShell Gallery Account**
   - Create an account at https://www.powershellgallery.com/
   - Verify your email address

2. **API Key**
   - Go to https://www.powershellgallery.com/account/apikeys
   - Click "Create"
   - Set a descriptive name (e.g., "GitHub Actions - New-GHProject")
   - Set expiration date or leave blank for no expiration
   - Select scope: "Push new packages and package versions"
   - Click "Create"
   - **Copy the API key immediately** (you won't be able to see it again)

## Setting Up GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `PSGALLERY_API_KEY`
5. Value: Paste your PowerShell Gallery API key
6. Click **Add secret**

## Publishing Methods

### Method 1: Automatic Publishing on Release (Recommended)

The module is automatically published when you create a release:

1. Update the version in `New-GHProject/New-GHProject.psd1`
2. Update `CHANGELOG.md` with release notes
3. Commit and push changes
4. Create a new release on GitHub:
   - Go to **Releases** → **Create a new release**
   - Tag version: `vX.Y.Z` (e.g., `v1.0.0`)
   - Release title: `Version X.Y.Z`
   - Description: Copy from CHANGELOG.md
   - Click **Publish release**
5. The workflow will automatically publish to PowerShell Gallery

### Method 2: Manual Publishing

You can manually trigger publishing:

1. Go to **Actions** tab
2. Select **Publish to PowerShell Gallery** workflow
3. Click **Run workflow**
4. Enter the version number (e.g., `1.0.0`)
5. Click **Run workflow**

## Verifying Publication

After publishing:

1. Wait a few minutes for processing
2. Visit https://www.powershellgallery.com/packages/New-GHProject
3. Verify the version is listed
4. Test installation:
   ```powershell
   Install-Module -Name New-GHProject -Force
   Get-Module -Name New-GHProject -ListAvailable
   ```

## Versioning Guidelines

Follow [Semantic Versioning](https://semver.org/):

- **Major version** (X.0.0): Breaking changes
- **Minor version** (0.X.0): New features, backwards compatible
- **Patch version** (0.0.X): Bug fixes, backwards compatible

### Version Update Checklist

- [ ] Update `ModuleVersion` in `New-GHProject.psd1`
- [ ] Update `CHANGELOG.md` with changes
- [ ] Update `ReleaseNotes` in manifest (optional)
- [ ] Run all tests locally
- [ ] Create GitHub release with tag `vX.Y.Z`

## Troubleshooting

### Publication Fails with "API Key Invalid"

- Verify the secret `PSGALLERY_API_KEY` is set correctly
- Check if the API key has expired
- Ensure the key has "Push" permissions

### Publication Fails with "Version Already Exists"

- You cannot republish the same version
- Increment the version number in the manifest
- Create a new release with a new tag

### Module Not Found After Publishing

- Wait 5-10 minutes for PowerShell Gallery to index
- Clear your PowerShell Gallery cache:
  ```powershell
  Unregister-PSRepository -Name PSGallery
  Register-PSRepository -Default
  ```

### Workflow Doesn't Trigger

- Ensure the release tag starts with `v` (e.g., `v1.0.0`)
- Check workflow permissions in Settings → Actions → General
- Verify the workflow file is in `.github/workflows/`

## Best Practices

1. **Test Before Publishing**
   - Always run tests locally before creating a release
   - Verify the module imports correctly
   - Test on multiple platforms if possible

2. **Version Management**
   - Keep version numbers consistent across files
   - Never skip versions
   - Document all changes in CHANGELOG.md

3. **Release Notes**
   - Include clear, user-friendly release notes
   - Highlight breaking changes prominently
   - Provide migration guides for major versions

4. **Security**
   - Never commit API keys to the repository
   - Rotate API keys periodically
   - Use repository secrets for sensitive data

## Resources

- [PowerShell Gallery Publishing Guide](https://docs.microsoft.com/en-us/powershell/gallery/how-to/publishing-packages/publishing-a-package)
- [Semantic Versioning](https://semver.org/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
