# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC_CLOSEOUT

## Goal

Record docs-only implementation closeout for the accepted/pushed Add Component click-to-place draft positioning implementation (`6177dea`).

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`
- Latest accepted/pushed scope-lock baseline: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_SCOPE_LOCK_PASS` at `4f0fab1` (`docs: lock add component click-to-place draft`).
- Latest accepted/pushed implementation: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_PASS` at `6177dea` (`feat: add component click-to-place draft`).
- Claude audit for the implementation: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Focused validation recorded for the implementation: `flutter test test/widget/board_canvas_screen_test.dart` passed 89/89; `flutter analyze` remained at 9 pre-existing issues with no new warnings.

## Status labels to record

- `ROUTE_EFFECT: IMPL_POST_AUDIT_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_B`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS.md`

## Accepted implementation behavior

- Click on Board Canvas may move/place the existing local ghost preview into a local draft position.
- "click-to-place" means local draft positioning only.
- The clicked canvas point is a UI preview anchor, not canonical board data.
- Draft position state is volatile widget/UI state only.
- Ghost remains visually draft/unsaved and distinguishable from confirmed placements and measurement overlays.
- The ghost can move visually, but no component is created.
- Cancel/change-template must clear local draft position when applicable.
- Existing builder/template/draft-label behavior remains local only.

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

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_CLICK_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
