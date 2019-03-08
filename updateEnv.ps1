param(
    [Alias('l')]
    [Parameter(Mandatory=$False)]
    [Switch] $SymLink = $False,

    [Parameter(Mandatory=$False)]
    [Switch] $BumpMajor = $False,

    [Parameter(Mandatory=$False)]
    [Switch] $BumpMinor = $False,

    [Parameter(Mandatory=$False)]
    [Switch] $BumpPatch = $False,

    [Alias('n')]
    [Parameter(Mandatory=$False)]
    [Switch] $DryRun = $False
)

$version_regex = '("version"\s*:\s*")((?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+))"'

$version_info = Get-Content .\info.json |
    # %{$_ -split "\n"} |
    %{if ($_ -match $version_regex) { [PSCustomObject]$Matches }} |
    Select-Object -Property @{Name="Major"; Expression = {[int]($_.Major)}},
                            @{Name="Minor"; Expression = {[int]($_.Minor)}},
                            @{Name="Patch"; Expression = {[int]($_.Patch)}}

Write-Host "Version: $($version_info.Major).$($version_info.Minor).$($version_info.Patch)"

if ($BumpMajor -or $BumpMinor -or $BumpPatch) {
    Write-Host "Performing Version Bump"
    if ($BumpMajor) { $version_info.Major = $version_info.Major + 1 }
    if ($BumpMinor) { $version_info.Minor = $version_info.Minor + 1 }
    if ($BumpPatch) { $version_info.Patch = $version_info.Patch + 1 }
    # $version_info = 

    Write-Host "New Version: $($version_info.Major).$($version_info.Minor).$($version_info.Patch)"

    (Get-Content .\info.json) -replace $version_regex, "`"version`": `"$($version_info.Major).$($version_info.Minor).$($version_info.Patch)`"" |
        Out-File .\info.json -Encoding utf8
}

$mod_name = Get-Content .\info.json | ForEach-Object {if ($_ -match '"name"\s*:\s*"([^"]+)"') { $Matches[1] }}
$old_mods = (Get-ChildItem ..\ | ForEach-Object {if ($_ -match $mod_name) { $_.FullName }})

foreach ($old_mod in $old_mods) {
    Write-Host "Removing: $old_mod"
    if (-not $DryRun) {
        # Remove-Item -Recurse -Force $old_mod
    }
}

Write-Host "Linking mod..."
if (-not $DryRun) {
    New-Item -ItemType Junction -Target ./ -Name "../../mods/$($mod_name)_$($version_info.Major).$($version_info.Minor).$($version_info.Patch)"
}

