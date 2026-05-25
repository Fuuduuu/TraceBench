# FLUTTER_NEW_PROJECT_WIZARD_PASS

- Status: completed
- Lane: FLUTTER_PASS
- Scope: implement V1 New Project Wizard for blank local project bootstrap

## Files changed

- lib/shared/services/python_runner.dart
- lib/shared/services/project_creator.dart
- lib/shared/services/project_exporter.dart
- lib/features/project/screens/new_project_wizard_screen.dart
- lib/features/project/screens/home_screen.dart
- lib/app/router.dart
- test/unit/python_runner_test.dart
- test/unit/project_creator_test.dart
- test/widget/new_project_wizard_screen_test.dart
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/CURRENT_STATE.md
- docs/AUDIT_INDEX.md
- docs/audit/FLUTTER_NEW_PROJECT_WIZARD_PASS.md

## Implementation summary

- Added `PythonRunner` as shared Python discovery/command execution service.
- Refactored `ProjectExporter` to use `PythonRunner` while preserving:
  - mobile placeholder behavior
  - materializer-before-export order
  - sanitized failure messages
  - no stale-state clearing on export
- Added `ProjectCreator` service:
  - generates `project_id` as `prj_<8hex>`
  - creates wizard bootstrap files/folders only
  - writes empty `events.jsonl`
  - writes `manifest.json`, `metadata/schema_versions.json`, `exports/customer_report.md`, `device_profiles/default.json`
  - invokes Python materializer to generate `known_facts.json`
  - builds fresh in-memory `ProjectState` with `isProjectionStale == false`
  - performs best-effort cleanup on post-create failure
- Added `NewProjectWizardScreen` and route `/new-project`.
- Added `Uus projekt` action on home screen:
  - desktop/dev navigates to wizard
  - mobile shows V1 placeholder

## Boundary confirmations

- No `project_created` event was added.
- No evidence events are written by wizard bootstrap.
- No direct Dart-side `known_facts.json` assembly or mutation logic was introduced.
- No schema changes.
- No Python tooling file changes.
- No ZIP contract expansion.
- No mobile storage expansion.
- No `board_graph.json` / `view_state.json` generation.

## Validation

- `dart format` on changed Dart/test files: passed
- `flutter test --reporter expanded test/unit/python_runner_test.dart`: passed
- `flutter test --reporter expanded test/unit/project_creator_test.dart`: passed
- `flutter test --reporter expanded test/widget/new_project_wizard_screen_test.dart`: passed
- `flutter test --reporter expanded test/unit/project_exporter_test.dart`: passed
- `flutter test --reporter expanded`: failed only because local untracked `test/widget_test.dart` (environment artifact) references missing `MyApp`
- `flutter test --reporter expanded <tracked test files from git ls-files>`: passed
- `py -3 tools\\validate_all.py`: passed
- `git diff --check`: passed

## Next recommended pass

- `PROJECT_IMPORT_EXPORT_SMOKE_TEST_PASS` (AUDIT_ONLY)
