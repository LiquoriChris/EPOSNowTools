$Path = Get-ChildItem -Path $PSScriptRoot\root\Public
foreach ($Item in $Path) {
    . $Item.FullName
}