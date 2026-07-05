# ACTIVE_SCOPE_LOCK.md

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only scope-lock.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/audit/ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS.md`

## Goal

Lock future copy/labeling cleanup for standalone Add Component and Edit Component flows so they are not confused with Board Canvas visual placement confirmation.

## Locked product intent

- Standalone Add Component and Edit Component remain transitional canonical writer flows for now.
- Standalone Add Component creates component identity/existence through `component_created`.
- Standalone Edit Component updates component metadata through `component_updated`.
- Board Canvas `Lisa` / `Salvesta` confirms visual placement for an already selected existing component through `component_visual_placement_confirmed`.
- Future copy should distinguish identity creation, metadata editing, and visual placement confirmation.
- No route hiding, screen deletion, merge, runtime implementation, or test migration is authorized by this pass.

## Canonical semantic split

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement/documentation confirmation.

## Live-code findings

- `lib/features/project/screens/project_overview_screen.dart` owns `overview-add-component-button` routing to `/project/components/add` and `overview-edit-component-button` routing to `/project/components/edit`.
- `lib/features/components/screens/add_component_screen.dart` currently uses `Lisa komponent` copy and records `component_created`.
- `lib/features/components/screens/edit_component_screen.dart` currently uses `Muuda komponenti` copy and records `component_updated`.
- `lib/features/board_canvas/screens/board_canvas_screen.dart` currently uses `Lisa komponent` / `Salvesta` copy for selected-component visual placement confirmation.
- `test/widget/project_overview_screen_test.dart`, `test/widget/add_component_screen_test.dart`, `test/widget/edit_component_screen_test.dart`, and `test/widget/board_canvas_screen_test.dart` contain assertions around the affected labels and event roles.

## Future implementation may

- Update Project Overview action rail labels.
- Update standalone Add Component title/helper/safety copy.
- Update standalone Edit Component title/helper/safety copy.
- Update Board Canvas `Lisa` wording only if the next active-lock sync separately arms it and proves it is needed for comparison clarity.
- Update related widget tests.

## Future implementation must not

- Change router paths.
- Change writer services.
- Change event schema.
- Change validator/materializer/tools.
- Change `events.jsonl` semantics.
- Change `known_facts.json` semantics.
- Change Board Canvas placement writer behavior.
- Change measurement writer behavior.
- Change Project Open From Directory behavior.
- Merge Add/Edit with Board Canvas.
- Hide routes.
- Delete screens.
- Remove tests.

## Expected future implementation surfaces

Not armed by this pass. The next active-lock sync must inspect live code and arm exact paths.

Likely surfaces to verify:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`

## Explicitly not armed

- `lib/`
- `test/`
- `tools/`
- `schemas/`
- `events.jsonl`
- `known_facts.json`
- `_incoming`
- router changes
- writer behavior changes

## Staging

Do not stage, commit, or push.
