function Test-MtGsaFileTransferPolicies {
    <#
    .SYNOPSIS
    Checks if file transfer policies are configured to prevent data exfiltration.

    .DESCRIPTION
    File transfer policies in Global Secure Access can prevent data exfiltration by controlling
    file uploads/downloads. This test verifies that such policies are configured.

    .EXAMPLE
    Test-MtGsaFileTransferPolicies

    Returns true if file transfer policies are configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaFileTransferPolicies
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA file transfer policies
        $fileTransferPolicies = @(Invoke-MtGraphRequest -RelativeUri 'networkAccess/fileTransferPolicies' -ErrorAction SilentlyContinue)

        $configured = $false

        if ($fileTransferPolicies -and $fileTransferPolicies.Count -gt 0) {
            foreach ($policy in $fileTransferPolicies) {
                if ($policy.isEnabled -eq $true) {
                    $configured = $true
                    break
                }
            }
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. File transfer policies are configured to prevent data exfiltration.'
        } else {
            $testResultMarkdown = 'No file transfer policies configured. File transfer policies can prevent data exfiltration by controlling file uploads/downloads.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}