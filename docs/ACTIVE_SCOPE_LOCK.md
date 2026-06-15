# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS`

## Type

`FLUTTER_IMPLEMENTATION`

## Lane

`CODEX / FLUTTER_IMPLEMENTATION`

## Mode

Narrow implementation pass for a single inspector-only Board Canvas polish:
selected placement inspection copy now includes component-level related measurement count and safety context.

## Current goal
- Implement the selected-placement inspector measurement count copy in Board Canvas without changing any write, schema, materializer, validator, or geometry semantics.
- Keep route docs (`CURRENT_STATE`, `PASS_QUEUE`, `AUDIT_INDEX`) synchronized and preserve previous pan/zoom and read-only geometry behavior.

## Next recommended pass

`V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS`

## Scope decision

- scope type: `FLUTTER_IMPLEMENTATION`
- lane: `CODEX / FLUTTER_IMPLEMENTATION`
- mode: runtime+test implementation; semantics unchanged outside approved read-only inspector copy.
- latest pass handled: `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS.md`

## Forbidden touches

- `tools/event_writer_service.py`
- writer/service layers
- event schema/model files
- validator/
- materializer/
- schemas/
- Project ZIP import/export
- `lib/features/component_editor` component create/edit/update/edit flows
- Add/Edit Component behavior
- Save Measurement paths
- measurement board-coordinate modeling, point capture, or anchors
- measurement marker editor, placement authoring, marker dragging, or marker persistence
- background photo rendering/alignment
- contour/layer stack
- AI/OCR/CV candidates
- photo markup / probe tooling
- Repair Map
- Visual Trace Shape assist runtime behavior
- any `sequence` field addition
- dependency/toolchain lockfile or package updates
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`
- non-authorized runtime test suites outside the explicit allowlist

## Current route lock

Current: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS`

Next: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS`

## Exact focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS.md`

## Scope-lock carry-forward

- Pan/zoom/fit remains part of prior closed-out Board Canvas navigation scope.
- Selection remains chip-driven (`_PlacementSelector`) for this scoped route; no canvas tap/hit-testing addition is in scope.
- Event writer/schema/materializer/validator changes remain out of scope.
