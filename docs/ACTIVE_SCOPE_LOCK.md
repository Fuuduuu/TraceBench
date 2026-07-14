# Active Scope Lock

## Route

Current: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`
Next: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS`

Baseline: `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`
(`docs: record project home route scope audit`).

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

Accepted scope chain:

- scope lock `5b3e3e0dd8970cd4aa377c3eb8a1002ae507d75d`;
- scope-audit reconciliation
  `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`.

## Active implementation authority

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

No wildcard, optional file, or automatic expansion is authorized. If another
write is required, stop with `BLOCKED_ALLOWLIST_MISMATCH` or
`BLOCKED_IMPLEMENTATION_ALLOWLIST_UNRESOLVED`. Do not stage, commit, or push
from this pass.

## Human-locked route contract

- `/` remains the BenchBeep startup launcher.
- `/project` renders exactly one `BoardCanvasScreen` and is the canonical loaded-project home.
- `/project/board-canvas` is a redirect-only compatibility route to `/project` with no loop or second Board Canvas state path.
- `/project/overview` temporarily renders the existing `ProjectOverviewScreen`.
- Existing project child routes remain reachable: components, add/edit
  component, measurements, measurement compatibility redirect, measure sheet,
  not-populated, pins, events, graph, known facts, photos, reference images, and
  report.
- Existing route names `board-canvas` and `project-overview` remain on their
  semantic destinations where GoRouter uniqueness permits; the compatibility
  redirect does not receive a duplicate name.

## Map and screen boundaries

The maintained map for
`lib/features/board_canvas/screens/board_canvas_screen.dart` is inspect-only.
Disposition: `REVIEWED_NO_CHANGE`. Neither source nor map may change. If route
canonicalization requires a Board Canvas source edit, stop with
`DECOMPOSE_REQUIRED`.

`BenchBeepHomeScreen`, `ProjectOverviewScreen`, `NewProjectWizardScreen`, and
the legacy router `HomeScreen` are verify-only production surfaces. The
overview renderer, actions, copy, colors, and layout remain unchanged; its
existing Board Canvas action may exercise the compatibility redirect.

## Preserved boundaries

No overview deletion or redesign, Board Canvas UI change, global menu, event,
fact, writer, schema, validator, materializer, projection, Project ZIP format,
route-package, dependency, canonical placement/coordinate/net/electrical,
asset, `_incoming`, scratch cleanup, refactor, or extraction is authorized. No
later cleanup or retirement pass is armed.
