# PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS

## PASS_ID
`PHOTO_ALIGNMENT_MATERIALIZER_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only materializer scope lock. No materializer/schema/tool/Dart/runtime implementation.

## Baseline
- `PHOTO_ALIGNMENT_EVENT_SCHEMA_CLOSEOUT_PASS` is accepted.
- `photo_to_board_alignment_confirmed` currently has schema + validator support only.
- No materializer projection exists yet.
- No `known_facts` schema/model projection exists yet.
- No Dart `KnownFacts` alignment projection exists yet.

## Locked decisions

### 1) Projection ownership
- Future canonical projection ownership is Python materializer + `known_facts` schema.
- Future implementation must not:
  - store renderer-only transform truth in Flutter,
  - create `board_graph.json`,
  - create `view_state.json`,
  - persist hidden local transform state as canonical truth,
  - modify Project ZIP contract in this scope.

### 2) Future projection shape direction (not implemented)
Recommended future optional top-level key:
- `photo_to_board_alignments`

Recommended projected item fields:
- `alignment_id`
- `source_photo_id`
- `board_side`
- `coordinate_space_from`
- `coordinate_space_to`
- `reference_points_photo`
- `reference_points_board`
- `transform_type`
- `alignment_quality_label`
- `notes` (optional)
- `source_event_id`
- `status`

Recommended projection status:
- `user_confirmed_alignment`

### 3) First materializer-pass defer rules
First implementation must not:
- compute transform matrices/homographies,
- infer missing points,
- convert photo-local evidence to board-normalized evidence,
- project visual_trace/damage/suspect geometry through alignment,
- create renderer overlay data,
- create net/measurement/fault/identity facts.

### 4) Event selection rules
Future materializer projection direction:
- include only `event_type == photo_to_board_alignment_confirmed`
- include only `status == accepted`
- include only `actor.type == user`
- rely on validator-accepted payload contracts.

Non-accepted events must not appear in projected current facts.

### 5) Latest-per-alignment rule
First implementation direction:
- one current projected item per `alignment_id`,
- latest accepted event by sequence wins,
- `source_event_id` must point to winning event,
- no extra supersession lifecycle invention in first materializer pass.

### 6) known_facts schema direction
Future implementation will likely require `schemas/known_facts.schema.json` extension:
- optional top-level `photo_to_board_alignments`,
- strict item schema (`additionalProperties: false`),
- required fields aligned with projected item,
- preserved point constraints,
- `coordinate_space_from == photo_local`,
- `coordinate_space_to == board_normalized`,
- `transform_type in {similarity, affine}`,
- `status == user_confirmed_alignment`.

### 7) Materializer boundary rules
Future materializer must not:
- create/alter components,
- create/alter pins,
- create/alter measurements,
- create/alter nets,
- create/alter visual_traces,
- create fault candidates/repair conclusions,
- alter `excluded_from_fault_candidates`,
- modify customer report,
- change Project ZIP rules,
- write `board_graph.json` or `view_state.json`.

### 8) Placeholder policy
- `photo_reference_points_set` and `photo_layer_aligned` remain:
  - reserved/deferred,
  - not writer-ready,
  - not materialized,
  - not projected,
  - not represented in Dart.

### 9) Future implementation allowlist direction
Future `PHOTO_ALIGNMENT_MATERIALIZER_PASS` may likely touch:
- `tools/materialize_known_facts.py`
- `schemas/known_facts.schema.json`
- `tests/test_materialize_known_facts.py`
- `tests/test_project_zip.py` only if needed for compatibility assertions
- docs ledger/audit files

Must not touch:
- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `lib/**`
- `test/**`
- Flutter/runtime UI
- Project ZIP contract tooling (unless separately scoped).

### 10) Future precheck/implementation sequencing
Recommended next passes:
1. `PHOTO_ALIGNMENT_MATERIALIZER_PRECHECK_AUDIT_PASS`
2. `PHOTO_ALIGNMENT_MATERIALIZER_PASS`

## Future test expectations locked
- accepted user alignment event projects into `known_facts.photo_to_board_alignments`.
- rejected/draft/superseded alignment events do not project current facts.
- non-user actor alignment events do not project if present.
- latest accepted event wins per `alignment_id`.
- reference-point lists preserved without conversion.
- `transform_type` and `alignment_quality_label` preserved.
- `source_event_id` included.
- no nets/measurements/components/visual_traces created as side effects.
- known_facts schema accepts valid projected alignment and rejects malformed projection.
- Project ZIP validation behavior remains unchanged.
- `board_graph.json`/`view_state.json` remain forbidden.

## Result
This pass is docs-only and intentionally defers:
- materializer implementation,
- `known_facts` schema implementation,
- Dart model implementation,
- renderer/UI alignment behavior.
