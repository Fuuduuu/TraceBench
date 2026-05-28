# PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS

## PASS_ID
`PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only schema scope lock. No schema/tool/validator/materializer/Dart/runtime implementation.

## Input baseline
- `PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS` accepted.
- `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS` verdict already recorded: `NEEDS_SCOPE_FIRST`.

## Event family decision
Locked direction:
- future canonical family is `photo_to_board_alignment_confirmed`.

Placeholder handling:
- `photo_reference_points_set` and `photo_layer_aligned` remain reserved/deferred placeholders.
- placeholder families are unsafe for writer usage until formal payload schema + validator semantics + materializer projection + tests are accepted.

Rationale:
- safest first canonical path is one explicit user-confirmed alignment event.
- avoids ambiguous partial semantics from placeholder emission.

## Future payload direction (locked, not implemented)

Required fields:
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- `reference_points_photo`
- `reference_points_board`
- `transform_type`
- `alignment_quality_label`

Optional:
- `notes`

Hard value rules:
- `coordinate_space_from` must be `photo_local`.
- `coordinate_space_to` must be `board_normalized`.
- `graph_layout` rejected as canonical source/target space.
- `alignment_quality_label` should be descriptive text, not numeric certainty.
- avoid canonical numeric `confidence_score` in first schema direction.

## Reference-point direction (locked, not implemented)

`reference_points_photo`:
- list of photo-local `{x, y}` points in `source_photo_id` context.

`reference_points_board`:
- list of board-normalized `{x, y}` points where x/y are in `0..1`.

Rules:
- photo/board point-list lengths must be equal.
- minimum point count depends on `transform_type`.
- no hidden point inference.
- no AI-generated point canonicalization.
- points are spatial alignment evidence only; not identity/net/measurement/fault evidence.

## Transform-type direction (locked, not implemented)

Candidate first-direction enum:
- `similarity`
- `affine`

Deferred in first direction:
- `homography_candidate`
- freeform/manual/nonlinear transform families

Minimum pair direction:
- `similarity >= 2`
- `affine >= 3`

## Actor/status/source-photo direction (locked, not implemented)

- canonical accepted alignment requires `actor.type=user`.
- AI actor rejected for canonical alignment.
- `system/import` actor rejected unless separately scoped in a migration/import pass.
- accepted status required for materialization.
- `source_photo_id` must reference prior accepted `photo_added`.

## Evidence boundary constraints for future schema

Future alignment payload must not include fields implying identity/net/measurement/fault/proposal confirmation, including equivalents of:
- `net_id`
- `measurement_id`
- `fault_id`
- `component_identity`
- `identity_status`
- `ai_proposal_id`
- `proposal_status`
- `confidence_score`
- `confirmed_net`
- `confirmed_fault`
- `repair_conclusion`

## Future schema test expectations (locked)

- schema accepts valid `photo_to_board_alignment_confirmed`.
- schema rejects missing `alignment_id`.
- schema rejects missing `source_photo_id`.
- schema rejects `coordinate_space_from != photo_local`.
- schema rejects `coordinate_space_to != board_normalized`.
- schema rejects `graph_layout`.
- schema rejects numeric `confidence_score` if forbidden.
- schema rejects unequal reference-point list lengths.
- schema rejects too few pairs for selected `transform_type`.
- validator rejects AI actor.
- validator rejects missing/non-accepted/forward-referenced `source_photo_id`.
- materializer projects only accepted user-confirmed alignments.
- Project ZIP contract remains unchanged unless separately scoped.

## Sequencing and next recommendation

Locked sequence direction:
1. `PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS` (this pass, completed)
2. `PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS` (recommended)
3. `PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS` (only after precheck)
4. `PHOTO_ALIGNMENT_VALIDATOR_SCOPE_LOCK_PASS`
5. `PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`
6. `PHOTO_ALIGNMENT_DART_MODEL_SCOPE_LOCK_PASS`

## Final note
This pass explicitly defers schema implementation.
