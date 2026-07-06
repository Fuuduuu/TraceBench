# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

Selected-placement edit/prefill implementation closeout is complete. The active implementation lock is released and no implementation files remain armed.

The next route is intentionally unset until the user chooses the next pass.

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
| 9 | `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS` | Added a read-only Board Canvas `Komponendid` hub card that explains component identity, metadata, placement, and measurement write domains without adding writer calls or route changes. |
| 10 | `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS` | Preserved selected component/placement context when opening `Lisa`, seeded UI-local draft geometry/template from the selected current/latest placement, kept prefill no-write, kept `Salvesta` as the only canonical placement write trigger, and covered the V1/V2 stale-placement hazard in tests. |

## Latest closeout

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_POST_AUDIT_PASS` records:

- Implementation commit: `2d796f1f773f560ff0ecb96fb94d2aac834aef9e` (`fix: prefill placement draft from selected component`).
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Manual smoke: `PASS`.
- Route released to `NEEDS_USER_DECISION`.

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