# OpenMW translation sidecar의 Windows CTRL+Z(0x1A) 문제

## 증상

OpenMW 0.51 및 현재 master의 `components/translation/translation.cpp`는 `.cel`, `.top`, `.mrk` 파일을 다음처럼 엽니다.

```cpp
std::ifstream stream(collection.getPath(fileName));
```

Windows/MSVC의 텍스트 모드에서는 입력의 `CTRL+Z` (`0x1A`)가 EOF로 해석될 수 있습니다. 한국어 레거시 멀티바이트 인코딩에서는 `0x1A`가 실제 한글 바이트열 안에 나타날 수 있으므로, MRK 파일이 그 지점에서 잘리고 뒤쪽 토픽 매핑이 전부 사라질 수 있습니다.

## 실게임 재현

v1.0.7-rc5 MRK는 387행이었고 `0x1A`가 13행에 포함되어 있었습니다. 최초 `0x1A`는 38행 안에 있었습니다.

Windows에서 `0x1A`를 제거한 진단판으로 바꾸자, 기존에는 발견되지 않던 흐리스카르의 `금화 되찾기`와 타베레 베드라노의 `그가 화내는 걸 봤다` 토픽 링크가 실게임에서 정상적으로 나타났습니다.

`파르고스의 은닉처`는 별도로 stale MRK override까지 제거한 뒤 정상 링크와 Choice 흐름을 확인했습니다.

## 소스 수정

```diff
- std::ifstream stream(collection.getPath(fileName));
+ std::ifstream stream(collection.getPath(fileName), std::ios::binary);
```

패치 파일: `patches/openmw-translation-sidecar-binary-mode.patch`

`loadDataFromStream()`은 `std::getline()` 뒤 줄 끝의 `\r`를 이미 제거하고 있으므로, binary mode로 열어도 CRLF 파일 처리는 유지됩니다.

## 권장 회귀 테스트

Windows CI에서 임시 `.mrk` 또는 `.top` 파일을 만들고, 첫 매핑과 두 번째 매핑 사이의 legacy-encoded 문자열에 바이트 `0x1A`를 포함시킨 뒤 `Storage::loadTranslationData()`가 뒤쪽 매핑까지 읽는지 확인하는 테스트가 적합합니다. Linux에서는 text/binary 차이가 거의 없으므로 Windows runner가 핵심입니다.

## 상태

- 한국어 번역 배포 측 우회: v1.0.7-rc6에서 MRK `0x1A` 0으로 처리
- OpenMW 본체 소스 수정안: 저장소 `patches/`에 보존
- upstream 반영: 별도 GitLab MR/issue 제출 필요
