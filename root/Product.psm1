$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

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

function Remove-EposNowProduct {
<#
    .Synopsis
        Remove products from EPOS Now API.

    .Description
        This function will remove a product from the EPOS Now system using the unique Id number

    .PARAMETER Id
        int mandatory parameter. Product Id number

    .Example
        Example 1: Delete a product
        PS C:\> Delete-EposNowProduct -Id 348472

        Example 2: Delete products using the pipeline
        PS C:\> Get-EposNowProduct -Id 348472,312384 |Remove-EposNowProduct
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
            $Params = @{
                Area = 'product'
                Method = 'Delete'
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

function Update-EposNowProduct {
<#
    .Synopsis
        Updates products from EPOS Now API.

    .Description
        This function will update a product from the EPOS Now system

    .PARAMETER InFile
        string InFile parameter. Json file to update product.

    .PARAMETER Body
        string Body parameter. Json body.

    .Example
        Example 1: Update a product
        PS C:\> Delete-EposNowProduct -Id 348472

        Example 2: Delete products using the pipeline
        PS C:\> Get-EposNowProduct -Id 348472,312384 |Remove-EposNowProduct

    .NOTES 
        If using body parameter. convert body using ConvertTo-JsonEx -AsArray to put in correct formet
#>

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline,
                    Position = 0)]
        [string]$InFile,
        [Parameter(ValueFromPipeline,
                    Position = 1)]
        [string]$Body
    )

    Begin {

    }
    Process {
        Try {
            $Params = @{
                Area = 'product'
                ContentType = 'application/json'
                Method = 'Put'
                ErrorAction = 'Stop'
            }
            if ($Body) {
                $Params.Body = $Body
            }
            if ($InFile) {
                $Params.InFile = $InFile
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