# Active Scope Lock

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

CODEX / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_LANE_B_ADJACENT

## Scope

Docs-only active-lock sync for the next integrated Board Canvas Measure panel visual-density polish implementation pass.

This pass records accepted/pushed scope-lock `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS` at `42c3594` (`docs: lock measurement panel visual density scope`) and arms the future implementation pass with an exact runtime/test allowlist.

This pass does not implement runtime behavior and does not claim the future implementation is accepted/pushed.

## Armed future implementation pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`

## Future implementation allowlist

The future implementation pass may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If the future implementation requires any file outside this exact allowlist, stop and request a new scope decision before editing it.

## Allowed files for this active-lock sync

This docs-only active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

If any runtime, test, schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, generated, or untracked scratch file appears necessary in this sync pass, stop and request a new scope decision before editing it.

## Future allowed polish behavior

Future implementation may only:

- improve right-panel visual density;
- reduce vertical spacing and row height where safe;
- improve label hierarchy and technician-facing copy;
- improve measured-value row readability;
- make value/unit controls more compact;
- prevent awkward wrapping or overflow;
- make Continue in Measure Sheet visually secondary;
- keep Advanced technical details collapsed, quiet, and last;
- compact From -> To context presentation;
- add or update widget tests for UI structure and the non-writing boundary.

Future implementation must preserve the accepted hierarchy:

1. Compact header
2. Component visual
3. Measured values
4. From -> To context
5. Advanced technical details

## Required preservation

- Future implementation remains local UI-only and non-writing.
- Functional Save remains in the accepted Measure Sheet path.
- Optional Board Canvas affordances may continue to the existing Measure Sheet save flow, but must not perform canonical save/write.
- Existing standalone Measure Sheet route and `/project/measure-sheet` direct/fallback compatibility remain preserved.
- Project Overview measurement entry remains preserved.
- Existing accepted Measure Sheet save behavior remains preserved.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/highlight/preview/draft state.
- Board Canvas does not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements.
- Board Canvas does not import, call, route to, or otherwise wire `v2_save_measurement_writer.dart`.
- From -> To context remains display/provenance-only and must not imply confirmed connectivity.
- Visual traces remain visual-only and never measured nets.
- Component/pin/leg/target selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, and Add Component local behavior remain preserved.

## Forbidden surfaces preserved

- No runtime/test edits in this active-lock sync pass.
- No implementation accepted/pushed hash claim for `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`.
- No edits to router, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files are authorized for the future implementation.
- No import, call, route to, or other wiring of `v2_save_measurement_writer.dart` from Board Canvas is authorized.
- No canonical event/fact writes from Board Canvas.
- No `events.jsonl` writes, `known_facts` mutation, canonical fact creation, or canonical measurement creation from Board Canvas.
- No new Board Canvas save/write behavior.
- No AI/OCR/CV fact creation.
- No placement, coordinate, net, electrical, package, pin-mapping, identity, fault-evidence, or electrical-proof semantics changes.
- No Confirm/write/Edit Layout behavior.
- No Add Component Confirm/write behavior.
- No command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`
