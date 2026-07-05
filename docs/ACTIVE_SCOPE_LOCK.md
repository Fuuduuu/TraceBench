# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Mode

Docs-only active-lock sync.

## Implementation pass armed

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

## Implementation goal

Make the Board Graph route/surface truthful as an advanced/debug/projection inspection surface, while preserving Board Canvas as the primary technician-facing board/workbench surface.

## Live-code findings used for allowlist

- `lib/features/project/screens/project_overview_screen.dart` owns the visible Workbench action linking `overview-board-graph-button` to `/project/graph`, next to the Board Canvas action.
- `lib/features/board_graph/screens/board_graph_screen.dart` owns Board Graph title/copy and projection-stale context wording.
- `test/widget/project_overview_screen_test.dart` covers the Project Overview Workbench navigation affordances.
- `test/widget/board_graph_screen_test.dart` covers Board Graph screen labels, projection-stale behavior, and advanced controls.

## Future implementation may

- Relabel Board Graph in Project Overview as advanced/debug/projection inspection.
- Move Board Graph out of the primary Workbench action emphasis if this can be done inside the armed Project Overview surface.
- Clarify Board Graph screen title/copy so users do not confuse it with Board Canvas placement/write/edit workflows.
- Update the armed widget tests to preserve coverage under the new labels/navigation wording.

## Future implementation must not

- Delete Board Graph.
- Remove Board Graph tests without migration.
- Hide or remove `/project/graph`; route behavior changes require a later explicit route-hiding scope.
- Change Board Canvas behavior.
- Change writer/schema/events/known_facts/materializer/validator/projection semantics.
- Create or mutate canonical facts.
- Introduce any canonical write path.

## Explicitly not armed

- `lib/app/router.dart` because `/project/graph` remains available in the locked implementation direction.
- `lib/features/board_canvas/screens/board_canvas_screen.dart` because Board Canvas behavior is not part of this implementation.
- Placement, component, measurement, project-open, schema, tool, materializer, validator, events, known_facts, `_incoming`, sample, and asset files.

## Stop conditions

Stop and report `BLOCKED_PRODUCT_DECISION` if the implementation requires hiding/removing the route or deciding a different product role for Board Graph.

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if implementation requires a file outside the exact allowlist above.

## Staging

Do not stage, commit, or push.
