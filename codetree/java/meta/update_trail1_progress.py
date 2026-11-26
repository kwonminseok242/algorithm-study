#!/usr/bin/env python3
"""Trail1_체크리스트.md의 [x] 개수로 체크리스트·루트 README 진행률을 갱신한다."""
import json, re
from pathlib import Path

base = Path(__file__).resolve().parent
repo = base.parents[2]  # coding_test/
data = json.loads((base / "trail1_curriculum.json").read_text())
md_path = base / "Java_Trail1_체크리스트.md"
readme_path = repo / "README.md"
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


def java_note(stats, done_n, total_n):
    if total_n and done_n >= total_n:
        return "전체 완료"
    complete = [s for s in stats if s[3] > 0 and s[2] == s[3]]
    progress = [s for s in stats if s[3] > 0 and 0 < s[2] < s[3]]
    pending = [s for s in stats if s[3] > 0 and s[2] == 0]
    if complete and progress:
        last = complete[-1][0]
        cur = progress[0][0]
        done_label = f"Ch1~Ch{last}" if last > 1 else "Ch1"
        return f"{done_label} 완료 · Ch{cur} 진행"
    if complete and pending:
        last = complete[-1][0]
        cur = pending[0][0]
        done_label = f"Ch1~Ch{last}" if last > 1 else "Ch1"
        return f"{done_label} 완료 · Ch{cur} 진행"
    if progress:
        return f"Ch{progress[0][0]} 진행"
    return "시작 전"


note = java_note(ch_stats, done, total)

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
    text = re.sub(
        r"## 진행률\n.*?(?=\n## Ch1\.|\n- \[ \] Trail 1|\n## )",
        "\n".join(block),
        text,
        count=1,
        flags=re.S,
    )
else:
    text = text.replace("\n## Ch1.", "\n" + "\n".join(block) + "\n## Ch1.", 1)

md_path.write_text(text, encoding="utf-8")
print(f"checklist: {done}/{total} ({pct}%) · {note}")

# 루트 README.md Java Trail 1 진행률 동기화
if readme_path.exists():
    readme = readme_path.read_text(encoding="utf-8")
    java_section = (
        f"**Trail 1** `{bar}` **{done}/{total}** ({pct}%)  \n"
        f"[체크리스트](codetree/java/meta/Java_Trail1_체크리스트.md) 기준 · {note}\n"
        f"\n"
        f'<progress value="{done}" max="{total}"></progress>'
    )
    readme, n1 = re.subn(
        r"\*\*Trail 1\*\* `[^`]+` \*\*\d+/\d+\*\* \(\d+%\)  \n"
        r"\[체크리스트\]\([^)]+\) 기준 · [^\n]+\n"
        r"\n"
        r"<progress value=\"\d+\" max=\"\d+\"></progress>",
        java_section,
        readme,
        count=1,
    )
    readme, n2 = re.subn(
        r"\| Java Trail 1 \| \d+/\d+ \(\d+%\) \| [^|]+ \|",
        f"| Java Trail 1 | {done}/{total} ({pct}%) | {note} |",
        readme,
        count=1,
    )
    if n1 or n2:
        readme_path.write_text(readme, encoding="utf-8")
        print(f"readme: Java {done}/{total} ({pct}%) · section={n1} table={n2}")
    else:
        print("readme: Java 진행률 패턴을 찾지 못함 (수동 확인 필요)")
else:
    print(f"readme: 파일 없음 ({readme_path})")
