# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Active lock

Docs-only scope-lock for future Board Graph route/surface treatment.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/audit/BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS.md`

## Locked decision

- Board Canvas is the primary technician-facing board/workbench surface.
- Board Graph is not the primary placement/write/edit surface.
- Board Graph must not create canonical facts.
- Board Graph may remain reachable as advanced/debug/projection inspection unless a later implementation pass hides or relabels it.
- No deletion or route hiding is authorized by this pass.

## Future implementation planning

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS` must inspect live code and arm an exact implementation allowlist before any runtime/test changes.

Likely candidate surfaces to inspect, not armed here:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `lib/app/router.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

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

## Protected surfaces remain locked unless separately scoped

- placement writer contract
- canonical event schema
- validator / tools / materializer / projection semantics
- events / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization behavior
- projection-stale behavior
- canonical-bounds guard behavior
- component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- selected-placement prefill/edit flow
- `Muuda` / `Tühista` behavior
- samples/assets and `_incoming`
