[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$SumFile = Join-Path $Root 'SHA256SUMS.txt'
if (-not (Test-Path -LiteralPath $SumFile)) { throw 'SHA256SUMS.txt가 없습니다.' }

$Failures = [Collections.Generic.List[string]]::new()
foreach ($Line in Get-Content -LiteralPath $SumFile -Encoding UTF8) {
    if ($Line -notmatch '^([0-9a-f]{64})  (.+)$') { continue }
    $Expected = $Matches[1]; $Relative = $Matches[2]
    $Path = Join-Path $Root ($Relative -replace '/', '\')
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { $Failures.Add("누락: $Relative"); continue }
    $Actual = (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($Actual -ne $Expected) { $Failures.Add("해시 불일치: $Relative") }
}

$Main = (Get-FileHash -LiteralPath (Join-Path $Root 'Morrowind_Korean_ReTranslation_v01.esp') -Algorithm SHA256).Hash.ToLowerInvariant()
$Interior = (Get-FileHash -LiteralPath (Join-Path $Root 'Morrowind_Korean_Interior_CellNames_v01.esp') -Algorithm SHA256).Hash.ToLowerInvariant()
if ($Main -ne '52f973e173c037a1010a4fb91aec45a3946db6390c7e516eab96a9be629bc715') { $Failures.Add('본편 ESP 기준 해시 불일치') }
if ($Interior -ne '08c67a948bc7e4c0318c2ce52e1b93ebe910571d3ea04aa4b9edf007a83a436f') { $Failures.Add('실내 지명 ESP 기준 해시 불일치') }

$Yaml = @(Get-ChildItem -LiteralPath (Join-Path $Root 'l10n') -Filter 'ko.yaml' -File -Recurse)
if ($Yaml.Count -ne 8) { $Failures.Add("l10n 도메인 수 불일치: $($Yaml.Count)") }
$KeyCount = 0
foreach ($File in $Yaml) {
    foreach ($Line in Get-Content -LiteralPath $File.FullName -Encoding UTF8) {
        if ($Line -match '^\S[^:]*:') { $KeyCount++ }
    }
}
if ($KeyCount -ne 456) { $Failures.Add("OpenMW UI 키 수 불일치: $KeyCount") }
$Interface = Get-Content -LiteralPath (Join-Path $Root 'l10n\Interface\ko.yaml') -Encoding UTF8 -Raw
foreach ($Key in @("'No':", "'Off':", "'On':", "'Yes':")) {
    if (-not $Interface.Contains($Key)) { $Failures.Add("Interface 키 누락: $Key") }
}

$Latin1 = [Text.Encoding]::GetEncoding(28591)
$FallbackBytes = [IO.File]::ReadAllBytes((Join-Path $Root 'config\openmw_fallbacks_ko_runtime.cfg'))
$FallbackText = $Latin1.GetString($FallbackBytes)
$FallbackCount = @($FallbackText -split "`r?`n" | Where-Object { $_ -match '^fallback=' }).Count
if ($FallbackCount -ne 63) { $Failures.Add("fallback 문자열 수 불일치: $FallbackCount") }

if ($Failures.Count -gt 0) {
    foreach ($Failure in $Failures) { Write-Host "FAIL: $Failure" -ForegroundColor Red }
    exit 1
}
Write-Host 'PASS: 패키지 해시와 핵심 구조가 모두 일치합니다.' -ForegroundColor Green
Write-Host "OpenMW UI 키: $KeyCount / fallback 문자열: $FallbackCount / l10n 도메인: $($Yaml.Count)"
