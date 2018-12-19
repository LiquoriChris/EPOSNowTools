function _RequestUri {
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline,
                   Position = 0)]
        [string]$Area,
        [Parameter(Position = 1)]
        [int]$Id,
        [Parameter(Position = 2)]
        [string]$Page
    )

    Begin {
        $UrlBuilder = New-Object -TypeName System.Text.StringBuilder
        $UrlBuilder.Append('https://api.eposnowhq.com/api/V4') |Out-Null
    }
    Process {
        if ($Area) {
            $UrlBuilder.Append("/$Area") |Out-Null
        }
        if ($Id) {
            $UrlBuilder.Append("/$Id") |Out-Null
        }
        if ($Resource) {
            $UrlBuilder.Append("?page=$Page")
        }
        $Url = $UrlBuilder.ToString()
    }
    End {
        return $Url
    }
}

function _ApiCall {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Area,
        [int]$Id,
        [int]$Page,
        [string]$Method,
        [object]$Body,
        [string]$ContentType = 'application/json',
        [string]$Url
    )
    
    Begin {

    }
    Process {
        Try {
            if (!$Url) {
                $UrlBuildParams = @{} + $PSBoundParameters
                $Remove = 'Method','Body','ContentType','Url'
                foreach ($Item in $Remove) {
                    $UrlBuildParams.Remove($Item) |Out-Null
                }
                $Url = _RequestUri @UrlBuildParams
            }
            $Params = $PSBoundParameters
            $Params.Uri = $Url
            $Params.Headers = @{Authorization = "Basic $env:Access_Token"}
            $Remove = 'Area','Id','Url','Page'
            foreach ($Item in $Remove) {
                $Params.Remove($Item) |Out-Null
            }
            $Reponse = Invoke-RestMethod @Params
        }
        Catch {
            throw $_
        }
    }    
    End {
        return $Reponse
    }
}   