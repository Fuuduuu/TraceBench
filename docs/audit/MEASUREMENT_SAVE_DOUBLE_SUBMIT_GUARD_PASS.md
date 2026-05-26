# MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_PASS

Status: completed

Lane: FLUTTER_PASS

Scope: narrow UI-only duplicate submit guard for measurement save flow.

## Goal

Prevent duplicate `measurement_recorded` appends caused by rapid repeated taps or repeated submit of the exact same unchanged form state.

## Implemented changes

1. `MeasurementRecordScreen` immediate hard re-entry guard:
   - `_saveMeasurement()` now returns immediately when `_isSubmitting` is already true.
2. Normalized form-key guard:
   - Added deterministic normalized current form key from:
     - `mode`
     - `from`
     - `to`
     - `value`
     - `unit`
     - `power_state`
   - Uses trimmed user text and deterministic key composition.
3. Last successful form-key memory:
   - Stores `_lastSuccessfulFormKey` after successful save.
   - Submit is blocked when current form key equals last successful form key.
4. Re-enable-on-change behavior:
   - Editing form state changes current key and re-enables submit.
5. Writer layer untouched:
   - `MeasurementEventWriter` append semantics unchanged.

## Tests added/updated

`test/widget/measurement_write_screen_test.dart`:

1. Rapid double tap appends only one new `measurement_recorded` event.
2. Unchanged form cannot be submitted twice after success.
3. Editing form after success re-enables submit and allows one new event.
4. Existing success-path feedback tests remain.

## Boundaries confirmed

- No schema changes.
- No tooling/materializer/export/reload/stale-banner changes.
- No `known_facts.json` mutation logic changes.
- No historical event deduplication.
- No AI duplicate inference/canonical duplicate detection changes.

## Files changed

- `lib/features/measurements/screens/measurement_record_screen.dart`
- `test/widget/measurement_write_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/MEASUREMENT_SAVE_DOUBLE_SUBMIT_GUARD_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `git diff --name-only`
- `git status --short --branch`

