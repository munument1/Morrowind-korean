# OpenMW 0.51 Korean Translation v1.0.7-rc7

## Import Wizard 폰트 이름 호환 수정

RC7은 RC6의 ESP/MRK 게임플레이 payload를 바이트 단위로 유지하면서 폰트 파일명 호환성을 보완한 pre-release입니다.

OpenMW 자체 기본 설정은 `MysticCards` / `DemonicLetters`를 사용하지만, Morrowind.ini를 Import Wizard로 가져온 정상적인 환경에서는 `magic_cards_regular` / `daedric_font`가 사용자 `openmw.cfg`에 남을 수 있습니다. RC6는 전자 이름의 한국어 FNT만 포함했기 때문에 후자 환경에서 내장/기존 영문 폰트가 선택되어 한국어 조합용 바이트가 `Ç`, `ô`, `á` 같은 문자로 표시될 수 있었습니다.

RC7은 다음 호환 FNT를 추가합니다.

- `Fonts/magic_cards_regular.fnt`: `Fonts/MysticCards.fnt`와 바이트 단위 동일
- `Fonts/daedric_font.fnt`: `Fonts/DemonicLetters.fnt`와 바이트 단위 동일

별칭 FNT 내부의 텍스처 stem은 각각 기존 `MysticCards` / `DemonicLetters`를 유지하므로 기존 `MysticCards.tex` / `DemonicLetters.tex`를 그대로 사용합니다. 별도 TEX 복사본은 필요하지 않습니다.

## 유지되는 RC6 수정

- ESP SHA-256: `26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2`
- MRK SHA-256: `030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f`
- MRK 373행 / `0x1A` 0 / stale keyword 0
- 흐리스카르 `금화 되찾기` 링크 정상
- 흐리스카르 `파르고스의 은닉처` 링크 → 선택지 정상
- 타베레 베드라노 `그가 화내는` → `그가 화내는 걸 봤다` 링크 정상
- `.top` 없음 / CELL 0 / PGRD 0

## 폰트 검증

- `MysticCards.fnt` / `magic_cards_regular.fnt` SHA-256: `f4a361c752f937beccdfff013d65901797f3d2929f74440d4079df85629ecfcd`
- `DemonicLetters.fnt` / `daedric_font.fnt` SHA-256: `ee7ab5662eedf4cab7bdedf86e9bf5066ad5de36e2d9efed9910dec1cfdfefa2`
- 두 alias 모두 원본 FNT와 바이트 단위 동일
- alias가 참조하는 `MysticCards.tex` / `DemonicLetters.tex` 존재 확인
- `Fonts_Font_1`은 일반 게임 UI에 사용되지 않으므로 변경하지 않음

## 배포 파일

`Morrowind_Korean_ReTranslation_v1.0.7-rc7_OpenMW_0.51.0_IMPORT_FONT_ALIAS_FIX.zip`

GitHub asset SHA-256: `7337db136de43aff64449fee6307d211cf5f327d9aff0ee7dbd10ce9b274226b`

재현용 빌드 소스는 `release/rebuild_rc7.py`입니다.