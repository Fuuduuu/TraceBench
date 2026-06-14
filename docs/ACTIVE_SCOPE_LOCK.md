# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock of `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS` before implementation.

## Current goal
- Define the next narrow Board Canvas measurement-marker rendering slice as a component-level presence badge/highlight.
- Preserve all read-only / zero-event / non-coordinate semantics from existing Board Canvas passes.
- Keep route docs (`CURRENT_STATE`, `PASS_QUEUE`, `AUDIT_INDEX`) aligned for implementation handoff.

## Next recommended pass

`V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SCOPE_LOCK`
- mode: docs-only route lock constrained to this pass’s governance surface.
- latest pass handled: `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`
- prior governance-hygiene base: `20e80d3` (`docs: clean governance ledger statuses`)

## File allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`

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
- Visual Trace Shape Assist runtime behavior
- any `sequence` field addition
- dependency/toolchain lockfile or package updates
- platform/sample/assets (`assets/samples/pelle_pv20_minimal/metadata/`)
- `_incoming/`
- non-authorized runtime test suites outside the explicit allowlist

## Current route lock

Current: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`

## Exact allowed future implementation focus

- Default implementation file: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Default implementation tests: `test/widget/board_canvas_screen_test.dart`
- Measurement badge rendering is read-only and component-level only.
- Render badges/highlights only on already rendered component placements in existing board-normalized coordinates.

## Scope-lock carry-forward

- Pan/zoom/fit remains part of prior closed-out Board Canvas navigation scope.
- Event writer/schema/materializer/validator changes remain out of scope.
- Photo/AI/probe/contour/background layers remain deferred.
- `Project ZIP`, known-facts write-path, and events persistence are deferred.
- No `sequence` field changes.
- No direct runtime behavior should start in this lock pass; scope lock is docs-only.

## Exact future focus

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS.md`
