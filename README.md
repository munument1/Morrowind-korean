# 모로윈드 한국어 재번역 v01 핫픽스 1

OpenMW 0.51용 모로윈드 본편·Tribunal·Bloodmoon 한국어 재번역입니다.

## 중요: 이전 단일 ESP 폐기

이전에 배포한 단일 ESP에는 실내 지명 레코드의 참조 번호가 잘못 병합되어, 시작 장면에서 경비병이나 캐릭터 생성 이벤트가 중복되는 문제가 있었습니다.
이 핫픽스에서는 문제가 있는 실내 지명 변경을 제거했습니다. **이전 ZIP과 이전 ESP는 사용하지 마십시오.**

이미 문제 있는 ESP로 새 게임을 시작했다면 중복 참조와 캐릭터 생성 진행 상태가 저장 파일에 남을 수 있습니다. 이 핫픽스로 교체한 뒤 캐릭터 생성 전 저장 파일을 불러오거나 새 게임을 시작하는 것이 안전합니다.

## 배포 파일

- 파일명: `Morrowind_Korean_ReTranslation_v01_hotfix1.zip`
- 크기: 4,230,960바이트
- SHA-256: `2a4eb6d7406e4dc58aea84f89b0f65ae1305a9698cb4fea1a5ded66d9eef556e`
- Google Drive에는 배포하지 않습니다.

## 설치

1. OpenMW를 종료합니다.
2. 기존 `OpenMW\mods\Morrowind_Korean_ReTranslation_v01` 폴더가 있다면 삭제하거나 다른 곳으로 옮깁니다.
3. 압축을 풉니다.
4. 압축을 풀어 나온 `Morrowind_Korean_ReTranslation_v01` 폴더를 OpenMW의 `mods` 폴더 안에 통째로 넣습니다.

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

5. OpenMW Launcher에서 `Data Files` → `Data Directories`를 열고 다음 폴더를 데이터 디렉터리로 추가합니다.

```text
OpenMW\mods\Morrowind_Korean_ReTranslation_v01
```

6. 다음 순서로 플러그인을 활성화합니다.

```text
Morrowind.esm
Tribunal.esm
Bloodmoon.esm
Morrowind_Korean_ReTranslation_v01.esp
```

`Morrowind_Korean_Interior_CellNames_v01.esp`는 비활성화하고 제거하십시오.

## OpenMW 설정

이미 SmallBatang4 폰트와 한국어 fallback 설정을 적용했다면 이 절은 건너뛰어도 됩니다. OpenMW 설정 폴더는 일반적으로 `문서\My Games\OpenMW`입니다.

`openmw.cfg`를 백업한 뒤 다음 항목이 있는지 확인합니다.

```text
encoding=win1252
fallback=Fonts_Font_0,SmallBatang4
fallback=Fonts_Font_1,SmallBatang4
fallback=Fonts_Font_2,SmallBatang4
```

게임 설정 문구 번역을 사용하려면 `OpenMW Config\openmw.cfg.append.cfg`의 내용을 `openmw.cfg` 끝에 추가합니다. 이 파일에는 원시 바이트가 포함되어 있으므로 UTF-8로 변환하거나 다시 저장하지 마십시오. 같은 `fallback=` 항목은 중복 추가하지 않습니다.

`settings.cfg`의 `[General]` 절에는 다음 값을 넣습니다.

```text
preferred locales = ko,en
```

## 포함 내용

- 게임 본문·이름·추가 표시·스크립트 번역 ESP 1개
- 검증된 ESP 번역 45,881행
- 스크립트 문자열 3,714개
- OpenMW UI 번역 456개
- OpenMW fallback 문자열 63개
- SmallBatang4 비트맵 폰트

## 이번 핫픽스에서 제외된 내용

- 실내 지명 1,328개 번역

실내 지명은 게임 참조를 복제하지 않는 방식으로 다시 빌드하고 실제 시작 구간 시험을 통과한 뒤 별도 버전에서 복원할 예정입니다.

## 주의

- OpenMW 0.51.x 기준입니다.
- `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`이 모두 필요합니다.
- `[KOR01] Han Books.esp`, `[KOR02] Han Topic.esp`, `[KOR03] HBMJournal.esm`, `[KOR04] Game Setting.esp` 등 같은 레코드를 수정하는 기존 한국어 플러그인은 함께 사용하지 않는 것을 권장합니다.
