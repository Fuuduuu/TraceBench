# Active Scope Lock

## Current armed implementation pass

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`

## Prepared by

`V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

FLUTTER_UI_PROTECTED_IMPLEMENTATION / BOARD_CANVAS_NON_WRITING_SHELL / PROTECTED_UI_LANE_B_ADJACENT

## Goal

Arm the narrow future implementation pass for the first integrated visual-first measurement panel slice on Board Canvas.

The first implementation slice is explicitly a non-writing shell. It may add a right-side contextual measurement panel shell and local UI-only focus/highlight/preview/panel state so Canvas remains visible as much as practical. It must not add canonical writes, `events.jsonl` writes, `known_facts` mutation, new electrical semantics, new schema/projection behavior, or protected data-surface changes.

This active-lock sync is protected-UI / Lane-B-adjacent because it arms Board Canvas UI close to write-flow boundaries.

## Baseline

- Latest accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS` at `6711c6b` (`docs: lock integrated measurement panel scope`).
- Previous accepted/pushed measurement navigation closeout: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS` at `2270e0c` (`docs: record measurement navigation consolidation`).
- Latest accepted/pushed measurement navigation implementation: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` at `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`).
- Current active-lock sync pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This lock arms the implementation route only after the active-lock sync is accepted/pushed.
- Existing accepted behavior preserves standalone Measure Sheet route, `/project/measure-sheet` compatibility, Board Canvas read-only renderer behavior, and Add Component local behavior.

## Allowed files for future implementation

Future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If another runtime, test, route, Measure Sheet, Project Overview, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, or docs file appears necessary during the future implementation pass, stop and report the exact required file and rationale before editing it.

## Allowed behavior for future implementation

- Add a Board Canvas integrated measurement panel entry/shell.
- Keep Board Canvas visible as much as practical while the measurement panel is open.
- Present the panel as a right-side contextual panel similar to Add Component.
- Use user-defined component names where available, falling back to component IDs only when needed.
- Use hover/focus/selection to drive local UI-only component highlight and preview state.
- Show component and visual-trace preview context without treating visual trace as an electrical net or proof.
- Allow pin/leg selection to reveal value/unit/save-looking controls under the visual context only as inert or local UI-only placeholders in this first slice.
- Preserve local volatility for selection/focus/preview state.

## Required preservation

- Existing standalone Measure Sheet route remains alive.
- `/project/measure-sheet` direct/fallback route compatibility remains preserved.
- Project Overview measurement entry remains preserved.
- Existing accepted Measure Sheet save behavior remains preserved.
- Functional save remains in the existing Measure Sheet path unless a later separate writer scope explicitly authorizes Board Canvas write wiring.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/highlight/preview state.
- Board Canvas does not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements under this allowlist.
- Canvas hover/focus/selection visuals do not create facts, measurements, placement records, nets, or electrical proof.
- Visual traces remain visual-only and are never promoted to measured nets.
- Component/pin selection does not confirm identity, package, pin mapping, coordinates, nets, faults, or electrical facts.
- BenchBeep Home launcher remains preserved.
- `Open existing` remains preserved.
- `Import project` remains preserved.
- Back/Home returns to BenchBeep Home, not the legacy start screen.
- Menu System behavior remains preserved.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain preserved.

## Explicitly forbidden

- Runtime/test edits outside the exact implementation allowlist.
- Edits to `lib/app/router.dart`.
- Edits to `lib/features/project/screens/project_overview_screen.dart`.
- Edits to `lib/features/measure_sheet/screens/measure_sheet_screen.dart`.
- Edits to `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- Importing, calling, routing to, or otherwise wiring `v2_save_measurement_writer.dart` from Board Canvas.
- New writer/service behavior.
- New Board Canvas save/write behavior; save/value/unit controls in the first slice must remain inert or local UI-only placeholders.
- Canonical event/fact writes from Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation from Board Canvas.
- Schema, writer, validator, materializer, projection, or Project ZIP changes.
- AI/OCR/CV fact creation.
- Placement, coordinate, net, electrical, package, pin-mapping, or identity semantics changes.
- Confirm/write/Edit Layout behavior.
- Add Component Confirm/write behavior.
- Command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Future implementation validation

The future implementation pass must run at least:

```powershell
dart format lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart
flutter test test/widget/board_canvas_screen_test.dart
flutter test test/widget/measure_sheet_screen_test.dart
flutter test test/widget/project_overview_screen_test.dart
flutter test
python tools/validate_all.py
git status --short --branch
git diff --name-status
git diff --cached --name-status
git diff --check
```

If practical, also run:

```powershell
flutter analyze
```

Because the future implementation is product/UI surface work, manual smoke must pass before Claude audit and the Claude audit packet must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

## Boundary for this active-lock sync

- This file was updated by a docs-only active-lock sync.
- This sync does not implement runtime behavior.
- This sync does not mark `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` accepted/pushed.
- No untracked scratch files are touched or staged.

## Route

- Current sync pass: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Armed implementation pass after accepted/pushed sync: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`
