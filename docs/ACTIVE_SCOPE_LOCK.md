# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS`

## Type

`DOCS_CLOSEOUT`

## Lane

`CODEX / DOCS_CLOSEOUT`

## Mode

Docs closeout for `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS` (runtime behavior already implemented, validated, and committed/pushed).

## Current goal
- Keep route docs (`CURRENT_STATE`, `PASS_QUEUE`, `AUDIT_INDEX`) synchronized with actual status.
- Keep route docs synchronized with post-audit closeout status.

## Next recommended pass

`NEEDS_USER_DECISION`

## Scope decision

- scope type: `DOCS_CLOSEOUT`
- lane: `CODEX / DOCS_CLOSEOUT`
- mode: docs-only closeout scoped to governance and route documentation.
- latest pass handled: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`

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

Current: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS`

Next: `NEEDS_USER_DECISION`

## Exact closeout focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`

## Scope-lock carry-forward

- Pan/zoom/fit remains part of prior closed-out Board Canvas navigation scope.
- Event writer/schema/materializer/validator changes remain out of scope.
