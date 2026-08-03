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

$PluginPath = Join-Path $Root 'Morrowind_Korean_ReTranslation_v01.esp'
$Plugin = (Get-FileHash -LiteralPath $PluginPath -Algorithm SHA256).Hash.ToLowerInvariant()
if ($Plugin -ne 'a5a95f64afde810c3f6ec99af416a3c8d055c4c021883722fc020042d6877562') { $Failures.Add('통합 ESP 기준 해시 불일치') }
if ((Get-Item -LiteralPath $PluginPath).Length -ne 42704861) { $Failures.Add('통합 ESP 파일 크기 불일치') }
if (Test-Path -LiteralPath (Join-Path $Root 'Morrowind_Korean_Interior_CellNames_v01.esp')) {
    $Failures.Add('폐기된 실내 지명 보조 ESP가 패키지에 남아 있음')
}

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
Write-Host 'PASS: 단일 ESP 패키지 해시와 핵심 구조가 모두 일치합니다.' -ForegroundColor Green
Write-Host "ESP: 42704861바이트 / OpenMW UI 키: $KeyCount / fallback 문자열: $FallbackCount / l10n 도메인: $($Yaml.Count)"
