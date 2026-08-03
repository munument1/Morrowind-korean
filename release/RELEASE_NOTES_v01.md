# Morrowind 한국어 재번역 v01 — 단일 ESP 배포본

기존 본편 ESP와 실내 지명 보조 ESP를 하나의 `Morrowind_Korean_ReTranslation_v01.esp`로 통합한 대체 배포본입니다.

- 다운로드: https://drive.google.com/file/d/1AWCS8z6SoMtrq4lRyXQ5y7qS4SDiuJkw/view?usp=drivesdk
- ZIP 크기: 10,493,072바이트
- ZIP SHA-256: `dba29cc250df3925d6b4efd6c34cc71d4eb68a9d96bc242524ffefde773cf2f7`
- 통합 ESP 크기: 42,704,861바이트
- 통합 ESP SHA-256: `a5a95f64afde810c3f6ec99af416a3c8d055c4c021883722fc020042d6877562`
- 마스터: `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`

검증 결과:

- 본문·이름·추가 표시 번역 45,881행 PASS
- 스크립트 문자열 3,714행 PASS
- 실내 지명 1,328개 및 관련 참조 PASS
- 이전 두 ESP의 모든 레코드 바이트 보존 PASS
- 이전 두 ESP 로드 순서와 유효 레코드 상태 SHA-256 일치 PASS
- INFO/DIAL 그룹 구조 PASS
- OpenMW UI 456키, fallback 63개, 폰트 패치 PASS

이전 `Morrowind_Korean_Interior_CellNames_v01.esp`는 더 이상 활성화하지 마십시오. 실내 지명은 통합 ESP에 포함되어 있습니다.
