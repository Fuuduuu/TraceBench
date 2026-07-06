# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Route status

Docs-only active-lock sync is active for the selected-placement edit/prefill implementation pass.

This pass arms the implementation allowlist only. It does not implement runtime behavior and does not edit tests.

## Latest accepted baseline

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_POST_AUDIT_PASS` closed out pushed implementation commit `2d08eb6464c4a0edf6eef886accfcc5836a4f912` (`feat: add board canvas components workflow hub`).

Current scope-lock commit in live git log:

- `3596e1a` (`docs: lock selected placement edit prefill scope`)

## Implementation pass armed

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings

- Board Canvas owns the selected placement context, the Add Component / `Lisa` rail, local draft fields, save guards, and placement writer call site.
- `_selectedPlacementKey` is the volatile Board Canvas selection key.
- `_addComponentTemplatePlacementContextKey` carries the selected existing placement/component context into the Add Component panel.
- The panel already renders `Valitud komponent: ...` or `Valitud komponent: puudub`.
- Draft label, width, height, rotation, center, template, and save guard behavior are implemented in `lib/features/board_canvas/screens/board_canvas_screen.dart` and covered by `test/widget/board_canvas_screen_test.dart`.
- The placement writer contract is already established and does not need to change for this pass.

## Implementation requirement summary

The implementation pass must seed or prefill the Board Canvas visual placement draft from the currently selected existing placement where safe.

It must preserve:

- selected existing component as the required placement-confirm context
- UI-local draft seeding and draft edits until explicit `Salvesta`
- `Salvesta` as the only canonical placement write trigger
- existing required-label, canonical-bounds, local-folder, projection-stale, and rotation-normalization behavior
- Board Canvas renderer/painter read-only boundary

Critical stale-projection requirement:

- The implementation must not prefill from stale older placement data.
- Tests must prove the selected draft uses the current/latest placement value intended by the app projection, including the V1/V2 stream-order hazard recorded by placement projection ordering work.

## Boundary confirmation

- Docs-only active-lock sync.
- No runtime files edited.
- No test files edited.
- No placement writer, Add/Edit Component standalone, Project Overview, project-open, route, schema, validator, materializer, event, `known_facts.json`, sample, asset, or `_incoming` file is armed or edited by this sync.
- Do not use `git add .`, `git add -A`, or `git commit -am`.