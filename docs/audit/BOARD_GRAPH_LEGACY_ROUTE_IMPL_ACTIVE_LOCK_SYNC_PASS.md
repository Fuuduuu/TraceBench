# BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode

Docs-only active-lock sync.

## Baseline verification

- Expected route before sync: `BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS` -> `BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Live git baseline verified clean before edits.
- Latest pushed scope-lock commit observed: `2e34db6 docs: lock board graph legacy route scope`.

## Scope-lock source

`docs/audit/BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS.md`

## Live-code findings

- `lib/app/router.dart` defines `/project/graph` and `/project/board-canvas` as separate routes. Router is not armed because the locked implementation keeps `/project/graph` available.
- `lib/features/project/screens/project_overview_screen.dart` shows Board Graph in the Workbench action area via `overview-board-graph-button`, next to Board Canvas.
- `lib/features/board_graph/screens/board_graph_screen.dart` owns the Board Graph title/copy and projection-stale context. It consumes projected facts and has no canonical writer role in the inspected surface.
- `test/widget/project_overview_screen_test.dart` and `test/widget/board_graph_screen_test.dart` cover the affected navigation and screen labels.

## Implementation pass armed

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

## Implementation goal

Clarify Board Graph as an advanced/debug/projection inspection surface rather than a primary technician placement/write/edit workflow, while keeping Board Canvas as the primary board/workbench surface.

## Required boundaries

- Keep `/project/graph` available unless a later route-hiding pass explicitly scopes router changes.
- Do not delete Board Graph.
- Do not remove tests without migration.
- Do not change Board Canvas behavior.
- Do not create or mutate canonical facts.
- Do not touch writer/schema/events/known_facts/materializer/validator/projection semantics.
- Do not touch `_incoming`, samples, or assets.

## Route after sync

Current: `BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

Next: `BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Audit status

DRAFTED / PENDING

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
