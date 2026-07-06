# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS

## Next recommended pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS

## Route status

Docs-only active-lock sync is active for the Board Canvas `Komponendid` hub action-gateway implementation.

The previous scope-lock is pushed as `72a6049 docs: lock board canvas components workflow actions scope` and route state now advances from scope-lock to active-lock sync.

This pass arms an implementation allowlist only. It does not implement runtime behavior, does not edit tests, does not hide or delete routes/screens, and does not change writer semantics.

## Implementation shape decision

Implementation shape: navigation-only gateway with one existing in-panel action.

Future implementation may make the existing Board Canvas `Komponendid` hub rows actionable as follows:

- `Loo komponent`: navigate to existing Add Component identity route.
- `Muuda andmeid`: navigate to existing Edit Component metadata route.
- `Paiguta`: open or focus the current Board Canvas `Lisa` / `Salvesta` visual placement panel.
- `Mõõda komponenti`: navigate to existing Measure Sheet route as a route-only action, with no measurement writer merge and no context propagation requirement.

## Implementation allowlist armed

For `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No router, Project Overview, Add Component screen, Edit Component screen, Measure Sheet screen, writer, schema, tool, materializer, validator, events, known_facts, samples/assets, Project Open From Directory, rotation normalization, or `_incoming` files are armed.

## Protected boundary reminder

The canonical split must remain unchanged:

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

No identity may be created from visual placement. No pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored canonical facts may be inferred from hub actions.

## Binding workflow safety

Never use broad staging:

- Do not run `git add .`
- Do not run `git add -A`
- Do not run `git commit -am`
- Stage exact files only when the user explicitly requests staging.