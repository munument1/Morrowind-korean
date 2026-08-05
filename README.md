# 모로윈드 한국어 재번역 v1.0.5

OpenMW 0.51용 한국어 재번역의 cfg-없는 가독성 폰트 배포본입니다.

## 배포 파일

- `release/Morrowind_Korean_ReTranslation_v1.0.5_OpenMW_0.51.0_cfgfree_readable_font.zip`
- 크기: 4,297,696바이트
- SHA-256: `448bc35976b9757e3e8fdfd5a202100459fc72f7255252ec9bc75df79f3f291b`

## 설치

1. OpenMW를 종료합니다.
2. ZIP을 원하는 위치에 풉니다.
3. OpenMW Launcher에서 `mods/Morrowind_Korean_ReTranslation_v1.0.4_cfgfree_readable_font`를 데이터 경로로 추가합니다.
4. `Morrowind_Korean_ReTranslation_v1.0.4.esp`만 활성화합니다.
5. 예전 한국어 ESP 및 폰트 시험 모드는 비활성화합니다.

`openmw.cfg`를 덮어쓰거나 `fallback=Fonts_Font_*`를 직접 추가할 필요가 없습니다.

## cfg 없는 폰트 방식

OpenMW 0.51이 기본적으로 참조하는 `MysticCards`, `DejaVuLGCSansMono`, `DemonicLetters` 이름으로 보정된 SmallBatang 폰트를 제공합니다. 데이터 경로 우선순위로 기본 `.omwfont`보다 모드의 `.fnt`가 먼저 로드됩니다.

- 받침 유무의 진행폭을 12px로 통일
- 받침을 한 표시 픽셀 아래로 분리
- OpenMW 0.51에서 사라질 수 있는 초성 `ㅎ` 슬롯 보정

## 저장 호환성

핵심 ESP 파일명은 v1.0.4를 유지합니다. ESP에는 `CELL` 및 `PGRD` 레코드가 없으므로 외부 셀 이름이나 저장 파일의 셀 이동 식별자를 바꾸지 않습니다.

자세한 사항은 ZIP 내부의 `README_먼저읽기.txt`, 모드의 `README.md`, `INSTALL.md`를 확인하세요.
