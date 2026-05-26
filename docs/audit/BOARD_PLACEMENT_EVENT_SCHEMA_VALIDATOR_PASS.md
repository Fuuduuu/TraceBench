# BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS

Lane: `SCHEMA_PASS`  
Mode: schema + validator only

## MODEL_ROUTING_CHECK

Result: PASS

Reason:

- Implementation is restricted to `schemas/events.schema.json`, `tools/validate_events_jsonl.py`, and validator/schema tests.
- Projection/materializer/known-facts schema and ZIP tooling are intentionally not changed in this split.

## Scope summary

1. Added new event type support:
   - `component_visual_placement_confirmed`
2. Added strict payload schema:
   - required visual placement fields
   - exactly one sizing mode (`scale` xor `width`+`height`)
   - coordinate-space and board-side enums
   - conditional rules for `photo_local` vs `board_normalized`
   - `additionalProperties: false`
3. Added validator logic:
   - V1 actor requirement (`actor.type == user`)
   - `graph_layout` rejection
   - coordinate and sizing checks
   - source-photo reference rules for `photo_local`
   - source-photo forbidden for `board_normalized` in V1
   - prior `component_created` requirement for `component_id`
   - forward reference rejection
   - side-effect/proposal field rejection
4. Added validator tests for pass requirements.
5. No projection/materializer behavior changes in this pass.

## Files changed

- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `tests/test_validate_events_jsonl.py`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_SCHEMA_VALIDATOR_PASS.md`

## Validation commands

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_validate_events_jsonl`
- `git diff --name-only`
- `git status --short --branch`
