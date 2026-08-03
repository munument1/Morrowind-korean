# v01 배포 안내 — 2026-08-03

## 다운로드

- Google Drive ZIP: https://drive.google.com/file/d/1fSaNBgao9cFF37Tw0gLsU8UF8-sUk-Q_/view?usp=drivesdk
- 배포 폴더: https://drive.google.com/drive/folders/1pKjVx75OYFycEO0NmpmZbIjlADDITCKc
- 파일 크기: 10,518,356바이트
- SHA-256: `6a538e3eeef74a6b4d7c1aa9a193a9bc44803f1d914a7b5d88041faa11d952fb`

## 포함 범위

- 최종 검수표 51,440행 반영
- 본편 통합 ESP 45,881행 검증
- 스크립트 문장 3,714개 검증
- 실내 지명 1,328개 ID 검증
- OpenMW 네이티브 UI 456개 키
- `openmw.cfg` 설정 문자열 63개
- ㅎ 보정 SmallBatang4 비트맵 폰트

## 설치

ZIP을 ASCII 경로에 풀고 `tools/Verify-Package.ps1`을 실행한 뒤 `tools/Install-OpenMW-Korean.ps1`을 실행하십시오. 설치 도구는 기존 OpenMW 설정을 백업하고 필요한 데이터 경로, 플러그인, 폰트, UI 언어 및 fallback 문자열을 중복 없이 반영합니다.
