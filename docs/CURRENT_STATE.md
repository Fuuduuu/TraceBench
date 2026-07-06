# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Route status

Docs-only active-lock sync is active for the future Board Canvas `Komponendid` workflow panel implementation pass.

Implementation shape decision: `A` / small Board Canvas right-panel hub-and-copy slice first.

## Armed implementation allowlist

The next implementation pass may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` files are armed.

## Implementation goal

Introduce a small Board Canvas `Komponendid` workflow panel/hub treatment that makes component workflow roles visible around the selected board/component without merging writer semantics.

The first implementation should label or group these roles in Board Canvas:

- component identity/existence creation remains `component_created` via standalone Add Component flow.
- component metadata update remains `component_updated` via standalone Edit Component flow.
- selected-component visual placement confirmation remains `component_visual_placement_confirmed` via Board Canvas `Lisa` / `Salvesta`.
- component measurement remains `measurement_recorded` via Measure Sheet flow.

## Boundary confirmation

- Board Canvas remains the primary technician-facing board/workbench surface.
- Existing explicit Board Canvas placement save behavior remains unchanged.
- Existing standalone Add/Edit and Measure Sheet writer behavior remains unchanged.
- If implementation requires Project Overview, Add/Edit screens, Measure Sheet, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits, stop and report `BLOCKED_ALLOWLIST_MISMATCH`.
- If implementation requires a broader product choice than the small Board Canvas hub/copy slice, stop and report `BLOCKED_PRODUCT_DECISION`.
- Do not stage, commit, or push.