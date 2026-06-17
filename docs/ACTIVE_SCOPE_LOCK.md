# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_UI_POLISH`

## Mode

Implement only the first safe Board Canvas layout-density slice. Runtime changes are limited to Board Canvas layout composition and spacing. Tests may be updated only to pin preserved behavior and the new compact layout. No staging, commit, or push in this pass.

## Current goal

- Reclaim Board Canvas width and height.
- Replace the fixed selector column with compact selector/control-band layout.
- Move legend/safety copy out of the canvas panel vertical flow into an accessible Safety / Evidence disclosure.
- Reduce surrounding padding and gaps where safe.
- Preserve Board Canvas read-only, zero-event, projection, tap-to-select, pan/zoom/fit, measurement badge/count, inspector, visual-trace metadata, photo-alignment metadata-only, and `renderer writes: none` behavior.

## Next recommended pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`

## Scope baseline

- Accepted scope-lock commit: `af8425d` (`docs: lock board canvas layout density`)
- Upstream smoke result: `PASS_WITH_NITS`
- Current implementation target: first smallest safe slice only
- Post-audit target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`

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
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS.md`

## Allowed implementation scope

Allowed changes:

1. Board Canvas width/height reclaim.
2. Compact placement selector row/control area.
3. Safety/evidence legend moved into click/tap/keyboard reachable disclosure outside the canvas panel.
4. Padding/gap reduction around Board Canvas.
5. Focused widget tests for preserved rendering, selection, controls, safety copy access, footer, and source-boundary guard.

Required preserved behavior:

- read-only Board Canvas renderer
- pan/zoom/fit behavior and `board_canvas_fit_view_button` key
- tap-to-select behavior
- chip selector behavior and `placement_selector_*` keys
- inspector content and selection updates
- measurement badges/counts and safety copy
- visual-trace metadata card
- photo-alignment readiness metadata-only panel
- `renderer_writes_none` / `renderer writes: none`
- no authoring/write controls

## Explicitly not implemented in this pass

- Project Overview density
- collapsible inspector
- labeled fit/reset cluster
- zoom plus/minus controls
- multi-placement fixture/sample
- manual smoke rerun

## Strict non-goals / forbidden changes

- new board semantics
- new facts/events/coordinates
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
- Save Measurement behavior changes
- Add Component behavior changes
- Edit Component behavior changes
- writer service changes
- `MeasurementEventWriter` changes
- schema/model changes
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- dependency/toolchain/generated/platform changes
- broad theme/token migration

## Required validation

- `flutter test test/widget/board_canvas_screen_test.dart`
- `py -3 tools\validate_all.py`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

Next: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Layout-density polish must not change reset semantics, pan/zoom semantics, tap-to-select semantics, selection semantics, event/fact behavior, or Project ZIP behavior.
