# 변경 기록

## v01 단일 ESP 수동 배포본 — 2026-08-03

- 본편 번역과 실내 지명 번역을 `Morrowind_Korean_ReTranslation_v01.esp` 하나로 통합했습니다.
- `Morrowind_Korean_Interior_CellNames_v01.esp`를 폐기했습니다.
- 이전 두 ESP를 같은 순서로 불러왔을 때의 유효 레코드 상태를 단일 ESP에서 그대로 재현했습니다.
- 통합 ESP의 마스터 목록을 `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`으로 정리했습니다.
- Google Drive 배포 링크를 제거했습니다.
- 자동 설치·검증 PowerShell 스크립트를 제거했습니다.
- 배포 ZIP을 OpenMW의 `mods` 폴더에 통째로 넣는 구조로 변경했습니다.
- 원본 모로윈드 `Data Files` 폴더에 덮어쓴다는 잘못된 안내를 제거했습니다.
- 기본 `README.md`를 한국어로 변경하고 중복 `README_KO.md`를 제거했습니다.

## v01 — 2026-08-03

- 최종 검수표 51,440행을 반영했습니다.
- 게임 내 번역 45,881행을 재빌드하고 검증했습니다.
- 스크립트 정규화 과정에서 선택지와 메시지 상자 문법이 깨지지 않도록 수정했습니다.
- 실내 지명 1,328개와 관련 참조를 검증했습니다.
- OpenMW 0.51 네이티브 UI 문자열 456개를 8개 l10n 영역에 추가했습니다.
- `openmw.cfg`용 번역 fallback 문자열 63개를 추가했습니다.
- YAML 1.1 불리언으로 오인되는 `No`, `Off`, `On`, `Yes` 키를 문자열 키로 복원했습니다.
- ㅎ 표시를 보정한 SmallBatang4 비트맵 폰트를 추가했습니다.
