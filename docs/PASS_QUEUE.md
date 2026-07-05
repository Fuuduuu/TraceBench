# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS`

## Route status

The current pass is a docs-only active-lock sync for future standalone Add Component / Edit Component labeling cleanup.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |
| 7 | `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` | Made the missing required Add Component draft label/name reason visible while keeping `Salvesta` disabled and writer uninvoked until the label is entered. |

## Add/Edit/Board Canvas labeling sequence

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS` locked the product taxonomy:

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement/documentation confirmation.

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS` arms `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` with this exact implementation allowlist:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`

Live-code basis:

- Project Overview owns the Add/Edit/Board Canvas action labels and navigation buttons.
- Standalone Add Component owns visible identity-creation copy and `component_created` helper text.
- Standalone Edit Component owns visible metadata-edit copy and `component_updated` helper text.
- Board Canvas owns visible `Lisa komponent` / `Salvesta` copy for selected-component visual placement confirmation.
- The corresponding widget tests assert current labels and event-role copy.

Future implementation must preserve:

- routes working
- standalone Add Component as explicit human component identity/existence writer
- standalone Edit Component as explicit human metadata writer
- Board Canvas `Lisa` / `Salvesta` as visual placement confirmation for an existing component
- `component_created`, `component_updated`, and `component_visual_placement_confirmed` writer behavior
- writer contracts, event schema, `events.jsonl` as canonical truth, and `known_facts.json` as projection/cache
- Board Canvas renderer/painter read-only boundary

Future implementation must not:

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

## Scope gate rules

- One narrow pass at a time.
- Do not implement outside the active implementation allowlist.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.
