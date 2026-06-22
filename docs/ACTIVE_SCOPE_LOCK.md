# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC

## Goal

Record the docs-only post-audit closeout for the accepted/pushed Add Component drag-to-place draft implementation (`8e42537`).

## Baseline

- Latest accepted/pushed drag-to-place draft scope-lock: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS` at `bb3e23b` (`docs: lock add component drag-to-place draft`).
- Latest accepted/pushed drag-to-place draft implementation: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS` at `8e42537` (`feat: add component drag-to-place draft`).
- Implementation changed only `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.

## Status labels to record

- `ROUTE_EFFECT: IMPL_POST_AUDIT_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS.md`

## Accepted implementation behavior

- Click-to-place still works.
- Drag-to-place works.
- Fast drag no longer causes cursor/ghost drift.
- Dragging moves only the existing local Add Component draft/ghost preview.
- Drag position is local volatile UI state only.
- Dragged point/anchor is not canonical board data.
- No component is created by dragging.
- No confirmed placement is moved by dragging.
- No placement record is created or edited.
- No canonical board coordinates are produced, normalized, persisted, or written.
- The ghost must remain visually draft/unsaved and distinguishable from confirmed placements and measurement overlays.
- Existing click-to-place behavior must be preserved.
- Existing template/catalog/builder/local ghost behavior must be preserved.
- Cancel/change-template/reset clears or reseeds local draft position only, as already scoped for local draft behavior.

## Implementation files recorded

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Preserve boundary

- This closeout pass is docs-only.
- No runtime files are edited.
- No test files are edited.
- No event/fact/write/persistence.
- No canonical placement.
- No canonical coordinates.
- No `schema/writer/materializer/validator/projection/Project ZIP` changes.
- No Confirm/write.
- No Edit Layout.
- No Measure Sheet changes.
- No Project Overview deep-link.
- No committed placement.
- No moving existing confirmed placements.
- No snap/grid/magnet behavior.
- No rotation draft.
- No resize draft.
- No designator policy acceptance.
- No identity/package/electrical semantics.
- No `_incoming` or screenshot/design artifact runtime use.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
