# FLUTTER_ZIP_EXPORT_PASS

Status: completed

Lane: FLUTTER_PASS

Scope: Implement narrow V1 desktop/dev Project ZIP export handoff via existing Python tooling.

## Scope lock context

- `FLUTTER_ZIP_EXPORT_SCOPE_LOCK_PASS` remains accepted.
- `PROJECT_ZIP_SECURITY_HARDENING_PASS` baseline is in effect.
- Mobile remains placeholder in V1.
- `known_facts.json` is not mutated by Flutter directly.
- `events.jsonl` is not written by this pass.

## Files changed

- `lib/shared/services/project_exporter.dart`
- `lib/features/report/screens/customer_report_screen.dart`
- `test/unit/project_exporter_test.dart`
- `test/widget/customer_report_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_ZIP_EXPORT_PASS.md`

## Implementation summary

- Added `ProjectExporter` service with:
  - platform abstraction (`PlatformInfo`) for mobile/desktop guard,
  - injectable `ProcessRunner` for command execution,
  - Python discovery order `py -3` -> `python3` -> `python`,
  - `ExportResult` variants: `ExportSuccess`, `ExportMobilePlaceholder`, `ExportNoDirectory`, `ExportPythonNotFound`, `ExportMaterializerFailed`, `ExportExportFailed`.
- Export sequence:
  - return mobile placeholder on mobile,
  - return noDirectory when project path unavailable,
  - discover python candidate,
  - run `tools/materialize_known_facts.py <project_dir>/events.jsonl <project_dir>/known_facts.json` first,
  - run `tools/export_project_zip.py <project_dir> <parent>/<project_or_folder>_export.zip` second,
  - return success with zip path on success.
- Success path does not clear stale state.

## ProjectExport UI behavior

- `CustomerReportScreen` export button now calls `ProjectExporter`.
- Success message: `ZIP eksporditud: <path>. Uuendatud projektsiooni nägemiseks impordi projekt uuesti.`
- Mobile placeholder message: `Mobiilne eksport jääb V1-s placeholderiks.`
- Missing-directory / python-not-found / materializer-fail / export-fail messages are shown.

## Validation result

- `dart format lib/shared/services/project_exporter.dart lib/features/report/screens/customer_report_screen.dart test/unit/project_exporter_test.dart test/widget/customer_report_screen_test.dart`
- `flutter test --reporter expanded test/unit/project_exporter_test.dart`
- `flutter test --reporter expanded test/widget/customer_report_screen_test.dart`
- `flutter test --reporter expanded`
- `py -3 tools\validate_all.py`

## Tests added/updated

- `test/unit/project_exporter_test.dart` covers candidate discovery, fallback behavior, materializer-first ordering, failure propagation, zip path sanitization, and no `events.jsonl`/`known_facts.json` direct write.
- `test/widget/customer_report_screen_test.dart` covers export trigger rendering/behavior, placeholder on mobile, desktop success message with stale-banner preservation, and non-action banner semantics.

## Forbidden-surface confirmation

- No `known_facts.json` mutation from Dart services.
- No event-writing logic added.
- No `ProjectExporter` stale-state clear path.
- No Project ZIP tooling implementation was changed in this pass.
- No mobile/Android SAF/share sheet code introduced.
- No ZIP contract expansion.
