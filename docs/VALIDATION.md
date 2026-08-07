# 검증 결과

## v1.0.7-rc6 상태

- 상태: `RC_PASS_WINDOWS_SAFE_MRK`
- 대상: OpenMW 0.51.0
- GitHub Pre-release: `v1.0.7-rc6`
- 배포 ZIP: `Morrowind_Korean_ReTranslation_v1.0.7-rc6_OpenMW_0.51.0_MRK_WINDOWS_SAFE.zip`
- GitHub asset SHA-256: `ad9320ccc13a314f42de7a1c2928703a44bf28614744ce3ebf3ba65427e7ebc6`

## 게임플레이 payload

- ESP: `Morrowind_Korean_ReTranslation.esp`
- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK: `Morrowind_Korean_ReTranslation.mrk`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- MRK entries: 373
- MRK byte `0x1A`: 0
- stale MRK keyword: 0
- duplicate MRK topic key: 0
- duplicate MRK keyword value: 0

## RC6에서 닫은 런타임 문제

### Windows MRK EOF

OpenMW 0.51은 `.mrk/.top/.cel` 번역 sidecar를 `std::ifstream`으로 읽습니다. 한국어 레거시 인코딩에서 실제 글자 구성에 쓰이는 바이트 `0x1A`가 Windows 텍스트 모드에서 EOF처럼 작동할 수 있어 기존 MRK의 뒤쪽 항목이 로드되지 않는 현상을 실게임에서 확인했습니다.

RC6에서는 MRK 안의 `0x1A`를 0개로 만들었습니다. `0x1A`가 들어가던 13개 토픽은 MRK에서 제거하고 관련 응답문에 실제 한국어 DIAL명이 직접 나타나도록 복구했습니다.

### stale MRK override

RC5에서 `파고스의 은닉처`를 `파르고스의 은닉처`로 고친 뒤에도 MRK에는 이전 철자의 keyword override가 남아 있었습니다. RC6에서는 이 override를 제거하여 OpenMW가 현재 DIAL 문자열 자체를 keyword로 사용하도록 했습니다.

## 실게임 확인

- 흐리스카르 `금화 되찾기`: 링크 정상
- 흐리스카르 `파르고스의 은닉처`: 링크 정상
- `파르고스의 은닉처` 선택 후 Choice 표시: 정상
- 타베레 베드라노 `그가 화내는` → `그가 화내는 걸 봤다`: 링크 정상

## 구조 검증

- RC4 이후 변경 범위: INFO 응답 `NAME` 29개 + MRK 정리
- 기술 서브레코드 변경: 없음
- 레코드 수 변경: 없음
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

## 재현성

`release/rebuild_rc6.py`는 RC6 GitHub Pre-release를 생성할 때 실제로 사용한 재구축 스크립트입니다. 입력 RC4 ZIP의 SHA-256을 확인한 뒤 패치를 적용하고, ESP/MRK의 예상 SHA-256 및 MRK의 `0x1A` 부재를 검증합니다.

관련 메타데이터는 `release/manifest-v1.0.7-rc6.json`, 체크섬은 `release/SHA256SUMS_v1.0.7-rc6.txt`에 기록합니다.

## 남은 상태

RC6는 정식 stable이 아니라 pre-release입니다. 현재 제보된 세이다 닌 초반 토픽 경로는 실게임에서 확인했지만, 전체 게임의 모든 NPC/퀘스트 분기를 플레이한 것은 아닙니다. 추가 누락이 발견되면 NPC, 화면에 나온 대사, 기대한 토픽 이름을 기준으로 재현합니다.
