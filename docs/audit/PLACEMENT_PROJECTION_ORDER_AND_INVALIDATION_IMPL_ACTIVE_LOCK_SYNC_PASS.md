# PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS

## Pass metadata

- PASS_ID: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Mode: docs-only active-lock sync
- Route before pass:
  - Current: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`
  - Next: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Route after pass:
  - Current: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
  - Next: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`

## Scope-lock evidence

- Scope-lock commit: `5cbf3b5174d062e716aa0c31d73420716fff7964` (`docs: lock placement projection ordering`)
- Scope-lock audit: `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

## Implementation pass armed

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_PASS`

## Implementation allowlist

- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`

## Implementation goal

Implement locked `component_visual_placements` projection semantics:

- Cross-regime latest-wins uses deterministic `events.jsonl` stream order, not V1 `sequence` alone.
- Later valid placement event supersedes earlier placement for the same component.
- V1 and V2 placement confirmations both remain first-class when valid.
- `event_invalidated` retracts targeted confirmed placement event from `component_visual_placements`.
- Invalidating older placement does not remove newer valid placement.
- Invalidating newest placement falls back to previous valid placement, or removes projection if none remains.

## Test requirements

Implementation must add focused materializer tests proving:

- Later V2 placement beats earlier V1 placement for same component.
- Later V1 placement beats earlier V2 placement by stream order.
- `event_invalidated` retracts a targeted placement event.
- Invalidating an older placement does not remove a newer valid placement.
- Invalidating newest placement falls back to previous valid placement.
- Invalidating only placement removes projected placement.
- Contact/layout/electrical/net/pin/AI fields remain outside placement projection.

## Forbidden surfaces

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
- No `_incoming` edits or staging.
- No broad docs cleanup.
- No audit file moves/deletes.
- No implementation in this active-lock sync.
- No broad staging, commit, or push.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation plan

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit packet marker

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW
