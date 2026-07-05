# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. `BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS` is closed out by `BOARD_GRAPH_LEGACY_ROUTE_IMPL_POST_AUDIT_PASS`.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |
| 7 | `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` | Made the missing required Add Component draft label/name reason visible while keeping `Salvesta` disabled and writer uninvoked until the label is entered. |

## Board Graph route decision sequence

`LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` classified Board Graph as `KEEP_AS_TEST_OR_DEBUG_ONLY`: projection/debug/advanced, not a Board Canvas replacement.

`BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS` locked the product decision:

- Board Canvas is the primary technician-facing board/workbench surface.
- Board Graph is not the primary placement/write/edit surface.
- Board Graph must not create canonical facts.
- Board Graph may remain as an advanced/debug/projection inspection view.
- No deletion or route hiding is authorized by the scope-lock pass.

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS` armed the exact implementation allowlist for `BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS`:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/board_graph/screens/board_graph_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/board_graph_screen_test.dart`

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_PASS` was pushed as:

- Commit: `6234e790db1590e937f14f4118dfb4ba196dc815`
- Message: `fix: classify board graph as advanced projection surface`
- Claude audit: `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`
- Manual smoke: `OPTIONAL / not required`
- Targeted tests: `24/24` passed

Accepted behavior:

- Board Canvas is labeled/presented as the primary board/workbench surface.
- Board Graph is labeled/presented as advanced/debug projection inspection.
- `/project/graph` remains reachable.
- Board Graph screen/tests remain preserved.
- Board Graph remains no-write / no canonical facts.
- No router, writer, schema, validator, materializer, events, `known_facts.json`, `_incoming`, samples, or assets changed.

Non-blocking nit:

- The implementation bundled minor analyzer cleanups inside the armed files; these were verified safe and accepted.

## Scope gate rules

- One narrow pass at a time.
- Do not implement outside the active implementation allowlist.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.
