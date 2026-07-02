# Active Scope Lock

## Current pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Status

Docs-only active-lock sync is active.

This pass arms the future implementation allowlist. It does not perform runtime or test implementation.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

## Implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, writer, schema, tool, materializer, validator, router, sample, fixture, asset, or `_incoming` path is armed.

## Design input

Exact file: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`

Use as `DESIGN_INPUT_ONLY`.

- Do not edit `_incoming`.
- Do not stage `_incoming`.
- Do not copy the HTML into runtime.
- Do not import `_incoming` from runtime.
- Do not use `_incoming` as a runtime dependency.
- Do not read other `_incoming/**` files by default.

## Implementation goal to record

Implement UI-local `Lisa komponent` right-panel controls from the Claude Design handoff.

Future implementation may:

- update only the existing Board Canvas right-side `Lisa komponent` panel
- preserve the active template / shape package card
- preserve UI-local marker draft controls
- replace red annotation/instruction boxes with real UI controls
- add Size section: `Suurus`, `Laius`, `Kõrgus`, decrement/increment controls, corner-handle visual hint, and `Lohista nurgast suuruse muutmiseks`
- add Rotation section: `Pööramine`, `Pööre: 0°`, `⟲ −10°`, `⟳ +10°`, and quick snaps `0°`, `90°`, `180°`, `270°`
- add Draft preview: `Eelvaade`, dashed `Draft / unsaved` preview
- add Safety copy: `Mustand on lokaalne kuni salvestamiseni.`, `Kontaktid ei kinnita elektrilist ühendust.`, `Salvestamine vajab eraldi writer-pass'i.`
- add Action bar: `Salvesta`, `Muuda`, `Kustuta`, `Tühista`
- keep all changes UI-local / in-memory only
- keep `Salvesta` disabled/inert/design-intent only
- keep `Kustuta` as local draft discard only
- preserve `Ainult vaatamine · kirjutusi pole`
- preserve `renderer writes: none`

## Implementation must not

- create a writer
- call a writer
- call event writer service
- write `events.jsonl`
- write `known_facts.json`
- refresh projection as a save side-effect
- create or modify schema
- edit tools/materializer/validator/router
- create confirmed pins/pads/contacts/nets/traces/measurements/electrical facts
- delete canonical components
- emit invalidation/delete events
- introduce physical `mm` semantics unless current code already owns that unit
- require real corner drag-resize in the first implementation
- copy/import/stage `_incoming`
- consume other design packages

## Test requirements to record

Future implementation must prove:

- `Lisa komponent` panel contains the locked sections.
- Size controls are visible.
- Size controls mutate only local draft state.
- Rotation controls are visible.
- Rotation controls mutate only local draft state.
- Pin/contact marker controls remain UI-local marker draft.
- Safety copy is visible.
- `Salvesta` is disabled/inert/design-intent only.
- `Kustuta` discards local draft only.
- No canonical event write occurs.
- `state.events` remains empty where relevant.
- `Ainult vaatamine · kirjutusi pole` remains visible.
- `renderer writes: none` remains visible.
- No writer/service/schema/tool/materializer/validator/router change occurs.

## Forbidden surfaces for this active-lock sync

- No implementation in this active-lock sync.
- No runtime edits in this sync.
- No test edits in this sync.
- No writer edits or creation.
- No schema edits.
- No tools/materializer/validator edits.
- No router edits.
- No `events.jsonl` / `known_facts.json` edits.
- No sample/project fixture edits.
- No `_incoming` edits.
- No `_incoming` staging.
- No broad docs cleanup.
- Do not stage, commit, or push.

## Relation to writer contract

- `PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS` remains accepted/pushed and preserved.
- Writer implementation remains deferred.
- Future writer implementation must still obey the writer/Confirm contract.
- This Add Component panel implementation must not weaken writer boundaries.

## Route

1. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`
