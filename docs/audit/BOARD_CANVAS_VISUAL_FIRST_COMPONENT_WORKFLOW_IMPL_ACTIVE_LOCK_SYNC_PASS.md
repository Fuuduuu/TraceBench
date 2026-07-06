# BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode
Docs-only active-lock sync.

## Result
Armed the exact implementation allowlist for `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`.

This pass does not implement runtime behavior, edit tests, hide routes, delete screens, or stage/commit/push files.

## Claude nit patch recorded
Claude audit returned `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES` and requested same-pass documentation consistency repairs before staging.

This same-pass patch restores explicit Visual First wording, standalone-page transitional-debt framing, and the canonical four-event split in the route owners.

## Baseline verification
Verified before editing:
- `git status --short --branch`: `## main...origin/main`; tracked/cached diff clean, known untracked scratch only.
- `git log --oneline --decorate -10`: latest commit `ecba121 docs: lock visual-first board canvas component workflow scope` on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route docs showed `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS -> BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS` is pushed/recorded.

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
Read-only inspection found:
- The committed duplicate Board Canvas `Komponendid` hub/card UI is implemented in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Board Canvas widget expectations for that hub/card UI live in `test/widget/board_canvas_screen_test.dart`.
- The first safe cleanup slice can remove or replace the duplicate hub/card UI inside Board Canvas only.
- Router, Project Overview, standalone Add Component, standalone Edit Component, Measure Sheet, writer services, schema, validator, materializer, events, known facts, samples, assets, and `_incoming` are not required for this first slice.
- Existing placement controls and accepted measurement/right-panel behavior can be preserved in this first slice.

## First-slice implementation decision
Decision: duplicate hub/card cleanup only.

The implementation should remove or replace the committed duplicate Board Canvas `Komponendid` hub/card UI and must not replace it with another duplicate workflow selector.

Broader route/page retirement is still required later, but it is too broad for this first slice and must wait for separate dependency verification and scope-locking.

## Exact implementation allowlist armed
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Implementation pass armed
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Future implementation requirements
The implementation must:
- remove or replace the duplicate Board Canvas `Komponendid` hub/card UI
- preserve current placement controls
- preserve accepted measurement/right-panel behavior
- preserve selected-placement prefill
- preserve required-label guard
- preserve canonical-bounds guard
- preserve projection-stale copy
- preserve rotation normalization behavior
- preserve explicit `Salvesta` placement save semantics
- preserve renderer/painter read-only behavior
- avoid standalone route hiding/deletion in this first slice

## Expected future tests
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

## Measurement clarification carried forward
The accepted measurement/right-panel workflow stays.

The first cleanup slice must not rework measurement implementation. It may only remove/revise duplicate `Komponendid` hub/card measurement affordance if that affordance is part of the duplicate hub/card UI.

## Forbidden surfaces
Do not arm or edit in the implementation pass:
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

The implementation must not:
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

## Route state after sync
Current: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS`

Next: `BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_PASS`

## Changed files
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Boundary confirmation
Docs-only. No runtime, tests, router, writer services, schema, tools, materializer, validator, events.jsonl, known_facts.json, sample, asset, or `_incoming` files changed.

No files were staged, committed, or pushed.

## Audit status
DRAFTED / PENDING CLAUDE AUDIT
