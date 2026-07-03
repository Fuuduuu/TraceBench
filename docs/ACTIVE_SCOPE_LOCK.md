# Active Scope Lock

## Current pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Status

Docs-only active-lock sync is active.

This pass arms the future protected implementation allowlist. It does not perform runtime, test, writer, schema, tool, materializer, validator, router, event, known-facts, sample, fixture, asset, or `_incoming` implementation.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

## Implementation allowlist

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/unit/v2_placement_writer_test.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, writer, schema, tool, materializer, validator, router, event, known-facts, sample, fixture, asset, or `_incoming` path is armed.

## Implementation goal to record

Implement the protected placement writer and explicit Board Canvas Confirm/Salvesta hookup for human-confirmed visual placement.

Future implementation may:

- create `lib/features/components/services/v2_placement_writer.dart`
- wire Board Canvas `Salvesta` only as an explicit human Confirm action
- emit exactly one canonical event type: `component_visual_placement_confirmed`
- use V2/human envelope semantics with `schema_version: 2.0-draft`, `actor.type: human`, `source.type: explicit_user_confirmation`, `confirmation.confirmed: true`, and `client_operation_id`
- write visual placement envelope payload only: `component_id`, `coordinate_space`, `board_side`, `center_x`, `center_y`, `rotation_deg`, `width`, `height`, optional `template_id`, optional `source_photo_id`, optional `notes`
- reuse existing canonical append/event writer service precedent
- keep Board Canvas renderer/painter read-only

## Implementation must not

- write in this active-lock sync
- emit any event type except `component_visual_placement_confirmed`
- create component identity
- emit `component_created`
- emit `component_updated`
- write contacts, pins, pads, nets, traces, electrical facts, measurements, visual contact layout, AI-authored facts, or repair conclusions
- let AI author canonical placement events
- directly edit `known_facts.json`
- directly mutate projection state
- edit schema files
- edit tools/materializer/validator/router files
- edit samples/project fixtures
- edit or stage `_incoming`
- make draft interactions write canonical data
- wire `Salvesta` before the next implementation pass

## Confirm/Salvesta boundary

Canonical placement write requires explicit human action.

No canonical write occurs from opening the panel, selecting a component, dragging, rotating, resizing, changing side/template, editing notes, cancelling, resetting, discarding, or navigating away.

`Salvesta` may become functional only inside `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`, using the dedicated writer path and only when required placement fields are valid.

## Test requirements to record

Future implementation must prove:

- writer builds V2 human-confirmed `component_visual_placement_confirmed`
- writer does not emit `component_created` or `component_updated`
- writer output excludes contacts, pins, pads, nets, traces, measurements, electrical facts, AI facts, visual contact layout, and repair conclusions
- only explicit Confirm/Salvesta writes
- draft controls, cancel, reset, discard, and navigation write nothing
- Confirm appends exactly one placement event
- repeated `client_operation_id` follows existing idempotency precedent
- Board Canvas renderer/painter remains read-only except the explicit writer call from UI action
- existing draft shell and Add Component UI-local behavior remain intact

## Relation to prior locks

- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains the accepted writer/Confirm contract owner.
- `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS` is closed and remains UI-local/no-write except for future separately armed writer integration.
- Visual contact layout remains separate future scope.
- AI marker conversion remains separate future scope.

## Route

1. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`
