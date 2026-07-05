# ACTIVE_SCOPE_LOCK.md

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS`

## Mode

Docs-only active-lock sync.

## Implementation pass armed

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation goal

Update copy/labels so users can clearly distinguish:

- standalone Add Component = component identity/existence creation
- standalone Edit Component = component metadata update
- Board Canvas `Lisa` / `Salvesta` = visual placement confirmation for an existing selected component

## Live-code findings used for allowlist

- `lib/features/project/screens/project_overview_screen.dart` owns Project Overview action labels and navigation for Add Component, Edit Component, and Board Canvas.
- `lib/features/components/screens/add_component_screen.dart` owns standalone Add Component title/action/helper/safety copy and `component_created` user-facing writer copy.
- `lib/features/components/screens/edit_component_screen.dart` owns standalone Edit Component title/action/helper/safety copy and `component_updated` user-facing writer copy.
- `lib/features/board_canvas/screens/board_canvas_screen.dart` owns visible `Lisa komponent` / `Salvesta` copy for selected-component visual placement confirmation.
- `test/widget/project_overview_screen_test.dart`, `test/widget/add_component_screen_test.dart`, `test/widget/edit_component_screen_test.dart`, and `test/widget/board_canvas_screen_test.dart` contain directly relevant label and event-role assertions.

## Future implementation may

- Update Project Overview action labels to distinguish identity creation, metadata edit, and Board Canvas visual placement.
- Update standalone Add Component title/helper/safety/action copy to communicate component identity/existence creation.
- Update standalone Edit Component title/helper/safety/action copy to communicate component metadata update.
- Update Board Canvas `Lisa` / `Salvesta` wording only to keep visual placement confirmation distinct from identity creation.
- Update related widget tests.

## Future implementation must

- Keep routes working.
- Keep standalone Add Component as explicit human component identity/existence writer.
- Keep standalone Edit Component as explicit human metadata writer.
- Keep Board Canvas `Lisa` / `Salvesta` as visual placement confirmation for an existing component.
- Preserve `component_created` behavior.
- Preserve `component_updated` behavior.
- Preserve `component_visual_placement_confirmed` behavior.
- Preserve writer contracts.
- Preserve event schema.
- Preserve `known_facts.json` as projection/cache.
- Preserve `events.jsonl` as canonical truth.
- Preserve Board Canvas renderer/painter read-only boundary.

## Future implementation must not

- Hide routes.
- Delete screens.
- Merge Add/Edit with Board Canvas.
- Change writer services.
- Change router paths.
- Change event schema.
- Change validator/materializer/tools.
- Mutate `known_facts.json` directly from Flutter.
- Create pins/contacts/pads/nets/traces/electrical facts.
- Create measurements.
- Create AI-authored facts.
- Change Project Open From Directory.
- Change rotation normalization.
- Change projection-stale behavior.
- Change canonical-bounds guard behavior.

## Explicitly not armed

- `lib/app/router.dart`
- writer service files
- schema files
- tool/materializer/validator files
- event or `known_facts.json` files
- measurement writer/screen files
- project open files
- `_incoming`
- samples/assets

## Stop conditions

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if the implementation requires files outside the exact allowlist above.

Stop and report `BLOCKED_PRODUCT_DECISION` if implementation requires route hiding, screen deletion, or merging Add/Edit with Board Canvas.

## Staging

Do not stage, commit, or push.
