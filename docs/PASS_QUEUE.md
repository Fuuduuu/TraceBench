# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock is active. It locks a future Add Component / `Lisa komponent` UX copy fix for the missing required draft label/name save blocker.

## Locked problem statement

Manual smoke showed that `Salvesta` becomes inactive when the required draft label/name is empty, but the UI does not make that reason clear enough. The future implementation must show persistent visible copy explaining the missing label/name requirement.

Suggested copy intent for the future implementation:

- `Lisa nimi enne salvestamist.`
- `Komponendi nimi on salvestamiseks vajalik.`
- `Sisesta nimi, et paigutus salvestada.`

Exact final copy may be refined during implementation, but it must be concise, user-facing, and explicit.

## Locked behavior for future implementation

- Empty required label/name disables or keeps disabled `Salvesta`.
- Missing-label reason is visible without hover, tooltip, or clicking a disabled button.
- Writer is not invoked while label/name is missing.
- `events.jsonl` does not grow while label/name is missing.
- Entering a valid label/name can enable `Salvesta` only when other guards are satisfied.
- Existing guards remain intact: no selected component, invalid `board_normalized` bounds, and missing local project folder.
- Valid save still appends and shows projection-refresh truth copy.
- Draft edits / `Kustuta` / `Tühista` / navigation write nothing.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |

## Future implementation questions

The next active-lock sync must inspect live code and decide:

- Where the required draft label/name validation currently lives.
- Whether `Salvesta` is disabled because label is missing, or because multiple guards collapse into one state.
- Where the best persistent helper/error copy belongs.
- How to order messages when multiple guards are active: no selected component, missing required label/name, invalid bounds, and no local project folder.
- Which widget tests need to assert the disabled reason.

## Future implementation surfaces

No implementation allowlist is armed in this pass. The next active-lock sync must read live code and arm exact files.

Likely candidate surfaces, not armed here:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active implementation lock.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.