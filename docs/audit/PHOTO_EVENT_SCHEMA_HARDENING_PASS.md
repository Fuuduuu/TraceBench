# PHOTO_EVENT_SCHEMA_HARDENING_PASS

## Status

completed

## Lane

SCHEMA_PASS

## Files changed

- `schemas/events.schema.json`
- `schemas/known_facts.schema.json`
- `schemas/samples/valid_photo_added.json`
- `schemas/samples/valid_damage_region_marked.json`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `samples/pelle_pv20_minimal/events.jsonl`
- `samples/pelle_pv20_minimal/known_facts.json`
- `assets/samples/pelle_pv20_minimal/events.jsonl`
- `assets/samples/pelle_pv20_minimal/known_facts.json`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_schema_samples.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`

## Validator and schema changes

- Added `photo_added`, `damage_region_marked`, `suspect_region_marked`, and `visual_trace_added` payload definitions to `schemas/events.schema.json`.
- Enforced V1 rules for photo evidence payload fields, modes, path shape, bbox checks, trace id format, and evidence type.
- Extended `tools/validate_events_jsonl.py` with photo-flow-specific validation:
  - actor type restrictions (`ai` forbidden for all photo-flow evidence events)
  - photo id uniqueness
  - cross-reference checks for `photo_id` in damage/suspect/visual trace events
  - trace/region uniqueness
  - non-measurement evidence checks for `net_connection_confirmed`

## Materializer changes

- Extended `known_facts` output with:
  - `photos`
  - `damage_regions`
  - `suspect_regions`
  - `visual_traces`
- Materialization keeps measurements, components, pins, nets, and excluded footprint facts unchanged in behavior.
- `visual_trace_added` is materialized as evidence-only trace with `evidence_type = visual_trace` and never added to electrical `nets`.

## Sample updates

- Added placeholder photo events to `samples/pelle_pv20_minimal/events.jsonl`:
  - `evt_000014` (`photo_added`)
  - `evt_000015` (`damage_region_marked`)
- Regenerated known-facts outputs so sample materialization now includes `photo_top_backlight_001` and `DMG001`.
- Synced Flutter bundled sample copies in `assets/samples/pelle_pv20_minimal/`.

## Scope checks

- No Flutter code changes.
- No camera, OCR/CV, AI, or fault probability feature work.
- No connected-net invalidation.
- No Project ZIP tooling changes.

## Validation

- `py -3 tools\validate_all.py`
- `flutter test --timeout=30s --reporter expanded`
