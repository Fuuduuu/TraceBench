# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock. The `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS` protected implementation lock is released by `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS`.

## Released implementation lock

- Armed by: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Implemented by: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`
- Pushed implementation commit: `386b52369a44053ac947aed344864a1b74e54df1` (`fix: order placement projection by event stream`)
- Implementation audit: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Safe staging set recorded:
  - `tools/materialize_known_facts.py`
  - `tests/test_materialize_known_facts.py`

## Closed implementation summary

- `component_visual_placements` projection now uses deterministic `events.jsonl` stream order across V1 and V2 placements.
- Later valid placement supersedes earlier placement for the same component.
- V1 and V2 placement confirmations both remain first-class when valid.
- `event_invalidated` retracts targeted placement event from `component_visual_placements`.
- Invalidating older placement does not remove newer valid placement.
- Invalidating newest placement falls back to previous valid placement.
- Invalidating only placement removes projected placement.
- No placement-updated event type was introduced.

## Boundary record

- No Dart runtime edits.
- No Board Canvas UI edits.
- No placement writer.
- No Confirm/Edit UI.
- No router edits.
- No schema edits.
- No validator edits.
- No `known_facts` schema edits.
- No visual contact layout.
- No contacts/pads/legs rendering.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push by this closeout pass.

## Validation recorded

- `py -3 -m unittest tests.test_materialize_known_facts`: 95/95 OK.
- `py -3 tools/validate_all.py`: 285 tests OK; PASSED.
- `board_canvas_positive_smoke` materializes clean.

## Next work

A new user decision and explicit scoped pass are required before additional implementation or docs route work begins.
