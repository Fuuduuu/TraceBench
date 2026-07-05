# ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

- Branch: `main`
- Latest commit during gate: `bc7e614c19987888eec0883444c31fa4dd0c924a`
- Latest commit message: `docs: lock add/edit component legacy flow labeling scope`
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- `main` aligned with `origin/main`.
- Route before this pass:
  - Current: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS`
  - Next: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

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

## Live-code findings

- Project Overview owns Add Component, Edit Component, and Board Canvas action labels and navigation buttons.
- Standalone Add Component owns visible `Lisa komponent` copy and records `component_created`.
- Standalone Edit Component owns visible `Muuda komponenti` copy and records `component_updated`.
- Board Canvas owns visible `Lisa komponent` / `Salvesta` copy for selected-component visual placement confirmation.
- Project Overview, Add Component, Edit Component, and Board Canvas widget tests assert the affected labels and event-role copy.
- Router changes are not required because current routes already exist and future work is copy/labeling only.
- Writer files are not required because writer behavior must remain unchanged.

## Implementation goal

Future implementation will update copy/labels so users can clearly distinguish:

- standalone Add Component = component identity/existence creation
- standalone Edit Component = component metadata update
- Board Canvas `Lisa` / `Salvesta` = visual placement confirmation for an existing selected component

## Future implementation must

- keep routes working
- keep standalone Add Component as explicit human component identity/existence writer
- keep standalone Edit Component as explicit human metadata writer
- keep Board Canvas `Lisa` / `Salvesta` as visual placement confirmation for an existing component
- improve labels/copy so these three meanings are not confused
- preserve `component_created` behavior
- preserve `component_updated` behavior
- preserve `component_visual_placement_confirmed` behavior
- preserve writer contracts
- preserve event schema
- preserve `known_facts.json` as projection/cache
- preserve `events.jsonl` as canonical truth
- preserve Board Canvas renderer/painter read-only boundary

## Future implementation must not

- hide routes
- delete screens
- merge Add/Edit with Board Canvas
- change writer services
- change router paths
- change event schema
- change validator/materializer/tools
- mutate `known_facts.json` directly from Flutter
- create pins/contacts/pads/nets/traces/electrical facts
- create measurements
- create AI-authored facts
- change Project Open From Directory
- change rotation normalization
- change projection-stale behavior
- change canonical-bounds guard behavior

## Route after this pass

- Current: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS`

## Boundary confirmation

- This pass is docs-only.
- No runtime files edited by this pass.
- No test files edited by this pass.
- No route hiding or screen deletion happened.
- No implementation behavior changed.
- No writer/schema/tool/materializer/validator/event/known_facts/_incoming files changed.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify docs-only diff
- verify no runtime/test files changed in this pass
