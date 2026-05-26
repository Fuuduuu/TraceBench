# BOARD_PLACEMENT_REFERENCE_STATUS_FIX_PASS

Lane: `SCHEMA_PASS / VALIDATOR_FIX`  
Mode: implementation (narrow validator + validator tests only)

## Goal

Require `component_visual_placement_confirmed` placement references to resolve only to prior accepted create-events.

## Changes made

1. Updated placement provenance index behavior in `tools/validate_events_jsonl.py`:
   - `component_sequence_by_id` now records only `component_created` events with `status == "accepted"`.
   - `photo_sequence_by_id` now records only `photo_added` events with `status == "accepted"`.
2. Kept existing placement validation logic unchanged for:
   - forward reference rejection
   - actor restrictions
   - coordinate/sizing checks
   - visual-only boundary constraints.
3. Added placement-reference status tests in `tests/test_validate_events_jsonl.py`:
   - rejected/draft `component_created` no longer satisfy placement `component_id` references.
   - rejected/draft `photo_added` no longer satisfy `photo_local.source_photo_id` references.
   - `component_updated` alone does not satisfy placement component existence.
   - `component_marked_unknown` alone does not satisfy placement component existence.

## Preserved boundaries

- No schema changes.
- No materializer or known-facts projection changes.
- No Project ZIP contract/tooling changes.
- No Flutter/runtime/UI changes.
- Placement remains visual/documentation-only and non-electrical.

## Validation

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_validate_events_jsonl`
- `git diff --name-only`
- `git status --short --branch`
