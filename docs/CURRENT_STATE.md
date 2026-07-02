# Current State

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest pushed implementation commit verified for closeout: `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`).
- Route before closeout: current `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`, next `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`.
- Implementation audit recorded: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Route after closeout: `NEEDS_USER_DECISION`.

## Closed implementation summary

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS` is accepted, pushed, and closed out.

- `component_visual_placements` projection now uses deterministic `events.jsonl` stream order across V1 and V2 placements.
- Later valid placement supersedes earlier placement for the same component.
- V1 and V2 placement confirmations both remain first-class when valid.
- `event_invalidated` retracts targeted placement event from `component_visual_placements`.
- Invalidating older placement does not remove newer valid placement.
- Invalidating newest placement falls back to previous valid placement.
- Invalidating only placement removes projected placement.
- No placement-updated event type was introduced.

## Test coverage recorded

Focused materializer tests cover:

- Later V2 beats earlier V1.
- Later V1 beats earlier V2.
- Placement invalidation retraction.
- Invalidating older keeps newer.
- Invalidating newest falls back.
- Invalidating only removes projection.
- Forbidden semantic fields remain outside placement projection.

Recorded validation:

- `py -3 -m unittest tests.test_materialize_known_facts`: 95/95 OK.
- `py -3 tools/validate_all.py`: 285 tests OK; PASSED.
- `board_canvas_positive_smoke` materializes clean.

## Boundary confirmation

- No Dart runtime files changed.
- No Board Canvas UI files changed.
- No placement writer created.
- No Confirm/Edit UI added.
- No router edits.
- No schema edits.
- No validator edits.
- No `known_facts` schema edits.
- No visual contact layout added.
- No contacts/pads/legs rendering added.
- No AI marker implementation added.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No broad staging, commit, or push by this closeout pass.

## Canonical owners and evidence ledgers

- Active/near-future route queue: docs/PASS_QUEUE.md.
- Current scope boundary: docs/ACTIVE_SCOPE_LOCK.md.
- Completed pass provenance: docs/AUDIT_INDEX.md and docs/audit/.
- Stable architecture memory: docs/PROJECT_MEMORY.md.
- Core invariants and protected truth: docs/TRUTH_INDEX.md.
- Board vector and footprint architecture: docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md.
- Protected boundaries: docs/PROTECTED_SURFACES.md.
- Documentation classification/read priority: docs/FILE_MAP.md.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use git add ., git add -A, or git commit -am.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
- Next work requires a new explicit user decision and scoped pass.
