# 검증 결과

## 핫픽스 1 상태

- 상태: PASS
- 이전 단일 통합 ESP: `BROKEN_RETIRED`
- 확인된 오류: 실내 지명 패치의 `CELL` 내부 `FRMR` 참조 번호가 원본 ESM 마스터 인덱스로 재매핑되지 않아 NPC와 캐릭터 생성 오브젝트가 복제됨
- 관찰 증상: 시작 부두 경비병 중복, 인구조사 절차 전 직업 선택 장면 실행

## 핫픽스 ESP

- 파일: `Morrowind_Korean_ReTranslation_v01.esp`
- 크기: 18,184,467바이트
- SHA-256: `52f973e173c037a1010a4fb91aec45a3946db6390c7e516eab96a9be629bc715`
- 전체 레코드: 45,956개
- `CELL` 레코드: 126개
- `chargen` 문자열이 포함된 `CELL` 레코드: 0개
- 번역 행: 45,881 / 45,881
- 누락: 0
- 텍스트 불일치: 0
- 검증된 스크립트 문자열: 3,714개

## 실내 지명

- 검수 완료: 1,328개
- 핫픽스 포함: 0개
- 상태: 임시 제외
- 제외 이유: 기존 빌드가 전체 `CELL` 레코드를 복사하면서 참조 번호를 로컬 신규 참조로 만들었음
- 복원 조건: 원본 ESM별 `FRMR` 마스터 인덱스 재매핑, 중복 참조 검사, 시작 구간 실제 게임 시험

## OpenMW 자산

- 상태: PASS
- l10n 영역: 8개
- 네이티브 UI 키: 456개
- fallback 문자열: 63개
- Interface 키: No=아니요; Off=끔; On=켬; Yes=예
- 폰트 패치: PASS

## 핫픽스 ZIP

- 파일: `Morrowind_Korean_ReTranslation_v01_hotfix1.zip`
- 크기: 4,230,960바이트
- SHA-256: `2a4eb6d7406e4dc58aea84f89b0f65ae1305a9698cb4fea1a5ded66d9eef556e`
- ZIP 무결성 검사: PASS
- 내부 SHA256SUMS 검사: PASS
- 설치 방식: 압축을 풀어 나온 모드 폴더를 OpenMW의 `mods` 폴더에 통째로 배치
- Google Drive 배포: 사용하지 않음

## 제한 사항

현재 작업 환경에는 OpenMW 실행 파일이 없어 실제 게임 실행 시험은 수행하지 못했습니다. 대신 문제가 발생한 `CELL` 참조가 핫픽스 ESP에 포함되지 않았는지 구조적으로 검사했으며, 시작 이벤트 관련 `chargen` 참조가 포함된 `CELL` 레코드는 0개입니다.
