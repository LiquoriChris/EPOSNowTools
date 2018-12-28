$Path = Split-Path -Parent $PSScriptRoot
. "$Path\root\Common.ps1"

function Get-EposNowPopupNote {
<#
	.Synopsis
		Get popup notes from EPOS Now API.

	.Description
        This function will return all popup notes in the EPOS system except when using the Id variable
        which will return the specified popup note matching the unique Id.

    .PARAMETER Id
        int parameter. Popup note Id number

	.Example
        Example 1: Return all popup notes
        PS C:\> Get-EposNowPopupNote

        Example 2: Return popup note from EPOS Now with unique Id
        PS C:\> Get-EposNowPopupNote -Id 348472,343459
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
                Area = 'PopupNote'
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

function Remove-EposNowPopupNote {
<#
    .Synopsis
        Remove popup note from EPOS Now API.

    .Description
        This function will remove a popup note in the EPOS system

    .PARAMETER Id
        int parameter. popup note Id number

    .Example
        Example 2: Remove popup note from EPOS Now with unique Id
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
                Area = 'PopupNote'
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

function New-EposNowPopupNote {
<#
    .Synopsis
        Create popup note from EPOS Now API.

    .Description
        This function will create a popup note in the EPOS system

    .PARAMETER Id
        int parameter. popup note Id number

    .Example
        Example 2: Create popup note from EPOS Now with unique Id
        PS C:\> New-PopupNote -Name Note1 -Note 'This is my first note' -DisplayPerTransaction true
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   Position = 0)]
        [string]$Name,
        [Parameter(Mandatory,
                   Position = 1)]
        [string]$Note,
        [Parameter(Position = 2)]
        [ValidateSet('true','false')]
        [string]$DisplayPerTransaction = 'false'
    )

    Begin {

    }
    Process {
        Try {
            $Body = @{
                Name = $Name
                Note = $Note
                DisplayOncePerTransaction = $DisplayPerTransaction
            } |ConvertTo-Json -AsArray
            $Params = @{
                Area = 'PopupNote'
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