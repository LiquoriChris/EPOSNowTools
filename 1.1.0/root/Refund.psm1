$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowRefundReason {
<#
	.Synopsis
		Get refund reasons from EPOS Now API.

	.Description
        This function will return all refund reasons in the EPOS system except when using the Id variable
        which will return the specified refund reason matching the unique Id.

    .PARAMETER Id
        int parameter. Refund reason Id number

	.Example
        Example 1: Return all refund reason
        PS C:\> Get-EposNowRefundReason

        Example 2: Return refund reason from EPOS Now with unique Id
        PS C:\> Get-EposNowRefundReason -Id 348472,343459
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
                Area = 'RefundReason'
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

function Remove-EposNowRefundReason {
<#
    .Synopsis
        Remove refund reasons from EPOS Now API.

    .Description
        This function will remove a refund reason in the EPOS system

    .PARAMETER Id
        int parameter. Refund reason Id number

    .Example
        Example 2: Return refund reason from EPOS Now with unique Id
        PS C:\> Remove-EposNowRefundReason -Id 348472
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName,
                   ValueFromPipeline,
                   Position = 0)]
        [int]$Id
    )

    Begin {

    }
    Process {
        Try {
            $Body = @{
                Id = $Id
            } |ConvertTo-Json -AsArray
            $Params = @{
                Area = 'RefundReason'
                Body = $Body
                Method = 'Delete'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
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