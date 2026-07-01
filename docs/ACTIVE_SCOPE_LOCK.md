# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock. The `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS` protected implementation lock is released by `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_POST_AUDIT_PASS`.

## Released implementation lock

- Armed by: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Implemented by: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`
- Pushed implementation commit: `fa85231045c8dadc3543a914ca173829a3272c4d` (`feat: support V2 placement event regime`)
- Implementation audit: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Safe staging set recorded:
  - `tools/validate_events_jsonl.py`
  - `tools/materialize_known_facts.py`
  - `tests/test_validate_events_jsonl.py`
  - `tests/test_materialize_known_facts.py`

## Closed implementation summary

- V2 validator now accepts `component_visual_placement_confirmed`.
- V2 placement requires human actor / explicit user confirmation source / `confirmation.confirmed: true`.
- V2 placement uses width + height as the primary visual envelope model.
- V2 placement rejects forbidden semantic fields such as nets, pins, contacts, pads, AI-authored facts, and scale.
- Materializer now materializes V2 human-confirmed placement events into `component_visual_placements`.
- Latest-wins semantics are preserved.
- Focused validator/materializer tests were added.
- `schemas/events.schema.json` was not changed.

## Boundary record

- No Dart runtime edits.
- No Board Canvas UI edits.
- No Add Component writer edits.
- No placement writer service.
- No Confirm/Edit UI.
- No router edits.
- No `known_facts` schema change.
- No visual contact layout event/projection.
- No contacts/pads/legs rendering.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push by this closeout pass.

## Next work

A new user decision and explicit scoped pass are required before additional implementation or docs route work begins.
