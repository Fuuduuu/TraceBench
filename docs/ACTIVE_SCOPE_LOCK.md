# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_EVENT_SCHEMA_HARDENING_PASS`

## Goal

Harden V1 photo-flow events and add schema, validator, materializer and sample/test coverage for photo evidence events.

## Allowed surfaces

- schemas/events.schema.json
- schemas/known_facts.schema.json
- schemas/samples/valid_photo_added.json
- schemas/samples/valid_damage_region_marked.json
- tools/validate_events_jsonl.py
- tools/materialize_known_facts.py
- samples/pelle_pv20_minimal/events.jsonl
- samples/pelle_pv20_minimal/known_facts.json
- assets/samples/pelle_pv20_minimal/events.jsonl
- assets/samples/pelle_pv20_minimal/known_facts.json
- tests/test_validate_events_jsonl.py
- tests/test_materialize_known_facts.py
- tests/test_schema_samples.py
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md
- docs/audit/PHOTO_EVENT_SCHEMA_HARDENING_PASS.md

## Forbidden surfaces

- Flutter/Dart implementation
- camera/OCR/CV integration
- AI/fault probability logic
- source search
- photo file import or image processing pipelines
- cloud sync / BLE workflows
- connected-net invalidation implementation
- event-writing implementation

## Verify

Required:

- py -3 tools\validate_all.py
- flutter test --timeout=30s --reporter expanded
