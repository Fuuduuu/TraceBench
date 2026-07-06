# Pass Queue

## Current pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Route status
This docs-only active-lock sync arms the exact implementation allowlist for the first small Visual First cleanup slice.

Previous accepted/pushed scope-lock:
- `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`
- Latest pushed commit verified live: `ecba121 docs: lock visual-first board canvas component workflow scope`

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
- The committed duplicate Board Canvas `Komponendid` hub/card UI lives in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Matching Board Canvas widget assertions live in `test/widget/board_canvas_screen_test.dart`.
- The duplicate hub/card cleanup can be scoped to Board Canvas and its widget test.
- Router, Project Overview, standalone Add Component, standalone Edit Component, Measure Sheet, writer services, schema, validator, materializer, events, known facts, samples, assets, and `_incoming` are not needed for this first slice.
- Current placement controls and accepted measurement/right-panel behavior can be preserved while removing/replacing the duplicate hub/card UI.

## First-slice implementation decision
Arm duplicate Board Canvas `Komponendid` hub/card cleanup only.

The implementation must:
- remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI
- avoid introducing another duplicate workflow selector
- preserve existing placement controls
- preserve accepted measurement/right-panel behavior
- preserve selected-placement prefill, required-label guard, canonical-bounds guard, projection-stale copy, rotation normalization behavior, and explicit `Salvesta` placement save semantics
- preserve renderer/painter read-only behavior
- avoid standalone route deletion in this first slice

Broader route/page retirement remains later scoped work after dependency verification and right-panel replacements.

## Active implementation allowlist
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Expected implementation tests
The future implementation should add/update tests proving:
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

## Measurement clarification
The accepted measurement/right-panel workflow stays.

The first cleanup slice must not rework measurement implementation. It may only remove/revise duplicate `Komponendid` hub/card measurement affordance if that affordance is part of the duplicate hub/card UI.

## Forbidden surfaces
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

## Scope gate rules
- Route owners: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Audit/provenance owner: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Do not stage, commit, or push from implementation or docs-sync passes unless explicitly instructed.
- Never use `git add .`, `git add -A`, or `git commit -am`.
