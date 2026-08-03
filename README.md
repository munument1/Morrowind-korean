# Morrowind Korean ReTranslation

OpenMW 0.51 Korean retranslation package for Morrowind, Tribunal, and Bloodmoon.

The validated v01 package uses one ESP containing the translated game text, scripts, names, and 1,328 interior-cell localizations. It also contains 456 OpenMW native UI strings, 63 fallback configuration strings, and the patched bitmap-font set.

## Download

- Archive: https://drive.google.com/file/d/1AWCS8z6SoMtrq4lRyXQ5y7qS4SDiuJkw/view?usp=drivesdk
- SHA-256: `dba29cc250df3925d6b4efd6c34cc71d4eb68a9d96bc242524ffefde773cf2f7`
- Size: 10,493,072 bytes

## Install

Korean instructions: [README_KO.md](README_KO.md)

On Windows, extract the archive to an ASCII-only path, run `tools/Verify-Package.ps1`, then run `tools/Install-OpenMW-Korean.ps1`.

## Validation summary

- 51,440 reviewed rows complete
- 45,881 game-text rows verified
- 3,714 script strings verified
- 1,328 interior cell IDs integrated and verified
- former two-ESP effective record state reproduced exactly in one ESP
- 456 OpenMW native UI keys verified
- 63 OpenMW fallback strings verified
- font patch: PASS
