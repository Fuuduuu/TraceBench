# FLUTTER_PHOTO_LIST_PASS

- Status: completed
- Lane: FLUTTER_PASS
- Scope: read-only Flutter photo evidence list/view implementation

## Files changed

- lib/app/router.dart
- lib/features/project/screens/project_overview_screen.dart
- lib/features/photos/screens/photo_list_screen.dart
- test/unit/known_facts_parsing_test.dart
- test/widget/project_overview_screen_test.dart
- test/widget/photo_list_screen_test.dart
- test/integration/photo_list_end_to_end_test.dart
- docs/ACTIVE_SCOPE_LOCK.md
- docs/PASS_QUEUE.md
- docs/AUDIT_INDEX.md

## Validation

- `py -3 tools\validate_all.py`
- Flutter app test run:
  - `C:\\Users\\Kasutaja\\Desktop\\flutter\\flutter\\bin\\flutter.bat test --reporter expanded`

## Outcome

- Added `/project/photos` route under project overview routes.
- Added Project Overview entry/button to open the read-only Photos screen.
- Implemented `lib/features/photos/screens/photo_list_screen.dart` with:
  - empty state
  - photo list cards
  - beginner vs advanced views
  - damage / suspect / visual-trace counts
  - related IDs and bbox display in advanced mode
  - evidence wording for visual traces as visual-only
  - no edit/import/camera controls
- Added parsing and widget coverage for photo fields.
- Added project overview and end-to-end route coverage for Photos.
- Kept data source as `known_facts.json` through existing project state model.

## Forbidden-surface confirmation

- no schema/tool/materializer modifications
- no samples/assets mutations
- no Project ZIP contract changes
- no board_graph.json / view_state.json creation
- no event-writing implementation
- no component editing UI
- no camera/OCR/CV/photo import/file picker
- no visual_trace -> measured/electrical promotion
