# V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS

Date: 2026-06-22
Lane: CODEX / DOCS_PROTECTED_SCOPE_LOCK
Type: Lane B
Status: drafted / active docs-only protected scope-lock

## MODEL_ROUTING_CHECK

PASS.

## VERDICT

ACCEPT_READY_FOR_REAUDIT

## CHANGED_FILES

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS.md`

## WORK_SUMMARY

This pass locks a future local click-to-place draft positioning slice for the existing Add Component local canvas ghost preview.

The lock is docs-only. It does not implement click-to-place, drag-to-place, rotation, resize, Confirm/write, Edit Layout, or persistence.

## ROUTE_STATE

- Baseline route before this pass: `NEEDS_USER_DECISION`.
- Current pass: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`.
- Next route if accepted: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS`.
- Latest accepted/pushed baseline: `V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS` at `8ad1d0c` (`docs: sync stale _drawDashedLine nit to resolved`).
- This scope-lock pass has no accepted/pushed hash claim.

## LOCKED_FUTURE_WORK

- Click on Board Canvas may move/place the existing local ghost preview into a local draft position.
- "click-to-place" means local draft positioning only.
- The clicked canvas point is a UI preview anchor, not canonical board data.
- Draft position state is volatile widget/UI state only.
- Ghost remains visually draft/unsaved.
- Ghost remains distinguishable from confirmed placements and measurement overlays.
- The ghost can move visually, but no component is created.
- Cancel/change-template must clear local draft position when applicable.
- Existing builder/template/draft-label behavior remains local only.

## IMPLEMENTATION_ALLOWLIST_FOR_FUTURE_PASS

The future implementation pass may only edit:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Any other runtime/test file requires re-scope before implementation.

## EXPLICITLY_DEFERRED

- Drag-to-place.
- Rotation draft.
- Resize draft.
- Confirm/write.
- Committed placement.
- Canonical coordinates.
- Designator policy.
- Identity/package/electrical semantics.
- Edit Layout.
- Measure Sheet changes.
- Project Overview deep-link.

## BOUNDARY_CONFIRMATION

- No runtime files changed.
- No test files changed.
- No event/fact/write/persistence.
- No canonical placement.
- No canonical coordinates.
- No schema/writer/materializer/validator/projection/Project ZIP changes.
- No `_incoming`, screenshot, or design mockup runtime use.

## VALIDATION_RESULTS

Executed required check commands:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## FINAL_GIT_STATUS

- Expected modified docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and this audit artifact.
- No files are staged.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
