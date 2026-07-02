# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock is armed.

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS` has been closed out after the pushed implementation commit:

- `93452da3bddf554d7921b7df0e15bb183394f649`
- `feat: add add component panel local draft controls`

## Released implementation allowlist

The released implementation allowlist was:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, writer, schema, tool, materializer, validator, router, sample, fixture, asset, or `_incoming` path was armed by that implementation pass.

## Closed implementation summary

- Board Canvas `Lisa komponent` right panel now has UI-local add-component controls.
- Active template / shape package card is preserved.
- `Pin-asetus` / UI-local marker draft remains.
- `Suurus` local width/height controls are visible.
- `Pööramine` local rotation controls are visible.
- `Eelvaade` / Draft / unsaved preview is visible.
- Safety copy remains visible.
- Action bar contains `Salvesta`, `Muuda`, `Kustuta`, and `Tühista`.
- The fixed-height / hidden-scroll layout hack was removed.
- All controls remain UI-local / in-memory only.
- `Salvesta` remains inert/disabled/design-intent only.
- `Kustuta` discards local draft only.
- `Ainult vaatamine · kirjutusi pole` remains.
- `renderer writes: none` remains.

## Boundary after release

Future work requires a new route and active lock before editing.

Forbidden unless separately scoped:

- writer creation or writer calls
- event writer service calls
- `events.jsonl` writes
- `known_facts.json` writes
- schema edits
- tools/materializer/validator edits
- router edits
- sample/project fixture edits
- `_incoming` edits, copy, import, or staging
- confirmed pins/pads/contacts/nets/traces/measurements/electrical facts
- canonical delete or invalidation behavior
- broad docs cleanup
- staging, commit, or push by Codex

## Future candidates, not armed

- `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
- future visual-contact layout scope
