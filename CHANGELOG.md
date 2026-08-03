# Changelog

## v01 single-ESP refresh — 2026-08-03

- Integrated the former interior-cell support ESP into `Morrowind_Korean_ReTranslation_v01.esp`.
- Removed `Morrowind_Korean_Interior_CellNames_v01.esp` from the release package.
- Preserved every validated record byte from both component ESPs in the same effective load sequence.
- Removed the translation ESP itself from the master list; only the three official ESM masters remain.
- Updated the installer, verifier, documentation, manifest, checksums, and release archive for one-ESP installation.

## v01 — 2026-08-03

- Applied the final 51,440-row review workbook.
- Rebuilt and validated 45,881 translated game-text rows.
- Corrected script normalization so bitmap-font quotation conversion cannot break choice or message-box syntax.
- Built and validated 1,328 interior-cell IDs and references.
- Added 456 OpenMW 0.51 native UI strings across eight l10n domains.
- Added 63 translated `openmw.cfg` fallback strings.
- Restored `No`, `Off`, `On`, and `Yes` as literal YAML keys.
- Added the ㅎ-corrected SmallBatang4 bitmap font files.
