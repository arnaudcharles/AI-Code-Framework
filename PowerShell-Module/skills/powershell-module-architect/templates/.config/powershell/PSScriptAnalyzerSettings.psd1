@{
    Severity     = @('Error', 'Warning')
    ExcludeRules = @(
        # Document any exclusion here with a reason before adding it.
    )
    Rules        = @{
        PSUseCompatibleSyntax     = @{
            Enable         = $true
            TargetVersions = @('7.4')
        }
        PSAvoidUsingWriteHost     = @{ Enable = $true }
        PSAvoidUsingCmdletAliases = @{ Enable = $true }
        PSUseShouldProcessForStateChangingFunctions = @{ Enable = $true }
    }
}
