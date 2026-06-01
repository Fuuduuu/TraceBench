# PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS

PASS_ID: `PROJECT_EXPORTER_TEST_FIX_SCOPE_LOCK_PASS`
Lane: `DOCS_SYNC`
Mode: `Docs-only scope lock`

## Result

- `PROJECT_EXPORTER_TEST_FAILURE_TRIAGE_PASS` is recorded as accepted input for this lock.
- Failure classification from triage is preserved:
  - order-dependent test-isolation defect,
  - observed in `test/unit/project_exporter_test.dart` only,
  - unrelated to `Reference Images` work,
  - not a production `ProjectExporter` bug from current evidence,
  - by-name test run passes while full file order run fails deterministically.

## Scope lock

- Lock `PROJECT_EXPORTER_TEST_FIX_PASS` as the next implementation pass.
- `PROJECT_EXPORTER_TEST_FIX_PASS` lane: `TEST_FIX_PASS`.
- Preferred implementation scope is test-only and targeted:
  - `test/unit/project_exporter_test.dart`.
- No production code surface changes are planned in this scope lock.
- Fix targets in next pass are to remove order leakage in the fixture/test flow so the fallback test passes:
  - when run by name,
  - when the full `project_exporter_test.dart` file runs,
  - when the full Flutter suite runs.

## Allowed implementation surfaces

- `test/unit/project_exporter_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_EXPORTER_TEST_FIX_PASS.md`

## Forbidden surfaces

- Reference Images files.
- Board Canvas files.
- Project ZIP tooling/contracts.
- schemas.
- materializer code.
- samples.
- assets.
- `events.jsonl`.
- `known_facts.json`.
- `board_graph.json`.
- `view_state.json`.
- tags/release objects.
- broad test-suite refactors.
- unrelated test edits beyond `test/unit/project_exporter_test.dart`.

## Validation commands for next pass

- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test test/unit/project_exporter_test.dart --reporter expanded --plain-name "ProjectExporter falls back to python3/python when earlier candidates fail"`
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded`
- `py -3 tools\validate_all.py`

## Routing

- NEXT: `PROJECT_EXPORTER_TEST_FIX_PASS`
