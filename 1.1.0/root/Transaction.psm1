$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowTransaction {
<#
	.Synopsis
		Get transactions from EPOS Now API.

	.Description
        This function will return all transactions in the EPOS system except when using the Id variable
        which will return the specified transaction matching the unique Id.

    .PARAMETER Id
        int parameter. Transaction Id number

	.Example
        Example 1: Return all transactions
        PS C:\> Get-EposNowTransaction

        Example 2: Return a transaction from EPOS Now with unique Id
        PS C:\> Get-EposNowRefundReason -Id 348472
#>

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline,
                Position = 0)]
        [int]$Id
    )

    Begin {

    }
    Process {
        Try {
            $Params = @{
                Area = 'Transaction'
            }
            if ($Id) {
                $Params.Resource = $Id
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