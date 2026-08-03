[CmdletBinding()]
param(
    [string]$OpenMWConfigDir = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'My Games\OpenMW')
)

$ErrorActionPreference = 'Stop'
$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

if ($PackageRoot.ToCharArray() | Where-Object { [int]$_ -gt 127 }) {
    throw "패키지 경로에 비 ASCII 문자가 있습니다. 영문/숫자 경로로 옮긴 뒤 다시 실행하십시오: $PackageRoot"
}

$Required = @(
    'Morrowind_Korean_ReTranslation_v01.esp',
    'config\openmw_fallbacks_ko_runtime.cfg',
    'Fonts\SmallBatang4.fnt',
    'Fonts\SmallBatang4.tex',
    'l10n\Interface\ko.yaml'
)
foreach ($Relative in $Required) {
    $Path = Join-Path $PackageRoot $Relative
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "필수 파일이 없습니다: $Relative" }
}

New-Item -ItemType Directory -Force -Path $OpenMWConfigDir | Out-Null
$OpenMWCfg = Join-Path $OpenMWConfigDir 'openmw.cfg'
$SettingsCfg = Join-Path $OpenMWConfigDir 'settings.cfg'
if (-not (Test-Path -LiteralPath $OpenMWCfg)) {
    throw "openmw.cfg를 찾을 수 없습니다. OpenMW Launcher의 설치 마법사를 먼저 실행하십시오: $OpenMWCfg"
}

$Stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
Copy-Item -LiteralPath $OpenMWCfg -Destination "$OpenMWCfg.korean-v01.$Stamp.bak" -Force
if (Test-Path -LiteralPath $SettingsCfg) {
    Copy-Item -LiteralPath $SettingsCfg -Destination "$SettingsCfg.korean-v01.$Stamp.bak" -Force
}

$BytePreserving = [Text.Encoding]::GetEncoding(28591)
$CfgText = $BytePreserving.GetString([IO.File]::ReadAllBytes($OpenMWCfg))
$Lines = [Collections.Generic.List[string]]::new()
foreach ($Line in ($CfgText -split "`r?`n")) {
    if ($Line -eq '') { continue }
    $Lines.Add($Line)
}

$PackageData = $PackageRoot.Replace('\','/')
$DataLine = 'data="' + $PackageData + '"'
$MainContent = 'content=Morrowind_Korean_ReTranslation_v01.esp'
$RetiredInteriorContent = 'content=Morrowind_Korean_Interior_CellNames_v01.esp'
$FontKeys = @('Fonts_Font_0','Fonts_Font_1','Fonts_Font_2')

$RuntimePath = Join-Path $PackageRoot 'config\openmw_fallbacks_ko_runtime.cfg'
$RuntimeText = $BytePreserving.GetString([IO.File]::ReadAllBytes($RuntimePath))
$RuntimeLines = @($RuntimeText -split "`r?`n" | Where-Object { $_ -match '^fallback=([^,]+),' })
if ($RuntimeLines.Count -ne 63) { throw "설정 문자열 수가 63개가 아닙니다: $($RuntimeLines.Count)" }
$RuntimeKeys = @{}
foreach ($Line in $RuntimeLines) {
    if ($Line -match '^fallback=([^,]+),') { $RuntimeKeys[$Matches[1]] = $true }
}

$Filtered = [Collections.Generic.List[string]]::new()
foreach ($Line in $Lines) {
    $Drop = $false
    if ($Line -match '^encoding=') { $Drop = $true }
    elseif ($Line -eq $DataLine -or $Line -eq $MainContent -or $Line -eq $RetiredInteriorContent) { $Drop = $true }
    elseif ($Line -match '^fallback=([^,]+),') {
        $Key = $Matches[1]
        if ($RuntimeKeys.ContainsKey($Key) -or $FontKeys -contains $Key) { $Drop = $true }
    }
    if (-not $Drop) { $Filtered.Add($Line) }
}

$Filtered.Add('')
$Filtered.Add('# Morrowind Korean ReTranslation v01 - integrated single ESP')
$Filtered.Add('encoding=win1252')
$Filtered.Add($DataLine)
$Filtered.Add($MainContent)
$Filtered.Add('fallback=Fonts_Font_0,SmallBatang4')
$Filtered.Add('fallback=Fonts_Font_1,SmallBatang4')
$Filtered.Add('fallback=Fonts_Font_2,SmallBatang4')
foreach ($Line in $RuntimeLines) { $Filtered.Add($Line) }

$Out = (($Filtered -join "`r`n").TrimEnd("`r","`n") + "`r`n")
[IO.File]::WriteAllBytes($OpenMWCfg, $BytePreserving.GetBytes($Out))

function Set-IniValue {
    param([string]$Path, [string]$Section, [string]$Key, [string]$Value)
    $Utf8NoBom = [Text.UTF8Encoding]::new($false)
    $Text = if (Test-Path -LiteralPath $Path) { [IO.File]::ReadAllText($Path) } else { '' }
    $All = [Collections.Generic.List[string]]::new()
    foreach ($L in ($Text -split "`r?`n")) { $All.Add($L) }
    $SectionStart = -1; $SectionEnd = $All.Count
    for ($i=0; $i -lt $All.Count; $i++) {
        if ($All[$i] -match '^\s*\[(.+)\]\s*$') {
            if ($Matches[1] -ieq $Section) { $SectionStart = $i; continue }
            if ($SectionStart -ge 0) { $SectionEnd = $i; break }
        }
    }
    $NewLine = "$Key = $Value"
    if ($SectionStart -lt 0) {
        if ($All.Count -gt 0 -and $All[$All.Count-1] -ne '') { $All.Add('') }
        $All.Add("[$Section]"); $All.Add($NewLine)
    } else {
        $Found = $false
        for ($i=$SectionStart+1; $i -lt $SectionEnd; $i++) {
            if ($All[$i] -match ('^\s*' + [regex]::Escape($Key) + '\s*=')) {
                $All[$i] = $NewLine; $Found = $true; break
            }
        }
        if (-not $Found) { $All.Insert($SectionEnd, $NewLine) }
    }
    [IO.File]::WriteAllText($Path, (($All -join "`r`n").TrimEnd() + "`r`n"), $Utf8NoBom)
}

Set-IniValue -Path $SettingsCfg -Section 'General' -Key 'preferred locales' -Value 'ko,en'

Write-Host 'PASS: 단일 ESP OpenMW 한국어 재번역 v01 설정을 적용했습니다.' -ForegroundColor Green
Write-Host "설정 디렉터리: $OpenMWConfigDir"
Write-Host "데이터 디렉터리: $PackageRoot"
Write-Host "백업: $OpenMWCfg.korean-v01.$Stamp.bak"
Write-Host '이전 Morrowind_Korean_Interior_CellNames_v01.esp 항목은 제거되었습니다.'
