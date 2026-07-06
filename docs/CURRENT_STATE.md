# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only product scope-lock is active for a future Board Canvas `Komponendid` workflow panel direction.

No runtime, test, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits are authorized by this scope-lock.

## Scope intent

Board Canvas remains the primary technician-facing board/workbench surface. Component work should become more contextual to the selected board/component where practical.

Future product direction may introduce a Board Canvas right-side/contextual `Komponendid` panel that coordinates component identity, metadata, visual placement, and component-related measurement entry while keeping canonical event boundaries separate.

## Current semantic split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Locked direction

- Standalone Add Component and Edit Component remain available transitional canonical writer flows for now.
- Measure Sheet remains the current canonical measurement writer for now.
- Board Graph remains advanced/debug projection inspection.
- No routes/screens are hidden, deleted, or merged by this pass.
- No writer semantics change is authorized by this pass.
- No implementation allowlist is armed by this pass.

## Future decision still needed

A later product/implementation decision should choose whether the Board Canvas `Komponendid` workflow becomes:

- A navigation hub to existing Add/Edit/Measure flows.
- A true integrated right-panel workflow.
- A phased hybrid: first hub/copy, then integrated writer surfaces.
- Not pursued yet.

## Boundary confirmation

- This pass is docs-only.
- Future implementation must be separately scope-locked and active-lock synced before files are armed.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
