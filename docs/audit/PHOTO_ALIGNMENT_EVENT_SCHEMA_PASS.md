# PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS

## PASS_ID
`PHOTO_ALIGNMENT_EVENT_SCHEMA_PASS`

## Lane
`SCHEMA_PASS / VALIDATOR_FIX`

## Mode
Implement narrow event schema + validator support only.

## Inputs
- `PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS` accepted.
- `PHOTO_ALIGNMENT_EVENT_SCHEMA_PRECHECK_AUDIT_PASS` verdict from user/context: `PASS_WITH_NITS` (proceed).

## Implemented

### 1) `schemas/events.schema.json`
- Added event type:
  - `photo_to_board_alignment_confirmed`
- Added event-type payload routing in `allOf`.
- Added strict `$defs.photo_to_board_alignment_confirmed` with:
  - required:
    - `alignment_id`
    - `source_photo_id`
    - `board_side`
    - `coordinate_space_from`
    - `coordinate_space_to`
    - `reference_points_photo`
    - `reference_points_board`
    - `transform_type`
    - `alignment_quality_label`
  - optional:
    - `notes`
  - hard constraints:
    - `alignment_id` pattern `^ALN[0-9]+$`
    - `source_photo_id` pattern `^photo_[a-z0-9_]+$`
    - `board_side` enum `top|bottom|unknown`
    - `coordinate_space_from` const `photo_local`
    - `coordinate_space_to` const `board_normalized`
    - reference-point arrays with strict point objects `{x,y}`:
      - photo points: `x,y >= 0`
      - board points: `0 <= x,y <= 1`
    - `transform_type` enum `similarity|affine`
    - `alignment_quality_label` non-empty string
    - `additionalProperties: false`

### 2) `tools/validate_events_jsonl.py`
- Added alignment constants:
  - `ALIGNMENT_ALLOWED_TRANSFORM_TYPES`
  - `ALIGNMENT_MINIMUM_PAIRS`
  - `ALIGNMENT_FORBIDDEN_FIELDS`
- Added fallback event-type support for `photo_to_board_alignment_confirmed`.
- Added validator function:
  - `_validate_photo_to_board_alignment_confirmed(...)`
- Added main-dispatch integration.
- Enforced:
  - `actor.type == user` only
  - `source_photo_id` references prior accepted `photo_added`
  - forward source-photo reference rejection
  - `coordinate_space_from == photo_local`
  - `coordinate_space_to == board_normalized`
  - `graph_layout` rejection
  - strict list checks for `reference_points_photo` / `reference_points_board`
  - equal point-list length
  - transform minimum pairs:
    - similarity >= 2
    - affine >= 3
  - photo-point non-negative checks
  - board-point range `0..1` checks
  - non-empty `alignment_quality_label`
  - unique `alignment_id`
  - explicit forbidden-field rejection:
    - `net_id`, `measurement_id`, `fault_id`,
    - `component_identity`, `identity_status`,
    - `ai_proposal_id`, `proposal_status`,
    - `confidence_score`,
    - `confirmed_net`, `confirmed_fault`,
    - `repair_conclusion`,
    - `component_id`, `component_ids`,
    - `pin_id`, `pin_ids`,
    - `trace_id`.

### 3) Schema sample
- Added:
  - `schemas/samples/valid_photo_to_board_alignment_confirmed.json`
- Format is self-contained two-line JSONL sample:
  1. accepted `photo_added`
  2. accepted `photo_to_board_alignment_confirmed`

### 4) Tests
- Added alignment validator test coverage in `tests/test_validate_events_jsonl.py`:
  - happy path:
    - similarity with 2 pairs passes
    - affine with 3 pairs passes
  - actor rejection:
    - ai rejected
    - system rejected
  - required field rejection:
    - missing `alignment_id`
    - missing `source_photo_id`
    - missing `transform_type`
    - empty `alignment_quality_label`
  - source-photo checks:
    - unknown source rejected
    - forward reference rejected
    - non-accepted source rejected
  - coordinate-space checks:
    - invalid `coordinate_space_from`
    - invalid `coordinate_space_to`
    - `graph_layout` rejected
  - reference-point checks:
    - unequal list lengths rejected
    - too few pairs for `affine`
    - too few pairs for `similarity`
    - board point out of range rejected
    - photo point negative rejected
  - transform check:
    - unknown transform type rejected
  - forbidden-field checks:
    - `net_id`, `confidence_score`, `component_id`, `pin_id` rejected

## Explicitly not implemented in this pass
- no materializer projection (`tools/materialize_known_facts.py` unchanged)
- no `known_facts` schema/model changes
- no Project ZIP contract/tool changes
- no Flutter/runtime/photo-helper/renderer alignment behavior

## Recommended next pass
`PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`
