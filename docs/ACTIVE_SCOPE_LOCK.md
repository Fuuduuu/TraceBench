# Active Scope Lock

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH

## Scope

Docs-only scope-lock for the next narrow integrated Board Canvas Measure panel visual-density polish slice.

This pass records that `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` closed the previous target-capture lifecycle at `d39db25` (`docs: record measurement target capture`) and that the route before this new decision was `NEEDS_USER_DECISION`.

This pass does not implement runtime behavior and does not arm implementation directly.

## Allowed files for this scope-lock

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS.md`

If any runtime, test, schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, generated, or untracked scratch file appears necessary, stop and request a new scope decision before editing it.

## Future implementation intent

A later implementation pass may polish only the accepted integrated Board Canvas Measure panel presentation so it remains technician-facing, compact, and readable.

Future implementation must preserve the accepted hierarchy:

1. Compact header
2. Component visual
3. Measured values
4. From -> To context
5. Advanced technical details

Future implementation may improve only:

- right-panel visual density;
- vertical spacing;
- row height;
- label hierarchy;
- measured-value row readability;
- unit/value control compactness;
- prevention of awkward wrapping or overflow;
- secondary styling of Continue in Measure Sheet;
- collapsed or quiet Advanced section behavior;
- compact From -> To context presentation;
- small technician-facing copy improvements;
- widget tests covering the UI structure and non-writing boundary.

## Future implementation gate

Runtime implementation may begin only after a later docs-only active-lock sync is accepted/pushed.

Required next pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

That future active-lock sync should arm:

- `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`

Expected future implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The active-lock sync must inspect the live repo structure before finalizing the allowlist, must not invent files, and must not authorize broad directories.

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

- No runtime/test edits in this scope-lock pass.
- No implementation accepted/pushed hash claim for `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS`.
- No edits to router, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files are authorized.
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

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_SCOPE_LOCK_PASS`
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_ACTIVE_LOCK_SYNC_PASS`
