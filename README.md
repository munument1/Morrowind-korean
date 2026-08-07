# 모로윈드 한국어 재번역 v1.0.7-rc4

OpenMW 0.51용 한국어 재번역의 토픽 연결 전수 복구 후보판입니다.

## 배포 파일

- `Morrowind_Korean_ReTranslation_v1.0.7-rc4_OpenMW_0.51.0_MANUAL_TOPIC_CLOSURE.zip`
- SHA-256: `49aa8c70b518539b0f8519a09940cda305187f4205677e4e8d2efdd526e5511c`

## v1.0.7-rc4 핵심

- INFO를 `(부모 DIAL, INFO INAM)` 문맥으로 식별해 누락 대화를 복구했습니다.
- 기존 INFO ID 충돌 누락 66개 복구를 유지합니다.
- 원본 3개 마스터 직접 대조로 Topic/Persuasion 누락 INFO 153개를 추가 복구했습니다.
- compiled MWScript의 낡은 영문 `AddTopic` 참조 16개를 수정했습니다.
- 흐리스카르의 `금화 되찾기`와 프로케수스 살해 토픽 경로를 복구했습니다.
- 프로케수스의 잘못 번역된 기술용 ANAM 중복 INFO를 제거했습니다.
- OpenMW 0.51 `.mrk`를 사용해 안전한 implicit topic keyword를 복구했습니다.
- 자동 보류했던 토픽 36개를 전부 수동 검수하여 미결 0으로 정리했습니다.
- 전체 대사 재검증에서 새 false-positive topic edge 0, 기존 정상 edge 손실 0을 확인했습니다.
- 잘려 있던 `One destiny`, `Sixth trial`, `skin of the pearl` 응답을 복원했습니다.

## 설치

1. OpenMW를 종료합니다.
2. ZIP을 원하는 위치에 풉니다.
3. OpenMW Launcher에서 `mods/Morrowind_Korean_ReTranslation_v1.0.7-rc4`를 데이터 경로로 추가합니다.
4. `Morrowind_Korean_ReTranslation.esp`를 활성화합니다.
5. 같은 폴더의 `Morrowind_Korean_ReTranslation.mrk`는 같은 stem의 ESP용 파일로 자동 로드됩니다.
6. 예전 한국어 ESP와 v1.0.7 시험판은 비활성화합니다.

`openmw.cfg`를 덮어쓰거나 별도 encoding/fallback 설정을 추가할 필요가 없습니다.

## 검증 상태

- 보류 토픽 수동 검수: 36/36, 미결 0
- 새 오탐 topic edge: 0
- 기존 정상 topic edge 손실: 0
- `CELL=0`, `PGRD=0`
- `.top` 없음
- 구형 `@ + 0x7F + #` 링크 없음

RC 후보판이므로 새 게임 세이다 닌의 흐리스카르/프로케수스, 전사·마법사 길드 가입, 블러드문 `대장 찾기`, 모락 통 생귄/웹스피너 토픽의 실게임 회귀 확인을 권장합니다.

자세한 내용은 `release/RELEASE_NOTES_v1.0.7-rc4.md`를 확인하세요.
