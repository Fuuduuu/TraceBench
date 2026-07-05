# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Mode

No active implementation lock.

## Last released lock

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`

## Released implementation allowlist

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

## Closeout record

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_POST_AUDIT_PASS` releases the active implementation lock after pushed implementation commit `6234e790db1590e937f14f4118dfb4ba196dc815` (`fix: classify board graph as advanced projection surface`).

Claude audit recorded for the implementation:

- `AUDIT_VERDICT: ACCEPT_WITH_NITS`
- `SAFE_FOR_STAGING: YES`

Manual smoke was optional / not required. Targeted tests passed `24/24`.

## Behavior confirmed

- Board Canvas is the primary technician-facing board/workbench surface.
- Board Graph is an advanced/debug projection inspection surface.
- `/project/graph` remains reachable.
- Board Graph remains no-write and does not create canonical facts.
- Board Graph screen/tests remain preserved.

## Boundary confirmation

- No router files changed.
- No writer/schema/events/known_facts/materializer/validator/projection semantics changed.
- No `_incoming`, sample, or asset files changed.
- No canonical write path was introduced.

## Staging

Do not stage, commit, or push.
