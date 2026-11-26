#!/usr/bin/env python3
"""Compare the publication list of a fresh build with the one on the live site.

Used by the weekly (scheduled) build: if nothing changed, there is nothing to
publish; if something did, the deployment waits for approval, and the summary
written here shows the reviewer what changed.

Usage: compare-publications.py NEW_HTML LIVE_URL

Each publication on publications.html is a <section class="level2" id="...">
(see publications.qmd); entries are matched by that id and compared by text.
If the live list cannot be read (site down, or a page without these sections),
this reports "changed" so that a person decides.

Writes `changed=true|false` to $GITHUB_OUTPUT and a Markdown summary to
$GITHUB_STEP_SUMMARY (both printed to stdout when run locally).
"""

import html
import os
import re
import sys
import urllib.request

SECTION = re.compile(r'<section class="level2" id="([^"]+)">(.*?)</section>', re.S)


def entries(page):
    out = {}
    for id_, body in SECTION.findall(page):
        text = html.unescape(re.sub(r"<[^>]+>", "", body))
        out[id_] = re.sub(r"\s+", " ", text).strip()
    return out


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": "publications-check"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read().decode("utf-8", "replace")


def emit(changed, summary):
    out = os.environ.get("GITHUB_OUTPUT")
    if out:
        with open(out, "a") as f:
            f.write(f"changed={'true' if changed else 'false'}\n")
    else:
        print(f"changed={'true' if changed else 'false'}")
    dest = os.environ.get("GITHUB_STEP_SUMMARY")
    if dest:
        with open(dest, "a") as f:
            f.write(summary + "\n")
    else:
        print(summary)


def main(new_path, live_url):
    new = entries(open(new_path, encoding="utf-8").read())
    if not new:
        sys.exit(f"No publication entries found in {new_path}; did the page change format?")

    try:
        live = entries(fetch(live_url))
    except Exception as e:  # network error, HTTP error, ...
        emit(True, f"## Publications check\n\nCould not read the live list ({e}); "
                   f"approval needed to publish the new build ({len(new)} entries).")
        return
    if not live:
        emit(True, "## Publications check\n\nThe live page has no entries in the expected "
                   f"format; approval needed to publish the new build ({len(new)} entries).")
        return

    added = [i for i in new if i not in live]
    removed = [i for i in live if i not in new]
    changed = [i for i in new if i in live and new[i] != live[i]]

    if not (added or removed or changed):
        emit(False, f"## Publications check\n\nNo changes ({len(new)} entries); nothing to publish.")
        return

    lines = [f"## Publications check\n",
             f"{len(added)} added, {len(removed)} removed, {len(changed)} changed "
             f"({len(live)} → {len(new)} entries). Approval needed to publish.\n"]
    for title, ids, src in [("Added", added, new), ("Removed", removed, live)]:
        if ids:
            lines.append(f"### {title}\n")
            lines += [f"- {src[i]}" for i in ids]
            lines.append("")
    if changed:
        lines.append("### Changed\n")
        for i in changed:
            lines.append(f"- **Now:** {new[i]}\n  **Was:** {live[i]}")
        lines.append("")
    emit(True, "\n".join(lines))


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
