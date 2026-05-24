# PROJECTION_STALE_UI_PASS

- Status: completed
- Lane: FLUTTER_PASS
- Scope: display-only stale projection banner UI implementation on derived views
- Commit: `2e6449b`

## Files changed

- `lib/shared/widgets/projection_stale_banner.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/known_facts/screens/measurement_list_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `lib/features/photos/screens/photo_list_screen.dart`
- `lib/features/report/screens/customer_report_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/measurement_list_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`
- `test/widget/photo_list_screen_test.dart`
- `test/widget/customer_report_screen_test.dart`
- `test/widget/projection_stale_banner_widget_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECTION_STALE_UI_PASS.md`

## Validation

- `py -3 tools\validate_all.py` (passed)
- `dart format` on changed Dart/test files (passed)
- `flutter test --reporter expanded` (passed)

## Implementation summary

- Added reusable `ProjectionStaleBanner` widget with required copy and display-only contract:
  - `isStale`, `compact`, `showSecondary`, `contextLabel` inputs
  - hidden when stale is false
  - top-of-content placement on derived views
  - no callbacks or action affordances
  - passive tag text: `Vajab eksporti`
- Integrated banner on:
  - Project overview
  - Measurements/known facts
  - Board graph
  - Photo evidence
  - Customer report
- Navigation and existing content structure unchanged.

## Tests added/updated

- `test/widget/projection_stale_banner_widget_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/measurement_list_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`
- `test/widget/photo_list_screen_test.dart`
- `test/widget/customer_report_screen_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`

## Forbidden-surface confirmation

- No refresh/export/materializer buttons or callbacks introduced in banner component.
- No `known_facts.json` mutation.
- No event-writing changes.
- No Project ZIP tooling changes.
- No event materialization behavior added from banner.
