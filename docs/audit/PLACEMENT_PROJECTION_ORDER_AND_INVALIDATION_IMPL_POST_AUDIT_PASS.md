# PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS

## Pass metadata

- PASS_ID: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS`
- Mode: docs-only implementation closeout
- Route before pass:
  - Current: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
  - Next: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`
- Route after pass:
  - Current: `NEEDS_USER_DECISION`
  - Next: `NEEDS_USER_DECISION`

## Implementation commit

- Commit: `386b52369a44053ac947aed344864a1b74e54df1`
- Message: `fix: order placement projection by event stream`

## Audit record

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`
- Safe staging set:
  - `tools/materialize_known_facts.py`
  - `tests/test_materialize_known_facts.py`

## Validation recorded

- `py -3 -m unittest tests.test_materialize_known_facts`: 95/95 OK.
- `py -3 tools/validate_all.py`: 285 tests OK; PASSED.
- `board_canvas_positive_smoke` materializes clean.

## Implementation summary

- `component_visual_placements` projection now uses deterministic `events.jsonl` stream order across V1 and V2 placements.
- Later valid placement supersedes earlier placement for the same component.
- V1 and V2 placement confirmations both remain first-class when valid.
- `event_invalidated` retracts targeted placement event from `component_visual_placements`.
- Invalidating older placement does not remove newer valid placement.
- Invalidating newest placement falls back to previous valid placement.
- Invalidating only placement removes projected placement.
- No placement-updated event type was introduced.

## Tests added / covered

- Later V2 beats earlier V1.
- Later V1 beats earlier V2.
- Placement invalidation retraction.
- Invalidating older keeps newer.
- Invalidating newest falls back.
- Invalidating only removes projection.
- Forbidden semantic fields remain outside placement projection.

## Boundary confirmation

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
- No `_incoming` edits/staging.
- No runtime/test/tool/schema implementation edits by this closeout pass.
- No broad staging, commit, or push by this closeout pass.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_POST_AUDIT_PASS.md`

## Claude audit packet marker

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW
