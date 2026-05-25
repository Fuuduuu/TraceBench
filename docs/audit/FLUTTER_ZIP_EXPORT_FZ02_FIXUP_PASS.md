# FLUTTER_ZIP_EXPORT_FZ02_FIXUP_PASS

## Status
completed

## Lane
FLUTTER_PASS

## Scope
Mini fixup of export failure messaging after FLUTTER_ZIP_EXPORT_CODE_AUDIT_PASS.

## Summary
- Updated `ProjectExporter` failure variants to carry:
  - `sanitizedMessage` (user-facing, generic)
  - `rawDetail` (retained for diagnostics)
- Updated `CustomerReportScreen` export handling to show only sanitized messages to users.
- No raw subprocess detail is rendered in SnackBar text.

## Changes
- `lib/shared/services/project_exporter.dart`
  - `ExportMaterializerFailed` now exposes:
    - `sanitizedMessage` = "Materialiseerimine ebaõnnestus. Kontrolli projekti sündmuste faili."
    - `rawDetail` = existing summarized subprocess output.
  - `ExportExportFailed` now exposes:
    - `sanitizedMessage` = "ZIP pakkimine ebaõnnestus."
    - `rawDetail` = existing summarized subprocess output.
- `lib/features/report/screens/customer_report_screen.dart`
  - Failure UI path now uses `sanitizedMessage` only.
- `test/unit/project_exporter_test.dart`
  - Added assertions for sanitized messages and that raw detail remains available.
  - Added checks that sanitized messages do not include verbose path/traceback/script tokens.
- `test/widget/customer_report_screen_test.dart`
  - Added assertions that failure SnackBars show sanitized text only and do not include raw paths or tracebacks.
  - Kept stale-banner visibility and no-action assertions.

## Validation result
- Implemented as code-only fixup with no process lifecycle changes.
- `FZ-01` was **not** fixed in this pass (accepted as V1 risk):
  - `ProjectExporter` still uses `Process.run(...).timeout(...)`.
  - Timeout may not explicitly terminate OS child process.
  - Accepted for V1 desktop/dev handoff.
  - Future work item if needed: `FLUTTER_PROCESS_LIFECYCLE_HARDENING_PASS`.

## Forbidden-surface confirmation
- No ZIP contract changes.
- No DART-native materializer.
- No mobile export implementation.
- No `isProjectionStale` state clearing.
- No `known_facts.json` mutation from Dart.
- No event write path changes.
