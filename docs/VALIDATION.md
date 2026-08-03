# 검증 결과

## 핫픽스 1 상태

- 상태: PASS
- 이전 단일 통합 ESP: `BROKEN_RETIRED`
- 확인된 오류: 실내 지명 패치의 `CELL` 내부 `FRMR` 참조 번호가 재매핑되지 않아 NPC와 캐릭터 생성 오브젝트가 복제됨
- 관찰 증상: 시작 부두 경비병 중복, 인구조사 절차 전 직업 선택 장면 실행

## 핫픽스 ESP

- 파일: `Morrowind_Korean_ReTranslation_v01.esp`
- 크기: 18,184,467바이트
- SHA-256: `52f973e173c037a1010a4fb91aec45a3946db6390c7e516eab96a9be629bc715`
- 전체 레코드: 45,956개
- 번역 행: 45,881 / 45,881
- 검증된 스크립트 문자열: 3,714개
- `chargen` 문자열이 포함된 `CELL` 레코드: 0개

## 실내 지명

- 검수 완료: 1,328개
- 핫픽스 포함: 0개
- 상태: 임시 제외
- 복원 조건: 원본 ESM별 `FRMR` 마스터 인덱스 재매핑, 중복 참조 검사, 시작 구간 실제 게임 시험

## OpenMW 자산

- l10n 영역: 8개
- 네이티브 UI 키: 456개
- 번역 fallback 문자열: 63개
- 폰트 fallback: 3개
- 폰트 패치: PASS

## 간편 설치 ZIP

- 파일: `Morrowind_Korean_ReTranslation_v01_hotfix1_easy.zip`
- 크기: 4,230,726바이트
- SHA-256: `2d4ff0ad2839f4ea34332f136046bacc248f87e7f16be176b7c1bba9a8b6d5f9`
- ZIP 무결성 검사: PASS
- 설치 방식: `OpenMW 0.51.0` 폴더 전체 덮어쓰기
- Google Drive 배포: 사용하지 않음

## 동봉 openmw.cfg

- 파일: `OpenMW 0.51.0/openmw.cfg`
- 크기: 9,347바이트
- SHA-256: `e331d587a6d8d0fd59bb1d0675b94353a54afd20b83c825df8de5d2656b1e746`
- `resources=./resources`: 1개
- 데이터 경로: `./resources/vfs-mw`, `./mods/Morrowind_Korean_ReTranslation_v01`
- 콘텐츠: 공식 ESM 3개 + 한국어 ESP 1개
- BSA: Morrowind, Tribunal, Bloodmoon
- `encoding=win1252`: 1개
- 번역 fallback: 63개
- SmallBatang4 폰트 fallback: 3개
- `settings.cfg` 덮어쓰기: 없음

## 제한 사항

현재 작업 환경에는 OpenMW 실행 파일이 없어 실제 게임 실행 시험은 수행하지 못했습니다. 문제가 발생한 `CELL` 참조가 핫픽스 ESP에 포함되지 않았는지는 구조적으로 검사했습니다.
