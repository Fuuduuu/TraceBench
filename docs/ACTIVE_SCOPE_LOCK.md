# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Mode

Docs-only active-lock sync.

## Implementation pass armed

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS`

## Implementation-shape decision

`A` / small Board Canvas right-panel hub-and-copy slice first.

Rationale from live code:

- Project Overview already exposes distinct routes/actions for Add Component, Edit Component, Board Canvas, Measure Sheet, and Board Graph.
- Standalone Add Component already owns `component_created` identity/existence writing.
- Standalone Edit Component already owns `component_updated` metadata writing.
- Measure Sheet already owns `measurement_recorded` writing.
- Board Canvas already owns the selected-component visual-placement draft/save panel and `component_visual_placement_confirmed` writer call.
- A first Board Canvas-only hub/copy slice can improve product clarity without broad routing, writer, or screen changes.

## Exact implementation allowlist

The implementation pass may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other files are armed.

## Implementation goal

Add or refine a Board Canvas `Komponendid` workflow panel/hub treatment that is contextual to the selected board/component and makes the component workflow split visible.

The implementation may:

- add/relabel a compact `Komponendid` area in the Board Canvas right panel or contextual panel.
- present workflow entries/copy for component identity creation, metadata editing, visual placement confirmation, component measurement, and related measurement viewing.
- point users toward existing flows semantically without changing those flows.
- keep Board Canvas visual placement draft/save behavior intact.
- update Board Canvas widget tests for copy, visibility, guard behavior, and no-write paths.

## Canonical event boundaries to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Future implementation must preserve

- Board Canvas remains the primary technician-facing board/workbench surface.
- Board Canvas renderer/painter remains read-only.
- `Salvesta` remains the only canonical placement write trigger inside the Board Canvas placement panel.
- Draft edits, preview changes, `Kustuta`, `Tühista`, and navigation write nothing.
- Existing placement writer contract, projection-stale policy, rotation normalization, canonical-bounds guard, and Project Open From Directory behavior remain unchanged.
- Standalone Add/Edit Component and Measure Sheet writer behavior remains unchanged.
- No component identity is created from visual placement.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions are created by component workflow copy/hub UI.

## Explicitly not armed

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- router/app files
- writer/service files
- schema files
- validator/materializer/tool files
- `events.jsonl`
- `known_facts.json`
- samples/assets
- `_incoming`

## Stop conditions for implementation

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs any file outside the exact allowlist.

Stop and report `BLOCKED_PRODUCT_DECISION` if implementation requires a broader integrated writer panel, route hiding/deletion, writer merge, or non-copy navigation architecture decision.

## Staging

Do not stage, commit, or push.