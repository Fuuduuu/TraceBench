# Active Scope Lock

## Current pass

`PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_EDITOR_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only protected-surface product/architecture scope-lock is active.

This pass does not arm implementation. It locks the placement editor and placement writer contract before any Board Canvas placement editor UI, placement writer service, Confirm placement action, edit-placement flow, visual-contact layout, or AI-marker conversion is implemented.

## Write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_EDITOR_AND_WRITER_SCOPE_LOCK_PASS.md`

## Read-first route and architecture docs

- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`

## Placement editor contract locked

- Owner: Board Canvas right-panel / ghost draft area.
- First implementation slice: UI-local placement editor shell only.
- No canonical write on open, drag, rotate, resize, shape change, side change, cancel, discard, or leaving the editor.
- Draft state is in-memory until explicit Confirm.
- Draft UI must clearly show unsaved/session-only state.
- Editor may be seeded from selected component identity, existing confirmed placement projection, local ghost/template draft, or later AI marker candidate only in future scope.
- Editor controls may include component context, board side, shape/template family, center position/drag, `rotation_deg`, `width`, `height`, optional `template_id`, optional visual family reference, and optional notes.
- Per-side visual contact counts may exist only as UI-local visual draft controls until a future visual-contact layout scope.
- Contact counts must not be written to `component_visual_placement_confirmed`.
- Contacts/pads/legs/pin anchors must not be treated as confirmed contacts, pins, pads, nets, measurements, or electrical facts.
- Placement editor must not create component identity; Add Component remains the identity path.

## Placement writer contract locked

- Future dedicated writer service is expected at `lib/features/components/services/v2_placement_writer.dart`, unless active-lock sync justifies another exact path.
- Writer emits exactly one V2 event type: `component_visual_placement_confirmed`.
- Event envelope: `schema_version: 2.0-draft`, `actor.type: human`, `source.type: explicit_user_confirmation`, `confirmation.confirmed: true`, and `client_operation_id` / idempotency precedent.
- Payload includes `component_id`, `coordinate_space`, `board_side`, `center_x`, `center_y`, `rotation_deg`, `width`, `height`, optional `template_id`, optional `source_photo_id`, and optional `notes`.
- Writer uses the existing Python event writer service / canonical append path.
- Writer must not directly edit `known_facts.json`.
- Projection refresh/stale handling follows existing V2 writer patterns.
- Writer must preserve idempotent repeat behavior where applicable.
- Writer must not emit `component_created` or `component_updated`.
- Writer must not write visual contact layout, nets, pins, pads, contacts, measurements, electrical connectivity, AI facts, or repair conclusions.

## Edit placement contract locked

- Editing placement reopens the same editor pre-seeded from the projection.
- Changes are draft-only until explicit Confirm.
- Confirm emits a new `component_visual_placement_confirmed` event.
- Projection latest-wins chooses newest valid event by stream order.
- `event_invalidated` may retract a wrong placement event according to accepted projection semantics.
- Do not introduce `component_placement_updated` or `placement_updated` event types.
- Metadata edits such as label/ref/package remain in existing Edit Component flow.

## Manual and AI marker flow boundaries

Manual flow:

1. Add or select component identity.
2. Open placement editor from Board Canvas.
3. Pick shape/template family.
4. Adjust board side, position, rotation, width, and height.
5. Optionally adjust UI-local visual draft contact counts, but do not persist them as contacts.
6. Confirm placement explicitly.
7. Confirm emits `component_visual_placement_confirmed` through the future writer.

AI marker future flow:

- AI/photo candidate marker remains non-canonical proposal only.
- User may later open the same placement editor seeded from marker.
- Human adjusts shape, position, rotation, and size.
- Human Confirm emits the canonical placement event.
- AI never authors canonical placement.

## Forbidden surfaces in this pass

- No runtime edits.
- No test edits.
- No schema edits.
- No tools/materializer/validator edits.
- No writer edits.
- No router edits.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No FILE_MAP redesign.
- No broad docs cleanup.
- No audit file moves/deletes.
- No implementation.
- No broad staging, commit, or push.

## Boundary record

- Board Canvas renderer/painter remains read-only.
- Component identity and placement confirmation remain separate actions.
- Placement and visual contact layout remain separate canonical concepts.
- Visual contact confirmation is not electrical confirmation.
- AI markers remain unconfirmed until human conversion.
