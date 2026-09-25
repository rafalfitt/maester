function Test-MtEntraConnectSpCredentials {
    <#
    .SYNOPSIS
    Checks if Entra Connect Sync is configured with Service Principal credentials.

    .DESCRIPTION
    Entra Connect Sync should use a Service Principal with certificate-based authentication instead of
    a user account with password. This test verifies that the sync service uses a Service Principal.

    .EXAMPLE
    Test-MtEntraConnectSpCredentials

    Returns true if Entra Connect Sync uses a Service Principal with certificate.

    .LINK
    https://maester.dev/docs/commands/Test-MtEntraConnectSpCredentials
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get on-premises sync configuration
        $syncProfiles = @(Invoke-MtGraphRequest -RelativeUri 'onPremisesPublishingProfiles' -ErrorAction Stop)

        $usesSp = $false

        foreach ($profile in $syncProfiles) {
            if ($profile.type -eq 'passwordHashSync' -or $profile.type -eq 'passwordWriteback') {
                # Check if the profile uses a service principal
                if ($profile.servicePrincipalId) {
                    $sp = Invoke-MtGraphRequest -RelativeUri "servicePrincipals/$($profile.servicePrincipalId)?$select=id,appId,keyCredentials" -ErrorAction SilentlyContinue
                    if ($sp -and $sp.keyCredentials.Count -gt 0) {
                        $usesSp = $true
                    }
                }
            }
        }

        $return = $usesSp

        if ($return) {
            $testResultMarkdown = 'Well done. Entra Connect Sync uses a Service Principal with certificate-based authentication.'
        } else {
            $testResultMarkdown = 'Entra Connect Sync does not appear to use a Service Principal with certificate-based authentication. It may be using a user account with password, which is less secure.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}