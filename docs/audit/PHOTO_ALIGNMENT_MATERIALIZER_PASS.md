# PHOTO_ALIGNMENT_MATERIALIZER_PASS

## PASS_ID
`PHOTO_ALIGNMENT_MATERIALIZER_PASS`

## Lane
`TOOLS_PASS / SCHEMA_PASS`

## Mode
Implement narrow materializer + known_facts projection only.

## Implemented

### 1) Materializer projection
- Updated `tools/materialize_known_facts.py`.
- Added optional projection collection:
  - `known_facts.photo_to_board_alignments`
- Projection source:
  - `event_type == photo_to_board_alignment_confirmed`
- Projection filters:
  - `event.status == accepted`
  - `actor.type == user`
- Projected fields:
  - `alignment_id`
  - `source_photo_id`
  - `board_side`
  - `coordinate_space_from`
  - `coordinate_space_to`
  - `reference_points_photo`
  - `reference_points_board`
  - `transform_type`
  - `alignment_quality_label`
  - `notes` only when present
  - `source_event_id`
  - `status = user_confirmed_alignment`

### 2) Latest-per-alignment rule
- For matching `alignment_id`, latest accepted event by sequence wins.
- `source_event_id` comes from the winning event.
- No extra supersession/stale lifecycle introduced.

### 3) Empty projection convention
- `photo_to_board_alignments` is omitted when no qualifying alignment event exists.

### 4) known_facts schema support
- Updated `schemas/known_facts.schema.json`.
- Added optional `photo_to_board_alignments` item contract with strict fields and constraints:
  - `alignment_id` pattern `^ALN[0-9]+$`
  - `source_photo_id` photo-id pattern
  - `board_side` enum `top|bottom|unknown`
  - `coordinate_space_from` const `photo_local`
  - `coordinate_space_to` const `board_normalized`
  - `reference_points_photo` non-negative point coordinates
  - `reference_points_board` normalized `0..1` coordinates
  - `transform_type` enum `similarity|affine`
  - `alignment_quality_label` non-empty string
  - `source_event_id` non-empty string
  - `status` enum `user_confirmed_alignment`

### 5) Tests
- Updated `tests/test_materialize_known_facts.py` with alignment-projection coverage:
  - accepted projection path
  - notes present/absent behavior
  - required field preservation
  - actor/status gating (rejected/draft/superseded + ai/system/import)
  - latest-per-alignment winner rule
  - multiple alignment-id projection
  - omitted-key behavior when none
  - side-effect non-creation assertions
  - no `board_graph.json` / `view_state.json` write assertion
  - schema contract assertions for `photo_to_board_alignments`
- Updated `tests/test_project_zip.py` compatibility test:
  - project with accepted alignment event validates with unchanged ZIP contract/tooling.

## Explicitly not implemented
- No transform matrix computation.
- No photo-local geometry conversion.
- No render overlay data projection.
- No changes to `schemas/events.schema.json`.
- No changes to `tools/validate_events_jsonl.py`.
- No Dart/Flutter model or UI changes.
- No Project ZIP tooling/contract changes.

## Boundary confirmation
- No side effects into components, pins, nets, measurements, visual_traces, faults/fault_candidates, or repair conclusions.
- No changes to `excluded_from_fault_candidates`.
- No `board_graph.json` / `view_state.json` output.

## Next recommended pass
`PHOTO_ALIGNMENT_MATERIALIZER_AUDIT_PASS`
