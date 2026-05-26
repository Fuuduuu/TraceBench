# PROJECT_STATE_RELOAD_AFTER_EXPORT_PASS

Status: completed

Lane: FLUTTER_PASS

Scope: narrow runtime fix for post-export in-memory ProjectState refresh.

## Goal

After successful desktop/dev Export ZIP, reload current local project directory from disk and replace `projectStateProvider` so Project Overview counters reflect materialized `known_facts.json` without manual re-import.

## Implemented changes

1. Added centralized local-directory loader path:
   - `ProjectLoader.loadFromDirectory(projectDirectory)` in `lib/shared/services/project_loader.dart`.
   - Reads:
     - `manifest.json`
     - `known_facts.json`
     - `metadata/schema_versions.json` (optional)
     - `events.jsonl`
     - `exports/customer_report.md`
   - Reuses existing loader parse/build logic and returns `ProjectState` with preserved `projectDirectory`.
2. Updated export UI flow in `CustomerReportScreen`:
   - On `ExportSuccess` only, reloads via `ProjectLoader.loadFromDirectory(...)` and replaces `projectStateProvider`.
   - On reload failure after successful export, keeps existing provider state and shows safe fallback message.
   - On non-success export results (`ExportMaterializerFailed`, `ExportExportFailed`, `ExportPythonNotFound`, `ExportNoDirectory`, `ExportMobilePlaceholder`), no reload is attempted and provider state is unchanged.
3. Kept `ProjectExporter` export-only; no subprocess/materializer/export sequence changes.

## Tests updated

- `test/widget/customer_report_screen_test.dart`
  - successful desktop export reloads provider state
  - failed materializer/export/mobile placeholder do not reload
  - reload failure after `ExportSuccess` does not replace provider
  - stale banner remains passive (no export action introduced)
- `test/unit/project_loader_zip_test.dart`
  - `loadFromDirectory` preserves `projectDirectory` and loads fresh disk state
  - `loadFromDirectory` does not write `known_facts.json` or `events.jsonl`

## Validation

- `py -3 tools\validate_all.py` passed.
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded` passed.
- `git diff --name-only` and `git status --short --branch` run.

