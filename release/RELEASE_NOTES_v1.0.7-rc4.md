# OpenMW 0.51 Korean Translation v1.0.7-rc4

## 토픽 연결 전수 복구 후보판

v1.0.7-rc1의 추론식 DIAL 매핑을 폐기하고, 번역 시트의 DIAL 행과 `(parent DIAL, INFO INAM)` 문맥을 기준으로 다시 구축한 후보판입니다.

### 핵심 수정

- v1.0.6에서 확인된 INFO ID 충돌 누락 66개 복구 유지
- 원본 `Morrowind.esm / Tribunal.esm / Bloodmoon.esm` 직접 대조로 Topic/Persuasion 누락 INFO 153개 추가 복구 및 한국어화
- compiled MWScript의 낡은 영문 `AddTopic` 참조 16개 직접 수정
- `processusScript`의 `프로케수스 비텔리우스 살해` 연결 수정
- 프로케수스 살해 INFO 중 잘못 번역된 기술용 `ANAM`을 가진 중복 DIAL/INFO 1쌍 제거
- OpenMW 0.51 `.mrk`를 이용한 안전한 implicit topic keyword 복구
- RC2에서 자동 보류했던 36개 토픽 전부 수동 검수 완료, 미결 0
- 잘려 있던 `One destiny`, `Sixth trial`, `skin of the pearl` 응답 복원

### 회귀 방지

- `join the Mages Guild` → `마법사 길드에 가입`
- `join House Hlaalu` → `흘라알루 가문에 가입`
- `TopicsWebspinner`의 생귄 관련 27개 토픽을 서로 다른 27개 한국어 토픽으로 유지
- 흐리스카르 `금화 되찾기` 경로 복구
- 프로케수스 시체 조사 후 살해 토픽 등록 경로 복구

### 검증

- 보류 토픽 수동 검수: 36/36 완료, 미결 0
- 새 false-positive topic edge: 0
- 기존 정상 topic edge 손실: 0
- RC3 대비 실제 ESP 바이트 변경: INFO 64개 `NAME` 응답문만
- RC3의 SCPT는 바이트 단위 유지
- `CELL=0`, `PGRD=0`
- `.top` 없음
- 구형 `@ + 0x7F + #` 링크 없음
- 대량 result-script `AddTopic` 주입 없음

### 파일

`Morrowind_Korean_ReTranslation_v1.0.7-rc4_OpenMW_0.51.0_MANUAL_TOPIC_CLOSURE.zip`

SHA-256:

`49aa8c70b518539b0f8519a09940cda305187f4205677e4e8d2efdd526e5511c`

ESP SHA-256:

`c83299ebc70877b61b945a5124c5b224eb758c1fdde32e4f97a3b2434bde2fa1`

MRK SHA-256:

`0c36349316e9752a1ae0e5ef2ae6a0dc615cc960c9c6e01d694ddb259b9ba22d`

## 시험판 안내

정적·구조 검증은 통과했지만 RC 후보판이므로, 새 게임 세이다 닌의 흐리스카르/프로케수스와 전사·마법사 길드 가입, 블러드문 `대장 찾기`, 모락 통 생귄/웹스피너 토픽의 실게임 회귀 확인을 권장합니다.
