# FLUTTER_VIEWER_SHELL_FIXUP_PASS

## Status

completed

## Lane

FLUTTER_PASS

## Fix summary

- Kept GoRouter stability fix via `routerProvider` so router is not rebuilt in `TraceBenchApp.build()`.
- Kept screen-level beginner protection for Events viewer (instead of route redirect) to avoid prior navigation-loop instability.
- Ensured ProjectOverview beginner title shows human-readable `deviceType · model`.
- Added/updated tests for malformed ZIP handling and bundled sample sync checks.
- Reworked `events_viewer_screen_test.dart` to deterministic screen-level widget tests.

## Route protection approach

- Removed route-level `/project/events` beginner redirect from `lib/app/router.dart`.
- Added beginner check inside `EventsViewerScreen`:
  - reads `beginnerModeProvider`,
  - shows `Advanced režiim vajalik`,
  - hides raw `evt_`/`event_id`/payload in beginner mode.
- This was chosen because earlier redirect tests repeatedly hung and were unstable.

## Files changed

- `lib/app/app.dart`
- `lib/app/router.dart`
- `lib/features/events/screens/events_viewer_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/events_viewer_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/measurement_list_screen_test.dart`
- `test/unit/project_loader_zip_test.dart`
- `tests/test_asset_sample_sync.py`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_VIEWER_SHELL_PASS.md`

## Validation commands

- `flutter test test/widget/events_viewer_screen_test.dart --timeout=30s --reporter expanded`
- `flutter test --timeout=30s --reporter expanded`
- `py -3 tools\validate_all.py`

## Validation results

- `flutter test` commands completed successfully.
- `py -3 tools\validate_all.py` completed successfully.

## No scope expansion

- No UI feature scope was expanded.
- No event writing, camera/OCR/CV, AI, fault probability, source search, cloud/BLE, or real ZIP export was added.
