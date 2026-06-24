# TRACEBENCH_STALE_SECONDARY_POINTER_SYNC_PASS

## Lane and type

- Lane: `A`
- Type: `CODEX / DOCS_SYNC`
- Scope: docs-only secondary pointer sync.

## Baseline

- Latest accepted/pushed pass: `TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS`.
- Latest accepted/pushed commit: `ecae600` (`docs: compact TraceBench operational handoff`).
- Current route before this pass: `NEEDS_USER_DECISION`.
- GPT Pro documentation-governance audit recommended this pass to remove stale route/current labels from secondary/source/intake docs.

## Work performed

- Reworded `docs/SOURCES_INDEX_CURRENT.md` so it is explicitly a source/design/reference index only.
- Removed stale route snapshot wording from `docs/SOURCES_INDEX_CURRENT.md`.
- Replaced old token -> Home -> menu future-sequence wording with historical-intake wording and canonical route pointers.
- Reworded `docs/WORK_INTAKE_INDEX.md` rows that still described old current/future route state:
  - `WI-071` now records historical design-gap intake only and points live route truth to canonical docs.
  - `WI-078` no longer claims current design-intake route state or stale token/Home/menu future sequencing.
- Updated `docs/AUDIT_INDEX.md` so `TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS` is accepted/pushed as `ecae600` and this pass is the current docs-only sync candidate.

## Preserved facts

- BenchBeep remains the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact remains the data-fact/subsystem name.
- Latest accepted/pushed state remains `TRACEBENCH_OPERATIONAL_HANDOFF_COMPACTION_PASS` at `ecae600`.
- Current route remains `NEEDS_USER_DECISION`.
- Menu System line remains closed.
- Source/design references remain non-runtime.
- `_incoming` remains scratch/reference-only.

## Canonical route ownership

Secondary docs do not own live route truth.

Canonical live route/status ownership remains:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Boundary confirmation

- Docs-only hygiene pass.
- No route change.
- No active-lock change.
- No runtime files changed.
- No tests changed.
- No product behavior changed.
- No source/design runtime dependency introduced.
- No protected data/write changes.
- No historical audit artifact deleted or rewritten.
- No prompt-protocol cleanup combined into this pass.
- No memory/handoff refresh combined into this pass.
- No separate missing `33d2f17` AUDIT_INDEX pointer nit addressed in this pass.
- No untracked scratch files touched or staged.
- This pass records no accepted/pushed hash for itself.

## Route

- Current pass: `TRACEBENCH_STALE_SECONDARY_POINTER_SYNC_PASS`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.

## Changed files in this pass

- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_STALE_SECONDARY_POINTER_SYNC_PASS.md`

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
