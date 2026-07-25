# TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS

Status: `PRE-AUDIT SNAPSHOT` — the repair diff is unstaged and awaits
independent Claude audit; no audit verdict or staging-safety decision is
claimed.

PASS_ID: `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`

Lane: `A`

Profile: `MINI`

Mode: `DOCS_SYNC`

## Purpose

Execute the accepted scope lock's single docs-only correction to the
`docs/FILE_MAP.md` owner-role wording for
`docs/archive/AUDIT_INDEX_ARCHIVE.md`.

The corrected meaning is:

- the archive is the immutable historical audit-ledger snapshot; and
- per-pass disposition registers live in their corresponding
  `docs/audit/*.md` artifacts.

No other deferred finding is part of this pass.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: repo-local
  `.agents/skills/tracebench-prompt-authoring/SKILL.md`,
  `tools/validate_all.py`, and exact Git/hash evidence commands
- capability actually used: `tracebench-prompt-authoring` for the scoped
  PASS_ID boundaries and the real post-change Claude audit handoff
- why applicable: this is a narrow Lane A docs-only repair inside the accepted
  future allowlist
- external tool required: `YES` — independent read-only Claude Code audit is
  required before exact human staging, commit, and push

Capability use does not widen the active allowlist.

CODE_MAP_PREFLIGHT: `NOT_APPLICABLE` — no Dart production or test file is
targeted or materially changed.

MODEL_ROUTING_CHECK result: `PASS` — Codex writes the narrow accepted-lock
docs repair, Claude Code independently audits the real diff, and the human
alone may stage, commit, and push the exact accepted set.

## Baseline evidence

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD`, local `origin/main`, local `refs/heads/main`, and live
  `refs/heads/main`:
  `f3e3401a9cd76984cbb450525878e8ab626b28e3`
- Subject: `docs: reconcile file map scope-lock audit`
- Parent: `0167901f375d6b8e2d52810b85bab4075e02194c`
- Exact HEAD changed set:
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS.md`
- Tracked and cached diffs before this pass: empty.
- All three route owners agreed:
  `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS` ->
  `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS`.
- The scope-lock artifact records Claude `ACCEPT_AS_IS` /
  `SAFE_FOR_STAGING: YES`.
- The repair artifact and repair index row did not exist.
- The stale FILE_MAP owner-role cell still read:
  `Complete historical audit ledger and archive/compaction disposition owner`.

## Exact repair

Only the archive row's owner-role cell in `docs/FILE_MAP.md` changes:

- Before:
  `Complete historical audit ledger and archive/compaction disposition owner`
- After:
  `Immutable historical audit-ledger snapshot; per-pass disposition registers live in corresponding docs/audit/*.md artifacts`

Every other FILE_MAP row, section, and loading rule remains unchanged.

## Active authority

Only `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` is active. Its exact
write allowlist is:

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS.md`

## Route and release gate

All three route owners record:

`TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` ->
`NEEDS_USER_DECISION`

The repair remains current and active until its exact six-file diff is
independently audited and accepted, then committed and pushed exactly by the
human. `NEEDS_USER_DECISION` is a non-executable sentinel, grants no write
authority, and reserves no successor pass.

## Archive and preservation boundaries

- `docs/archive/AUDIT_INDEX_ARCHIVE.md` remains the immutable historical
  audit-ledger snapshot.
- Per-pass disposition registers live in corresponding `docs/audit/*.md`
  artifacts.
- The archive, archive README, existing scope-lock artifact, and all other
  audit artifacts are inspect-only and unchanged.
- The existing five active AUDIT_INDEX anchors remain byte-identical; this pass
  adds exactly one `PRE-AUDIT SNAPSHOT` row.

## Deferred and excluded findings

The stale Board Canvas code-map status, Project Sources, skill-inventory and
AUDIT_CONTRACT findings, source-package cleanup, repo-skill hardening, code-map
expansion, runtime, schema, tool, test, Dart, Flutter, package, asset, Project
ZIP, `_incoming`, and protected-semantic work remain deferred and unarmed.

## Fresh validation evidence

- `py -3 tools\validate_all.py`: `PASS`; 302 tests ran in `38.697s`, all
  `OK`, and `validate_all.py` reported `PASSED`.
- `git diff --check`: `PASS`; line-ending conversion advisories only.
- `git diff --stat` for tracked files: 5 files, 53 insertions, 70 deletions.
  This authorized new untracked artifact is not included by that Git command.
- `git diff --numstat` for tracked files:
  `20/26 ACTIVE_SCOPE_LOCK`, `1/0 AUDIT_INDEX`, `17/21 CURRENT_STATE`,
  `1/1 FILE_MAP`, and `14/22 PASS_QUEUE`.
- Exact changed-path union: the five modified docs plus this new repair
  artifact; no unexpected path.
- `git diff --cached --name-status`: empty.
- Route and authority: all three owners record the repair ->
  `NEEDS_USER_DECISION` and the exact same six-file active allowlist.
- FILE_MAP reconstruction: exactly the one intended owner-role cell changed;
  every other byte is preserved.
- Audit-index reconstruction: exactly one repair row was added to the five
  byte-identical prior anchors; all six PASS_IDs are unique, and no glued `||`
  row exists.
- Existing-audit preservation: all 642 pre-existing audit artifacts retain
  manifest SHA-256
  `1ef635377a72707c2f554309ac52322c495b27858ffc3af3cb88012ae9f5b477`.
- Inspect-only preservation:
  - archive SHA-256:
    `eb16fd47fe8e9bb7c3f7a173467398dfb0a881d4fecec6402529fd14bb621780`
  - archive README SHA-256:
    `e067eb02e2865a90038b3bdf422841372ae12f1f97ff341869a2cc4e8057ec65`
  - accepted scope-lock artifact SHA-256:
    `1455cbae20a645ac391c2662da5957603fae0f08b7565fedfd4c93df9349bf4a`
- Known scratch remains 94 files and 43,936,062 bytes with manifest SHA-256
  `a637002037b650b27ba942001d3eb9cb07c4886b0aaaecb211684bf1a112d523`.
- Nothing is staged.

## Audit state

This six-file repair diff is unstaged and awaits independent Claude audit.
Codex issues no acceptance verdict and performs no staging, commit, or push.
