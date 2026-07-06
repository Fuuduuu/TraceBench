# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active implementation lock is armed.

The attempted `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` direction was aborted before staging, commit, or push. The rejected direction was a navigation-only Board Canvas Komponendid gateway that sent users to old standalone pages through actions such as "Ava loomine", "Ava muutmine", and "Ava mõõtmine".

## Product decision recorded

`BLOCKED_PRODUCT_DECISION`

Board Canvas Komponendid workflow should be redesigned around in-panel work beside/on the canvas where practical. Old standalone pages must not be the primary Komponendid UX target for this workflow.

## Abort closeout

`BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS` records:

- uncommitted runtime/test implementation diff reverted;
- reverted files: `lib/features/board_canvas/screens/board_canvas_screen.dart`, `test/widget/board_canvas_screen_test.dart`;
- final tracked/cached diff empty after revert;
- `git diff --check` PASS;
- `flutter test test/widget/board_canvas_screen_test.dart` PASS, 112/112;
- `python tools/validate_all.py` PASS, 285 tests OK;
- no staging, commit, or push by the abort/revert step.

## Recommended next candidate

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`

This queue entry is informational only. A future scope-lock must separately decide the in-panel workflow direction and arm any implementation allowlist.

## Scope gate rules

- One pass at a time.
- Repo docs and verified git state outrank chat handoff text.
- Runtime/test/schema/tool/event/fact changes require an active lock that names the exact files.
- Protected surfaces require a dedicated protected-surface scope-lock before implementation.
- Do not stage, commit, or push unless explicitly requested.

## Current-state maintenance trigger

Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and the relevant `docs/audit/*.md` artifact together when a pass changes route state or audit state.

## Recent routing provenance

| Pass | Result | Notes |
|---|---|---|
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS` | armed implementation | Armed the rejected navigation-only actions implementation pass. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` | aborted before staging | Rejected by product decision; uncommitted runtime/test diff reverted. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS` | drafted closeout | Records abort, releases active lock, and returns route to `NEEDS_USER_DECISION`. |