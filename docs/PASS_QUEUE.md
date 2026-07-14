# Pass Queue

## Current route

Current: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`
Next: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS`

## Active implementation pass

`BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS` may write exactly:

- `lib/app/app.dart`
- `lib/app/router.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `test/widget/board_canvas_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/new_project_wizard_screen_test.dart`
- `test/integration/projection_stale_banner_end_to_end_test.dart`
- `test/integration/photo_list_end_to_end_test.dart`
- `test/integration/board_graph_end_to_end_test.dart`
- `test/integration/pelle_sample_end_to_end_test.dart`

The pass canonicalizes `/project` to Board Canvas, keeps the launcher at `/`,
redirects `/project/board-canvas` to `/project`, preserves the legacy overview
at `/project/overview`, and preserves every existing project child route.

The scope lock was pushed as
`5b3e3e0dd8970cd4aa377c3eb8a1002ae507d75d`; its accepted audit reconciliation
was pushed as `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`.

## Queue boundary

No test-file map, overview retirement, overview redesign, menu migration,
refactor, extraction, tooling, or further implementation pass is armed. Board
Canvas source and its maintained map remain excluded with disposition
`REVIEWED_NO_CHANGE`.

Scope evidence:
`docs/audit/BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS.md`.
