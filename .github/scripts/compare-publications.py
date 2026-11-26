#!/usr/bin/env python3
"""Compare a fresh build's publication list with the live site's.

Usage: compare-publications.py NEW_HTML LIVE_URL

Entries are the <section class="level2" id="..."> on publications.html,
matched by id. Reports "changed" if the live list can't be read.
Writes changed=true|false to $GITHUB_OUTPUT and a summary to
$GITHUB_STEP_SUMMARY (stdout when run locally).
"""

import html
import os
import re
import sys
import urllib.request

# One publication: captures its id (e.g. pmid-12345) and its HTML.
SECTION = re.compile(r'<section class="level2" id="([^"]+)">(.*?)</section>', re.S)


def entries(page):
    """{id: plain text} for every publication on the page."""
    out = {}
    for id_, body in SECTION.findall(page):
        # Strip tags and normalise whitespace, so only visible text is compared.
        text = html.unescape(re.sub(r"<[^>]+>", "", body))
        out[id_] = re.sub(r"\s+", " ", text).strip()
    return out


def fetch(url):
    """Download the live page."""
    req = urllib.request.Request(url, headers={"User-Agent": "publications-check"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read().decode("utf-8", "replace")


def emit(changed, summary):
    """Report the result to GitHub Actions (or print it when run locally)."""
    # Step output read by the workflow (steps.compare.outputs.changed).
    out = os.environ.get("GITHUB_OUTPUT")
    if out:
        with open(out, "a") as f:
            f.write(f"changed={'true' if changed else 'false'}\n")
    else:
        print(f"changed={'true' if changed else 'false'}")
    # Markdown shown on the run's summary page, for the reviewer.
    dest = os.environ.get("GITHUB_STEP_SUMMARY")
    if dest:
        with open(dest, "a") as f:
            f.write(summary + "\n")
    else:
        print(summary)


def main(new_path, live_url):
    # New build: no entries means the page format changed; fail the step.
    new = entries(open(new_path, encoding="utf-8").read())
    if not new:
        sys.exit(f"No publication entries found in {new_path}; did the page change format?")

    # Live site: if it can't be read, report "changed" so a person decides.
    try:
        live = entries(fetch(live_url))
    except Exception as e:
        emit(True, f"## Publications check\n\nCould not read the live list ({e}); "
                   f"approval needed to publish the new build ({len(new)} entries).")
        return
    if not live:
        emit(True, "## Publications check\n\nThe live page has no entries in the expected "
                   f"format; approval needed to publish the new build ({len(new)} entries).")
        return

    # Compare by id: new ids, dropped ids, and same id with different text.
    added = [i for i in new if i not in live]
    removed = [i for i in live if i not in new]
    changed = [i for i in new if i in live and new[i] != live[i]]

    if not (added or removed or changed):
        emit(False, f"## Publications check\n\nNo changes ({len(new)} entries); nothing to publish.")
        return

    # Summary for the reviewer: counts, then each added/removed/changed entry.
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
