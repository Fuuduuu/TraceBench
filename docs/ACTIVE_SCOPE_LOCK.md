# Active Scope Lock

## Current pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Status

Docs-only active-lock sync is active. It arms the protected implementation pass and exact implementation allowlist.

Accepted scope-lock evidence:

- Scope-lock pass: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`
- Scope-lock commit: `df6a64329544e5966847ff9c8b56818046259885` (`docs: lock placement event V2 regime`)
- Audit record: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Audit-record sync commit baseline: `62853c674790bb82469d65497a7b6e7d569e22ce` (`docs: record placement event V2 regime audit`)

## Implementation pass armed

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Implementation write allowlist

- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`

## Implementation goal

Migrate `component_visual_placement_confirmed` to the V2/human event regime and prevent materializer drop of V2 human-authored placement events.

The implementation pass may:

- add `component_visual_placement_confirmed` to V2 event handling / V2 event-type ownership where that owner is in the allowlisted files
- validate `schema_version: 2.0-draft`
- validate `actor.type: human`
- validate source block
- validate `confirmation.confirmed: true`
- validate `client_operation_id` / idempotency shape where applicable
- preserve payload semantics for `component_id`, `coordinate_space`, `board_side`, `center_x`, `center_y`, `rotation_deg`, `width`, `height`, optional `template_id`, optional `source_photo_id`, and optional `notes`
- update materializer so V2 human-authored placement events are not silently dropped
- preserve latest-wins projection semantics for `component_visual_placements`
- add focused validator/materializer tests

## Forbidden surfaces for implementation

- No Dart runtime edits.
- No Board Canvas UI edits.
- No Add Component writer edits.
- No placement writer service.
- No Confirm/Edit UI.
- No router edits.
- No `known_facts` schema change unless separately justified and stopped for human approval.
- No visual contact layout event/projection.
- No contacts/pads/legs rendering.
- No AI marker implementation.
- No sample/project fixture edits unless stopped and separately approved.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push.

## Boundary record

- This implementation is event-regime/projection plumbing only.
- It does not create a placement writer.
- It does not expose placement Confirm UI.
- It does not change Board Canvas renderer behavior.
- Visual contact layout remains separate future scope.
- AI never authors canonical placement events.
- `component_visual_placement_confirmed` must not represent electrical connectivity, net identity, measurement pin identity, confirmed contact layout, AI-authored fact, or visual contact/pad layout.
