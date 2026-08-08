# 검증 결과

## v1.0.7-rc7 상태

- 상태: `RC_PASS_IMPORT_FONT_ALIAS_COMPAT`
- 대상: OpenMW 0.51.0
- GitHub Pre-release: `v1.0.7-rc7`
- 배포 ZIP: `Morrowind_Korean_ReTranslation_v1.0.7-rc7_OpenMW_0.51.0_IMPORT_FONT_ALIAS_FIX.zip`
- GitHub asset SHA-256: `7337db136de43aff64449fee6307d211cf5f327d9aff0ee7dbd10ce9b274226b`

## 게임플레이 payload

RC7의 ESP/MRK는 RC6와 바이트 단위 동일합니다.

- ESP: `Morrowind_Korean_ReTranslation.esp`
- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK: `Morrowind_Korean_ReTranslation.mrk`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- MRK entries: 373
- MRK byte `0x1A`: 0
- stale MRK keyword: 0
- duplicate MRK topic key: 0
- duplicate MRK keyword value: 0

## RC7에서 닫은 폰트 호환 문제

OpenMW 자체 기본 설정은 `Fonts_Font_0=MysticCards`, `Fonts_Font_2=DemonicLetters`를 사용합니다. 반면 Morrowind.ini를 Import Wizard로 가져온 정상적인 환경에서는 `Fonts_Font_0=magic_cards_regular`, `Fonts_Font_2=daedric_font`가 사용자 `openmw.cfg`에 남을 수 있습니다.

RC6는 `MysticCards.fnt` / `DemonicLetters.fnt` 한국어 비트맵 폰트만 포함했기 때문에 후자 환경에서는 다른 영문 폰트가 선택되어 한국어 조합용 바이트가 `Ç`, `ô`, `á` 같은 문자로 표시될 수 있었습니다.

RC7은 다음 FNT 별칭을 추가합니다.

- `magic_cards_regular.fnt` = `MysticCards.fnt` 바이트 단위 복사본
- `daedric_font.fnt` = `DemonicLetters.fnt` 바이트 단위 복사본

OpenMW의 FNT 로더는 선택된 FNT 파일을 연 뒤 FNT 헤더의 texture stem으로 `.tex`를 찾으므로, 별칭 FNT는 각각 기존 `MysticCards.tex` / `DemonicLetters.tex`를 그대로 참조합니다.

### 폰트 검증

- `MysticCards.fnt` SHA-256: `f4a361c752f937beccdfff013d65901797f3d2929f74440d4079df85629ecfcd`
- `magic_cards_regular.fnt` SHA-256: `f4a361c752f937beccdfff013d65901797f3d2929f74440d4079df85629ecfcd`
- `DemonicLetters.fnt` SHA-256: `ee7ab5662eedf4cab7bdedf86e9bf5066ad5de36e2d9efed9910dec1cfdfefa2`
- `daedric_font.fnt` SHA-256: `ee7ab5662eedf4cab7bdedf86e9bf5066ad5de36e2d9efed9910dec1cfdfefa2`
- 두 alias 모두 source FNT와 byte-identical: PASS
- alias 내부 texture stem에 대응하는 `.tex` 존재: PASS
- `Fonts_Font_1`: 일반 게임 UI에 사용되지 않으므로 변경 없음

## RC6에서 닫은 런타임 문제

### Windows MRK EOF

OpenMW 0.51은 `.mrk/.top/.cel` 번역 sidecar를 `std::ifstream`으로 읽습니다. 한국어 레거시 인코딩에서 실제 글자 구성에 쓰이는 바이트 `0x1A`가 Windows 텍스트 모드에서 EOF처럼 작동할 수 있어 기존 MRK의 뒤쪽 항목이 로드되지 않는 현상을 실게임에서 확인했습니다.

RC6부터 MRK 안의 `0x1A`를 0개로 유지합니다. `0x1A`가 들어가던 13개 토픽은 MRK에서 제거하고 관련 응답문에 실제 한국어 DIAL명이 직접 나타나도록 복구했습니다.

### stale MRK override

RC5에서 `파고스의 은닉처`를 `파르고스의 은닉처`로 고친 뒤에도 MRK에는 이전 철자의 keyword override가 남아 있었습니다. RC6부터 이 override를 제거하여 OpenMW가 현재 DIAL 문자열 자체를 keyword로 사용합니다.

## 실게임 확인

- 흐리스카르 `금화 되찾기`: 링크 정상
- 흐리스카르 `파르고스의 은닉처`: 링크 정상
- `파르고스의 은닉처` 선택 후 Choice 표시: 정상
- 타베레 베드라노 `그가 화내는` → `그가 화내는 걸 봤다`: 링크 정상

## 구조 검증

- RC7의 ESP/MRK: RC6와 바이트 단위 동일
- RC7 신규 게임 데이터 변경: 없음
- RC7 신규 패키지 변경: FNT 별칭 2개 + 문서/검증 메타데이터
- `CELL` 레코드: 0
- `PGRD` 레코드: 0
- `.top`: 없음
- 구형 `@ + 0x7F + #` 링크: 없음
- 대량 result-script `AddTopic` 주입: 없음
- 기존 compiled SCPT topic-fix 유지

## 누적 v1.0.7 복구

- INFO 식별 기준을 전역 INAM에서 `(부모 DIAL, INFO INAM)` 문맥으로 수정
- 기존 INFO ID 충돌 누락 66개 복구 유지
- 원본 3개 마스터 대조 Topic/Persuasion 누락 INFO 153개 복구 유지
- compiled MWScript의 낡은 영문 `AddTopic` 참조 16개 수정 유지
- 프로케수스 살해 토픽 경로 수정 및 잘못 번역된 기술용 ANAM 중복 INFO 제거 유지
- 자동 보류 토픽 36개 수동 검수 완료 상태 유지
- Windows-safe MRK 373행 / `0x1A` 0 / stale keyword 0 유지

## 재현성

- `release/rebuild_rc6.py`: RC4 검증 ZIP에서 RC6 게임플레이 payload를 재구축하고 해시/구조를 검증합니다.
- `release/rebuild_rc7.py`: RC6 payload의 ESP/MRK 해시를 확인한 뒤 FNT 별칭 2개를 추가하고 별칭 바이트 동일성 및 TEX 참조를 검증합니다.
- `release/manifest-v1.0.7-rc7.json`: RC7 입력/출력과 해시를 기록합니다.
- `release/SHA256SUMS_v1.0.7-rc7.txt`: 배포 ZIP, ESP, MRK, 원본/별칭 FNT 체크섬을 기록합니다.

## 남은 상태

RC7는 정식 stable이 아니라 pre-release입니다. 토픽 쪽 핵심 제보 경로는 실게임에서 확인했으며, 이번 RC7의 폰트 별칭 수정은 구조·해시 검증을 통과했습니다. 실제 Import Wizard 환경에서 제보된 깨짐 화면이 사라지는지 한 번 더 확인하면 폰트 호환 회귀까지 런타임으로 닫을 수 있습니다.