#!/usr/bin/env python3
import hashlib, json, re, shutil, sys, tempfile, zipfile
from pathlib import Path

ESP_SHA = "26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2"
MRK_SHA = "030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f"
OLD_MOD = Path("mods/Morrowind_Korean_ReTranslation_v1.0.7-rc6")
NEW_MOD = Path("mods/Morrowind_Korean_ReTranslation_v1.0.7-rc7")


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def fnt_texture_name(data: bytes) -> str:
    if len(data) != 14632:
        raise RuntimeError(f"unexpected Morrowind FNT size: {len(data)}")
    return data[12:296].split(b"\0", 1)[0].decode("ascii")


def main(rc6_zip: str, out_zip: str) -> None:
    src = Path(rc6_zip)
    out = Path(out_zip)
    with tempfile.TemporaryDirectory(prefix="mw_rc7_") as td:
        root = Path(td)
        with zipfile.ZipFile(src) as z:
            z.extractall(root)

        old = root / OLD_MOD
        new = root / NEW_MOD
        if not old.is_dir():
            raise RuntimeError(f"RC6 mod folder not found: {OLD_MOD}")
        old.rename(new)

        esp = new / "Morrowind_Korean_ReTranslation.esp"
        mrk = new / "Morrowind_Korean_ReTranslation.mrk"
        if sha(esp.read_bytes()) != ESP_SHA:
            raise RuntimeError("RC6 ESP hash mismatch")
        if sha(mrk.read_bytes()) != MRK_SHA:
            raise RuntimeError("RC6 MRK hash mismatch")

        fonts = new / "Fonts"
        aliases = {
            "magic_cards_regular.fnt": "MysticCards.fnt",
            "daedric_font.fnt": "DemonicLetters.fnt",
        }
        details = []
        for alias, original in aliases.items():
            src_fnt = fonts / original
            dst_fnt = fonts / alias
            shutil.copyfile(src_fnt, dst_fnt)
            if src_fnt.read_bytes() != dst_fnt.read_bytes():
                raise RuntimeError(f"font alias is not byte-identical: {alias}")
            tex_stem = fnt_texture_name(dst_fnt.read_bytes())
            if not (fonts / f"{tex_stem}.tex").is_file():
                raise RuntimeError(f"texture referenced by {alias} is missing: {tex_stem}.tex")
            details.append({
                "alias": alias,
                "source": original,
                "sha256": sha(dst_fnt.read_bytes()),
                "internal_texture": f"{tex_stem}.tex",
                "byte_identical": True,
            })

        for p in [root / "README_먼저읽기.txt", new / "README.md", new / "INSTALL.md", new / "RELEASE_NOTES.md"]:
            if p.exists():
                text = p.read_text(encoding="utf-8")
                text = re.sub(r"v1\.0\.7-rc6", "v1.0.7-rc7", text)
                p.write_text(text, encoding="utf-8")

        for p in root.glob("RELEASE_NOTES_v1.0.7-rc*.txt"):
            p.unlink()
        (root / "RELEASE_NOTES_v1.0.7-rc7.txt").write_text(
            "OpenMW 0.51 Korean Translation v1.0.7-rc7\n\n"
            "- RC6 gameplay payload retained byte-for-byte.\n"
            "- Added magic_cards_regular.fnt as a byte-identical alias of MysticCards.fnt.\n"
            "- Added daedric_font.fnt as a byte-identical alias of DemonicLetters.fnt.\n"
            "- Supports both OpenMW default font names and Morrowind.ini/Import Wizard font names without user cfg edits.\n",
            encoding="utf-8",
        )

        report = {
            "status": "PASS",
            "version": "v1.0.7-rc7",
            "base": "v1.0.7-rc6",
            "ESP_sha256": ESP_SHA,
            "MRK_sha256": MRK_SHA,
            "font_aliases": details,
            "cfg_font_name_compatibility": [
                "Fonts_Font_0=MysticCards",
                "Fonts_Font_0=magic_cards_regular",
                "Fonts_Font_2=DemonicLetters",
                "Fonts_Font_2=daedric_font",
            ],
            "Fonts_Font_1": "unchanged; not used for normal game UI",
        }
        docs = new / "docs"
        docs.mkdir(exist_ok=True)
        (docs / "v107_rc7_font_alias_validation.json").write_text(
            json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )

        with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as z:
            for p in sorted(root.rglob("*")):
                if p.is_file():
                    z.write(p, p.relative_to(root))

    with zipfile.ZipFile(out) as z:
        prefix = "mods/Morrowind_Korean_ReTranslation_v1.0.7-rc7/Fonts/"
        assert z.read(prefix + "magic_cards_regular.fnt") == z.read(prefix + "MysticCards.fnt")
        assert z.read(prefix + "daedric_font.fnt") == z.read(prefix + "DemonicLetters.fnt")
        esp = z.read("mods/Morrowind_Korean_ReTranslation_v1.0.7-rc7/Morrowind_Korean_ReTranslation.esp")
        mrk = z.read("mods/Morrowind_Korean_ReTranslation_v1.0.7-rc7/Morrowind_Korean_ReTranslation.mrk")
        assert sha(esp) == ESP_SHA
        assert sha(mrk) == MRK_SHA

    print("ZIP_SHA256=" + sha(out.read_bytes()))
    print("ESP_SHA256=" + ESP_SHA)
    print("MRK_SHA256=" + MRK_SHA)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: rebuild_rc7.py RC6.zip OUT.zip")
    main(sys.argv[1], sys.argv[2])
