<#
.SYNOPSIS
    PSScriptAnalyzer configuration for New-GHProject module.

.DESCRIPTION
    This configuration file defines the rules and settings for PSScriptAnalyzer,
    the PowerShell code quality and style checking tool. It ensures consistent
    code quality and adherence to PowerShell best practices throughout the project.

    The configuration includes:
    - All default PowerShell Gallery rules
    - Severity levels (Error, Warning, Information)
    - Code formatting rules (braces, indentation, whitespace)
    - Best practice rules (parameter validation, error handling, etc.)

.NOTES
    PSScriptAnalyzer Documentation: https://github.com/PowerShell/PSScriptAnalyzer
    Rule Reference: https://github.com/PowerShell/PSScriptAnalyzer/tree/master/RuleDocumentation
#>

@{
    # Use the PowerShell Gallery rule set as a foundation
    IncludeDefaultRules = $true
    
    # Severity levels to include in analysis
    # Error: Critical issues that must be fixed
    # Warning: Important issues that should be addressed
    # Information: Suggestions for improvement
    Severity = @('Error', 'Warning', 'Information')
    
    # Rules to exclude from analysis (if any)
    # Uncomment individual rules to exclude them from analysis
    ExcludeRules = @(
        # Example: Uncomment to allow Write-Host usage
        # 'PSAvoidUsingWriteHost'
    )
    
    # Custom rules path (empty by default)
    # Add paths to custom rule scripts if needed
    CustomRulePath = @()
    
    # Specific rules to run (in addition to defaults)
    # This list ensures critical best practice rules are enforced
    IncludeRules = @(
        'PSAvoidDefaultValueForMandatoryParameter',
        'PSAvoidDefaultValueSwitchParameter',
        'PSAvoidGlobalAliases',
        'PSAvoidGlobalFunctions',
        'PSAvoidGlobalVars',
        'PSAvoidInvokingEmptyMembers',
        'PSAvoidNullOrEmptyHelpMessageAttribute',
        'PSAvoidOverwritingBuiltInCmdlets',
        'PSAvoidShouldContinueWithoutForce',
        'PSAvoidTrailingWhitespace',
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingComputerNameHardcoded',
        'PSAvoidUsingConvertToSecureStringWithPlainText',
        'PSAvoidUsingDeprecatedManifestFields',
        'PSAvoidUsingEmptyCatchBlock',
        'PSAvoidUsingInvokeExpression',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingPositionalParameters',
        'PSAvoidUsingUsernameAndPasswordParams',
        'PSAvoidUsingWMICmdlet',
        'PSDSCDscExamplesPresent',
        'PSDSCDscTestsPresent',
        'PSDSCReturnCorrectTypesForDSCFunctions',
        'PSDSCStandardDSCFunctionsInResource',
        'PSDSCUseIdenticalMandatoryParametersForDSC',
        'PSDSCUseIdenticalParametersForDSC',
        'PSDSCUseVerboseMessageInDSCResource',
        'PSMisleadingBacktick',
        'PSMissingModuleManifestField',
        'PSPlaceCloseBrace',
        'PSPlaceOpenBrace',
        'PSPossibleIncorrectComparisonWithNull',
        'PSPossibleIncorrectUsageOfAssignmentOperator',
        'PSPossibleIncorrectUsageOfRedirectionOperator',
        'PSProvideCommentHelp',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSReviewUnusedParameter',
        'PSShouldProcess',
        'PSUseApprovedVerbs',
        'PSUseBOMForUnicodeEncodedFile',
        'PSUseCmdletCorrectly',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseLiteralInitializerForHashtable',
        'PSUseOutputTypeCorrectly',
        'PSUseProcessBlockForPipelineCommand',
        'PSUsePSCredentialType',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns',
        'PSUseSupportsShouldProcess',
        'PSUseToExportFieldsInManifest',
        'PSUseUTF8EncodingForHelpFile',
        'PSUseUsingScopeModifierInNewRunspaces'
    )
    
    # Detailed settings for specific rules
    # These configurations fine-tune the behavior of individual rules
    Rules = @{
        # Open brace placement: Same line, new line after
        PSPlaceOpenBrace = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }
        
        # Close brace placement: New line after, allow empty lines before
        PSPlaceCloseBrace = @{
            Enable             = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }
        
        # Indentation: Use spaces (4 spaces per level)
        PSUseConsistentIndentation = @{
            Enable          = $true
            Kind            = 'space'
            IndentationSize = 4
        }
        
        # Whitespace consistency: Enforce spacing around operators and brackets
        PSUseConsistentWhitespace = @{
            Enable          = $true
            CheckOpenBrace  = $true
            CheckOpenParen  = $true
            CheckOperator   = $true
            CheckSeparator  = $true
        }
        
        # Assignment alignment: Align assignments in hashtables
        PSAlignAssignmentStatement = @{
            Enable         = $true
            CheckHashtable = $true
        }
        
        # Correct casing: Enforce proper casing for cmdlets and parameters
        PSUseCorrectCasing = @{
            Enable = $true
        }
    }
}
