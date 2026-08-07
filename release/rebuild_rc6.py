#!/usr/bin/env python3
import sys, zipfile, tempfile, shutil, hashlib, base64, zlib, json, struct, re
from pathlib import Path

RC4_ZIP_SHA="49aa8c70b518539b0f8519a09940cda305187f4205677e4e8d2efdd526e5511c"
ESP4_SHA="c83299ebc70877b61b945a5124c5b224eb758c1fdde32e4f97a3b2434bde2fa1"
ESP6_SHA="26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2"
MRK6_SHA="030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f"
PATCH_B64="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"
FARGOTH_KEY=bytes.fromhex("87a17f15c97f10b77f19c97f1bd17f201bc9e112d6dc1ea67f")
OUT_NAME="Morrowind_Korean_ReTranslation_v1.0.7-rc6_OpenMW_0.51.0_MRK_WINDOWS_SAFE.zip"

def sha(b): return hashlib.sha256(b).hexdigest()

def parse_records(data):
    out=[]; o=0
    while o+16<=len(data):
        h=bytearray(data[o:o+16]); s=struct.unpack_from("<I",h,4)[0]; e=o+16+s
        if e>len(data): raise RuntimeError("bad ESP record")
        out.append([h,data[o+16:e]]); o=e
    if o!=len(data): raise RuntimeError("trailing ESP bytes")
    return out

def subs(p):
    out=[]; o=0
    while o<len(p):
        t=p[o:o+4]; s=struct.unpack_from("<I",p,o+4)[0]; e=o+8+s
        if e>len(p): raise RuntimeError("bad INFO subrecord")
        out.append([t,p[o+8:e]]); o=e
    return out

def pack_subs(srs):
    b=bytearray()
    for t,v in srs: b += t+struct.pack("<I",len(v))+v
    return bytes(b)

def patch_esp(data):
    if sha(data)!=ESP4_SHA: raise RuntimeError("unexpected RC4 ESP")
    patches=json.loads(zlib.decompress(base64.b64decode(PATCH_B64)))
    rr=parse_records(data)
    if len(patches)!=29: raise RuntimeError("patch table corrupt")
    for idx_s,v64 in patches.items():
        idx=int(idx_s); h,p=rr[idx]
        if h[:4]!=b"INFO": raise RuntimeError(f"record {idx} is not INFO")
        srs=subs(p); found=False
        for sr in srs:
            if sr[0]==b"NAME":
                sr[1]=base64.b64decode(v64); found=True; break
        if not found: raise RuntimeError(f"INFO {idx} has no NAME")
        rr[idx][1]=pack_subs(srs)
    out=bytearray()
    for h,p in rr:
        struct.pack_into("<I",h,4,len(p)); out += h+p
    out=bytes(out)
    if sha(out)!=ESP6_SHA: raise RuntimeError("RC6 ESP hash mismatch: "+sha(out))
    return out

def patch_mrk(data):
    lines=data.splitlines()
    if len(lines)!=387: raise RuntimeError("unexpected RC4 MRK row count")
    kept=[]
    removed_ctrlz=0; removed_stale=0
    for line in lines:
        if b"\x1a" in line:
            removed_ctrlz += 1; continue
        if b"\t" in line and line.split(b"\t",1)[0]==FARGOTH_KEY:
            removed_stale += 1; continue
        kept.append(line)
    out=b"\n".join(kept)+b"\n"
    if removed_ctrlz!=13 or removed_stale!=1 or len(kept)!=373:
        raise RuntimeError(f"MRK repair counts wrong: {removed_ctrlz}/{removed_stale}/{len(kept)}")
    if b"\x1a" in out: raise RuntimeError("CTRL+Z remains in MRK")
    if sha(out)!=MRK6_SHA: raise RuntimeError("RC6 MRK hash mismatch: "+sha(out))
    return out

def main(src,out):
    src=Path(src); out=Path(out)
    if sha(src.read_bytes())!=RC4_ZIP_SHA: raise RuntimeError("unexpected RC4 ZIP")
    with tempfile.TemporaryDirectory() as td:
        root=Path(td)
        with zipfile.ZipFile(src) as z: z.extractall(root)
        old=root/"mods/Morrowind_Korean_ReTranslation_v1.0.7-rc4"
        new=root/"mods/Morrowind_Korean_ReTranslation_v1.0.7-rc6"
        old.rename(new)
        esp=new/"Morrowind_Korean_ReTranslation.esp"
        mrk=new/"Morrowind_Korean_ReTranslation.mrk"
        esp.write_bytes(patch_esp(esp.read_bytes()))
        mrk.write_bytes(patch_mrk(mrk.read_bytes()))
        (root/"README_먼저읽기.txt").write_text("""모로윈드 한국어 재번역 v1.0.7-rc6 — OpenMW 0.51.0
Windows/OpenMW 실게임 테스트로 확인된 대화 토픽 연결 수정 후보판입니다.

핵심:
- MRK 373행 / 0x1A 0
- RC4의 0x1A 포함 MRK 13개 제거 후 해당 토픽을 대사 직접 연결로 복구
- 흐리스카르: 금화 되찾기 -> 파르고스의 은닉처 -> 선택지 실게임 확인
- 타베레 베드라노: 그가 화내는 -> 그가 화내는 걸 봤다 실게임 확인
- ESP SHA-256: 26da6c578d7136eb0e12f63d4e2d326cef2c10d7e4a148684c65136f753052e2
- MRK SHA-256: 030bb6acb37f1d5718d0af7c4c49367f596dc95e7f75805113a5707bb69b675f
""",encoding="utf-8")
        for p in [new/"README.md",new/"INSTALL.md",new/"RELEASE_NOTES.md"]:
            if p.exists():
                s=p.read_text(encoding="utf-8").replace("v1.0.7-rc4","v1.0.7-rc6")
                p.write_text(s,encoding="utf-8")
        (new/"RELEASE_NOTES.md").write_text("""# v1.0.7-rc6

OpenMW 0.51 / Windows 실게임에서 발견된 MRK 로딩 및 stale override 문제를 수정했습니다.

- MRK: 373행, 0x1A 0
- 0x1A 포함 13개 MRK 토픽은 직접 응답 연결로 전환
- 파르고스의 은닉처 stale MRK override 제거
- 흐리스카르 퀘스트 링크/선택지 실게임 확인
- 타베레 베드라노 `그가 화내는` 링크 실게임 확인
- ESP/MRK 핵심 파일은 로컬 검증 RC6과 동일한 SHA-256
""",encoding="utf-8")
        (new/"docs/validation_rc6_release_rebuild.json").write_text(json.dumps({
            "status":"PASS","ESP_sha256":ESP6_SHA,"MRK_sha256":MRK6_SHA,
            "MRK_entries":373,"MRK_0x1A":0,"direct_INFO_NAME_repairs_from_RC4":29,
            "runtime_confirmed":["금화 되찾기","파르고스의 은닉처","그가 화내는 걸 봤다"]
        },ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
        for p in root.glob("RELEASE_NOTES_v1.0.7-rc4.txt"): p.unlink()
        (root/"RELEASE_NOTES_v1.0.7-rc6.txt").write_text("OpenMW 0.51 Korean Translation v1.0.7-rc6\nWindows-safe MRK and runtime-confirmed early quest topic chain fixes.\n",encoding="utf-8")
        with zipfile.ZipFile(out,"w",compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
            for p in sorted(root.rglob("*")):
                if p.is_file(): z.write(p,p.relative_to(root))
    print("ZIP_SHA256="+sha(out.read_bytes()))
    print("ESP_SHA256="+ESP6_SHA)
    print("MRK_SHA256="+MRK6_SHA)

if __name__=="__main__":
    if len(sys.argv)!=3: raise SystemExit("usage: rebuild_rc6.py RC4.zip OUT.zip")
    main(sys.argv[1],sys.argv[2])
