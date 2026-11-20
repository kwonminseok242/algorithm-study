#!/usr/bin/env python3
"""Trail1_체크리스트.md의 [x] 개수로 진행률 섹션을 갱신한다."""
import json, re
from pathlib import Path

base = Path(__file__).resolve().parent
data = json.loads((base / "trail1_curriculum.json").read_text())
md_path = base / "Java_Trail1_체크리스트.md"
text = md_path.read_text(encoding="utf-8")

done = len(re.findall(r"^- \[x\] \[", text, re.M))
total = sum(len(ls.get("cards") or []) for ch in data for ls in ch["lessons"])
pct = round(done / total * 100) if total else 0
filled = round(pct / 5)
bar = "█" * filled + "░" * (20 - filled)

ch_stats = []
for ch in data:
    ch_total = sum(len(ls.get("cards") or []) for ls in ch["lessons"])
    if ch_total == 0:
        ch_stats.append((ch["order"], ch["name"], 0, 0, 0, "··········"))
        continue
    pat = rf"## Ch{ch['order']}\. .*?(?=## Ch|\Z)"
    m = re.search(pat, text, re.S)
    sec = m.group(0) if m else ""
    ch_done = len(re.findall(r"^- \[x\] \[", sec, re.M))
    p = round(ch_done / ch_total * 100)
    f = round(p / 10)
    b = "█" * f + "░" * (10 - f)
    ch_stats.append((ch["order"], ch["name"], ch_done, ch_total, p, b))

block = [
    "## 진행률",
    "",
    f"**전체** `{bar}` **{done}/{total}** ({pct}%)",
    "",
    f'<progress value="{done}" max="{total}"></progress>',
    "",
    "| Chapter | 진행 | 바 |",
    "|---|---:|:---|",
]
for order, name, d, t, p, b in ch_stats:
    if t == 0:
        block.append(f"| Ch{order}. {name} | — | `{b}` 문제명 미확보 |")
    else:
        block.append(f"| Ch{order}. {name} | {d}/{t} ({p}%) | `{b}` |")
block += [
    "",
    "> 체크박스를 `[x]`로 바꾼 뒤 이 스크립트를 다시 실행하면 진행률이 갱신됩니다.",
    "",
]

if "## 진행률" in text:
    text = re.sub(r"## 진행률\n.*?(?=\n## Ch1\.|\n- \[ \] Trail 1|\n## )", "\n".join(block), text, count=1, flags=re.S)
else:
    text = text.replace("\n## Ch1.", "\n" + "\n".join(block) + "\n## Ch1.", 1)

md_path.write_text(text, encoding="utf-8")
print(f"updated: {done}/{total} ({pct}%)")
