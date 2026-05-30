# BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS

## PASS_ID
`BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only audit closeout.

## Audit verdicts recorded
- GPT Pro: `PREFER_METADATA_ONLY_NEXT`
- Claude Code: `PASS`

## Accepted UI audit decision
Next safe V1 UI direction is `READINESS_PANEL_ONLY`.

This means:
- show photo-alignment readiness/status metadata only,
- no background photo helper,
- no transform computation,
- no matrix computation,
- no photo-local evidence conversion,
- no visual_trace/damage/suspect canvas geometry,
- no event-writing UI,
- no Project ZIP contract change,
- no `board_graph.json`,
- no `view_state.json`.

## Accepted compatibility baseline
- `photo_to_board_alignment_confirmed` schema/validator support is accepted.
- `known_facts.photo_to_board_alignments` materializer projection is accepted.
- `known_facts` schema support is accepted.
- Dart KnownFacts `photoToBoardAlignments` support is accepted.
- board-canvas route and read-only inspector exist.
- measurement and visual-trace summaries remain metadata-only.
- `renderer writes: none` remains hard boundary.

## Allowed readiness metadata
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- reference-point count only
- `transform_type` as declared metadata only
- `alignment_quality_label`
- `source_event_id`
- `status`

## Explicit forbidden UI/rendering surfaces
- raw reference-point coordinate display,
- transform matrix computation,
- similarity/affine/homography computation,
- background photo helper,
- photo-local evidence board rendering,
- visual_trace/damage/suspect canvas geometry,
- event-writing UI,
- reference-point editing,
- confirm/save/apply controls,
- Project ZIP contract changes,
- `board_graph.json`,
- `view_state.json`.

## Safety copy required for future readiness panel
- `Photo alignment readiness — metadata only`
- `Stores alignment reference points only.`
- `Does not confirm identity, nets, measurements, or faults.`
- `No photo-local evidence is rendered on board canvas.`
- `No transform is computed.`
- `renderer writes: none`
- `Not electrical proof.`

## Scope notes for next pass
- readiness panel should be project/photo-level, not per-component, unless explicitly justified.
- reference-point count is safe; raw `x/y` values are not.
- `transform_type` must be labeled: `declared type — not computed`.
- `source_photo_id` must not create implicit navigation to photo overlay unless separately scoped.

## Routing
- Current pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_UI_SCOPE_AUDIT_CLOSEOUT_PASS`
- Next recommended pass: `BOARD_CANVAS_PHOTO_ALIGNMENT_READINESS_PANEL_SCOPE_LOCK_PASS`

## Hard boundaries preserved
- no schema/tool/materializer/Dart/Flutter implementation changes
- no Project ZIP contract changes
- no `board_graph.json` / `view_state.json`
- no photo-local evidence rendering
- no transform computation
