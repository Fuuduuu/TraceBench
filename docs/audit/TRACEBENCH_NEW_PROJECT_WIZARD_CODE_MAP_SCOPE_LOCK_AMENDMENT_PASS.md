# TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS

Status: `PRE-AUDIT SNAPSHOT` — this five-file docs-only amendment diff is
unstaged and awaits independent Claude audit; no audit verdict or
staging-safety decision is claimed.

PASS_ID: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS`

Lane: `A`

Mode: `DOCS_SYNC`

Profile: `SCOPE_LOCK_AMENDMENT / DOCS_ONLY`

Amends: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`

## Purpose

Repair a deficient lock. `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
reserved `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` with an exact four-file
future allowlist covering only the two map files, `docs/code_maps/CODE_MAP_INDEX.md`,
and the successor's own audit artifact. That allowlist gave the successor no
write authority over `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`,
`docs/ACTIVE_SCOPE_LOCK.md`, or `docs/AUDIT_INDEX.md`.

The successor therefore could not record its own route state or the ledger row
that `docs/AUDIT_CONTRACT.md` requires for every audit artifact. Completing it
under the four-file list would have left `Current` naming a finished pass with
no lawful way forward, forcing a follow-up pass whose only content was a pointer
reset.

The operative requirement is `docs/AUDIT_CONTRACT.md`, which states that new
audit artifacts must have a ledger row. The four-file allowlist denies the
successor the write access that row requires. That allowlist is therefore
insufficient, not absent: this lock names both its PASS_ID and an allowlist, and
is deficient only by narrowness.

`docs/PASS_LIFECYCLE.md:47-48` and `docs/PROMPTING_PROTOCOL.md:438-440` state the
amend-rather-than-sync principle for protected implementation locks. Neither
directly governs this docs-only, non-protected lock, and neither is triggered
literally here, because this lock lacks neither its PASS_ID nor its allowlist.
Both are cited only as supporting analogy. `docs/PASS_LIFECYCLE.md` separately
discourages creating a PASS_ID merely to copy a verdict. This pass amends the
lock in place and creates no closeout.

This pass creates no code map, no index row, no Dart change, no Wizard V2
product behavior, and no implementation authority.

## TOOL_SKILL_CHECK

Inspected repo-local capability before acting: `tools/` (Python validators and
`tools/validate_all.py`), `docs/code_maps/CODE_MAP_STANDARD.md`, repo-local
governance contracts, and available Claude Code tooling.

Narrowest applicable capability used: direct file edits to the five authorized
docs plus `git diff --check` and `py -3 tools/validate_all.py` for validation.
No external tool, package, install, network call, or generator was required or
used. No repo-local skill exists for scope-lock amendment authoring.

## MODEL_ROUTING_CHECK

Authored by Claude Code under explicit human authorization recorded in the
session that opened this pass. `docs/PASS_LIFECYCLE.md` enters the scope-lock
node from a route/backlog decision, so no prior allowlist could self-authorize
this amendment; the human decision is the sole entry gate.

`docs/PROMPTING_PROTOCOL.md` requires independent Claude audit for amendment
passes. This diff is offered for that audit and is not staged.

`AGENTS.md` states: "One narrow PASS_ID at a time."
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS` is already accepted,
committed, and pushed as `363d86bf81266a6205fff2f0f07d9a302077065c`, so that
PASS_ID is complete and only its route pointer remains. This amendment is a
narrow in-place fixup of that same lock. It is not a second concurrent active
pass, opens no parallel PASS_ID, and claims no concurrent active write
authority.

## CODE_MAP_PREFLIGHT

`not applicable`. This pass targets no Dart production or test file and does not
materially depend on one. It writes no code map and no index row. Both Wizard
Dart targets remain inspect-only and untouched.

## Verified baseline

- Path: `C:\Users\Kasutaja\Desktop\TraceBench`
- Remote: `origin` -> `https://github.com/Fuuduuu/TraceBench.git`
- Branch: `main`, upstream `origin/main`
- HEAD: `363d86bf81266a6205fff2f0f07d9a302077065c` (`docs: lock New Project Wizard code-map scope`)
- `origin/main`: `363d86bf81266a6205fff2f0f07d9a302077065c` — no divergence
- Index: empty; nothing staged at authoring time

## Preserved out-of-scope work

An unauthorized twelve-file documentation-repair cluster was present in the
worktree at authoring time and was outside every active allowlist. Under
explicit human decision it was preserved outside the repository as a reversible
binary patch and those exact twelve paths were restored to HEAD.

All twelve paths were verified blob-identical to HEAD immediately after restore.
Eleven of them remain HEAD-identical and carry no change from this pass. The
twelfth, `docs/AUDIT_INDEX.md`, was the cluster's single collision with this
pass, because both sets must write it. It is intentionally changed here, and by
exactly one thing: this amendment's own ledger row. Preservation was therefore a
precondition, not a convenience.

The cluster is unreviewed by this pass, remains unauthorized, and must receive
its own scope lock, its own audit, and a rebase onto post-amendment
`docs/AUDIT_INDEX.md` before any future staging.

## Amendment content

Append-only except one in-place replacement, identified exactly below. The
superseded four-file future allowlist is retained verbatim in
`docs/ACTIVE_SCOPE_LOCK.md` under `## Exact future allowlist`, marked as
historical record and no longer live authority. No prior allowlist line, audit
artifact, ledger row, or archive row was deleted or rewritten.

The single non-append change in this amendment is the in-place replacement of
the three-line stop condition in `docs/ACTIVE_SCOPE_LOCK.md` under
`## Excluded authority and stops`. Its superseded wording, "either map requires
a fifth file", encoded the four-file allowlist and became false the moment that
allowlist was superseded. It is replaced by "any file outside the exact amended
eight-file successor allowlist is required". The replacement is necessary rather
than cosmetic, narrows nothing and widens nothing, and grants no authority: it
only repoints the stop condition at the live eight-file list. No other line
anywhere in this amendment is deleted or rewritten.

The live future authority is the new `## Amended exact future allowlist`
section. `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` remains conditionally
reserved and may activate only after this amendment diff is independently
accepted and pushed. Its complete future write allowlist is exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

No other file is authorized for the successor.

## Status and audit gates for the successor

Both map files and both `docs/code_maps/CODE_MAP_INDEX.md` rows must begin as
`REVIEW_REQUIRED`.

Uncommitted worktree copies of both Wizard maps and both index rows currently
read `MAINTAINED` with `Audit evidence: none`, which contradicts the lock and
was not produced by this pass. Those worktree files were deliberately not
edited, staged, or reverted here; they are outside this pass's five-file
allowlist. The successor must revert them to `REVIEW_REQUIRED` before offering
its diff for audit.

`docs/code_maps/CODE_MAP_INDEX.md` is foreign to this pass and must never be
staged with it. Its uncommitted worktree rows were authored outside this
amendment, are outside its five-file allowlist, and belong to the successor
pass; no staging set for
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` may include
that path.

Both required audits occur inside the successor, before any staging:

1. Independent Claude map-to-code audit while both maps and both index rows
   still read `REVIEW_REQUIRED`.
2. Promotion to `MAINTAINED` only after that audit returns clean, in the same
   pass, with `Audit evidence:` citing
   `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`.
3. Final independent Claude diff audit of the complete eight-file diff.
4. Exact human `git add <file>` staging, then commit and push.

The successor advances `Current` and `Next` itself in that same pass.

## Route after this pass

Unchanged and deliberately not advanced.

- Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
- Next: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

Leaving `Current` and `Next` unchanged is deliberate, not an oversight. This
amendment is a fixup applied in place to the very lock that `Current` already
names. It is not a second active pass and runs alongside no other PASS_ID
authority, so `Current` correctly continues to name
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`. The successor advances
the route itself when it runs.

No closeout, route-release, ceremony, or pointer-reset pass may be created for
this route.

## Excluded surfaces

This pass changes no Dart production or test file, no code map, no map index
row, no schema, validator, materializer, writer, projection, tool, script,
asset, sample, package manifest, ZIP contract, router, UI, `_incoming` input, or
design handoff.

It adds no `sequence` field and changes no V2 event semantics, event envelope,
evidence-status lifecycle, or any item owned by `docs/PROTECTED_SURFACES.md`.
The `sequence` / V2 event-ordering question remains deliberately unresolved and
outside this scope.

It deletes and rewrites no prior audit artifact, ledger row, or archive row.

## Exact amendment diff

Five files, all Markdown, all inside the authorized set:

- `docs/ACTIVE_SCOPE_LOCK.md` — superseded-marker on the historical allowlist;
  new `## Amended exact future allowlist` and `## Amended status and audit
  gates` sections; pointer added to `## Future map-pass contract`; and, under
  `## Excluded authority and stops`, the in-place three-line stop-condition
  replacement of "either map requires a fifth file" with "any file outside the
  exact amended eight-file successor allowlist is required" — the only
  non-append change in this diff
- `docs/CURRENT_STATE.md` — new `## Scope-lock amendment (route unchanged)`
  section; `Current pass` and `Next recommended pass` lines untouched
- `docs/PASS_QUEUE.md` — new `## Scope-lock amendment (queue unchanged)`
  section; `Current` and `Next` untouched
- `docs/AUDIT_INDEX.md` — exactly one new ledger row for this pass
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS.md`
  — this artifact (new, untracked)

## Fresh validation evidence

- `git diff --check`: clean, exit 0
- `git diff --cached --check`: clean, exit 0; index empty
- `py -3 tools/validate_all.py`: `[OK] validate_all.py PASSED`, exit 0,
  302 tests OK; schema, event-log, project-state, and ZIP validators passed
- Expected non-blocking warnings, classified: that run emits
  `[WARN] missing optional photo file` for two distinct fixture photos,
  `photos/top_backlight_001.jpg` and `photos/smoke_top_001.jpg`, each reported
  twice (once on ZIP validation and once on directory validation), for four
  emitted lines. All are expected fixture warnings from sample projects that
  intentionally omit optional photo binaries; the behavior is pinned by
  `test_missing_optional_photo_file_is_warning_not_error`. They are
  pre-existing, unrelated to this docs-only amendment, and non-blocking; the
  run still exits 0 and reports `PASSED`.
- Twelve preserved paths verified blob-identical to HEAD after restore
- Preservation patch verified both reverse-appliable and forward-appliable

## Audit state

Independent Claude audit has not run on this amendment diff. No audit verdict,
no `SAFE_FOR_STAGING` decision, and no staging set is claimed here.

Applicable contract: `docs/AUDIT_CONTRACT.md` `Contract: scope-lock-post-audit`.

Nothing in this pass is staged, committed, or pushed.
