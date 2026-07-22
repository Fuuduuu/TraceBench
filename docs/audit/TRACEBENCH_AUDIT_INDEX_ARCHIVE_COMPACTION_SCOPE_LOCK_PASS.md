# TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS

Status: `PRE-AUDIT SNAPSHOT` — no independent audit verdict or staging-safety
decision is claimed.

Lane: B
Mode: `DOCS_SYNC`

## Purpose

Lock one later docs-only pass that preserves the complete historical audit
ledger before compacting the active lookup index and records evidence-based
dispositions for stale route records. This pass performs no archive,
compaction, historical classification, closeout, implementation activation, or
audit reconciliation.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: repo-local
  `.agents/skills/tracebench-scope-lock/SKILL.md`; repo-local
  `.agents/skills/tracebench-prompt-authoring/SKILL.md` applies only to the
  post-change audit packet
- capability actually used: `tracebench-scope-lock` for the reservation and
  authority boundary; `tracebench-prompt-authoring` only for the final packet
- why applicable: the current work is a docs-only scope lock reserving one
  exact later archive/compaction pass and requiring a real post-change Claude
  audit packet
- external tool required: YES — independent Claude Code repo-local audit is
  required before any exact human staging/commit/push

`tracebench-audit-reconciliation` is not applicable because no already-returned
audit is being reconciled. Capability selection does not expand either
allowlist.

CODE_MAP_PREFLIGHT: NOT_APPLICABLE — this pass and its reserved successor are
docs-only and do not target or materially depend on Dart production/test
files.

## Baseline and route evidence

- repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- branch: `main`
- `HEAD`: `fc2ec5d1a1601de8098c317ed0d587aa57071c3b`
- local `origin/main`: `fc2ec5d1a1601de8098c317ed0d587aa57071c3b`
- live `refs/heads/main`: `fc2ec5d1a1601de8098c317ed0d587aa57071c3b`
- subject: `docs: close out board outline v2 event foundation`
- tracked diff before this pass: empty
- cached diff before this pass: empty
- incoming route in all three owners: `NEEDS_USER_DECISION` ->
  `NEEDS_USER_DECISION`
- known untracked/scratch inventory: 94 files across the 16 known scratch
  roots; no unexpected top-level path

## Current scope-lock authority

The active pass is
`TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`. It may write only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS.md`

The current pass adds exactly one audit-index row for this PASS_ID. That row
and this artifact remain `PRE-AUDIT SNAPSHOT` evidence and claim no verdict.

## Observed ledger foundation

Before the new scope-lock row, `docs/AUDIT_INDEX.md` contained 753 unique
PASS_ID rows, no duplicate PASS_ID, and deliberately mixed historical row
shapes. Its SHA-256 was
`E68CB8BC83F4C76B02B7C8212CD43FE0C12336715102E152418685E9169AF6A7`.
`docs/archive/AUDIT_INDEX_ARCHIVE.md` did not exist. The later pass must measure
and preserve its own complete starting ledger, including this scope-lock row,
before removing or compacting anything.

Each required retained anchor existed exactly once at baseline:

- `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS`
- `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS`
- `BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS`
- `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS`

Their current status text is evidence to investigate, not authority to infer a
new disposition.

## Binding owners for the future pass

- `docs/AUDIT_INDEX.md`: complete starting ledger and current lookup surface
- `docs/archive/README.md`: archive classification and historical-only rule
- `docs/FILE_MAP.md`: file-role registry to update narrowly after creation
- `docs/AUDIT_CONTRACT.md`: audit evidence and independent verdict rules
- `docs/PASS_LIFECYCLE.md`: scope-lock and later-pass activation lifecycle
- `docs/MEMORY_PROTOCOL.md` and `docs/MEMORY_MAINTENANCE.md`: archive-before-
  delete and current-versus-historical documentation rules

## Reserved future pass

Future PASS_ID: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS`

The future exact write allowlist is:

- `docs/AUDIT_INDEX.md`
- `docs/archive/AUDIT_INDEX_ARCHIVE.md`
- `docs/FILE_MAP.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

The future pass is reserved but not active. It may begin only after this exact
five-file scope-lock diff is independently accepted, the human commits and
pushes the exact accepted set, and a fresh no-drift recheck confirms that
accepted commit at `HEAD`, local `origin/main`, and live `refs/heads/main`.

## Locked future execution contract

The future pass must perform these operations in order:

1. Record the complete starting ledger's byte hash, line/row inventory, unique
   PASS_ID count, and the exact four retained-anchor counts.
2. Create `docs/archive/AUDIT_INDEX_ARCHIVE.md` and prove that every starting
   historical row, its ordering, and the existing authority/convention text
   are preserved before deleting or compacting any active-index content.
3. Add a clearly labelled disposition register covering every row whose
   status the future pass classifies or changes. Each entry must record the
   PASS_ID, truthful disposition, and concise exact evidence basis; rows not
   registered remain historical snapshot text, not newly adjudicated evidence.
4. Classify only after inspecting the exact referenced audit artifact and Git
   evidence required for that PASS_ID. Descriptive ledger prose, route
   position, naming, and status keywords are not sufficient proof by
   themselves.
5. Leave all pre-existing `docs/audit/*.md` artifacts byte-identical. The
   archive and register preserve history; they do not rewrite it.
6. Compact `docs/AUDIT_INDEX.md` to contain only its purpose/authority rules,
   the archive pointer, historical lookup instructions, and the four named
   current evidence anchors. The current scope-lock row and the future pass's
   own evidence belong in the preserved archive/register, not as additional
   active anchors.
7. Update `docs/FILE_MAP.md` only enough to register the active audit index as
   the compact lookup surface and `docs/archive/AUDIT_INDEX_ARCHIVE.md` as the
   historical ledger/disposition owner.

No starting row may disappear from both the active index and the archive. The
future pass must stop before compaction if preservation cannot be demonstrated.

## Locked future validation

The future archive/compaction pass must run and record:

- `py -3 tools\validate_all.py`
- `git diff --check`
- exact changed-file check against its four-file allowlist
- cached/staged-file check: empty
- starting-ledger preservation proof: recorded byte hash and one-for-one row
  and ordering comparison against the archived snapshot
- active-index structure check: required authority/lookup text, exact archive
  pointer, and exactly the four named anchor PASS_ID rows
- disposition check: every classified or changed row has exact artifact/Git
  evidence, while pushed-but-unaudited, pre-audit, genuinely unexecuted, and
  unresolved evidence retain their distinct truthful states
- pre-existing audit-artifact hash check: byte-identical
- final local/live-ref and known scratch-inventory no-drift checks

## Disposition rules

- A recorded independent accepted verdict may be classified as audited only
  when the exact artifact and Git evidence support it.
- A pushed pass with no recorded independent audit remains pushed-but-unaudited
  historical evidence debt. It must not become accepted or
  `RETIRED / NOT_EXECUTED`.
- A `PRE-AUDIT` record retains an explicit no-verdict disposition unless later
  exact evidence proves a verdict.
- `RETIRED / NOT_EXECUTED` is allowed only when exact evidence proves the work
  was genuinely unexecuted.
- Ambiguous or conflicting evidence remains explicitly unresolved evidence
  debt; the future pass must not guess, merge identities, or invent an outcome.

## Preserved boundaries and deferred work

The future pass must not edit existing audit artifacts, source/design inputs,
skills, policy, runtime, schemas, tools, tests, Dart, Flutter, packages, assets,
Project ZIP, or protected semantics. It must not normalize or rewrite
historical rows before their preservation is proved.

Source-package cleanup, repo-skill hardening, and code-map expansion remain
deferred. This lock creates no PASS_ID, allowlist, or activation authority for
any of them.

## Validation contract

The current scope-lock diff must pass:

- `py -3 tools\validate_all.py`
- `git diff --check`
- exact changed-file check: the five current allowlisted files only
- cached/staged-file check: empty
- route check: all three owners exactly current scope lock -> future pass
- ledger check: exactly one new matching PASS_ID row and no duplicate PASS_ID
- preservation check: every pre-existing audit-index byte remains unchanged
  apart from the single inserted row
- artifact/archive check: no existing audit artifact changed and
  `docs/archive/AUDIT_INDEX_ARCHIVE.md` remains absent
- final `HEAD`, local `origin/main`, and live `refs/heads/main` no-drift check
- known untracked/scratch inventory no-drift check apart from this new tracked
  audit artifact appearing as an untracked worktree file

Any validation failure, unexpected file change, evidence ambiguity, or
allowlist insufficiency is a hard stop.

## Post-change validation evidence

- `py -3 tools\validate_all.py`: PASS on the required rerun with temp/output
  write access; 302 tests ran and passed. The first restricted-sandbox attempt
  failed only with `PermissionError` for `.codex` outputs and Windows temp
  directories; no product assertion failed, and the permitted rerun completed
  with exit code 0.
- `git diff --check`: PASS; line-ending conversion notices only.
- exact changed-file set: PASS; exactly the five current allowlisted paths.
- cached/staged set: PASS; empty.
- route agreement: PASS; all three owners record the current scope lock and
  the reserved archive/compaction pass.
- ledger row/identity check: PASS; 754 rows, 754 unique PASS_ID values, and
  exactly one row for this scope lock.
- ledger byte-preservation check: PASS; removing only the inserted row
  reconstructs SHA-256
  `E68CB8BC83F4C76B02B7C8212CD43FE0C12336715102E152418685E9169AF6A7`.
- audit/archive boundary: PASS; no existing audit artifact changed and
  `docs/archive/AUDIT_INDEX_ARCHIVE.md` remains absent.
- known untracked/scratch inventory: PASS; the original 94 files and
  43,936,062 bytes remain, plus only this authorized new audit artifact.

## Audit state

This scope lock awaits independent Claude audit. No audit verdict is issued by
Codex and no staging, commit, or push action is authorized by this artifact.
