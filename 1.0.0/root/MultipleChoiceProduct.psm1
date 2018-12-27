$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowMultipleChoiceProdctGroup {
<#
	.Synopsis
		Get multiple choice product groups from EPOS Now API.

	.Description
        This function will return all multiple choice product groups in the EPOS system unless using the Id parameter
        which will return the specified multiple choice product group matching the unique Id.

    .PARAMETER Id
        int parameter. Multiple Choice Product Group Id number

	.Example
        Example 1: Return all multiple choice product groups
        PS C:\> Get-EposNowMultipleChoiceProductGroup

        Example 2: Return multiple choice product group from EPOS Now with unique Id
        PS C:\> Get-EposNowMultipleChoiceProductGroup -Id 348472
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
                Area = 'MultipleChoiceProduct'
                ErrorAction = 'Stop'
            }
            if ($Id) {
                $Params.Resource = "Group/$Id"
            }
            else {
                $Params.Resource = 'Group'
            }
            $Reponse = _APICall @Params |ConvertTo-JsonEx -AsArray -Depth 100
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Get-EposNowMultipleChoiceProdctByProductId {
<#
    .Synopsis
        Get multiple choice product group from product Id from EPOS Now API.

    .Description
        This function will return the multiple choice product if a product has a multiple choice product 
        group exists

    .PARAMETER Id
        int parameter. Product Id to find multiple choice product group

    .Example
        Example 1: Return all multiple choice product group by product id
        PS C:\> Get-EposNowMultipleChoiceProductGroupByProductId -Id 348472

        Example 2: Return all multiple choice product group by product id using pipeline
        PS C:\> Get-EposNowProduct -Id 439582 |Get-EposNowMultipleChoiceProductGroupByProductId
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
                Area = 'MultipleChoiceProduct'
                Resource = $Id
                ErrorAction = 'Stop'
            }
            $Reponse = _APICall @Params |ForEach-Object {
                $Props = @{
                    ProductId = $_.ProductId
                    Id = $_.Groups.Id
                    Name = $_.Groups.Name
                }
                New-Object -TypeName PSObject -Property $Props
            }
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Get-EposNowMultipleChoiceProduct {
    <#
        .Synopsis
            Get multiple choice product group from product Id from EPOS Now API.
    
        .Description
            This function will return the multiple choice product if a product has a multiple choice product 
            group exists
    
        .PARAMETER Id
            int parameter. Product Id to find multiple choice product group
    
        .Example
            Example 1: Return all multiple choice product group by product id
            PS C:\> Get-EposNowMultipleChoiceProductGroupByProductId -Id 348472
    
            Example 2: Return all multiple choice product group by product id using pipeline
            PS C:\> Get-EposNowProduct -Id 439582 |Get-EposNowMultipleChoiceProductGroupByProductId
    #>
    
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipelineByPropertyName,
                       ValueFromPipeline,
                       Position = 0)]
            [int]$Id
        )
    
        Begin {
    
        }
        Process {
            Try {
                $Params = @{
                    Area = 'MultipleChoiceProduct'
                    ErrorAction = 'Stop'
                }
                $Reponse = _APICall @Params |ForEach-Object {
                    $Props = @{
                        ProductId = $_.ProductId
                        Id = $_.Groups.Id
                        Name = $_.Groups.Name
                    }
                    New-Object -TypeName PSObject -Property $Props
                }
            }
            Catch {
                throw $_
            }
        }
        End {
            return $Reponse
        }
    }

function Add-EposNowMultipleChoiceProductGroupToProduct {
<#
    .Synopsis
        Add multiple choice product group to a product

    .Description
        This function will add multiple choice product groups to a product using the product Id and group Id

    .PARAMETER Id
        int parameter. Multiple choice product group Id

    .PARAMETER ProductId
        int parameter. Product Id to add a multiple choice product group

    .Example
        Example 1: Add a multiple choice product group to a product
        PS C:\> Add-EposNowMultipleChoiceProductGroupToProduct -Id 4549384 -ProductId 13433

        Example 2: Add a multiple choice product group to a product using the pipeline
        PS C:\> Get-EposNowMultipleChoiceProductGroup -Id 439582 |
        Add-EposNowMultipleChoiceProductGroupToProduct -ProductId 1293432
#>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName,
                   ValueFromPipeline,
                   Position = 0)]
        [int[]]$Id,
        [Parameter(Mandatory,
                   Position = 1)]
        [int]$ProductId
    )

    Begin {

    }
    Process {
        Try {
            $Body = @{
                ProductId = $ProductId
                GroupIds = @($Id)
            } |ConvertTo-Json
            $Params = @{
                Area = 'MultipleChoiceProduct'
                Resource = 'AddGroupsToProduct'
                Body = $Body
                Method = 'Post'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
            }
            $Reponse = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Remove-EposNowMultipleChoiceProductGroupToProduct {
<#
    .Synopsis
        Remove multiple choice product group to a product

    .Description
        This function will Remove multiple choice product groups to a product using the product Id and group Id

    .PARAMETER Id
        int parameter. Multiple choice product group Id

    .PARAMETER ProductId
        int parameter. Product Id to Remove a multiple choice product group

    .Example
        Example 1: Remove a multiple choice product group to a product
        PS C:\> Remove-EposNowMultipleChoiceProductGroupToProduct -Id 4549384 -ProductId 13433

        Example 2: Remove a multiple choice product group to a product using the pipeline
        PS C:\> Get-EposNowMultipleChoiceProductGroup -Id 439582 |
        Remove-EposNowMultipleChoiceProductGroupToProduct -ProductId 1293432
#>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory,
                    ValueFromPipelineByPropertyName,
                    ValueFromPipeline,
                    Position = 0)]
        [int[]]$Id,
        [Parameter(ValueFromPipelineByPropertyName,
                   Mandatory,
                   Position = 1)]
        [int]$ProductId
    )

    Begin {

    }
    Process {
        Try {
            $Body = @{
                ProductId = $ProductId
                GroupIds = @($Id)
            } |ConvertTo-Json
            $Params = @{
                Area = 'MultipleChoiceProduct'
                Resource = 'RemoveGroupsToProduct'
                Body = $Body
                Method = 'Post'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
            }
            $Reponse = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Add-EposNowProductToMultipleChoiceProductGroup {
<#
    .Synopsis
        Add product to a multiple choice product group

    .Description
        This function will add a product to a multiple choice product groups using the product Id and group Id

    .PARAMETER Body
        string parameter. Json body to update prodcuts in a multiple choice product group

    .PARAMETER InFile
        string InFile. Path to json file to update products in a multiple choice product group

    .Example
        Example 1: Add a product to a multiple choice product group using body
        PS C:\> Add-EposNowProductToMultipleChoiceProductGroup -Body $Body

        Example 2: Add a product to a multiple choice product group using InFile
        PS C:\> $Get = Get-EposNowMultipleChoiceProdctGroup -Id 14331 |Set-Content C:\temp\mcpg.json
                Add-EposNowProductToMultipleChoiceProductGroup -InFile C:\temp\mcpg.json
#>

    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline,
                    Position = 0)]
        [string]$InFile,
        [Parameter(Position = 1)]
        [string]$Body
    )

    Begin {

    }
    Process {
        Try {
            $Params = @{
                Area = 'MultipleChoiceProduct'
                Resource = 'Group'
                Method = 'Put'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
            }
            if ($InFile) {
                $Params.InFile = $InFile
            }
            if ($Body) {
                $Params.Body = $Body
            }
            $Reponse = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Update-EposNowMultipleChoiceProductGroup {
<#
    .Synopsis
        Update product to a multiple choice product group

    .Description
        This function will update a product to a multiple choice product groups using the product Id and group Id

    .PARAMETER Body
        string parameter. Json body to update prodcuts in a multiple choice product group

    .PARAMETER InFile
        string InFile. Path to json file to update products in a multiple choice product group

    .Example
        Example 1: Update a product to a multiple choice product group using body
        PS C:\> Update-EposNowProductToMultipleChoiceProductGroup -Body $Body

        Example 2: Update a product to a multiple choice product group using InFile
        PS C:\> $Get = Get-EposNowMultipleChoiceProdctGroup -Id 14331 |Set-Content C:\temp\mcpg.json
                Update-EposNowProductToMultipleChoiceProductGroup -InFile C:\temp\mcpg.json
#>

    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline,
                    Position = 0)]
        [string]$InFile,
        [Parameter(Position = 1)]
        [string]$Body
    )

    Begin {

    }
    Process {
        Try {
            $Params = @{
                Area = 'MultipleChoiceProduct'
                Resource = 'Group'
                Method = 'Put'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
            }
            if ($InFile) {
                $Params.InFile = $InFile
            }
            if ($Body) {
                $Params.Body = $Body
            }
            $Reponse = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}

function Remove-EposNowMultipleChoiceProductGroup {
<#
    .Synopsis
        Remove product to a multiple choice product group

    .Description
        This function will Remove a product to a multiple choice product groups using the product Id and group Id

    .PARAMETER Id
        Mandatory int parameter. Unique id number of the multiple choice product group to remove

    .Example
        Example 1: Remove a multiple choice product group
        PS C:\> Remove-EposNowProductToMultipleChoiceProductGroup -Id

        Example 2: Remove a multiple choice product group using pipeline
        PS C:\> Get-EposNowMultipleChoiceProductGroup -Id 34920 |Remove-EposNowMultiplieChoiceProductGroup
#>

    [CmdletBinding()]
    Param (
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
                id = $Id
            } |ConvertTo-JsonEx -AsArray
            $Params = @{
                Area = 'MultipleChoiceProduct'
                Resource = 'Group'
                Body = $Body
                Method = 'Delete'
                ContentType = 'application/json'
                ErrorAction = 'Stop'
            }
            $Reponse = _APICall @Params
        }
        Catch {
            throw $_
        }
    }
    End {
        return $Reponse
    }
}