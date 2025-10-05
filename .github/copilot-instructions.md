# GitHub Copilot Instructions for New-GHProject

## Language and Documentation Standards

### English-Only Requirement
All code elements must be written in **English only**:
- **Comments**: All inline comments, block comments, and documentation comments
- **String literals**: All user-facing messages, error messages, and output strings
- **Variable names**: All variable, function, and parameter names
- **Documentation**: All README files, help text, and external documentation
- **Commit messages**: All git commit messages and PR descriptions

### Documentation Requirements

#### Comment-Based Help
All public PowerShell functions must include comprehensive comment-based help with:
- `.SYNOPSIS`: Brief one-line description
- `.DESCRIPTION`: Detailed explanation of functionality
- `.PARAMETER`: Description for each parameter
- `.EXAMPLE`: At least one usage example
- `.OUTPUTS`: Return type description (if applicable)
- `.NOTES`: Additional information (author, version, dependencies)

#### Code Comments
- Add comments for complex logic or non-obvious implementations
- Use English for all explanatory comments
- Keep comments concise and meaningful
- Update comments when modifying code
- Avoid redundant comments that simply restate the code

#### Error Messages
- Write all error messages in English
- Make error messages clear and actionable
- Include context about what went wrong
- Suggest potential solutions when appropriate

## Code Style and Best Practices

### PowerShell Conventions
- Use approved PowerShell verbs (check with `Get-Verb`)
- Follow PascalCase for function names and parameters
- Use meaningful, descriptive names in English
- Implement `[CmdletBinding()]` for advanced functions
- Use `ShouldProcess` for functions that make changes
- Include proper error handling with try/catch blocks
- Write verbose output for debugging purposes

### Formatting Standards
- Use 4 spaces for indentation (no tabs)
- Place opening braces on the same line
- Add a new line after opening braces
- Maintain consistent whitespace around operators
- Align assignment statements in hashtables
- Use proper casing for cmdlets and parameters

### Testing Standards
- Write Pester tests for all new functions
- Use descriptive test names in English
- Test both success and failure scenarios
- Include parameter validation tests
- Validate help documentation completeness

### File Organization
- Public functions: `/New-GHProject/Public/`
- Private functions: `/New-GHProject/Private/`
- Tests: `/Tests/`
- Examples: `/Examples/`
- Documentation: Root level and `/docs/`

## GitHub Workflow Guidelines

### Commit Messages
- Write commit messages in English
- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters or less
- Reference issues and PRs in commit body

### Pull Request Labels
Release management is automated based on PR labels:
- `major release`: Breaking changes, major version bump
- `minor release`: New features, minor version bump
- `patch release`: Bug fixes, patch version bump
- `skip release`: Skip release creation
- `documentation`: Documentation-only changes
- `dependencies`: Dependency updates

### Code Review Process
1. Ensure all tests pass
2. Verify PSScriptAnalyzer has no issues
3. Check that all comments and strings are in English
4. Validate documentation is complete and accurate
5. Confirm changes follow project conventions

## Copilot-Specific Guidance

### When Writing Code
1. **Always use English** for all identifiers, comments, and strings
2. **Include comment-based help** for all public functions immediately
3. **Follow existing patterns** in the codebase for consistency
4. **Write tests** alongside new functionality
5. **Document as you code** rather than adding documentation later

### When Suggesting Changes
1. Maintain existing code style and formatting
2. Preserve English-only convention in all suggestions
3. Include updated documentation with code changes
4. Suggest test cases for new functionality
5. Reference related issues or PRs when applicable

### When Fixing Issues
1. Understand the context before suggesting fixes
2. Provide clear explanations in English
3. Consider edge cases and error scenarios
4. Update related documentation if needed
5. Ensure backward compatibility unless it's a breaking change

## Quality Assurance

### Before Committing
- [ ] All code comments are in English
- [ ] All string literals are in English
- [ ] Comment-based help is complete for public functions
- [ ] Variable and function names use English words
- [ ] Tests are written and passing
- [ ] PSScriptAnalyzer shows no issues
- [ ] Documentation is updated
- [ ] Examples are updated if necessary

### Code Analysis
Run PSScriptAnalyzer before committing:
```powershell
Invoke-ScriptAnalyzer -Path ./New-GHProject -Recurse -Settings ./PSScriptAnalyzerSettings.psd1
```

### Testing
Run Pester tests before committing:
```powershell
Invoke-Pester -Path ./Tests -Output Detailed
```

## Additional Resources

- PowerShell Best Practices: https://poshcode.gitbook.io/powershell-practice-and-style/
- PSScriptAnalyzer Rules: https://github.com/PowerShell/PSScriptAnalyzer/tree/master/RuleDocumentation
- Pester Documentation: https://pester.dev/docs/quick-start
- GitHub API Documentation: https://docs.github.com/en/rest

## Resolution Guidelines

When GitHub Copilot identifies issues or suggests improvements:

1. **Language Issues**: Immediately replace any non-English text with English equivalents
2. **Missing Documentation**: Add complete comment-based help following the template
3. **Code Style**: Apply PSScriptAnalyzer fixes or manual formatting corrections
4. **Test Coverage**: Add missing test cases for untested code paths
5. **Error Handling**: Implement proper try/catch blocks with English error messages
6. **Performance**: Optimize code while maintaining readability and English documentation
7. **Security**: Address security concerns with proper validation and secure coding practices

All resolutions and suggestions should maintain the English-only standard throughout the codebase.
