# PROJECT_EXPORTER_TEST_FIX_PASS

PASS_ID: `PROJECT_EXPORTER_TEST_FIX_PASS`
Lane: `TEST_FIX_PASS`
Mode: `Narrow test-isolation fix`

## Result

- Root cause identified as test-order / call-shape fragility in the fallback assertion logic, not a production `ProjectExporter` bug.
- Deterministic by-name behavior no longer depended on full-file ordering after assertion normalization.

## Changes

- Updated `test/unit/project_exporter_test.dart`:
  - normalized executable comparison via basename helper (`_commandExecutable`) in fallback test assertions,
  - made probe assertions explicit to `--version` calls for the selected fallback executable,
  - kept `py` and fallback-version probe assertions stable across invocation order,
  - preserved the existing intent that the test still proves fallback from earlier failed candidates to `python3`/`python`.

## Non-production impact

- No production code was changed.
- Scope remained test-only.

## Scope lock compliance

- Allowed production surfaces remained untouched (`ProjectExporter`, `PythonRunner`, and all non-test runtime paths unchanged).
- Only allowed files were edited under `test/unit/project_exporter_test.dart` plus docs-ledger files.

## Verification

- `flutter test test/unit/project_exporter_test.dart --reporter expanded --plain-name "ProjectExporter falls back to python3/python when earlier candidates fail"`
- `flutter test test/unit/project_exporter_test.dart --reporter expanded`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`
- All required commands passed.

## Next recommended pass

- `PROJECT_EXPORTER_TEST_FIX_POST_AUDIT_PASS`
