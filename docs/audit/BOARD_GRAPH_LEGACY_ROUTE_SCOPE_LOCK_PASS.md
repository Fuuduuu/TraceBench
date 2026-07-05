# BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS

Status: DRAFTED / PENDING CLAUDE AUDIT
Mode: docs-only scope-lock
Route: `BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS` -> `BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Baseline verification

- Initial gate commands were run before editing: `git status --short --branch`, `git log --oneline --decorate -8`, `git diff --name-status`, `git diff --cached --name-status`, and `git diff --check`.
- Tracked diff was clean before this pass.
- Cached diff was clean before this pass.
- Branch was aligned with `origin/main` before this pass.
- Live route docs showed `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` before this scope-lock.
- Latest live commit at gate was `6238a5c` (`docs: classify legacy and transitional surfaces`).

## Read-only findings

- `LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` classified Board Graph as `KEEP_AS_TEST_OR_DEBUG_ONLY` with capability `projection/debug only`.
- Router exposes Board Graph at `/project/graph` through `BoardGraphScreen`.
- Project Overview / Workbench currently exposes a Board Graph action alongside Board Canvas-related navigation.
- Board Canvas is the accepted primary board/workbench technician surface and the current placement workflow owner.
- Board Graph remains useful as projection/debug/advanced inspection, but it can be confusing if presented as a peer primary technician workflow.
- `test/widget/board_graph_screen_test.dart` is the direct Board Graph widget-test surface to preserve or migrate before future route hiding.

## Locked decision

- Board Canvas is the primary technician-facing board/workbench surface.
- Board Graph is not the primary placement/write/edit surface.
- Board Graph must not create canonical facts.
- Board Graph may remain as advanced/debug/projection inspection unless a later implementation hides or relabels it.
- No deletion or route hiding is authorized by this pass.

## Questions resolved for this scope

1. Board Graph should be treated as an advanced/debug projection view.
2. Board Graph should remain reachable from current navigation until a route-hiding/relabel implementation is separately scoped.
3. Later user-facing wording should distinguish it from Board Canvas with language such as `Advanced graph view`, `Projection graph`, or `Debug graph`.
4. Future implementation must preserve or migrate Board Graph tests and navigation expectations before any route hiding.

## Future implementation may later

- relabel Board Graph as advanced/debug
- move Board Graph out of primary Workbench action rail
- hide it behind advanced/dev tools
- keep direct route available for tests/dev
- update navigation tests accordingly

## Future implementation must not

- delete Board Graph in one step
- remove tests without migration
- change Board Canvas behavior
- change writer/schema/events/known_facts behavior
- create or mutate canonical facts
- alter projection/materializer semantics

## Boundary record

- No runtime files edited.
- No test files edited.
- No schema/tool/materializer/validator/router/events/known_facts/_incoming files edited.
- No route hiding, screen deletion, runtime implementation, or test migration authorized.
- No canonical facts created or mutated.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify route is recorded consistently
- verify no runtime/test files changed
