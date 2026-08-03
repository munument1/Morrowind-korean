# Validation

## Final review workbook

- Status: PASS
- Total completed rows: 51,440
- Sheet rows: 본문 35,926; 이름 7,163; 추가 표시 2,792; 스크립트 3,714; 실내 지명 1,328; OpenMW UI 517
- Changed translations applied: 본문 422; 이름 219; 추가 표시 403; 스크립트 2,781; 실내 지명 652; OpenMW UI 289
- Restored YAML keys affected by YAML 1.1 boolean parsing: `No`, `Off`, `On`, `Yes`

## Integrated single ESP

- Status: PASS
- File: `Morrowind_Korean_ReTranslation_v01.esp`
- Bytes: 42,704,861
- SHA-256: `a5a95f64afde810c3f6ec99af416a3c8d055c4c021883722fc020042d6877562`
- Masters: `Morrowind.esm`, `Tribunal.esm`, `Bloodmoon.esm`
- Records: 50,892
- Expected and verified translation rows: 45,881
- Missing rows: 0
- Text mismatches: 0
- SCPT rows: 900 / 900
- INFO script rows: 2,814 / 2,814
- Interior cell IDs: 1,328 / 1,328
- Renamed cell record occurrences: 1,340
- Renamed pathgrid records: 1,238
- Residual exact or quoted English references: 0
- Exact component record bytes preserved: PASS
- Effective record state equal to former two-ESP load sequence: PASS
- INFO records without a DIAL parent group: 0

## OpenMW assets

- Status: PASS
- Native UI source strings: 456
- Native UI runtime strings: 456
- Fallback strings: 63
- Domain counts: Calendar 35; Interface 58; OMWCamera 36; OMWCombat 9; OMWControls 97; OMWEngine 177; OMWMusic 5; OMWShaders 39
- Interface boolean keys: No=아니요; Off=끔; On=켬; Yes=예
- Font patch: PASS

## Package-level verification

Run from the extracted package root:

```powershell
.\tools\Verify-Package.ps1
```

The verifier checks every file listed in `SHA256SUMS.txt`, the integrated ESP hash, absence of the retired interior ESP, eight l10n domains, the 456-key aggregate, the four quoted Interface boolean keys, and the 63 runtime fallback lines.
