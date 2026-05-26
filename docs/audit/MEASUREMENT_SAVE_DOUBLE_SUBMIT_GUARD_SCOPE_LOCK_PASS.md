# MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_LOCK_PASS

Status: completed

Lane: DOCS_SYNC

Scope: docs-only scope lock for duplicate measurement save prevention.

## Background captured

From `MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_AUDIT_PASS`:

1. `MeasurementRecordScreen` already has `_isSubmitting`, but disable logic is currently rebuild-time through `_canSubmit`.
2. Fast repeated taps can call `_saveMeasurement()` more than once before disabled rebuild is applied.
3. After successful save, unchanged form state can be submitted again and append duplicate `measurement_recorded` events.
4. `MeasurementEventWriter` intentionally appends accepted events and must not deduplicate by payload.
5. Duplicate prevention belongs in UI state (`MeasurementRecordScreen`), not in schema/tooling/materializer layers.

## Locked implementation direction

- Follow-up implementation pass:
  - `MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_PASS` (`FLUTTER_PASS`)
- Required behavior:
  1. Add immediate `_saveMeasurement()` re-entry guard.
  2. Keep submit blocked while save is in progress.
  3. Store last successful normalized form key.
  4. Block repeated submit when current form key matches last successful key.
  5. Re-enable submit only when form state changes.

## Locked boundaries

- Must remain unchanged:
  - `MeasurementEventWriter` append semantics
  - historical event data (no dedupe rewrite)
  - schema/canonical event rules
  - materializer/known-facts ownership
  - export/reload flow
  - stale banner behavior
  - ProjectState reload logic

## Files changed in this lock pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`

