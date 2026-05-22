# FLUTTER_VIEWER_SHELL_PASS

## Status

completed

## Lane

FLUTTER_PASS

## Files changed

- `AGENTS.md`
- `pubspec.yaml`
- `analysis_options.yaml`
- `.gitignore`
- `assets/samples/pelle_pv20_minimal/manifest.json`
- `assets/samples/pelle_pv20_minimal/events.jsonl`
- `assets/samples/pelle_pv20_minimal/known_facts.json`
- `assets/samples/pelle_pv20_minimal/exports/customer_report.md`
- `lib/main.dart`
- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/shared/models/project_manifest.dart`
- `lib/shared/models/known_facts.dart`
- `lib/shared/models/trace_bench_event.dart`
- `lib/shared/models/project_state.dart`
- `lib/shared/services/project_loader.dart`
- `lib/shared/theme/app_theme.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/known_facts/screens/component_list_screen.dart`
- `lib/features/known_facts/screens/measurement_list_screen.dart`
- `lib/features/known_facts/screens/not_populated_screen.dart`
- `lib/features/known_facts/screens/pin_list_screen.dart`
- `lib/features/known_facts/screens/known_facts_viewer_screen.dart`
- `lib/features/events/screens/events_viewer_screen.dart`
- `lib/features/report/screens/customer_report_screen.dart`
- `test/unit/manifest_parsing_test.dart`
- `test/unit/known_facts_parsing_test.dart`
- `test/unit/event_parsing_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/measurement_list_screen_test.dart`
- `test/widget/not_populated_screen_test.dart`
- `test/integration/pelle_sample_end_to_end_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`

## Flutter SDK/toolchain result

- `flutter --version` failed: command not found.
- Flutter validation could not be executed in this environment.

## Package list

- `archive: ^3.6.0`
- `file_picker: ^8.1.0`
- `path_provider: ^2.1.0`
- `flutter_riverpod: ^2.5.0`
- `go_router: ^14.0.0`
- `flutter_markdown: ^0.7.3`

## Tests run

- `py -3 tools\\validate_all.py` (passed)
- `flutter test` (not run — Flutter SDK unavailable)

## No event writing statement

- No code path writes to `events.jsonl`.
- Only read-only load and read-only views are implemented.

## Export note

- ZIP export button is a placeholder only:
  "Eksport tuleb järgmises versioonis".

## Bundled sample sync note

- Pelle PV20 sample is copied into `assets/samples/pelle_pv20_minimal/**`.
- Refresh sample bundle manually after future SAMPLE_PASS changes.
