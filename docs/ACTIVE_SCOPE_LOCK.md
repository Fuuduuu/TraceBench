# Active Scope Lock

## Current pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Mode
Docs-only active-lock sync.

## Purpose
Arm the smallest safe implementation allowlist for the first Visual First component workflow cleanup slice.

## Baseline
Verified live before this sync:
- Latest pushed scope-lock commit: `ecba121 docs: lock visual-first board canvas component workflow scope`
- Route before this sync: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS -> BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`
- `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS` is pushed/recorded
- Main aligned with `origin/main`
- Tracked diff clean
- Cached diff clean

## Product rule
VISUAL FIRST.

All normal component work must happen in the Board Canvas right-side menu/panel:
- measurement
- component creation
- component metadata editing
- visual placement

Old standalone Add/Edit/Measure-style pages are transitional debt. They must be removed or migrated through scoped passes, not duplicated in Board Canvas and not kept as the primary technician workflow.

Do not return to table/form-filling UX.

## Canonical event split to preserve
- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

## Live-code findings
- The committed duplicate Board Canvas `Komponendid` hub/card UI is implemented in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Matching Board Canvas widget expectations are in `test/widget/board_canvas_screen_test.dart`.
- The first safe cleanup slice can remove or replace the duplicate hub/card UI inside Board Canvas only.
- Router, Project Overview, standalone Add Component, standalone Edit Component, Measure Sheet, writer services, schema, validator, materializer, events, known facts, samples, assets, and `_incoming` are not required for this first slice.
- Existing placement controls and accepted measurement/right-panel behavior can be preserved in this first slice.

## Active implementation allowlist
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation pass armed
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Implementation goal
Remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI as the first Visual First cleanup slice.

The implementation must:
- remove or replace the duplicate `Komponendid` hub/card UI
- avoid replacing it with another duplicate workflow selector
- preserve current placement controls
- preserve accepted measurement/right-panel behavior
- preserve selected-placement prefill
- preserve required-label, canonical-bounds, and local-folder save guards
- preserve projection-stale success copy
- preserve placement writer invocation behavior
- preserve renderer/painter read-only behavior
- avoid standalone route hiding/deletion in this first slice

## Measurement clarification
The accepted measurement/right-panel workflow stays.

The first cleanup slice must not rework measurement implementation. It may only remove/revise duplicate `Komponendid` hub/card measurement affordance if that affordance is part of the duplicate hub/card UI.

## Expected tests
Implementation tests should prove:
- duplicate `Komponendid` hub/card UI is removed or replaced
- no duplicate workflow selector remains
- rejected labels or old workflow-card affordances do not remain as primary UI
- placement controls still work as before
- accepted measurement/right-panel behavior is preserved
- no canonical write happens from removing/replacing the hub
- `Salvesta` remains the explicit placement write trigger
- no route hiding/deletion occurred in the first slice
- no writer/event/schema behavior changed
- renderer/painter remains read-only

## Forbidden surfaces
Do not edit:
- router
- Project Overview
- standalone Add Component screen
- standalone Edit Component screen
- Measure Sheet screen
- writer services
- schema files
- validator/materializer/tools
- events.jsonl
- known_facts.json
- Project Open From Directory files
- `_incoming`
- samples/assets

Do not:
- rebuild old standalone forms inside Board Canvas
- create another duplicate workflow menu
- route technicians out of Board Canvas as primary workflow
- change measurement implementation in the first cleanup slice
- hide/delete old standalone routes in this first slice
- change writer/event/schema semantics
- create identity from visual placement
- create pins/contacts/pads/nets/traces/electrical facts from visual drafts
- create AI-authored canonical facts
- implement startup intro or use `_incoming` design handoffs

## This sync boundaries
Docs-only. No runtime, tests, router, writer services, schema, tools, materializer, validator, events.jsonl, known_facts.json, sample, asset, or `_incoming` files changed.
