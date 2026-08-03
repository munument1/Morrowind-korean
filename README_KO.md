# Morrowind 한국어 재번역 v01

OpenMW 0.51용 모로윈드 본편·Tribunal·Bloodmoon 한국어 재번역 배포본입니다. 최종 검수표 51,440행과 실내 지명 1,328개를 **하나의 ESP**에 통합했으며, OpenMW 네이티브 UI 번역, `openmw.cfg` 설정 문자열, 비트맵 폰트를 함께 제공합니다.

## 다운로드

- 배포 ZIP: https://drive.google.com/file/d/1AWCS8z6SoMtrq4lRyXQ5y7qS4SDiuJkw/view?usp=drivesdk
- 배포 폴더: https://drive.google.com/drive/folders/1fNH3RfXaiqLm7RG-zmMjkd_d6XXX5mRY
- 파일 크기: 10,493,072바이트
- SHA-256: `dba29cc250df3925d6b4efd6c34cc71d4eb68a9d96bc242524ffefde773cf2f7`

## 포함 파일

- `Morrowind_Korean_ReTranslation_v01.esp`: 본문·이름·추가 표시·스크립트·실내 지명을 모두 포함한 단일 플러그인
- `l10n/*/ko.yaml`: OpenMW 네이티브 UI 456개 문자열
- `config/openmw_fallbacks_ko_runtime.cfg`: 설정 문자열 63개
- `Fonts/SmallBatang4*`: 한국어 3바이트 조합 표시 및 ㅎ 보정 폰트
- `tools/Install-OpenMW-Korean.ps1`: Windows 자동 설정 도구
- `tools/Verify-Package.ps1`: 파일 해시와 핵심 구조 검증 도구
- `validation/`: 최종 빌드 및 단일 ESP 통합 검증 보고서

## 자동 설치 및 설정 — Windows

1. ZIP을 `D:\OpenMW Mods\Morrowind Korean ReTranslation v01`처럼 **ASCII 경로**에 풉니다.
2. PowerShell을 열고 압축을 푼 폴더에서 다음을 실행합니다.

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\tools\Verify-Package.ps1
.\tools\Install-OpenMW-Korean.ps1
```

설치 도구는 기본적으로 `문서\My Games\OpenMW\openmw.cfg`와 `settings.cfg`를 찾고, 수정 전에 타임스탬프가 붙은 백업을 만듭니다. 다른 설정 디렉터리를 사용한다면 다음처럼 지정합니다.

```powershell
.\tools\Install-OpenMW-Korean.ps1 -OpenMWConfigDir "D:\OpenMW Profile"
```

## 수동 설치

OpenMW Launcher의 **Data Files → Data Directories**에서 이 패키지의 루트 폴더를 추가하고 다음 순서로 활성화합니다.

1. `Morrowind.esm`
2. `Tribunal.esm`
3. `Bloodmoon.esm`
4. `Morrowind_Korean_ReTranslation_v01.esp`

`openmw.cfg`에는 아래 항목이 필요합니다.

```text
encoding=win1252
fallback=Fonts_Font_0,SmallBatang4
fallback=Fonts_Font_1,SmallBatang4
fallback=Fonts_Font_2,SmallBatang4
```

그리고 `config/openmw_fallbacks_ko_runtime.cfg`의 63개 `fallback=` 행을 추가합니다. `settings.cfg`의 `[General]` 섹션에는 다음을 설정합니다.

```text
preferred locales = ko,en
```

## 충돌 주의

기존 `[KOR01] Han Books.esp`, `[KOR02] Han Topic.esp`, `[KOR03] HBMJournal.esm`, `[KOR04] Game Setting.esp` 및 이전 배포본의 `Morrowind_Korean_Interior_CellNames_v01.esp`는 비활성화하십시오. 실내 지명은 이제 본편 ESP에 포함되어 있습니다.

## 검증 결과

- 최종 검수표: 51,440 / 51,440행 완료
- 단일 ESP: 42,704,861바이트, SHA-256 `a5a95f64afde810c3f6ec99af416a3c8d055c4c021883722fc020042d6877562`
- 번역 행: 45,881행 일치, 누락 0, 텍스트 불일치 0
- 스크립트: SCPT 900행 + INFO 스크립트 2,814행 일치
- 실내 지명: 1,328개 ID, 잔존 영문 참조 0
- 이전 두 ESP의 레코드 바이트를 그대로 보존하고 동일 로드 순서의 유효 레코드 상태와 SHA-256 일치
- 공식 마스터: `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`만 포함
- OpenMW UI: 456개 키
- `openmw.cfg` 설정 문자열: 63개
- 폰트 패치: PASS

자세한 수치는 `docs/VALIDATION.md`와 패키지 내부 `validation/*.json`을 참조하십시오.
