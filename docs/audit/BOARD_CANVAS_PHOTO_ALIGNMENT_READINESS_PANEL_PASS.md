# BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS

## PASS_ID
`BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`

## Lane
`FLUTTER_PASS`

## Mode
Implement narrow read-only board-canvas photo-alignment readiness panel.

## Scope implemented
- Added a read-only project/photo-level readiness metadata panel to board canvas.
- Panel appears when `KnownFacts.photoToBoardAlignments` is non-empty.
- Panel is non-actionable and read-only.
- Panel uses constrained scrollable layout to avoid RenderFlex overflow on constrained viewports while preserving all required copy and fields.

## Data path used
- `ProjectState.knownFacts.photoToBoardAlignments` typed projection only.
- No raw `known_facts.json` parsing.
- No `events.jsonl` reads.
- No tooling/materializer calls.

## Displayed metadata (allowlist only)
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- reference pair count only
- `transform_type` labeled `declared type — not computed`
- `alignment_quality_label`
- `source_event_id`
- `status`

## Required safety copy implemented
- `Photo alignment readiness — metadata only`
- `Stores alignment reference points only.`
- `Does not confirm identity, nets, measurements, or faults.`
- `No photo-local evidence is rendered on board canvas.`
- `No transform is computed.`
- `renderer writes: none`
- `Not electrical proof.`

## Forbidden behavior confirmed
- No raw reference-point `x/y` display.
- No transformed coordinates or matrix/math output.
- No background photo helper or image/photo rendering.
- No photo-local evidence conversion.
- No visual_trace/damage/suspect canvas geometry rendering.
- No edit/confirm/save/apply/reference-point editing/event-writing UI.
- No AI proposal UI.
- No Project ZIP contract change.
- No `board_graph.json` / `view_state.json`.

## Existing behavior preserved
- board-normalized placement rendering
- read-only inspector
- measurement summary
- visual_trace metadata summary
- empty states
- `renderer writes: none`

## Routing
- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_AUDIT_PASS`
