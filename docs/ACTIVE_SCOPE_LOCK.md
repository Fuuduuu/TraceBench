# Active Scope Lock

## Current pass

`BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_POST_AUDIT_PASS`

## Status

Docs-only architecture decision scope-lock is active.

This pass records human decisions for the future placement editor architecture. It does not authorize runtime, test, schema, writer, materializer, validator, projection, router, sample, asset, pubspec, Confirm/write/Edit Layout, or AI marker implementation.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/audit/BOARD_CANVAS_PLACEMENT_EDITOR_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS.md`

## Source review recorded

`ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`

Recorded findings:

- Add Component currently writes `component_created` only.
- `component_created` confirms identity/existence only and carries no position, side, rotation, size, shape, or contacts.
- Board Canvas renderer is bodyOnly/read-only.
- Board Canvas local builder/ghost is UI-local only and has no confirm/save/write path.
- `component_visual_placement_confirmed` is scaffolded in schema/materializer/validator but has no Dart writer/sample.
- Existing V2 writers use `actor.type = human`; existing placement materializer path expects `actor.type = user`.
- Visual contact layout is separate future scope from placement.
- Contacts, pads, and legs on component image remain future confirmed visual-contact layout scope.

## Human decisions locked

- Placement events should align to the V2 event regime: `schema_version: 2.0-draft`, `actor.type: human`, source block, `confirmation.confirmed: true`, and idempotent `client_operation_id` precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Evolve the Board Canvas right-panel / ghost draft into the official UI-local placement editor.
- Do not create a standalone placement editor screen first unless a later scope overturns this decision.
- Painter/renderer remains read-only; future Confirm calls a dedicated placement writer service.
- Primary confirmed visual placement size model is `width` + `height`; `scale` may remain import/backward compatibility only unless later scoped.
- VectorFootprintLibrary / footprint recipe model owns the canonical visual vocabulary.
- Board Canvas starter templates are UI presets only.
- Visual contact layout is a separate future event/projection and is not electrical confirmation.
- AI marker remains an unconfirmed proposal/sidecar/UI-local candidate until a human converts it through the same placement editor path.

## Standing forbidden surfaces for this pass

- No runtime or test edits.
- No schema, writer, materializer, validator, projection, router, sample, asset, or pubspec edits.
- No `events.jsonl` or `known_facts.json` semantic changes.
- No Confirm/write/Edit Layout implementation.
- No AI marker implementation.
- No `_incoming` staging or runtime dependency.
- No broad staging, commit, or push.
