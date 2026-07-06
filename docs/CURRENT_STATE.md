# Current State

## Current pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Route status
Docs-only active-lock sync for the first small Visual First component workflow cleanup slice.

Baseline verified from live git/docs:
- Latest pushed scope-lock commit: `ecba121 docs: lock visual-first board canvas component workflow scope`
- Prior route before this sync: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS -> BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Main is aligned with `origin/main`.
- Tracked diff and cached diff were clean before this sync.
- `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS` is pushed/recorded.

This pass does not implement runtime UI, edit tests, hide routes, delete screens, or perform implementation work.

## Product rule carried forward
VISUAL FIRST.

Board Canvas right-side panel/menu is the primary surface for normal component work:
- component creation
- component metadata editing
- visual placement
- measurement

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. They are not the primary technician workflow and must not be duplicated inside Board Canvas.

## Canonical event split to preserve
- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Live-code findings
- The committed duplicate Board Canvas `Komponendid` hub/card UI is implemented inside `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Board Canvas widget expectations for the hub/card UI live in `test/widget/board_canvas_screen_test.dart`.
- The first safe cleanup slice can remove or replace the duplicate hub/card UI inside Board Canvas only.
- Router, Project Overview, standalone Add Component, standalone Edit Component, Measure Sheet, writer services, schema, validator, materializer, events, known facts, samples, assets, and `_incoming` are not required for this first slice.
- Existing placement controls and accepted measurement/right-panel behavior can remain untouched in the first slice.

## First-slice implementation decision
Arm only duplicate Board Canvas `Komponendid` hub/card cleanup.

The future implementation should:
- remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI
- not replace it with another duplicate workflow selector
- keep old standalone Add/Edit/Measure-style pages out of the primary technician workflow
- preserve current placement controls
- preserve accepted measurement/right-panel behavior
- preserve `Salvesta` placement save behavior
- preserve renderer/painter read-only boundaries
- avoid standalone route deletion in this first slice

Broader route/page retirement remains later scoped work after dependency verification and right-panel replacements.

## Active implementation allowlist
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Measurement clarification carried forward
The accepted measurement/right-panel workflow stays.

The first cleanup slice must not rework measurement implementation. It may only remove/revise duplicate `Komponendid` hub/card measurement affordance if that affordance is part of the duplicate hub/card UI.

## Boundaries
Future implementation must not:
- rebuild old standalone forms inside Board Canvas
- create another duplicate workflow menu
- route technicians out of Board Canvas as primary workflow
- change measurement implementation in the first cleanup slice
- hide or delete old standalone routes in this first slice
- change writer services
- change event schema
- change validator/materializer/tools
- touch `events.jsonl` or `known_facts.json`
- mutate `known_facts.json` directly from Flutter
- create identity from visual placement
- create pins/contacts/pads/nets/traces/electrical facts from visual drafts
- create AI-authored canonical facts
- implement startup intro or use `_incoming` design handoffs
