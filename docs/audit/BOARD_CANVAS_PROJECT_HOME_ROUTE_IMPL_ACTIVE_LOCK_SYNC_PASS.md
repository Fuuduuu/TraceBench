# BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass identity

- Project: TraceBench / BenchBeep / BoardFact
- Lane: A
- Profile: MINI
- Mode: docs-only active-lock sync
- Current after sync: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS`
- Next after sync: `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS`

This pass performs only the authority transition required by
`docs/AUDIT_CONTRACT.md`. It implements no runtime behavior and changes no
Dart, test, code-map, tool, asset, package, dependency, or `_incoming` file.

## Verified gate and accepted evidence

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- `HEAD == origin/main == e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`
- Commit subject: `docs: record project home route scope audit`
- Tracked diff before editing: empty
- Cached diff before editing: empty
- `git diff --check` before editing: PASS
- Only known untracked scratch was present and remained outside scope.
- Accepted scope-lock commit:
  `5b3e3e0dd8970cd4aa377c3eb8a1002ae507d75d`
  (`docs: lock board canvas project home route`)
- Scope-audit reconciliation:
  `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`
  (`docs: record project home route scope audit`)
- Scope-lock audit: `AUDIT_VERDICT: ACCEPT_AS_IS`,
  `SAFE_FOR_STAGING: YES`, blockers none, nits none.

Before this sync, `docs/ACTIVE_SCOPE_LOCK.md` still named the docs-only scope
lock as current. The active-lock sync gate therefore required this docs-only
transition before implementation.

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

No wildcard, optional path, unspecified file, or automatic expansion is
authorized.

## Preserved route contract

- `/` remains the BenchBeep launcher.
- `/project` becomes the canonical Board Canvas home.
- `/project/board-canvas` redirects to `/project` without a loop or second
  Board Canvas state path.
- `/project/overview` retains the existing legacy overview.
- Every existing `/project/*` child route remains reachable.
- The route name `board-canvas` stays on the canonical Board Canvas destination.
- The route name `project-overview` stays on the retained overview destination.
- The compatibility redirect remains unnamed.

## Preserved boundaries

- Board Canvas source and maintained map remain unchanged with disposition
  `REVIEWED_NO_CHANGE`.
- `ProjectOverviewScreen` is neither deleted nor redesigned.
- No overview retirement or control migration is authorized.
- No writer, event, fact, schema, validator, materializer, projection, Project
  ZIP, package, dependency, `_incoming`, refactor, tooling, asset, or unrelated
  route change is authorized.
- This sync implements no runtime or test behavior.

## Stop conditions

Stop for baseline mismatch, dirty tracked/cached state, governance conflict,
allowlist mismatch, required Board Canvas source/map change, or any protected
surface expansion.

## Validation record

- `python tools/validate_all.py`: PASS -- 285 tests.
- `git diff --check`: PASS.
- Exact five-file docs allowlist: PASS.
- `git diff --cached --name-status`: PASS -- empty.
- Active route synchronization: PASS --
  `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_PASS` ->
  `BOARD_CANVAS_PROJECT_HOME_ROUTE_IMPL_POST_AUDIT_PASS`.
- Exact ten-file runtime/test authority: PASS.
- Source, test, code-map, tool, and scratch tracked diff: PASS -- empty.
- `HEAD`: PASS -- unchanged at
  `e682a5b44f57e19d0f7cebaa887a4ea2457bc5b9`.

## Model routing

Codex performs this deterministic docs-only sync, Claude Code performs the
independent read-only pre-staging audit, and the human owns exact staging,
commit, and push.
