# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` is closed out after pushed implementation and accepted audit.

No next implementation pass is armed.

## Latest closeout

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_POST_AUDIT_PASS`

Recorded:

- implementation commit `c773c413f6d8588e1043de5822e6c30cadf918f2` (`fix: explain missing add component draft label`)
- Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- manual smoke `PASS`
- safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |
| 7 | `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` | Made the missing required Add Component draft label/name reason visible while keeping `Salvesta` disabled and writer uninvoked until the label is entered. |

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


## Legacy surface classification planning

`LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` is a docs-only classification pass. It keeps the active route at `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` and records durable app-surface labels in `docs/PROJECT_MEMORY.md`.

No deletion/hiding/removal is authorized by the classification. Later cleanup must use small scoped passes: docs labeling, route hiding/debug-only scope, test migration, and removal only after replacement/proof.

Likely future candidates, not armed:

- `BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`
- `ADD_EDIT_COMPONENT_LEGACY_FLOW_REVIEW_PASS`
- `MEASURE_SHEET_V2_ALIGNMENT_SCOPE_LOCK_PASS`
