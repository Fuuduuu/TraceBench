# V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS

Date: 2026-06-15
Lane: FLUTTER_IMPLEMENTATION
Status: in progress

## Goal

Add a component-level read-only marker system for Board Canvas rendered component placements to indicate when any related measurements exist, without introducing measurement geometry or coordinate assumptions.

## Implementation scope

- Kept `lib/features/board_canvas/screens/board_canvas_screen.dart` as the single runtime implementation file.
- Kept runtime/editor behavior read-only and projection-only:
  - Added exact association helpers:
    - `measurementEndpointMatchesComponent(endpoint, componentId)`
    - `measurementCountsByComponents(...)`
    - `measurementCountForComponent(...)`
  - Count-based measurement presence is computed only for board-normalized rendered component IDs.
  - `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS` semantics are preserved (exact match or `componentId + "."` match, no loose prefix).
  - Badge rendering in `_BoardPlacementPainter` is label/count based and attached to rendered placement geometry.
  - Pan/zoom/fit behavior remains from previous pass and badge painting occurs in canvas coordinates.
- Updated inspector card copy to clarify measurement presence semantics:
  - component-level only,
  - no board coordinates,
  - no net confirmation.
- Updated legend copy to mirror badge meaning and non-coordinate scope.

## Tests

- Updated `test/widget/board_canvas_screen_test.dart` with focused behavior checks for:
  - `from` exact match
  - `to` exact match
  - dot-prefix match
  - false-prefix guard (`Q2` vs `Q20`)
  - placement-only badge gating
  - no-match/no-related measurement cases
  - two-component shared measurement count behavior

## Files changed

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS.md`

## Boundaries preserved

- No coordinate geometry or probe-point inference was added.
- No line drawing between endpoints.
- No event, `events.jsonl`, `known_facts.json`, or Project ZIP write-path changes.
- No schema/validator/materializer/model/write-tool changes.
- No sequence field addition.
