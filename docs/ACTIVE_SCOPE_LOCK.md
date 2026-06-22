# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / AUDIT_ONLY + CODEX / DOCS_SYNC

## Goal

Record the docs-only post-audit closeout for the accepted/pushed Add Component draft ghost semantic-color implementation (`772eb78`).

## Baseline

- Latest accepted/pushed drag-to-place draft closeout: `V2_WORKBENCH_ADD_COMPONENT_DRAG_TO_PLACE_DRAFT_IMPL_POST_AUDIT_PASS` at `c35dd22` (`docs: record add component drag-to-place draft`).
- Latest accepted/pushed draft ghost semantic-color implementation: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_PASS` at `772eb78` (`style: use draft semantic color for add component ghost`).
- Implementation changed only `lib/features/board_canvas/screens/board_canvas_screen.dart` and `test/widget/board_canvas_screen_test.dart`.

## Status labels to record

- `ROUTE_EFFECT: IMPL_POST_AUDIT_CLOSEOUT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS.md`

## Design context

- Claude design critique recommended: amber = measured / active measuring; purple / unknown = draft / unsaved / unknown.
- BenchBeep is the user-facing app name.
- This closeout records context only and does not implement new design recommendations.

## Accepted implementation behavior

- Add Component draft/ghost now uses purple/unknown-draft semantics rather than amber/measured semantics.
- Dashed draft/unsaved styling remains.
- Click-to-place behavior is preserved.
- Drag-to-place behavior is preserved.
- Fast drag drift fix is preserved.
- No token-system migration.
- No `app_theme.dart` / `ThemeExtension` migration.
- No behavior/canonical/write/data changes.
- No component creation.
- No placement record creation or editing.
- No canonical coordinates.
- No persistence/events/facts/writer/schema/materializer/validator/projection/Project ZIP.
- No Confirm/write/Edit Layout.

## Implementation files recorded

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Preserve boundary

- This closeout pass is docs-only.
- No runtime files are edited.
- No test files are edited.
- No product behavior is changed.
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
- No docs/sources or design artifact runtime use.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_DRAFT_GHOST_SEMANTIC_COLOR_POST_AUDIT_PASS`
- Next route: `NEEDS_USER_DECISION`

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```
