# 모로윈드 한국어 재번역 v1.0.7-rc7

OpenMW 0.51용 한국어 재번역의 대화 토픽 및 폰트 호환 수정 후보판입니다.

## 배포 파일

- GitHub Pre-release: `v1.0.7-rc7`
- `Morrowind_Korean_ReTranslation_v1.0.7-rc7_OpenMW_0.51.0_IMPORT_FONT_ALIAS_FIX.zip`
- GitHub asset SHA-256: `7337db136de43aff64449fee6307d211cf5f327d9aff0ee7dbd10ce9b274226b`

## v1.0.7-rc7 핵심

- RC6의 ESP/MRK 게임플레이 payload를 바이트 단위로 그대로 유지합니다.
- OpenMW 기본 폰트 이름 `MysticCards` / `DemonicLetters`를 계속 지원합니다.
- Morrowind.ini / Import Wizard가 남기는 `magic_cards_regular` / `daedric_font` 이름도 지원하도록 FNT 호환 별칭을 추가했습니다.
- `magic_cards_regular.fnt`는 `MysticCards.fnt`와 바이트 단위로 동일합니다.
- `daedric_font.fnt`는 `DemonicLetters.fnt`와 바이트 단위로 동일합니다.
- 별칭 FNT 내부 TEX 참조는 기존 `MysticCards.tex` / `DemonicLetters.tex`를 그대로 사용합니다.
- 따라서 정상적인 OpenMW 기본 설정과 Morrowind Import Wizard 설정 모두에서 사용자가 `Fonts_Font_0` / `Fonts_Font_2`를 수동으로 바꿀 필요가 없습니다.

## RC6에서 유지되는 토픽 수정

- INFO를 `(부모 DIAL, INFO INAM)` 문맥으로 식별해 기존 누락 대화 복구를 유지합니다.
- 원본 3개 마스터 직접 대조로 복구한 Topic/Persuasion INFO 153개와 compiled MWScript `AddTopic` 수정 16개를 유지합니다.
- 프로케수스 살해 토픽 경로와 잘못 번역된 기술용 ANAM 중복 INFO 제거를 유지합니다.
- MRK는 **373행 / 0x1A 0 / stale keyword 0**입니다.
- `0x1A`가 필요했던 13개 토픽은 MRK에서 제외하고 해당 응답문에서 실제 한국어 DIAL명이 직접 발견되도록 복구했습니다.
- `파르고스의 은닉처`의 stale MRK override 제거를 유지합니다.

## 실게임에서 확인된 경로

- 흐리스카르: `금화 되찾기` 링크 정상
- 흐리스카르: `파르고스의 은닉처` 링크 → 선택지 정상
- 타베레 베드라노: `그가 화내는` → `그가 화내는 걸 봤다` 링크 정상

## 설치

1. OpenMW를 종료합니다.
2. ZIP을 원하는 위치에 풉니다.
3. OpenMW Launcher에서 `mods/Morrowind_Korean_ReTranslation_v1.0.7-rc7`를 데이터 경로로 추가합니다.
4. `Morrowind_Korean_ReTranslation.esp`를 활성화합니다.
5. 같은 폴더의 `Morrowind_Korean_ReTranslation.mrk`는 같은 stem의 ESP용 파일로 자동 로드됩니다.
6. 예전 한국어 ESP와 이전 v1.0.7 시험판은 비활성화합니다.

`openmw.cfg`를 덮어쓰거나 별도 encoding/fallback 설정을 추가할 필요가 없습니다. RC7은 `MysticCards`/`DemonicLetters`와 `magic_cards_regular`/`daedric_font` 두 폰트 이름 체계를 모두 포함합니다.

## 검증 상태

- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- `MysticCards.fnt` / `magic_cards_regular.fnt` SHA-256: `f4a361c752f937beccdfff013d65901797f3d2929f74440d4079df85629ecfcd`
- `DemonicLetters.fnt` / `daedric_font.fnt` SHA-256: `ee7ab5662eedf4cab7bdedf86e9bf5066ad5de36e2d9efed9910dec1cfdfefa2`
- MRK entries: 373
- MRK byte `0x1A`: 0
- stale MRK keyword: 0
- `CELL=0`, `PGRD=0`
- `.top` 없음
- 구형 `@ + 0x7F + #` 링크 없음
- 대량 result-script `AddTopic` 주입 없음

## 재현용 소스 / upstream 패치

- `release/rebuild_rc6.py`: RC4 검증 ZIP에서 RC6 게임플레이 payload를 재구축하고 해시/구조를 검증하는 스크립트
- `release/rebuild_rc7.py`: RC6 payload를 검증한 뒤 Import Wizard 폰트 별칭을 추가하고 RC7을 재구축하는 스크립트
- `release/manifest-v1.0.7-rc7.json`: RC7 입력/출력과 해시 기록
- `release/SHA256SUMS_v1.0.7-rc7.txt`: RC7 핵심 파일 체크섬
- `patches/openmw-translation-sidecar-binary-mode.patch`: OpenMW가 `.cel/.top/.mrk`를 Windows text mode가 아닌 binary mode로 열도록 하는 upstream 소스 수정안
- `docs/OPENMW_TRANSLATION_SIDECAR_CTRLZ.md`: `0x1A` EOF 문제의 재현·원인·회귀 테스트 제안

자세한 내용은 `release/RELEASE_NOTES_v1.0.7-rc7.md`와 `docs/VALIDATION.md`를 확인하세요.