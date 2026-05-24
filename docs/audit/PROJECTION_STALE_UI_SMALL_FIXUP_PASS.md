# PROJECTION_STALE_UI_SMALL_FIXUP_PASS

Status: completed  
Lane: FLUTTER_PASS  

Goal: Fix AUI-01 from `PROJECTION_STALE_UI_CODE_AUDIT_PASS` by making stale banner content-flow safe in BoardGraph and CustomerReport.

Files changed:
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `lib/features/report/screens/customer_report_screen.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`

Validation:
- `C:/Users/Kasutaja/Desktop/flutter/flutter/bin/dart.bat format lib/features/board_graph/screens/board_graph_screen.dart lib/features/report/screens/customer_report_screen.dart test/widget/board_graph_screen_test.dart test/widget/customer_report_screen_test.dart test/integration/projection_stale_banner_end_to_end_test.dart`
- `C:/Users/Kasutaja/Desktop/flutter/flutter/bin/flutter.bat test --reporter expanded test/widget/board_graph_screen_test.dart`
- `C:/Users/Kasutaja/Desktop/flutter/flutter/bin/flutter.bat test --reporter expanded test/widget/customer_report_screen_test.dart`
- `C:/Users/Kasutaja/Desktop/flutter/flutter/bin/flutter.bat test --reporter expanded test/integration/projection_stale_banner_end_to_end_test.dart`
- `C:/Users/Kasutaja/Desktop/flutter/flutter/bin/flutter.bat test --reporter expanded`
- `py -3 tools\\validate_all.py`

Summary:
- AUI-01 fixed:
  - `ProjectionStaleBanner` is now in scroll/content flow at top of body content for both `BoardGraphScreen` and `CustomerReportScreen`.
  - It is no longer fixed pseudo-header-like outside content flow.
  - Existing graph/report content remains present and screen actions remain intact.
- AUI-02 remains deferred to export/report artifact validation.

Tests:
- `test/widget/board_graph_screen_test.dart`
- `test/widget/customer_report_screen_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`

Forbidden-surface confirmation:
- No refresh/export/materializer actions were introduced.
- No `known_facts.json` mutation.
- No event-writing changes.
- No Project ZIP tooling changes.
- No new schema/tooling edits.
