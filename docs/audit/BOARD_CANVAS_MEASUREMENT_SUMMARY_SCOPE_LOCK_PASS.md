# BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS

- PASS_ID: `BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS`
- Lane: `DOCS_SYNC`
- Date: 2026-05-28
- Mode: docs-only scope lock
- Status: completed

## Inputs acknowledged

- `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_AUDIT_CLOSEOUT_PASS` accepted.
- `BOARD_CANVAS_READONLY_RENDERER_QA_PASS` accepted.
- Final evidence decision remains `DEFER_VISUAL_EVIDENCE`.

## Locked decision

Future board-canvas measurement support is limited to read-only inspector/list metadata only.

It must not render measurement geometry on the board canvas.

## Rationale

- `MeasurementFact` has no board/canvas coordinate fields.
- measurement `from` / `to` are string references, not geometry anchors.
- overlay placement would require inferred coordinates and risks false spatial/electrical claims.

## Future pass routing

- Next recommended pass: `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`.

## Future implementation scope (locked allowlist)

- `lib/features/board_canvas/**`
- board-canvas widget tests (`test/widget/board_canvas_screen_test.dart` or focused board-canvas measurement tests)
- docs ledger/audit files

If implementation requires `lib/shared/models`, schema/tooling, or Project ZIP contract changes, it must stop and request a new scope pass.

## Strict association rule (locked)

A measurement may be associated with selected component only when one of these is true:

- `measurement.from == componentId`
- `measurement.to == componentId`
- `measurement.from` starts with `componentId + "."`
- `measurement.to` starts with `componentId + "."`

Forbidden:

- loose prefix matching (`Q2` must not match `Q20`)
- net/proximity/coordinate inference
- inferred pin geometry from endpoint text

## Explicitly forbidden in future measurement summary implementation

- measurement canvas overlays
- invented measurement anchors/coordinates
- measurement averaging/recalculation/inference
- net inference/promotion from measurement summary proximity
- action surfaces (`Measure`, `Re-measure`, `Apply to schematic`, `Confirm net`)
- event-writing paths
- known-facts mutation
- `board_graph.json` / `view_state.json` creation
- Project ZIP contract changes

## Deferred surfaces

- measurement canvas overlays
- net rendering from measurements
- pin-geometry overlays
- measurement editing/re-measure actions
- AI interpretation of measurements
- fault probability

## Boundary confirmation

- visual_trace remains visual-only.
- no visual_trace -> net promotion.
- no photo-local evidence rendering without accepted transform/audit.
- no renderer writes.
- no `board_graph.json` / `view_state.json`.
