# Release Workflow Documentation

## Overview

This repository uses an automated release workflow based on PR labels. When a pull request is merged to the main/master branch, the CI/CD workflow automatically handles versioning, tagging, and release creation based on the labels applied to the PR.

## Release Labels

### Available Labels

1. **skip release** - Skip all release and tagging steps
2. **major release** - Create a major version bump (e.g., 1.0.0 → 2.0.0)
3. **minor release** - Create a minor version bump (e.g., 1.0.0 → 1.1.0)
4. **patch release** - Create a patch version bump (e.g., 1.0.0 → 1.0.1)

### How to Use

1. Create a pull request with your changes
2. The PR will be automatically labeled based on changed files (e.g., `powershell`, `documentation`, `ci`)
3. Manually add ONE of the release labels to indicate the release type:
   - Add `major release` for breaking changes or major new features
   - Add `minor release` for new features that are backwards compatible
   - Add `patch release` for bug fixes and minor improvements
   - Add `skip release` if the changes don't require a release (e.g., documentation updates)
4. Merge the PR when ready

## Workflow Behavior

### On Pull Request

- **Auto-labeling**: The labeler action automatically adds labels based on which files were changed
- **Testing**: All tests and linting checks run automatically

### On Merge to Main/Master

1. **Tests run**: All tests and linting checks must pass
2. **Release job executes**:
   - Checks the merged PR for release labels
   - If `skip release` label is present: workflow stops, no release is created
   - If a release label is present:
     - Reads current version from `New-GHProject/New-GHProject.psd1`
     - Calculates new version based on label type
     - Updates the module manifest with new version
     - Commits the version change
     - Creates a git tag (e.g., `v1.2.3`)
     - Creates a GitHub release
3. **Publish workflow triggers**: The GitHub release automatically triggers the publish workflow to deploy to PowerShell Gallery

## Version Numbering

The workflow follows semantic versioning (MAJOR.MINOR.PATCH):

- **Major**: Incompatible API changes (resets minor and patch to 0)
- **Minor**: Backwards-compatible new functionality (resets patch to 0)
- **Patch**: Backwards-compatible bug fixes

### Examples

Current version: `1.5.3`

- `major release` → `2.0.0`
- `minor release` → `1.6.0`
- `patch release` → `1.5.4`
- `skip release` → No version change

## Automatic Labels

The following labels are automatically added based on file changes:

- `powershell` - Changes to .ps1, .psm1, or .psd1 files
- `documentation` - Changes to .md files or docs/ directory
- `ci` - Changes to workflow files
- `test` - Changes to test files
- And many more (see `.github/labeler.yml`)

## Important Notes

1. **Only one release label** should be added per PR. If multiple release labels are present, the workflow will use this priority: major > minor > patch
2. **The skip release label** takes precedence over all other release labels
3. **Direct pushes** to main/master without a PR will not trigger releases (no PR labels to check)
4. **Manual releases** can still be created using the publish workflow's manual trigger
5. **Version conflicts**: Ensure the version in the manifest is up to date before merging

## Troubleshooting

### No release was created after merge

- Check if the PR had a release label (not just `skip release`)
- Verify that tests passed before the release job ran
- Check the workflow logs in the Actions tab

### Wrong version was created

- Ensure the correct release label was applied to the PR
- Verify that only one release label was present
- Check that the base version in the manifest was correct

### Release job failed

- Check the Actions tab for detailed error logs
- Common issues:
  - Missing permissions
  - Git conflicts
  - Invalid manifest file
