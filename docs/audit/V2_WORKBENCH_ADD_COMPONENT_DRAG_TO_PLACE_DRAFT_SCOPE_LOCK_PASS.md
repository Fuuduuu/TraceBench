# V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS

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
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS.md`

## WORK_SUMMARY

This pass locks a future local drag-to-place draft positioning slice for the existing Add Component local ghost/draft preview.

The lock is docs-only. It does not implement drag-to-place, rotation, resize, Confirm/write, Edit Layout, persistence, schema/writer/materializer/validator/projection/Project ZIP/event/fact changes, or runtime/test changes.

## ROUTE_STATE

- Baseline route before this pass: `NEEDS_USER_DECISION`.
- Current pass: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`.
- Next route if accepted: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS`.
- Latest accepted/pushed baseline: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` at `eae355f` (`docs: record add component click-to-place draft`).
- Manual smoke checkpoint for click-to-place draft UX passed.
- This scope-lock pass has no accepted/pushed hash claim.

## LOCKED_FUTURE_WORK

- Dragging the existing local Add Component draft/ghost preview on Board Canvas may update its local volatile draft anchor/position.
- "drag-to-place" means moving the existing local draft/ghost preview only.
- Drag position is local volatile UI state only.
- Dragged point/anchor is not canonical board data.
- The clicked/dragged point remains UI preview state only.
- The visual draft/ghost may be clamped to safe canvas bounds if needed.
- Existing click-to-place behavior must be preserved.
- Existing template/catalog/builder/local ghost behavior must be preserved.
- Ghost must remain visually draft/unsaved and distinguishable from confirmed placements and measurement overlays.
- Cancel/change-template/reset clears or reseeds local draft position only, as already scoped for local draft behavior.

## IMPLEMENTATION_ALLOWLIST_FOR_FUTURE_PASS

The future implementation pass may only edit:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Any other runtime/test file requires re-scope before implementation.

## EXPLICITLY_DEFERRED

- Confirm/write.
- Committed placement.
- Canonical coordinates.
- Moving existing confirmed placements.
- Snap/grid/magnet behavior.
- Rotation draft.
- Resize draft.
- Designator policy.
- Identity/package/electrical semantics.
- Edit Layout.
- Measure Sheet changes.
- Project Overview deep-link.
- Schema/writer/materializer/validator/projection/Project ZIP/event/fact changes.

## BOUNDARY_CONFIRMATION

- No runtime files changed.
- No test files changed.
- No event/fact/write/persistence.
- No component is created by dragging.
- No confirmed placement is moved by dragging.
- No placement record is created or edited.
- No canonical placement.
- No canonical coordinates are produced, normalized, persisted, or written.
- No schema/writer/materializer/validator/projection/Project ZIP changes.
- No `_incoming`, screenshot, or design artifact runtime use.

## VALIDATION_RESULTS

Executed required check commands:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## FINAL_GIT_STATUS

- Expected modified docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and this audit artifact.
- No runtime or test files are changed.
- No files are staged.

## STAGED

NO

## COMMITTED

NO

## PUSHED

NO

## SAFE_FOR_REAUDIT

YES
