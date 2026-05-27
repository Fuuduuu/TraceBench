# MEASUREMENT_EVENT_ID_COMPAT_FIX_PASS

## Lane

`FLUTTER_PASS / VALIDATOR_COMPAT`

## Goal

Make Dart measurement event writer produce schema/validator-compatible `event_id` values without changing schema/validator format.

## Scope

- Updated:
  - `lib/shared/event_write/measurement_event_writer.dart`
  - `test/unit/measurement_event_writer_test.dart`
- Not changed:
  - `schemas/events.schema.json`
  - `tools/validate_events_jsonl.py`
  - migration/historical event rewrite
  - measurement payload or envelope semantics outside `event_id` generation compatibility

## Implementation summary

1. Default writer `event_id` generation now uses schema-compatible format:
   - `^evt_[0-9]{6}$`
2. Default generation is sequence-based:
   - sequence 1 -> `evt_000001`
   - sequence 2 -> `evt_000002`
3. Uniqueness is preserved by checking existing IDs and advancing candidate numeric suffix only if needed.
4. Existing injected `eventIdGenerator` seam is preserved, but injected values are now validated against schema-compatible format before use.
5. Historical `evt_flutter_*` events are not rewritten and no migration is introduced.

## Tests updated

- Added/updated unit coverage for:
  - default generated `event_id` matches schema pattern
  - sequence-to-ID mapping (`evt_000001`, `evt_000002`, etc.)
  - distinct IDs across multiple append operations
  - custom generator collision handling with schema-compatible IDs
  - explicit default-path non-emission of `evt_flutter_*`
- Existing measurement write behavior tests remain in place.

## Validation

- `py -3 tools\validate_all.py`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
