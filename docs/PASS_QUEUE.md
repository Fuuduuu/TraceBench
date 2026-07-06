# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Route status

The current pass is a docs-only active-lock sync arming the first narrow Board Canvas `Komponendid` workflow panel implementation slice.

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
| 8 | `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` | Clarified Project Overview, standalone Add Component, standalone Edit Component, and Board Canvas copy so identity creation, metadata edit, and visual placement confirmation are not confused. |

## Board Canvas `Komponendid` workflow implementation lock

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS` arms `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`.

Implementation-shape decision: `A` / small Board Canvas right-panel hub-and-copy slice first.

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The implementation should make Board Canvas component workflow roles visible without moving or merging writers:

- `Loo komponent` / identity creation remains the standalone Add Component `component_created` flow.
- `Muuda andmeid` / metadata update remains the standalone Edit Component `component_updated` flow.
- `Paiguta` / visual placement confirmation remains the selected-component Board Canvas `component_visual_placement_confirmed` flow.
- `Mõõda komponenti` / measurement remains the Measure Sheet `measurement_recorded` flow.

If implementation requires Project Overview, Add/Edit screens, Measure Sheet, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.

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