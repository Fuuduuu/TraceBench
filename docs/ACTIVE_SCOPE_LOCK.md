# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_UI_POLISH`

## Mode

Implement the locked Board Canvas layout-density polish slice only. Do not broaden to Project Overview / Workbench. Do not stage, commit, or push.

## Current goal

- Make Board Canvas substantially more space-efficient after user screenshot review.
- Make board/canvas area larger in both width and height.
- Make top/header/control chrome more compact.
- Make Placement selection collapsible/expandable and compact by default.
- Keep Safety / Evidence collapsed or compact by default while preserving access to all safety copy.
- Add UI-only volatile inspector hide/show/restore behavior.
- Preserve read-only renderer, tap-to-select, selector selection, pan/zoom/fit, measurement badges/counts, measurement summary, inspector content, visual-trace metadata, photo-alignment readiness metadata-only panel, and `renderer writes: none`.

## Next recommended pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_POST_AUDIT_PASS`

## Baseline

- Scope-lock commit: `a7f58f5` (`docs: lock board canvas layout density polish`)
- Prior density implementation: `16072fa` (`feat(board-canvas): reclaim canvas layout space`)
- Current route: Board Canvas-only implementation

## File allowlist for this implementation pass

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS.md`

## Implemented scope

Allowed implementation changes:

1. More compact Board Canvas AppBar/footer/outer padding.
2. Placement selector converted to a compact collapsed disclosure while preserving `placement_selector_*` chip keys.
3. Safety / Evidence disclosure kept compact/collapsed by default with safety copy still accessible by click/tap/keyboard.
4. Canvas title/subtitle moved from vertical flow to an overlay status pill so canvas height is not consumed by header text.
5. Right inspector made hideable/restorable through volatile UI state only.
6. Focused widget tests updated for collapsed selector/safety access, inspector hide/restore, canvas expansion, preserved renderer behavior, and source-boundary guards.

## Deferred / not implemented

- Optional auto-hide top/header behavior is deferred.
- Project Overview / Workbench density remains deferred to a later separate implementation pass, such as `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` or `V2_WORKBENCH_LAYOUT_DENSITY_IMPL_PASS`.
- Multi-placement fixture/sample coverage remains deferred unless separately scoped.
- Manual smoke rerun remains deferred until after implementation/post-audit.
- No closeout docs are pre-registered by this implementation pass.

## Strict non-goals / forbidden changes

- Project Overview / Workbench layout
- new board semantics
- facts/events/coordinates
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- trace-color editing
- background photo rendering
- photo-local to board transform
- contour/layers
- AI/OCR/CV
- Save Measurement behavior
- Add Component behavior
- Edit Component behavior
- writer service changes
- `MeasurementEventWriter`
- schema/model changes
- validator/materializer/projection changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path
- `sequence`
- `Muu ühik`
- dependency/toolchain/generated/platform files
- broad theme/token migration

## Required validation

- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools/validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`

Next: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_POST_AUDIT_PASS`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Layout-density polish must not change reset semantics, pan/zoom semantics, tap-to-select semantics, selection semantics, event/fact behavior, or Project ZIP behavior.
