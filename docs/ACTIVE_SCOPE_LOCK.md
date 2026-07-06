# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock status

Released. No implementation files are currently armed.

## Abort closeout record

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS` records the aborted `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`.

Rejected direction:

- Navigation-only Komponendid hub actions such as "Ava loomine", "Ava muutmine", and "Ava mõõtmine".
- Sending users from Board Canvas to old standalone pages as the primary Komponendid workflow.

New product decision:

- Board Canvas Komponendid workflow should be redesigned for in-panel work beside/on the canvas where practical.
- Do not route users out to old standalone pages as the primary Komponendid UX.

## Previously armed implementation allowlist

The aborted implementation had touched only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Those uncommitted changes were reverted before this closeout. These files are no longer armed by an active lock.

## Revert evidence recorded

- Final tracked diff after revert: empty.
- Final cached diff after revert: empty.
- `git diff --check`: PASS.
- `flutter test test/widget/board_canvas_screen_test.dart`: PASS, 112/112.
- `python tools/validate_all.py`: PASS, 285 tests OK.
- No files staged, committed, or pushed by the abort/revert step.

## Recommended next candidate

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`

This is not armed. A future scope-lock must define the in-panel workflow and exact allowlist before implementation.

## Protected boundary reminder

No runtime, tests, writer, schema, tools, events, known_facts, samples, assets, router, or `_incoming` files are authorized by this released lock.