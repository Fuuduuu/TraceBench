# Pass Queue

## Current route

Current: `BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS`
Next: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`

## Current docs-only scope lock

This pass may write exactly the four operational route docs and
`docs/audit/BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS.md`. It changes no
runtime, tests, router, code map, standard, tool, or `_incoming` file.

## Armed implementation pass

After independent audit, acceptance, and push of this scope lock,
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

## Queue boundary

No test-file map, overview retirement, overview redesign, menu migration,
refactor, extraction, tooling, or further implementation pass is armed. Board
Canvas source and its maintained map remain excluded with disposition
`REVIEWED_NO_CHANGE`.

Scope evidence:
`docs/audit/BOARD_CANVAS_PROJECT_HOME_ROUTE_SCOPE_LOCK_PASS.md`.
