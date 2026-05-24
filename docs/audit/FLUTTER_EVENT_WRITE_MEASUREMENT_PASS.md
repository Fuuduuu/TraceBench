# FLUTTER_EVENT_WRITE_MEASUREMENT_PASS

Status: completed  
Lane: FLUTTER_PASS

## Files changed

- `lib/shared/event_write/measurement_event_writer.dart`
- `lib/shared/models/project_state.dart`
- `lib/features/measurements/screens/measurement_record_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/app/router.dart`
- `test/unit/measurement_event_writer_test.dart`
- `test/widget/measurement_write_screen_test.dart`
- `test/integration/measurement_write_end_to_end_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_EVENT_WRITE_MEASUREMENT_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\dart.bat format lib/shared/event_write/measurement_event_writer.dart lib/features/measurements/screens/measurement_record_screen.dart lib/shared/models/project_state.dart test/unit/measurement_event_writer_test.dart test/widget/measurement_write_screen_test.dart test/integration/measurement_write_end_to_end_test.dart`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`

## Implementation summary

- Added a narrow measurement event writer service that:
  - reads existing local `events.jsonl`,
  - validates existing sequence/event id policy,
  - computes `sequence = max(existing) + 1` (or `1` if empty),
  - generates collision-resistant `evt_flutter_<timestamp_utc>_<short_random>` event ids,
  - builds a single `measurement_recorded` event envelope with explicit `from`, `to`, and `unit`,
  - appends by rewriting file content through a temp-file strategy that preserves existing lines on success and restores backup on failure.
- Added manual measurement UI (`/project/measurements/new`) with manual value/unit/target input, submit guardrails, success and error messaging, and stale projection notice.
- Marked local project state as projection stale (`isProjectionStale = true`) after successful append.
- No known facts mutation or ZIP writes.

## Tests added / updated

- `test/unit/measurement_event_writer_test.dart`
- `test/widget/measurement_write_screen_test.dart`
- `test/integration/measurement_write_end_to_end_test.dart`

## Forbidden-surface confirmation

- Measurement-only event writing implemented (`measurement_recorded`).
- `known_facts.json` is not mutated.
- No direct ZIP mutation.
- No `net_connection_confirmed`/`component_created`/`pin_defined` side-effect events.
- No AI-authored measurement values.
- No component, pin, photo, annotation writes.
- No visual trace promotion logic.
