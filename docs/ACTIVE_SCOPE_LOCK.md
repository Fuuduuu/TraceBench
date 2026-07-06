# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only product scope revision.

## Active lock status

No runtime/test implementation allowlist is armed by this pass.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md` only if needed for taxonomy cross-reference
- `docs/audit/BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS.md`

## Product decision locked

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` was rejected because the navigation-only Komponendid hub direction sent technicians to old standalone pages as the primary workflow.

The revised direction is an in-panel Board Canvas Komponendid workflow:

- Board Canvas remains the primary technician-facing board/workbench surface.
- Komponendid work should happen beside/on the canvas where practical.
- The Komponendid panel should evolve into contextual in-panel modes.
- Standalone Add/Edit/Measure pages remain transitional/backstage routes for now.
- No route hiding, screen deletion, writer merge, or runtime implementation is authorized by this pass.

## Canonical split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Future first-slice direction

The likely first implementation slice should be a Board Canvas-only panel shell:

- convert the current read-only Komponendid hub into an in-panel mode selector / contextual shell;
- make `Paiguta` use the existing Board Canvas placement draft behavior;
- keep `Uus komponent`, `Muuda andmeid`, and `Mõõda` planned/future unless separately implemented;
- avoid navigation out to legacy standalone pages as primary UX;
- write nothing by mode switching.

## Forbidden in this pass

- No `lib/` edits.
- No `test/` edits.
- No `tools/` edits.
- No `schemas/` edits.
- No `events.jsonl` or `known_facts.json` edits.
- No `_incoming` edits.
- No route hiding or screen deletion.
- No writer merge or writer semantics change.
- No implementation allowlist arming.
- No staging, commit, or push.

## Next active-lock sync requirement

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS` must inspect live code and arm exact implementation files. Likely first-slice candidates are:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Those candidates are not armed by this scope revision.