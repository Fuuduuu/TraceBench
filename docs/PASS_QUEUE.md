# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

## Route status

Docs-only active-lock sync is active. It arms the exact implementation allowlist for the Add Component required draft label/name copy fix.

## Implementation pass armed

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code routing finding

The future implementation belongs in Board Canvas only:

- The draft label state, label input, save boundary copy, and save enable/disable gate are in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Relevant coverage and source-boundary assertions are in `test/widget/board_canvas_screen_test.dart`.
- The placement writer, project-open files, rotation-normalization files, projection-stale files outside Board Canvas, tools/materializer/validator/schema, events/known_facts, router, and `_incoming` are not armed.

## Required future behavior

- Empty required label/name disables or keeps disabled `Salvesta`.
- Visible copy explains the missing label/name without hover/click.
- Writer is not invoked while label/name is missing.
- Entering valid label/name can enable `Salvesta` when other guards pass.
- Existing guards still work: no selected component, invalid board-normalized bounds, and missing local project folder.
- Valid save still appends and shows projection-refresh truth copy.
- Draft edits / `Kustuta` / `Tühista` / navigation write nothing.

## Guard priority to preserve or document

1. no selected component
2. missing required label/name
3. invalid board-normalized bounds
4. missing local project folder

If implementation finds a better priority from live UX constraints, it must document the choice in tests/audit without changing writer/schema/event boundaries.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |

## Scope gate rules

- One narrow pass at a time.
- Do not implement outside the active implementation allowlist.
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