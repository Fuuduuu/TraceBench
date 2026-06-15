# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION`

## Mode

Narrow UI-only Board Canvas tap/click selection shortcut implementation.

## Current goal

- Implement selection of an already-rendered board-normalized component placement by tapping/clicking its rendered footprint.
- Preserve current Board Canvas read-only behavior, chip selector behavior, pan/zoom/fit behavior, and zero-event boundaries.
- Keep the exact runtime/test touch set and forbid coordinate, measurement, event, fact, net, trace, writer, schema, materializer, validator, and Project ZIP expansion.

## Next recommended pass

`V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_POST_AUDIT_PASS`

## Scope decision

- scope type: `FLUTTER_IMPLEMENTATION`
- lane: `CODEX / FLUTTER_IMPLEMENTATION`
- mode: UI-only runtime/test implementation; no staging, commit, or push in this pass.
- latest pass handled: `V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS`
- accepted baseline: `bbc51c1` (`docs: lock board canvas tap to select`)

## File allowlist for this pass

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance docs:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS.md`

## Current Board Canvas selection state

- Selection remains driven by volatile UI state (`_selectedPlacementKey`) only.
- `_PlacementSelector` chips remain available and must keep existing behavior.
- The canvas is rendered through `InteractiveViewer`, a UI-only tap layer, and `CustomPaint`.
- Direct tap-to-select may select only an already-rendered placement and must reuse the existing inspector flow.
- The existing inspector, measurement summary, measurement badge count, and source-boundary guards remain read-only.

## Locked implementation scope

This implementation may:

- Add tap/click selection for already-rendered board-normalized component placements.
- Update only volatile UI selection state.
- Reuse existing `_PlacementEntry`, `selectedKey`, and inspector flow.
- Keep existing chip selector behavior intact.
- Preserve `InteractiveViewer` pan/zoom/fit behavior.
- Preserve read-only / zero-event behavior.
- Add focused tests for tap-to-select behavior and boundary guards.

## Implementation touch set

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance docs:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS.md`

No other runtime files are allowed unless implementation audit explicitly justifies the expansion.

## Tap / hit-test boundary

- Tap-to-select means only: select this existing rendered placement in the UI.
- A transient hit-test against already-rendered placement geometry may be used only for UI selection.
- The hit-test result must not be stored as an event, fact, coordinate, measurement, placement, marker, trace, net, view-state file, or Project ZIP content.

## Pan / zoom boundary

Implementation must preserve:

- tap selects a rendered component when not panning,
- pan/zoom gestures still work,
- fit/reset still works,
- tap selection remains aligned under transformed canvas coordinates,
- tap handling does not regress `InteractiveViewer` gesture behavior.

If safe tap gesture handling is not straightforward, implementation must stop and report rather than weakening pan/zoom behavior.

## Forbidden touches

- component creation
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad authoring
- board coordinate authoring
- new fact/event semantics
- new association rule
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
- event schema/model changes
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- custom unit / `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad Board Canvas redesign
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`

## Current route lock

Current: `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS`

Next: `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_POST_AUDIT_PASS`

## Exact focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS.md`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth; this pass and tap selection must not write it.
- `known_facts.json` remains projection/cache; tap selection must not mutate it.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
