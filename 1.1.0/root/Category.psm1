$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowCategory {
<#
	.Synopsis
		Get Categorys from EPOS Now API.

	.Description
        This function will return all Categorys in the EPOS system except when using the Id variable
        which will return the specified Categorys matching the unique Id.

    .PARAMETER Id
        int parameter. Category Id number

	.Example
        Example 1: Return all Categorys
        PS C:\> Get-EposNowCategory

        Example 2: Return Categorys from EPOS Now with unique Id
        PS C:\> Get-EposNowCategory -Id 348472,312384
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
                Area = 'category'
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

function Remove-EposNowCategory {
<#
    .Synopsis
        Remove Categorys from EPOS Now API.

    .Description
        This function will remove a Category from the EPOS Now system using the unique Id number

    .PARAMETER Id
        int mandatory parameter. Category Id number

    .Example
        Example 1: Delete a Category
        PS C:\> Remove-EposNowCategory -Id 348472

        Example 2: Delete Categorys using the pipeline
        PS C:\> Get-EposNowCategory -Id 348472 |Remove-EposNowProduct
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
        $Body = @{
            Id = $Id
        } |ConvertTo-Json -AsArray
        Try {
            $Params = @{
                Area = 'category'
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

function Update-EposNowCategory {
<#
    .Synopsis
        Updates Categorys from EPOS Now API.

    .Description
        This function will update a Category from the EPOS Now system

    .PARAMETER InFile
        string InFile parameter. Json file to update Category.

    .PARAMETER Body
        string Body parameter. Json body.

    .Example
        Example 1: Update a Category
        PS C:\> Update-EposNowCategory -Body $Body

    .NOTES 
        If using body parameter. convert body using ConvertTo-Json -AsArray to put in correct formet
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
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
                Area = 'category'
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

function New-EposNowCategory {
<#
    .Synopsis
        Creates Categorys from EPOS Now API.

    .Description
        This function will Create a Category from the EPOS Now system

    .PARAMETER InFile
        string InFile parameter. Json file to Create Category.

    .PARAMETER Body
        string Body parameter. Json body.

    .Example
        Example 1: Create a Category
        PS C:\> Create-EposNowCategory -Body $Body

    .NOTES 
        If using body parameter. convert body using ConvertTo-Json -AsArray to put in correct formet
#>

    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
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
                Area = 'category'
                ContentType = 'application/json'
                Method = 'Post'
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