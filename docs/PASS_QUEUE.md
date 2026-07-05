# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

The current pass is a docs-only scope-lock for Board Graph route/surface treatment.

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

`BOARD_GRAPH_LEGACY_ROUTE_SCOPE_LOCK_PASS` locks the product decision for the next implementation planning step:

- Board Canvas is the primary technician-facing board/workbench surface.
- Board Graph is not the primary placement/write/edit surface.
- Board Graph must not create canonical facts.
- Board Graph may remain as an advanced/debug/projection inspection view.
- No deletion or route hiding is authorized by this docs-only pass.

Next pass:

- `BOARD_GRAPH_LEGACY_ROUTE_IMPL_ACTIVE_LOCK_SYNC_PASS` should inspect live route/navigation/test code and arm the exact allowlist for any future relabel/hide/move implementation.

Future implementation may later:

- relabel Board Graph as advanced/debug
- move Board Graph out of primary Workbench action rail
- hide it behind advanced/dev tools
- keep direct route available for tests/dev
- update navigation tests accordingly

Future implementation must not:

- delete Board Graph in one step
- remove tests without migration
- change Board Canvas behavior
- change writer/schema/events/known_facts behavior
- create or mutate canonical facts
- alter projection/materializer semantics

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
