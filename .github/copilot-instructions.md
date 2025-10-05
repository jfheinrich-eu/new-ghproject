# GitHub Copilot Instructions

## Project Overview
This repository provides a PowerShell module to create GitHub repositories with proper branch setup and protection rules.

## Code Style and Standards

### PowerShell Guidelines
- Follow PowerShell best practices and the PowerShell Style Guide
- Use approved PowerShell verbs for function names (Get-, Set-, New-, Remove-, etc.)
- Write clear, descriptive parameter names using PascalCase
- Include proper comment-based help for all functions
- Use `[CmdletBinding()]` for advanced functions
- Handle errors gracefully with try-catch blocks where appropriate
- Use parameter validation attributes (`[ValidateNotNullOrEmpty()]`, etc.)

### Code Organization
- Keep functions focused and single-purpose
- Use meaningful variable names
- Add inline comments for complex logic
- Group related functions together

### Documentation
- Include comment-based help with .SYNOPSIS, .DESCRIPTION, .PARAMETER, and .EXAMPLE
- Update README.md when adding new features
- Document any prerequisites or dependencies

### Testing
- Write Pester tests for all functions
- Include both positive and negative test cases
- Test edge cases and error conditions

### Git and GitHub
- Write clear, descriptive commit messages
- Use conventional commit format when possible (feat:, fix:, docs:, etc.)
- Keep changes focused and atomic
- Reference issues in commit messages when applicable

## Project-Specific Considerations
- This module interacts with the GitHub API
- Ensure proper authentication handling
- Handle rate limiting gracefully
- Validate repository names and settings before making API calls
- Provide helpful error messages for common failure scenarios
