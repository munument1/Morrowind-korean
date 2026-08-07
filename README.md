# 모로윈드 한국어 재번역 v1.0.7-rc6

OpenMW 0.51용 한국어 재번역의 대화 토픽 연결 수정 후보판입니다.

## 배포 파일

- GitHub Pre-release: `v1.0.7-rc6`
- `Morrowind_Korean_ReTranslation_v1.0.7-rc6_OpenMW_0.51.0_MRK_WINDOWS_SAFE.zip`
- GitHub asset SHA-256: `ad9320ccc13a314f42de7a1c2928703a44bf28614744ce3ebf3ba65427e7ebc6`

## v1.0.7-rc6 핵심

- INFO를 `(부모 DIAL, INFO INAM)` 문맥으로 식별해 기존 누락 대화 복구를 유지합니다.
- 원본 3개 마스터 직접 대조로 복구한 Topic/Persuasion INFO 153개와 compiled MWScript `AddTopic` 수정 16개를 유지합니다.
- 프로케수스 살해 토픽 경로와 잘못 번역된 기술용 ANAM 중복 INFO 제거를 유지합니다.
- OpenMW 0.51 `.mrk`의 Windows 텍스트 모드 문제를 확인하여 한국어 레거시 인코딩 바이트 `0x1A`가 MRK 안에 남지 않도록 정리했습니다.
- MRK는 **373행 / 0x1A 0 / stale keyword 0**입니다.
- `0x1A`가 필요했던 13개 토픽은 MRK에서 제외하고, 해당 응답문 안에 실제 한국어 DIAL명이 직접 나타나도록 복구했습니다.
- `파르고스의 은닉처`에 남아 있던 이전 철자의 stale MRK override를 제거했습니다.
- RC4 이후 변경은 검증된 INFO 응답 `NAME` 29개와 MRK 정리로 제한했습니다.

## 실게임에서 확인된 경로

- 흐리스카르: `금화 되찾기` 링크 정상
- 흐리스카르: `파르고스의 은닉처` 링크 → 선택지 정상
- 타베레 베드라노: `그가 화내는` → `그가 화내는 걸 봤다` 링크 정상

## 설치

1. OpenMW를 종료합니다.
2. ZIP을 원하는 위치에 풉니다.
3. OpenMW Launcher에서 `mods/Morrowind_Korean_ReTranslation_v1.0.7-rc6`를 데이터 경로로 추가합니다.
4. `Morrowind_Korean_ReTranslation.esp`를 활성화합니다.
5. 같은 폴더의 `Morrowind_Korean_ReTranslation.mrk`는 같은 stem의 ESP용 파일로 자동 로드됩니다.
6. 예전 한국어 ESP와 이전 v1.0.7 시험판은 비활성화합니다.

`openmw.cfg`를 덮어쓰거나 별도 encoding/fallback 설정을 추가할 필요가 없습니다.

## 검증 상태

- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- MRK entries: 373
- MRK byte `0x1A`: 0
- stale MRK keyword: 0
- `CELL=0`, `PGRD=0`
- `.top` 없음
- 구형 `@ + 0x7F + #` 링크 없음
- 대량 result-script `AddTopic` 주입 없음

## 재현용 소스 / upstream 패치

- `release/rebuild_rc6.py`: RC4 검증 ZIP에서 RC6 게임플레이 payload를 재구축하고 해시/구조를 검증하는 스크립트
- `release/manifest-v1.0.7-rc6.json`: RC6 입력/출력과 해시 기록
- `release/SHA256SUMS_v1.0.7-rc6.txt`: RC6 핵심 파일 체크섬
- `patches/openmw-translation-sidecar-binary-mode.patch`: OpenMW가 `.cel/.top/.mrk`를 Windows text mode가 아닌 binary mode로 열도록 하는 upstream 소스 수정안
- `docs/OPENMW_TRANSLATION_SIDECAR_CTRLZ.md`: `0x1A` EOF 문제의 재현·원인·회귀 테스트 제안

자세한 내용은 `release/RELEASE_NOTES_v1.0.7-rc6.md`와 `docs/VALIDATION.md`를 확인하세요.
