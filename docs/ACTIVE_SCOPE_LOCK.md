# Active Scope Lock

## Current pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS`

## Next recommended pass

`ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only protected UI scope-lock is active.

No runtime implementation lock is armed yet. The future implementation allowlist must be armed by `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS` before any Board Canvas runtime/test edits.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_SCOPE_LOCK_PASS.md`

## Design input

Exact file: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\Components\Lisa_Komponent_Panel_Codex_Handoff.html`

Use as `DESIGN_INPUT_ONLY`.

- Do not edit `_incoming`.
- Do not stage `_incoming`.
- Do not copy the HTML into runtime.
- Do not create runtime dependencies on `_incoming`.
- Do not read other `_incoming/**` files by default for this pass.

## Scope summary

Lock the UI-local `Lisa komponent` right-panel redesign before implementation.

This pass intentionally defers `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`. The writer/Confirm contract remains locked and preserved, but writer implementation is not armed in this pass.

## Locked UI contract

Future implementation should update only the existing Board Canvas right-side `Lisa komponent` panel.

Panel sections to preserve:

1. Header: `Lisa komponent`, `Mustand` local draft badge.
2. Active template card: selected shape/package, contact count, `Muuda kuju`.
3. Draft label field: `Nimi / tähis`, placeholder `nt R12, U3, C7`.
4. Shape/package section: `Kuju`, `Vali kuju` / `Muuda kuju`.
5. Pin/contact layout section: `Pin-asetus`, `UI-local marker draft`, top/right/bottom/left local marker steppers, and safety copy `Kontaktid on lokaalne mustand; neid ei kinnitata elektriliste kontaktidena.`
6. Size section: `Suurus`, `Laius`, `Kõrgus`, decrement/increment controls, corner-handle visual hint, and `Lohista nurgast suuruse muutmiseks`.
7. Rotation section: `Pööramine`, `Pööre: 0°`, `⟲ −10°`, `⟳ +10°`, and quick snaps `0° / 90° / 180° / 270°`.
8. Draft preview: `Eelvaade`, dashed `Draft / unsaved` visual preview.
9. Safety copy: `Mustand on lokaalne kuni salvestamiseni.`, `Kontaktid ei kinnita elektrilist ühendust.`, `Salvestamine vajab eraldi writer-pass'i.`
10. Action bar: `Salvesta`, `Muuda`, `Kustuta`, `Tühista`.

## UI-local boundaries

- All controls are UI-local draft only.
- `Salvesta` may be visible only as disabled/inert/design-intent until writer implementation is separately armed.
- `Salvesta` must not call a writer, event service, `events.jsonl`, `known_facts.json`, projection refresh, schema, validator, or materializer.
- `Muuda` is local edit/draft mode only in this UI pass.
- `Kustuta` means discard local draft only.
- Do not delete canonical components.
- Do not emit delete/invalidation events.
- Pin/contact controls are visual marker drafts only.
- Do not create confirmed pins, pads, contacts, nets, traces, measurements, or electrical facts.
- Preserve top badge `Ainult vaatamine · kirjutusi pole`.
- Preserve footer `renderer writes: none`.

## Forbidden surfaces

- No runtime implementation in this pass.
- No tests in this pass.
- No writer edits or creation.
- No schema/tool/materializer/validator/router edits.
- No `events.jsonl` or `known_facts.json` edits.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No Claude Design file copying into runtime.
- No broad docs cleanup.

## Future implementation sequence

1. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `ADD_COMPONENT_PANEL_LOCAL_DRAFT_CONTROLS_IMPL_PASS`

Then return to one of:

- `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
- another explicit user-selected scope

Likely future allowlist, not yet armed:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
