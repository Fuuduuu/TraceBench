# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_PROTECTED_SCOPE_LOCK

## Goal

Create a docs-only protected scope-lock for local click-to-place draft positioning of the existing Add Component local canvas ghost preview.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`
- Latest accepted/pushed governance baseline: `V2_WORKBENCH_BOARD_CANVAS_DASHED_LINE_CLEANUP_DOCS_SYNC_PASS` at `8ad1d0c` (`docs: sync stale _drawDashedLine nit to resolved`).
- Latest accepted Add Component runtime includes local ghost preview, visual template catalog, and template shape/default propagation.
- Manual smoke reported visual template catalog and shape/default propagation as passed.
- Existing Add Component ghost preview is local, draft/unsaved visual state only.

## Status labels to record

- `ROUTE_EFFECT: PROTECTED_SCOPE_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS.md`

## Locked future work

- Click on Board Canvas may move/place the existing local ghost preview into a local draft position.
- "click-to-place" means local draft positioning only.
- The clicked canvas point is a UI preview anchor, not canonical board data.
- Draft position state is volatile widget/UI state only.
- Ghost remains visually draft/unsaved and distinguishable from confirmed placements and measurement overlays.
- The ghost can move visually, but no component is created.
- Cancel/change-template must clear local draft position when applicable.
- Existing builder/template/draft-label behavior remains local only.

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
- No drag-to-place.
- No rotation draft.
- No resize draft.
- No designator policy acceptance.
- No identity/package/electrical semantics.
- No `_incoming` or screenshot/design artifact runtime use.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS`
- Next route: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
