# Current State

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Route status
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS` was aborted and reverted before staging or push.

This closeout records the product correction and releases the active implementation lock. It does not implement removal, start a replacement scope, or change runtime behavior.

## Abort/revert evidence
The uncommitted implementation was reverted cleanly.

Reverted files:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Recorded revert state:
- both files byte-identical to `HEAD` after revert
- tracked diff empty before this docs pass
- cached diff empty before this docs pass
- no runtime/test changes remain
- no files staged, committed, or pushed by the revert step

## Obsolete audit / rejected direction
An earlier Claude audit technically accepted the first implementation direction, but that audit is now obsolete after user product review.

After revert, the app still shows the earlier committed Board Canvas `Komponendid` hub/card UI. That UI is baseline from an earlier pass, not residue from the reverted implementation. User now rejects that baseline direction too because it duplicates old workflow concepts instead of removing or migrating them.

Rejected direction:
- preserving or creating duplicate UI for component creation
- preserving or creating duplicate UI for component metadata editing
- preserving or creating duplicate UI for placement
- preserving or creating duplicate UI for measurement
- risk of returning to table/form-filling workflow

## Locked product rule
VISUAL FIRST.

All component work must happen in the Board Canvas right-side menu/panel:
- measurement
- component creation
- component metadata editing
- visual placement

Old standalone Add/Edit/Measure-style pages must be removed or migrated through scoped passes, not duplicated in Board Canvas and not used as the primary technician workflow.

Measurement/right-panel workflow is considered already ready for the current product direction. Do not change measurement implementation in this closeout.

## Recommended next candidate
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`

Candidate only; no next scope is started.

The next candidate must define:
- Board Canvas right panel as primary component-work surface
- removal/migration of old standalone Add/Edit/Measure-style pages
- removal/migration of committed duplicate `Komponendid` hub/card UI
- no duplicate UI
- no route-out primary workflow
- no table/form-filling regression

## Boundary confirmation
No runtime, tests, router, writer services, schema, tools, materializer, validator, events.jsonl, known_facts.json, `_incoming`, sample, or asset files are changed by this closeout.
