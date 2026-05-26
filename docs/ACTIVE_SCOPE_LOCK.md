# ACTIVE_SCOPE_LOCK.md

## Current pass

`MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_LOCK_PASS`

## Goal

Lock narrow docs-only scope for preventing duplicate `measurement_recorded` events caused by repeated fast taps on `Salvesta sündmus`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `lib/**` implementation changes in this pass
- `test/**`
- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `pubspec.yaml`
- `pubspec.lock`
- `events.jsonl`
- `known_facts.json`
- Project ZIP tooling changes
- materializer/export/reload flow changes
- `MeasurementEventWriter` semantic changes
- historical event deduplication
- schema changes
- AI duplicate inference
- canonical event rule changes

## Scope decisions to lock

1. The follow-up implementation pass is explicitly `MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_PASS` (`FLUTTER_PASS`).
2. Duplicate prevention lives in `MeasurementRecordScreen` UI state only.
3. Future implementation must add immediate `_saveMeasurement()` re-entry guard.
4. Future implementation must keep submit blocked while save is in progress.
5. Future implementation must store last successful normalized form key and block repeated submit for unchanged form state.
6. Future implementation must re-enable submit only when form state changes.
7. `MeasurementEventWriter` append semantics remain unchanged.
8. No historical event dedupe.
9. No changes to materializer, `known_facts`, export flow, stale banner behavior, or ProjectState reload logic.

## Validate

- `py -3 tools\validate_all.py`
