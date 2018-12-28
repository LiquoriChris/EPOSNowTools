$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowDiscountReason {
<#
	.Synopsis
		Get discount reasons from EPOS Now API.

	.Description
        This function will return all discount reasons in the EPOS system except when using the Id variable
        which will return the specified discount reason matching the unique Id.

    .PARAMETER Id
        int parameter. discount reason Id number

	.Example
        Example 1: Return all discount reason
        PS C:\> Get-EposNowDiscountReason

        Example 2: Return discount reason from EPOS Now with unique Id
        PS C:\> Get-EposNowDiscountReason -Id 348472,343459
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
                Area = 'DiscountReason'
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

function Remove-EposNowDiscountReason {
<#
    .Synopsis
        Remove discount reasons from EPOS Now API.

    .Description
        This function will remove a discount reason in the EPOS system

    .PARAMETER Id
        int parameter. discount reason Id number

    .Example
        Example 2: Return discount reason from EPOS Now with unique Id
        PS C:\> Remove-EposNowDiscountReason -Id 348472
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
                Area = 'DiscountReason'
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

function New-EposNowDiscountReason {
<#
    .Synopsis
        Create discount reasons from EPOS Now API.

    .Description
        This function will create a discount reason in the EPOS system

    .PARAMETER Id
        int parameter. discount reason Id number

    .Example
        Example 2: Return discount reason from EPOS Now with unique Id
        PS C:\> New-EposNowDiscountReason -Id 348472
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                    ValueFromPipeline,
                    Position = 0)]
        [string]$Name,
        [Parameter(Mandatory,
                   Position = 1)]
        [alias('Percent')]
        [int]$Discount
    )

    Begin {

    }
    Process {
        Try {
            $Body = @{
                Name = $Name
                DefaultPercentage = $Discount
            } |ConvertTo-Json -AsArray
            $Params = @{
                Area = 'DiscountReason'
                Body = $Body
                Method = 'Post'
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