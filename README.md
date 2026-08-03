# 모로윈드 한국어 재번역 v01

OpenMW 0.51용 모로윈드 본편·Tribunal·Bloodmoon 한국어 재번역입니다.
본문, 이름, 추가 표시, 스크립트, 실내 지명을 `Morrowind_Korean_ReTranslation_v01.esp` 하나에 통합했습니다.

## 배포 파일

- 파일명: `Morrowind_Korean_ReTranslation_v01.zip`
- 크기: 10,499,720바이트
- SHA-256: `163e9c05ea19d33fe274351890a0905228800213b4da1a4f9381af828c79e90f`
- Google Drive에는 배포하지 않습니다.

## 설치

1. OpenMW를 종료합니다.
2. 압축을 풉니다.
3. 압축을 풀어 나온 `Morrowind_Korean_ReTranslation_v01` 폴더를 **OpenMW의 `mods` 폴더 안에 통째로 넣습니다.**

```text
OpenMW
└─ mods
   └─ Morrowind_Korean_ReTranslation_v01
      ├─ Morrowind_Korean_ReTranslation_v01.esp
      ├─ Fonts
      ├─ l10n
      ├─ OpenMW Config
      └─ README.md
```

원본 모로윈드의 `Data Files` 폴더에는 덮어쓰지 마십시오.

4. OpenMW Launcher에서 `Data Files` → `Data Directories`를 열고 아래 폴더를 데이터 디렉터리로 추가합니다.

```text
OpenMW\mods\Morrowind_Korean_ReTranslation_v01
```

5. 다음 순서로 플러그인을 활성화합니다.

```text
Morrowind.esm
Tribunal.esm
Bloodmoon.esm
Morrowind_Korean_ReTranslation_v01.esp
```

기존 배포본의 `Morrowind_Korean_Interior_CellNames_v01.esp`는 더 이상 사용하지 않습니다. 활성화되어 있다면 끄고 파일도 삭제하십시오.

## OpenMW 설정

이미 다른 한국어 패치에서 SmallBatang4 폰트와 한국어 fallback 설정을 적용했다면 이 절은 건너뛰어도 됩니다.

OpenMW 설정 폴더는 보통 다음 위치에 있습니다.

```text
문서\My Games\OpenMW
```

### openmw.cfg

`openmw.cfg`를 먼저 백업한 뒤 다음 항목이 있는지 확인합니다.

```text
encoding=win1252
fallback=Fonts_Font_0,SmallBatang4
fallback=Fonts_Font_1,SmallBatang4
fallback=Fonts_Font_2,SmallBatang4
```

게임 설정 문구 번역을 사용하려면 `OpenMW Config\openmw.cfg.append.cfg`의 내용을 `openmw.cfg` 끝에 추가합니다.
이 파일에는 폰트용 원시 바이트가 포함되어 있으므로 UTF-8로 변환하거나 다시 저장하지 마십시오. 기존에 같은 `fallback=` 항목이 있다면 중복 추가하지 않습니다.

### settings.cfg

`settings.cfg`의 `[General]` 절에 다음 값을 넣습니다.

```text
preferred locales = ko,en
```

## 기존 한국어 패치 정리

같은 레코드를 수정하는 기존 한국어 플러그인은 함께 사용하지 않는 것을 권장합니다.
특히 다음 파일이 활성화되어 있다면 비활성화하십시오.

```text
[KOR01] Han Books.esp
[KOR02] Han Topic.esp
[KOR03] HBMJournal.esm
[KOR04] Game Setting.esp
Morrowind_Korean_Interior_CellNames_v01.esp
```

## 포함 내용

- 단일 통합 ESP 1개
- 최종 검수 번역 51,440행 반영
- ESP 번역 45,881행 검증
- 스크립트 문자열 3,714개 검증
- 실내 지명 1,328개 검증
- OpenMW UI 번역 456개
- OpenMW fallback 문자열 63개
- SmallBatang4 비트맵 폰트

## 주의

- OpenMW 0.51.x 기준입니다.
- `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`이 모두 필요합니다.
- 다른 대형 대화·서적·게임 설정·실내 지명 모드와 충돌할 수 있으며, 뒤에 로드된 플러그인이 우선합니다.
