param(
    [Parameter(Mandatory = $true)]
    [string] $Tag,

    [string] $Repository = $env:GITHUB_REPOSITORY,

    [string] $ManifestPath = '.\dist\dev\TugOfWar\TugOfWar.json',

    [string] $PackagePath = '.\dist\dev\TugOfWar\latest.zip',

    [string] $OutputPath = '.\pluginmaster.json'
)

$ErrorActionPreference = 'Stop'

if ($Tag -notmatch '^v\d+(\.\d+){3}$') {
    throw "Release tag '$Tag' must use the form v1.2.3.4."
}

if ([string]::IsNullOrWhiteSpace($Repository)) {
    throw 'Repository must be in OWNER/REPO format.'
}

if (-not (Test-Path -LiteralPath $ManifestPath)) {
    throw "Plugin manifest not found: $ManifestPath"
}

if (-not (Test-Path -LiteralPath $PackagePath)) {
    throw "Plugin package not found: $PackagePath"
}

$tagVersion = $Tag.Substring(1)
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
if ($manifest.AssemblyVersion -ne $tagVersion) {
    throw "Tag version $tagVersion does not match plugin AssemblyVersion $($manifest.AssemblyVersion). Update TugOfWar.json before tagging a release."
}

$entry = [ordered]@{}
foreach ($property in $manifest.PSObject.Properties) {
    $entry[$property.Name] = $property.Value
}

$packageUrl = "https://github.com/$Repository/releases/latest/download/latest.zip"
$entry['TestingAssemblyVersion'] = $manifest.AssemblyVersion
$entry['IsHide'] = $false
$entry['IsTestingExclusive'] = $false
$entry['DownloadLinkInstall'] = $packageUrl
$entry['DownloadLinkTesting'] = $packageUrl
$entry['DownloadLinkUpdate'] = $packageUrl
$entry['LastUpdate'] = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds().ToString()

ConvertTo-Json -InputObject @($entry) -Depth 20 | Set-Content -LiteralPath $OutputPath -Encoding utf8NoBOM
