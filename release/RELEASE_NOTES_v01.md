# 모로윈드 한국어 재번역 v01 핫픽스 1

## 긴급 수정 내용

이전 실내 지명 통합 ESP는 폐기되었습니다. `CELL` 내부 참조 번호 처리 오류로 시작 구역의 경비병과 캐릭터 생성 오브젝트가 복제될 수 있었습니다.

핫픽스 1은 문제가 있는 실내 지명 변경을 제거하고 검증된 게임 본문·이름·추가 표시·스크립트 번역 ESP로 되돌렸습니다.

## 간편 설치 배포본

- 파일명: `Morrowind_Korean_ReTranslation_v01_hotfix1_easy.zip`
- 크기: 4,230,726바이트
- SHA-256: `2d4ff0ad2839f4ea34332f136046bacc248f87e7f16be176b7c1bba9a8b6d5f9`
- ZIP 검사: PASS
- Google Drive 배포: 사용하지 않음

압축 안의 `OpenMW 0.51.0` 폴더를 기존 `OpenMW 0.51.0` 폴더에 그대로 덮어쓰면 다음 항목이 한 번에 설치됩니다.

- `openmw.cfg`
- `mods\Morrowind_Korean_ReTranslation_v01`
- 한국어 ESP, 폰트, l10n 파일

`openmw.cfg`는 포터블 경로 `./resources/vfs-mw`와 `./mods/Morrowind_Korean_ReTranslation_v01`을 사용합니다. 공식 ESM 3개와 한국어 ESP, SmallBatang4 폰트, 번역 fallback 63개가 등록되어 있습니다.

기존 `openmw.cfg`에 다른 모드를 등록했다면 덮어쓰기 전에 백업하십시오. `settings.cfg`는 배포본에서 덮어쓰지 않습니다.

## ESP

- 파일명: `Morrowind_Korean_ReTranslation_v01.esp`
- 크기: 18,184,467바이트
- SHA-256: `52f973e173c037a1010a4fb91aec45a3946db6390c7e516eab96a9be629bc715`
- 번역 행: 45,881개 검증
- 스크립트 문자열: 3,714개 검증
- `chargen` 참조가 포함된 `CELL` 레코드: 0개

## 임시 제외

- 실내 지명 1,328개

문제 있는 ESP로 이미 시작 장면을 진행했다면 캐릭터 생성 전 저장 파일을 불러오거나 새 게임을 시작하는 것이 안전합니다.
