# BOARD_PLACEMENT_EVENT_PROJECTION_PASS

Lane: `TOOLS_PASS / SCHEMA_PASS`  
Mode: known-facts projection only

## MODEL_ROUTING_CHECK

Result: PASS

Reason:

- Implementation is limited to known-facts schema + materializer + projection/ZIP tests.
- No changes were made to event schema (`schemas/events.schema.json`) or event validator behavior (`tools/validate_events_jsonl.py`).
- Projection is kept visual/documentation-only with no electrical identity/net/measurement/fault side effects.

## Scope summary

1. Added optional top-level `component_visual_placements` to `schemas/known_facts.schema.json`.
2. Added strict item shape:
   - required placement fields
   - required `source_event_id`
   - required `status: user_confirmed_visual`
   - exactly one sizing mode (`scale` xor `width`+`height`)
   - `coordinate_space` enum and `board_side` enum
   - conditional source-photo requirement for `photo_local`
   - `additionalProperties: false` for placement items
3. Updated `tools/materialize_known_facts.py` to project accepted human-confirmed placement events:
   - reads `component_visual_placement_confirmed`
   - accepts only `status == accepted`
   - requires actor `type == user`
   - selects latest accepted placement per `component_id`
   - writes `source_event_id` and `status: user_confirmed_visual`
   - carries optional `template_id` / `source_photo_id` only when present
4. Added tests for:
   - top-level projection behavior
   - latest-per-component behavior
   - source event/status fields
   - `photo_local` / `board_normalized` projection expectations
   - visual-only side-effect boundary
   - removed-component placement retention
   - known-facts schema presence for placement projection
   - ZIP validation pass with placement projection
   - ZIP validation failure when placement projection is stale/missing

## Files changed

- `schemas/known_facts.schema.json`
- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_project_zip.py`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_PLACEMENT_EVENT_PROJECTION_PASS.md`

## Validation commands

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_materialize_known_facts`
- `py -3 -m unittest tests.test_project_zip`
- `git diff --name-only`
- `git status --short --branch`
