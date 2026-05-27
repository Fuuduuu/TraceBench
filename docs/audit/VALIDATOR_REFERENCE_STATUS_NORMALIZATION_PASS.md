# VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS

Lane: `SCHEMA_PASS / VALIDATOR_FIX`  
Mode: validator-only reference-status normalization

## Goal

Normalize validator reference semantics so domain references resolve to prior accepted source events where required by `GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS`.

## Implementation summary

Updated `tools/validate_events_jsonl.py` reference index usage and checks:

1. Accepted-source indexes now drive domain provenance checks:
   - `accepted_component_sequence_by_id`
   - `accepted_photo_sequence_by_id`
   - `accepted_measurement_sequence_by_event_id`
   - `accepted_pin_sequence_by_id`
2. Preserved placement strictness:
   - `component_visual_placement_confirmed` continues to require accepted component/photo provenance and forward-reference rejection.
3. Normalized component provenance checks:
   - `pin_defined` requires accepted prior component create and non-forward reference.
   - `repair_action_recorded` component targets require accepted prior component provenance (with sample-safe handling when no component create events exist in isolated fixtures).
   - `component_updated` and `component_marked_unknown` now require accepted prior component provenance and non-forward reference.
4. Normalized photo provenance checks:
   - `damage_region_marked`, `suspect_region_marked`, and `visual_trace_added` require accepted prior photo provenance and reject forward references.
5. Normalized measurement provenance checks:
   - `net_connection_confirmed.confirmed_by_event_ids` now require accepted prior measurement evidence and reject forward references.
6. Normalized pin target provenance in repair actions:
   - pin targets require accepted prior pin provenance and reject forward references.
7. Intentionally preserved audit metadata references:
   - `claim_invalidated` / conflict-family references still use all-event-id audit semantics in this pass.

## Tests added/updated

Updated `tests/test_validate_events_jsonl.py` with coverage for:

- rejected/non-accepted component-created provenance rejection in:
  - `pin_defined`
  - `component_updated`
  - `component_marked_unknown`
  - `repair_action_recorded` component targets
- rejected/non-accepted photo-created provenance rejection in:
  - `damage_region_marked`
  - `suspect_region_marked`
  - `visual_trace_added`
- forward photo reference rejection in `visual_trace_added`
- rejected/non-accepted measurement evidence rejection in `net_connection_confirmed`
- accepted measurement evidence pass path in `net_connection_confirmed`
- forward measurement reference rejection in `net_connection_confirmed`
- rejected/non-accepted pin provenance rejection for repair pin targets
- accepted pin provenance pass path for repair pin targets
- audit-metadata preservation example:
  - `claim_invalidated` may reference a rejected event id

## Out-of-scope (preserved)

- No schema changes.
- No materializer or known-facts projection behavior changes.
- No Project ZIP tooling changes.
- No sample/assets changes.
- No runtime/UI changes.

