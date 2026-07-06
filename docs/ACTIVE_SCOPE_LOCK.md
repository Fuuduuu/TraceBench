# Active Scope Lock

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Mode
No active implementation lock.

## Lock state
Released by `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ABORT_CLOSEOUT_PASS`.

## Released implementation pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Abort reason
`BLOCKED_PRODUCT_DECISION`

The attempted implementation was rejected after user product review.

## Obsolete audit / rejected direction
The earlier Claude audit that technically accepted the first implementation direction is obsolete after user product review.

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

## Active implementation allowlist
None.

No runtime, test, router, writer, schema, tool, materializer, validator, events, known_facts, sample, asset, or `_incoming` files are armed.

## Recommended next candidate
`BOARD_CANVAS_VISUAL_FIRST_COMPONENT_WORKFLOW_SCOPE_PASS`

Candidate only; not armed.
