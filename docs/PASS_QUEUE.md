# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. The Board Canvas `Komponendid` workflow hub implementation is closed out.

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

## Board Canvas `Komponendid` workflow panel sequence

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS` locked the product direction: Board Canvas is the primary technician-facing board/workbench surface, while standalone Add/Edit and Measure Sheet remain the current canonical writer flows.

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS` armed `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS` with the exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS` was pushed as `2d08eb6464c4a0edf6eef886accfcc5836a4f912` (`feat: add board canvas components workflow hub`) and is closed out by `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_POST_AUDIT_PASS`.

Accepted result:

- Board Canvas Add Component / `Lisa` panel now includes a read-only `Komponendid` hub card.
- The hub explains four separate write domains:
  - `component_created` = component identity/existence creation.
  - `component_updated` = component metadata update.
  - `component_visual_placement_confirmed` = visual placement confirmation.
  - `measurement_recorded` = measurement write.
- The hub is display-only / informational.
- It introduces no writer calls, no buttons/actions, no route changes, no setState behavior, and no canonical writes.
- Existing `Salvesta` behavior, placement writer invocation, required-label guard, canonical-bounds guard, rotation normalization, and projection-stale behavior remain unchanged.
- Board Canvas renderer/painter remains read-only.
- No writer/schema/tool/materializer/validator/events/known_facts/_incoming changes were made.

Accepted audit nit:

- Codex/change summary understated the implementation as copy polish; actual diff added a new read-only `Komponendid` hub card.
- Audit accepted this as within scope and non-blocking.

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
