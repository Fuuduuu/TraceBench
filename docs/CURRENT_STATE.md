# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS`

## Route status

Docs-only active-lock sync is active for the future Add/Edit Component legacy-flow labeling implementation.

No runtime, test, router, writer, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits are authorized by this sync pass.

## Active-lock result

The implementation pass `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` is armed with the exact live-code allowlist:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`

## Scope intent

Future implementation may update copy/labels so users can clearly distinguish:

- standalone Add Component = component identity/existence creation through `component_created`
- standalone Edit Component = component metadata update through `component_updated`
- Board Canvas `Lisa` / `Salvesta` = visual placement confirmation for an existing selected component through `component_visual_placement_confirmed`

## Boundary confirmation

- Routes must keep working.
- No route hiding or screen deletion is armed.
- No writer service, router path, schema, validator, materializer, tool, event, `known_facts.json`, sample, asset, Project Open From Directory, rotation normalization, projection-stale, or canonical-bounds behavior change is armed.
- The sync pass itself made docs-only route/lock changes.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
