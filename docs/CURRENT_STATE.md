# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Route status

Docs-only active-lock sync is active for the future Board Graph route/surface implementation.

No runtime, test, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits are authorized by this sync pass.

## Active-lock result

The implementation pass `BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS` is armed with the exact live-code allowlist:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

## Scope intent

Board Canvas is the primary technician-facing board/workbench surface.

Board Graph is currently a projection/debug/advanced surface at `/project/graph`, reachable from Project Overview / Workbench navigation and covered by Board Graph widget tests.

The armed implementation may relabel or reposition Board Graph so it is not presented as the primary placement/write/edit workflow, while keeping `/project/graph` available unless a later route-hiding pass explicitly scopes router changes.

## Boundary confirmation

- Board Canvas behavior remains unchanged.
- Board Graph route remains available.
- Router changes are not armed.
- Writer/schema/events/known_facts/materializer/validator/projection semantics remain unchanged.
- No canonical facts are created or mutated by this docs-only pass.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
