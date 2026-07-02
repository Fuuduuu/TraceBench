# Active Scope Lock

## Current pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only protected-surface scope-lock is active.

This lock records ordering and invalidation semantics for `component_visual_placements` before any placement writer, Confirm UI, edit-placement flow, visual-contact layout, or AI marker conversion is implemented.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS.md`

## Protected risks locked

1. Mixed V1/V2 latest-wins risk: an older V1 placement with a real `sequence` must not beat a newer V2 human-authored placement solely because V2 has no sequence.
2. Placement invalidation gap: `event_invalidated` must retract targeted placement events from `component_visual_placements` projection once the future implementation lands.
3. Future placement writer, Confirm UI, edit-placement flow, visual-contact layout, and AI marker conversion must not ship until these semantics are resolved by implementation.

## Human decisions locked

- Legacy V1 placement events remain first-class legacy events.
- The materializer must interleave V1 and V2 placement confirmations deterministically.
- Projection latest-wins uses stream order as the primary cross-regime ordering source, not V1 `sequence` alone.
- A later event in `events.jsonl` supersedes an earlier placement for the same component when both are valid accepted/human-confirmed placements.
- `event_invalidated` retracts a confirmed placement event when it targets that placement event.
- A retracted placement event no longer contributes to `component_visual_placements`.
- If a newer non-invalidated placement exists for the same component, projection uses that newest valid placement.
- If no valid non-invalidated placement remains, that component has no projected placement.
- Placement correction remains append-only through newer `component_visual_placement_confirmed` events.
- No new placement-updated event type is introduced for this fix.
- Contact layout, electrical connectivity, pin identity, net identity, AI-authored facts, pads, contacts, and visual-contact layout remain outside placement projection.

## Future implementation target

- `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS` must run before implementation.
- Likely future implementation allowlist:
  - `tools/materialize_known_facts.py`
  - `tests/test_materialize_known_facts.py`
- Optional validator/test owner only if a later implementation review proves validator behavior must change.

## Future implementation test requirements

- Later V2 placement beats earlier V1 placement for the same component when stream order is later.
- Later V1 placement still beats earlier V2 placement when stream order is later.
- `event_invalidated` retracts a targeted placement event.
- Invalidating an older placement does not remove a newer valid placement.
- Invalidating the newest placement falls back to the previous valid placement, or removes projected placement if none remains.
- Materializer uses deterministic stream order / event index for placement latest-wins across V1 and V2.
- Materializer accounts for `event_invalidated` targeting placement event IDs.

## Forbidden surfaces

- No runtime Dart edits.
- No Board Canvas UI edits.
- No placement writer.
- No Confirm/Edit UI.
- No router edits.
- No schema edits.
- No `tools/validate_events_jsonl.py` edits in this scope-lock.
- No `known_facts` schema edits.
- No visual contact layout.
- No contacts/pads/legs rendering.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No FILE_MAP redesign.
- No broad docs cleanup.
- No audit file moves/deletes.
- No implementation.
- No broad staging, commit, or push.

## Boundary record

- V2 `component_visual_placement_confirmed` validator/materializer support is implemented.
- V2 placement events validate/materialize under `schema_version: 2.0-draft`, `actor.type: human`, `source.type: explicit_user_confirmation`, `confirmation.confirmed: true`, `client_operation_id`, and width + height as the primary visual envelope model.
- `schemas/events.schema.json` remains V1-envelope-only by design/current state.
- No Dart placement writer exists yet.
- No placement Confirm/Edit UI exists yet.
- Board Canvas remains read-only.
- Visual contact layout remains separate future scope.
- AI never authors canonical placement events.

## Validation required

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`
