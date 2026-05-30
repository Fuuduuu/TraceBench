# BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Baseline accepted input
- `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS` is accepted and pushed.
- Accepted V1-safe UI direction remains `READINESS_PANEL_ONLY`.
- No background photo helper.
- No transform/matrix computation.
- No photo-local evidence conversion.
- No visual_trace/damage/suspect canvas geometry.
- No event-writing UI.
- No Project ZIP contract change.
- No `board_graph.json` / `view_state.json`.

## Scope decision (locked)
Future `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS` is locked to a read-only board-canvas readiness/status panel with metadata only.

### Panel type
- read-only readiness/status panel only
- metadata only
- no canvas geometry
- no overlays
- no photo rendering
- no event writing

### Panel placement
- prefer project/photo-level board-canvas panel, not per-component identity
- panel may appear when `KnownFacts.photoToBoardAlignments` is non-empty
- panel must not imply alignment is a property of selected component identity

### Allowed displayed fields
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- reference-point count only
- `transform_type` (metadata only)
- `alignment_quality_label`
- `source_event_id`
- `status`

### Explicitly forbidden displayed fields/behavior
- raw reference-point `x/y` coordinates
- transformed coordinates
- transform matrix output
- similarity/affine/homography computation output
- mapped visual traces
- mapped damage/suspect regions
- background photo
- photo overlay
- edit/confirm/save/apply controls
- event-writing actions
- reference-point editing
- navigation to photo overlay unless separately scoped

### Required safety copy
- `Photo alignment readiness — metadata only`
- `Stores alignment reference points only.`
- `Does not confirm identity, nets, measurements, or faults.`
- `No photo-local evidence is rendered on board canvas.`
- `No transform is computed.`
- `renderer writes: none`
- `Not electrical proof.`

### transform_type wording lock
- display with label: `declared type — not computed`
- must not imply matrix/math was calculated

## Future implementation allowlist (locked)
May touch only:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- docs ledger/audit files

Must not touch:
- `lib/shared/models/known_facts.dart`
- `schemas/**`
- `tools/**`
- `tests/**`
- `samples/**`
- `assets/**`
- Project ZIP tooling/files

## Future test expectations (locked)
- panel appears when `photoToBoardAlignments` is non-empty
- panel absent or empty-safe when no alignments exist
- allowed metadata fields appear
- reference-point count appears
- raw reference-point `x/y` values do not appear
- `transform_type` includes `declared type — not computed`
- required safety copy appears
- no background photo/image rendering
- no `drawLine`/`drawPath`/photo-local overlay behavior
- no edit/confirm/save/apply/event-writing labels
- no `board_graph.json` / `view_state.json` behavior
- `renderer writes: none` remains visible
- existing board-canvas placement/inspector/measurement/visual-trace tests remain passing

## Routing
- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`

## Hard boundaries preserved
- renderer writes nothing
- photo pixels are not facts
- alignment is not identity/pin/net/measurement/fault proof
- `visual_trace` is not a net
- damage is not fault proof
- suspect is not probability
- no `board_graph.json`
- no `view_state.json`
- no Project ZIP contract change
