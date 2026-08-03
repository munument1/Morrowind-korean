# 검증 결과

## 최종 검수표

- 상태: PASS
- 완료 행: 51,440
- 시트별 행: 본문 35,926; 이름 7,163; 추가 표시 2,792; 스크립트 3,714; 실내 지명 1,328; OpenMW UI 517
- 수정 반영: 본문 422; 이름 219; 추가 표시 403; 스크립트 2,781; 실내 지명 652; OpenMW UI 289
- YAML 키 복원: `No`, `Off`, `On`, `Yes`

## 단일 통합 ESP

- 상태: PASS
- 파일: `Morrowind_Korean_ReTranslation_v01.esp`
- 크기: 42,704,861바이트
- SHA-256: `a5a95f64afde810c3f6ec99af416a3c8d055c4c021883722fc020042d6877562`
- 마스터: `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`
- 레코드: 50,892개
- 번역 행: 45,881 / 45,881
- 누락: 0
- 텍스트 불일치: 0
- SCPT 문자열: 900 / 900
- INFO 스크립트 문자열: 2,814 / 2,814
- 실내 지명 ID: 1,328 / 1,328
- 이름이 변경된 CELL 레코드: 1,340개
- 이름이 변경된 PGRD 레코드: 1,238개
- 잔존 영문 정확 일치·인용 참조: 0
- 기존 두 ESP의 구성 레코드 바이트 보존: PASS
- 기존 두 ESP 로드 순서의 유효 레코드 상태와 동일: PASS
- DIAL 상위 그룹이 없는 INFO 레코드: 0

## OpenMW 자산

- 상태: PASS
- 네이티브 UI 원본 문자열: 456개
- 네이티브 UI 런타임 문자열: 456개
- fallback 문자열: 63개
- 영역별 개수: Calendar 35; Interface 58; OMWCamera 36; OMWCombat 9; OMWControls 97; OMWEngine 177; OMWMusic 5; OMWShaders 39
- Interface 키: No=아니요; Off=끔; On=켬; Yes=예
- 폰트 패치: PASS

## 단순 배포 ZIP

- 파일: `Morrowind_Korean_ReTranslation_v01.zip`
- 크기: 10,653,085바이트
- SHA-256: `361e432ff7615609d7f1001950673420b2671537517dc8725d397ac3eb4fda46`
- ZIP 무결성 검사: PASS
- 최상위 구성: `README.md`, `Data Files`, `OpenMW Config`, `SHA256SUMS.txt`
- 설치 방식: 압축 안의 `Data Files` 폴더를 기존 모로윈드 `Data Files` 폴더에 병합·덮어쓰기
- Google Drive 배포: 사용하지 않음
- 자동 설치 스크립트: 포함하지 않음
