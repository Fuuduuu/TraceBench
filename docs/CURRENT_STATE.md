# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only scope-lock is active for future Board Graph route/surface treatment.

No runtime, test, schema, tool, event, `known_facts.json`, sample, asset, or `_incoming` edits are authorized by this pass.

## Scope intent

Board Canvas is the primary technician-facing board/workbench surface.

Board Graph is currently a projection/debug/advanced surface at `/project/graph`, reachable from Project Overview / Workbench navigation and covered by `test/widget/board_graph_screen_test.dart`.

This pass documents the future decision only:

- Board Graph is not the primary placement/write/edit surface.
- Board Graph must not create canonical facts.
- Board Graph may remain reachable as advanced/debug/projection inspection until a later implementation pass hides or relabels it.
- No deletion or route hiding is authorized by this pass.

## Future implementation direction, not armed here

A later implementation may relabel Board Graph as advanced/debug, move it out of primary Workbench action rail, hide it behind advanced/dev tools, keep direct route access for tests/dev, and update navigation tests accordingly.

The next active-lock sync pass must inspect live code and arm the exact implementation allowlist before any runtime/test edit.

## Boundary confirmation

- Board Canvas behavior remains unchanged.
- Board Graph route remains unchanged.
- Writer/schema/events/known_facts/materializer/validator/projection semantics remain unchanged.
- No canonical facts are created or mutated by this docs-only pass.
- Do not use `git add .`, `git add -A`, or `git commit -am`.
