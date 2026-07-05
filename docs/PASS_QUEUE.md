# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

The current pass is a docs-only scope-lock for future standalone Add Component / Edit Component copy and labeling cleanup.

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

## Recent Board Graph closeout

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS` was pushed as `6234e790db1590e937f14f4118dfb4ba196dc815` (`fix: classify board graph as advanced projection surface`) and closed out by `BOARD_GRAPH_LEGACY_ROUTE_IMPL_POST_AUDIT_PASS`.

Accepted behavior from that chain:

- Board Canvas is the primary board/workbench surface.
- Board Graph is advanced/debug projection inspection.
- `/project/graph` remains reachable.
- Board Graph remains no-write / no canonical facts.

## Add/Edit/Board Canvas labeling scope

`LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` classified standalone Add Component and Edit Component as `KEEP_BUT_RESKIN_LATER` transitional canonical writer flows, not trash.

This scope-lock records the canonical semantic split:

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement/documentation confirmation.

Locked product intent:

- Keep standalone Add Component and Edit Component for now as transitional canonical writer flows.
- Do not delete, hide, merge, or replace them in this pass.
- Standalone Add Component should be described as component identity/existence creation.
- Standalone Edit Component should be described as component metadata editing.
- Board Canvas `Lisa` should be described as visual placement/template confirmation for an existing component.
- Future copy should distinguish identity, metadata, and visual placement.
- Future visual reskin/V2 alignment may happen later, but is not part of this pass.

Future active-lock sync must inspect live code and decide:

- where Project Overview action labels are defined
- where standalone Add Component title/helper/safety copy is defined
- where standalone Edit Component title/helper/safety copy is defined
- whether Board Canvas `Lisa` wording should be touched in the same implementation or only referenced
- which widget tests assert the current labels
- whether copy updates can happen without router or writer changes

Likely future surfaces, not armed by this pass:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`

The active-lock sync must verify exact paths before arming an implementation allowlist.

## Future implementation boundaries

Future implementation may update labels/helper/safety copy in Project Overview, standalone Add Component, standalone Edit Component, and related widget tests.

Future implementation must not:

- change router paths
- change writer services
- change event schema
- change validator/materializer/tools
- change events.jsonl semantics
- change known_facts.json semantics
- change Board Canvas placement writer behavior
- change measurement writer behavior
- change Project Open From Directory behavior
- merge Add/Edit with Board Canvas
- hide routes
- delete screens
- remove tests

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
