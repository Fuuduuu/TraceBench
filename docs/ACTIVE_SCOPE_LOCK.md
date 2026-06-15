# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Documentation closeout only for the accepted Board Canvas selection inspector polish implementation.

## Current goal
- Record `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS` as implemented, audited, accepted, committed, and pushed.
- Keep route docs (`CURRENT_STATE`, `PASS_QUEUE`, `AUDIT_INDEX`) synchronized.
- Preserve docs-only scope: no runtime, tests, tooling, schema, writer, materializer, validator, or Project ZIP changes.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout; runtime/test implementation already accepted and pushed.
- latest pass handled: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS.md`

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
- any runtime/test file, including:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- any `sequence` field addition
- dependency/toolchain lockfile or package updates
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`
- non-authorized runtime test suites outside the explicit allowlist

## Current route lock

Current: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Exact focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS.md`

## Scope-lock carry-forward

- Accepted implementation commit: `67e877f` (`feat(board-canvas): polish selection inspector measurement count`).
- Inspector measurement count remains component-level only and preserves the delimiter-safe association rule.
- Pan/zoom/fit remains part of prior closed-out Board Canvas navigation scope.
- Selection remains chip-driven (`_PlacementSelector`); no canvas tap/hit-testing addition is included.
- Event writer/schema/materializer/validator changes remain out of scope.
