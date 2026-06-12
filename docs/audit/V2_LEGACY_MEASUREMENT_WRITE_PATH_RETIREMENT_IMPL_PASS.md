# V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS

## MODEL_ROUTING_CHECK

PASS. This repository-local implementation pass is appropriate after accepted
legacy write-path scope lock and closeout.

## Type

`FLUTTER_PASS / UI_WRITE_PATH_REMEDIATION`

## Lane

`CODEX / IMPLEMENTATION`

## Startup state

- `docs/CURRENT_STATE.md` currently set `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`.
- `docs/ACTIVE_SCOPE_LOCK.md` set to implementation lock for the same pass.
- `docs/PASS_QUEUE.md` routes current to this pass and next to `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_PASS`.
- Legacy diagnosis in `WI-060` remains open for post-audit closure.

## Scope drift check

- PASS.
- `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS` is active in both
  current-state/queue/scope-lock documents.
- Implementation stays inside explicit allowlist:
  - `lib/app/router.dart`
  - `lib/features/project/screens/project_overview_screen.dart`
  - `test/widget/project_overview_screen_test.dart`
- No protected runtime surface (schema/materializer/event writer service/project ZIP)
  files are modified.

## Files changed

- `docs/CURRENT_STATE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md` (small docs-only follow-up from previous scope-lock hygiene pass, not runtime work)
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS.md`
- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

## Implementation summary

- Implemented a hard compatibility redirect in router:
  - `/project/measurements/new` now redirects to `/project/measure-sheet`.
- Updated Project Overview measurement CTA:
  - `Lisa mõõtmine` now navigates to `/project/measure-sheet`.
- Added regression coverage:
  - Overview legacy CTA opens Measure Sheet, not legacy form UI.
  - Direct `/project/measurements/new` navigation redirects to Measure Sheet
    and does not render `MeasurementRecordScreen` controls.
- Kept route-remediation minimal and did not alter `V2SaveMeasurementWriter`
  or legacy writer internals.

## Legacy path retirement details

- Compatibility redirect preserves any external links to old route while ensuring
  normal and manual navigation resolves to the accepted V2 path.
- This does not alter the legacy writer implementation or V2 event schema.
- Existing `MeasurementRecordScreen` file remains in place but no longer reachable
  from normal Overview flow.

## V2 sequence-contract preservation

- No V2 events were changed to add `sequence`.
- No V2 event model fields were modified.
- No `tools/event_writer_service.py` edits were made.

## Tests added/updated

- Updated `test/widget/project_overview_screen_test.dart` with:
  - `legacy "Lisa mõõtmine" action navigates to Measure Sheet path`
  - `/project/measurements/new` route redirects to Measure Sheet and does not
    render legacy measurement submit controls.
- Existing `test/widget/measure_sheet_screen_test.dart` source-boundary test still
  confirms the V2 source never references `MeasurementEventWriter` path route to
  `/project/measurements/new`.

## WI-060 status

- Updated to `implementation-pending-post-audit` in `docs/WORK_INTAKE_INDEX.md`.

## Route decision

- Current pass: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`.
- Next recommended pass: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_POST_AUDIT_PASS`.

## Validation sequence (run in order)

1. `dart format` on changed Dart files.
2. `dart analyze` on changed Dart files.
3. Focused Flutter tests:
   `test/widget/project_overview_screen_test.dart`
4. `flutter test`.
5. `py -3 tools\validate_all.py`.
6. `git diff --check`.
7. `git status --short --branch`.
8. `git diff --name-only`.

## Validation result

- 1. `dart format` on changed Dart files: PASS.
- 2. `dart analyze` on changed Dart files: PASS.
- 3. Focused Flutter tests (`project_overview_screen_test.dart`, `measure_sheet_screen_test.dart`):
  - PASS (31 tests).
- 4. `flutter test` (full suite): PASS (263 tests).
- 5. `py -3 tools\validate_all.py`: PASS (268 validator/tests, schema checks passed, temporary project import/export artifacts expected).
- 6. `git diff --check`: PASS.
- 7. `git status --short --branch`: PASS.
- 8. `git diff --name-only`: PASS.

## safe_for_post_audit

YES.
