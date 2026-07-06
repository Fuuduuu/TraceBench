# Pass Queue

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Route status
The active implementation lock for `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS` is released.

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ABORT_CLOSEOUT_PASS` records a user product-decision abort and product correction. It does not start the replacement scope.

## Abort/revert evidence
The attempted in-panel implementation was reverted before staging or push.

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
The earlier Claude audit that technically accepted the first implementation direction is obsolete after user product review.

After revert, the app still shows the earlier committed Board Canvas `Komponendid` hub/card UI. That is baseline UI from an earlier pass, not residue from the reverted implementation. User now rejects this baseline direction too because it duplicates old workflow concepts instead of removing or migrating them.

Rejected direction:
- duplicate UI for component creation
- duplicate UI for component metadata editing
- duplicate UI for placement
- duplicate UI for measurement
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

## Scope gate rules
- Route owners: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`.
- Audit/provenance owner: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.
- Do not stage, commit, or push from implementation or docs-sync passes unless explicitly instructed.
- Never use `git add .`, `git add -A`, or `git commit -am`.
