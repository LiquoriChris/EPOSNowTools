$Path = Split-Path -Parent $PSScriptRoot
. "$Path\Private\Common.ps1"

function Connect-EposNowAccount {
<#
	.Synopsis
		Connect to EPOS Now API.

	.Description
        This function will authenticate with EPOS Now API and store local environment variable for headers
        to be used in calling the API

    .PARAMETER AccessToken
        Mandatory string parameter. Access token to authenticate with EPOS Now API.

	.Example
        Example 1: Authenticate with EPOS Now
        PS C:\> Connect-EposNowAccount -AccessToken 49183908f9238D29812304F29123
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   HelpMessage = "API token provided after purchasing API app",
                   Position = 0)]
        [string]$AccessToken
    )

    Begin {

    }
    Process {
        Try {
            $env:Access_Token = $AccessToken
            _APICall -Area tokeninfo -Method Get |Out-Null
            Write-Output "Connected to EPOS Now API"
        }
        Catch {
            Write-Error "You have entered an incorrect access token. Please try again"
            Clear-Variable $env:Access_Token
        }
    }
}

Export-ModuleMember Connect-EposNowAccount