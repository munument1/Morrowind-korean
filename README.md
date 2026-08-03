# 모로윈드 한국어 재번역 v01 핫픽스 1

OpenMW 0.51.0용 한국어 재번역 간편 설치 배포본입니다.

## 중요: 이전 단일 ESP 폐기

이전에 배포한 실내 지명 통합 ESP에는 시작 장면의 경비병과 캐릭터 생성 오브젝트가 중복되는 문제가 있었습니다. 이전 ZIP과 ESP는 사용하지 마십시오. 핫픽스 1에서는 문제가 있는 실내 지명 변경을 임시 제외했습니다.

이미 문제 있는 ESP로 시작했다면 중복 상태가 저장 파일에 남을 수 있습니다. 핫픽스로 교체한 뒤 배에서 내리기 전 저장 파일이나 새 게임으로 확인하십시오.

## 배포 파일

- 파일명: `Morrowind_Korean_ReTranslation_v01_hotfix1_easy.zip`
- 크기: 4,235,750바이트
- SHA-256: `0acde971a4b4399efcf2f5d78acdaa243660e0d9152f31c7a01a04a09491fac4`
- Google Drive에는 배포하지 않습니다.

## 설치

1. OpenMW를 종료합니다.
2. 압축을 풉니다.
3. 압축 안의 `OpenMW 0.51.0` 폴더를 현재 사용 중인 `OpenMW 0.51.0` 폴더 위에 복사해 **덮어쓰기**합니다.
4. OpenMW Launcher를 실행합니다.

```text
OpenMW 0.51.0
├─ openmw.cfg
├─ SHA256SUMS.txt
└─ mods
   └─ Morrowind_Korean_ReTranslation_v01
      ├─ Morrowind_Korean_ReTranslation_v01.esp
      ├─ Fonts
      ├─ l10n
      ├─ README.md
      └─ SHA256SUMS.txt
```

별도로 모드 폴더를 등록하거나 `openmw.cfg` 내용을 붙여넣을 필요가 없습니다.

## openmw.cfg 구성

동봉된 `openmw.cfg`는 사용자가 제공한 OpenMW 0.51.0 기본 설정 파일 521줄 전체를 기반으로 만들었습니다. 조명·날씨·물·캐릭터 생성 등 원래 설정은 유지하고 다음 항목만 반영했습니다.

- `data=./mods/Morrowind_Korean_ReTranslation_v01`
- `encoding=win1252`
- `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`
- `Morrowind_Korean_ReTranslation_v01.esp`
- SmallBatang4 폰트 3개 항목
- 한국어 fallback 문자열 63개

수정된 설정 파일은 529줄, 30,121바이트이며 SHA-256은 `7dac219722ef79a7a135e61370bdb58b7fc4fae2409f693797e52c855f6a6893`입니다.

기존 `openmw.cfg`에 다른 모드나 사용자 설정을 직접 추가해 두었다면 덮어쓰기 전에 백업하십시오. `settings.cfg`는 덮어쓰지 않습니다.

## 포함 내용

- 검증된 게임 본문·이름·추가 표시·스크립트 번역 45,881행
- 스크립트 문자열 3,714개
- OpenMW UI 번역 456개
- OpenMW fallback 문자열 63개
- SmallBatang4 비트맵 폰트

## 임시 제외

- 실내 지명 1,328개

실내 지명은 참조 번호를 올바르게 재매핑하고 실제 시작 구간 시험을 통과한 뒤 복원합니다.
