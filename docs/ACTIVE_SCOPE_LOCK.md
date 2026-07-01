# Active Scope Lock

## Current pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only protected-surface scope-lock is active.

This pass locks the future `component_visual_placement_confirmed` V2 event-envelope regime before any placement writer/editor implementation. It does not authorize runtime, test, schema, writer, materializer, validator, projection, router, sample, asset, pubspec, Confirm/Edit UI, event implementation, placement writer, or AI marker implementation changes.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/audit/BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS.md`

## Source review recorded

`ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`

Recorded findings:

- `component_created` exists and confirms identity/existence only.
- `component_visual_placement_confirmed` is scaffolded in schema/materializer/validator.
- There is no Dart placement writer and no sample event.
- Existing V2 writers use `actor.type = human` with source/confirmation blocks.
- Existing placement materializer path currently expects `actor.type = user`.
- This creates an actor/envelope contradiction that must be resolved before implementation.

## Future V2 regime decision locked

- `component_visual_placement_confirmed` must align to the V2 event regime in a future protected implementation pass.
- Use `schema_version: 2.0-draft`.
- Use `actor.type: human`.
- Use a source block.
- Use `confirmation.confirmed: true`.
- Use `client_operation_id` / idempotency precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Future protected implementation must reconcile `schemas/events.schema.json`, `tools/validate_events_jsonl.py`, `tools/materialize_known_facts.py`, any V2 event-type owner, and any tests/samples needed.
- Materializer must not silently drop V2 human-authored placement events.
- This decision does not implement the migration.

## Current V1 scaffold clarification

- Current schema/validator/materializer code remains unchanged by this pass.
- Current `schemas/events.schema.json` still declares V1 envelope shape with required `sequence` and `status` fields.
- Current placement projection behavior remains the accepted repo behavior until a protected implementation changes it.
- The V1 scaffold versus pending V2 migration contradiction is recorded as an implementation prerequisite, not resolved here.

## Placement event semantics locked

`component_visual_placement_confirmed` should represent:

- `component_id`
- board side
- coordinate space
- center position
- `rotation_deg`
- `width` + `height` as primary visual envelope size model
- optional `template_id` / visual family reference
- human confirmation metadata

It must not represent:

- electrical connectivity
- net identity
- measurement pin identity
- confirmed contact layout
- AI-authored fact
- visual contact/pad layout

## Visual contact boundary

- Visual contact layout remains a separate future scope/event/projection.
- Do not fold contacts/pads/legs into `component_visual_placement_confirmed`.
- Visual contact confirmation is not electrical confirmation.

## AI marker boundary

- AI/photo marker remains unconfirmed proposal only.
- Human confirmation through the placement editor creates the canonical placement event.
- AI never authors canonical placement.

## Standing forbidden surfaces for this pass

- No runtime or test edits.
- No schema, tool, writer, materializer, validator, projection, router, sample, asset, or pubspec edits.
- No `events.jsonl` or `known_facts.json` semantic changes.
- No event implementation.
- No placement writer.
- No Confirm/Edit UI.
- No AI marker implementation.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push.
