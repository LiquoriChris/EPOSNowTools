$Path = Split-Path -Parent $PSScriptRoot
. "$Path\Private\Common.ps1"

function Get-EposNowProduct {
<#
	.Synopsis
		Get products from EPOS Now API.

	.Description
        This function will return all products in the EPOS system except when using the Id variable
        which will return the specified products matching the unique Id.

    .PARAMETER Id
        int parameter. Product Id number

	.Example
        Example 1: Return all products
        PS C:\> Get-EposNowProduct

        Example 2: Return products from EPOS Now with unique Id
        PS C:\> Get-EposNowProduct -Id 348472,312384
#>

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline,
                   Position = 0)]
        [int]$Id,
        [Parameter(Position = 1)]
        [int]$Page
    )

    Begin {

    }
    Process {
        Try {
            $Params = @{
                Area = 'product'
            }
            if ($Id) {
                $Params.Id = $Id
            }
            if ($Page) {
                $Params.Page = $Page
            }
            $Response = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Response
    }
}

Export-ModuleMember Get-EposNowProduct