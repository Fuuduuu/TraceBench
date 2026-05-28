# PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS

## PASS_ID
`PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock. No schema/tool/materializer/Dart/runtime implementation.

## Input audit verdict
- `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS`: `NEEDS_SCOPE_FIRST`.

## Decision
Photo-alignment implementation remains deferred.
This pass locks only the future data-model direction and sequencing.

## Placeholder event policy
- `photo_reference_points_set` and `photo_layer_aligned` are placeholder event names only.
- They are unsafe for writer usage until dedicated accepted scope locks cover:
  - payload schema semantics,
  - validator semantics,
  - materializer projection semantics,
  - tests.
- Placeholder pass-through is acceptable only while no writer emits accepted events for these families.

## Canonical alignment principle
If photo-to-board alignment affects board-canvas evidence placement, report/export output, or repeatable project state, alignment must be:
- canonical,
- event-backed,
- human-confirmed,
- materialized.

The following are not canonical truth:
- hidden UI transform state
- local cache truth
- `view_state.json`
- `board_graph.json`
- AI-only transform proposals
- background-photo drag state

## Volatile preview principle
Future volatile/session alignment preview is allowed only if:
- explicitly labeled non-canonical preview
- not saved/materialized/exported/reported
- reset on reload
- never used as accepted board-canvas truth

## Candidate future canonical event direction (not implemented)
Candidate event:
- `photo_to_board_alignment_confirmed`

Minimum payload direction:
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from = photo_local`
- `coordinate_space_to = board_normalized`
- `reference_points_photo[]`
- `reference_points_board[]`
- `transform_type`
- `alignment_quality_label`
- `notes` (optional)

Actor/rule direction:
- `actor.type` must be `user` for canonical alignment.
- AI actor must be rejected for canonical alignment.
- `source_photo_id` must reference prior accepted `photo_added`.
- `graph_layout` must be rejected as canonical source or target coordinate space.
- Alignment does not confirm identity/net/measurement/fault truth.
- Future lifecycle must support supersession/stale-awareness.

## Evidence-family boundaries reaffirmed
- board-normalized component placements: safe and already implemented.
- photo-local placements: not board-renderable without accepted transform.
- visual-trace geometry: photo-local, deferred from board-canvas rendering.
- damage/suspect geometry: photo-local, deferred from board-canvas rendering.
- visual-trace metadata: safe as read-only inspector/list metadata.
- measurement summary: safe as read-only inspector/list metadata.
- background photo helper: deferred.
- AI overlays: out of scope.

## Future sequence lock
1. `PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS`
2. `PHOTO_ALIGNMENT_VALIDATOR_SCOPE_LOCK_PASS`
3. `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`
4. `PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`
5. only later: board-canvas background/photo helper or visual evidence rendering scope locks

Governance-first alternative before step 1:
- `PHOTO_FLOW_SPEC_AUDIT_PASS`

## Test expectations locked for future implementation
- canonical alignment requires `actor.type=user`
- AI actor rejected
- `source_photo_id` must reference accepted `photo_added`
- `coordinate_space_from == photo_local`
- `coordinate_space_to == board_normalized`
- `graph_layout` rejected
- no visual_trace -> net promotion
- damage/suspect never become fault proof
- no `board_graph.json`
- no `view_state.json`
- no Project ZIP contract change unless separately scoped
- renderer writes nothing
- no photo-local evidence rendered on board without accepted transform

## Next recommended pass
`PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS`  
Alternative if governance requires audit-first reconciliation: `PHOTO_FLOW_SPEC_AUDIT_PASS`.
