# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Create a docs-only protected scope-lock for local drag-to-place draft positioning of the existing Add Component local ghost/draft preview.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`
- Latest accepted/pushed scope-lock baseline: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS` at `4f0fab1` (`docs: lock add component click-to-place draft`).
- Latest accepted/pushed implementation: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS` at `6177dea` (`feat: add component click-to-place draft`).
- Latest accepted/pushed implementation closeout: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` at `eae355f` (`docs: record add component click-to-place draft`).
- Manual smoke checkpoint for click-to-place draft UX passed.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS.md`

## Locked future work

- Dragging the existing local Add Component draft/ghost preview on Board Canvas may update its local draft anchor/position.
- "drag-to-place" means moving the existing local draft/ghost preview only.
- Drag position is local volatile UI state only.
- Dragged point/anchor is not canonical board data.
- No component is created by dragging.
- No confirmed placement is moved by dragging.
- No placement record is created or edited.
- No canonical board coordinates are produced, normalized, persisted, or written.
- The ghost must remain visually draft/unsaved and distinguishable from confirmed placements and measurement overlays.
- The visual draft/ghost may be clamped to safe canvas bounds if needed.
- Existing click-to-place behavior must be preserved.
- Existing template/catalog/builder/local ghost behavior must be preserved.
- Cancel/change-template/reset clears or reseeds local draft position only, as already scoped for local draft behavior.

## Future implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Preserve boundary

- This pass is docs-only.
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

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`
- Next route: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
