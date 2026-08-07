# OpenMW 0.51 Korean Translation v1.0.7-rc6

## Windows MRK / 대화 토픽 연결 수정 후보판

실게임 테스트에서 확인된 OpenMW 0.51의 한국어 대화 토픽 연결 문제를 반영한 pre-release입니다.

## 핵심 수정

- `.mrk`에서 한국어 레거시 인코딩의 `0x1A`가 Windows 텍스트 모드 EOF로 작동할 수 있는 문제를 제거했습니다.
- MRK를 **373행 / 0x1A 0**으로 정리했습니다.
- `0x1A`가 필요했던 13개 토픽은 MRK 대신 해당 응답문에서 실제 한국어 DIAL명이 직접 발견되도록 복구했습니다.
- `파르고스의 은닉처`에 남아 있던 RC5 이전 철자의 stale MRK override를 제거했습니다.
- RC4 이후 변경은 검증된 INFO 응답 `NAME` 29개와 MRK 정리로 제한했습니다.

## 실게임 확인

- 흐리스카르: `금화 되찾기` 링크 정상
- 흐리스카르: `파르고스의 은닉처` 링크 → 선택지 정상
- 타베레 베드라노: `그가 화내는` → `그가 화내는 걸 봤다` 링크 정상

## 검증된 핵심 파일

- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- MRK entries: 373
- MRK byte `0x1A`: 0
- `.top`: 사용 안 함
- CELL / PGRD 추가 없음
- 대량 result-script `AddTopic` 주입 없음

## 배포 ZIP

`Morrowind_Korean_ReTranslation_v1.0.7-rc6_OpenMW_0.51.0_MRK_WINDOWS_SAFE.zip`

GitHub Release asset SHA-256:

`ad9320ccc13a314f42de7a1c2928703a44bf28614744ce3ebf3ba65427e7ebc6`

## 재현용 소스

`release/rebuild_rc6.py`는 v1.0.7-rc4 검증 ZIP을 입력으로 받아 RC6의 ESP/MRK 수정과 검증을 재현하는 빌드 스크립트입니다. RC6 pre-release를 만들 때 사용한 스크립트와 동일한 blob을 저장소에 보존합니다.

RC 후보판이므로 추가 퀘스트 진행 중 링크 누락이 보이면 NPC, 표시된 대사, 빠진 토픽 이름을 함께 제보해 주세요.
