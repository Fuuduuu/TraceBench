# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS`

## Type

`FLUTTER_TEST`

## Lane

`CODEX / FLUTTER_TEST`

## Mode

QA regression-hardening test pass for accepted `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`.

## Current goal
- Strengthen regression tests for marker presence, inspector summary, pan/zoom behavior, and source-boundary guarantees.
- Keep route docs (`CURRENT_STATE`, `PASS_QUEUE`, `AUDIT_INDEX`) synchronized with actual status.

## Next recommended pass

`V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS`

## Scope decision

- scope type: `FLUTTER_TEST`
- lane: `CODEX / FLUTTER_TEST`
- mode: test-only regression hardening; runtime behavior remains unchanged.
- latest pass handled: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `test/widget/board_canvas_screen_test.dart`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS.md`

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

Current: `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS`

Next: `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS`

## Exact focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS.md`

## Scope-lock carry-forward

- Pan/zoom/fit remains part of prior closed-out Board Canvas navigation scope.
- Event writer/schema/materializer/validator changes remain out of scope.
