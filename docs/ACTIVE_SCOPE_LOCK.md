# Active Scope Lock

## Current armed implementation pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`

## Prepared by

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

FLUTTER_UI_PROTECTED_IMPLEMENTATION / BOARD_CANVAS_TARGET_CAPTURE_DRAFT / PROTECTED_UI_LANE_B_ADJACENT

## Goal

Arm the narrow future implementation pass for local UI-only target selection and draft value/unit capture inside the accepted integrated Board Canvas Measure panel.

The future implementation remains non-writing. It may add selected target-row state, pin/leg target selection UI, local draft value/unit state, local validation hints, and Canvas focus/highlight/preview linked to the selected target. It must not add canonical writes, `events.jsonl` writes, `known_facts` mutation, writer wiring, new electrical semantics, new schema/projection behavior, or protected data-surface changes.

This active-lock sync is protected-UI / Lane-B-adjacent because it arms Board Canvas UI near accepted measurement write-flow boundaries.

## Baseline

- Latest accepted/pushed scope-lock: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS` at `375adbe` (`docs: lock measurement target capture scope`).
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` at `934a5a4` (`docs: record integrated measurement panel shell`).
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` at `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`).
- Current active-lock sync pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This lock arms the implementation route only after the active-lock sync is accepted/pushed.
- Accepted integrated Measure panel behavior:
  - Board Canvas Measure entry opens a right-side contextual panel in the workbench-shell UI.
  - Canvas stays visible.
  - The panel is a non-writing shell.
  - Measured values list is the main content.
  - Quick local capture controls are inert/local UI-only placeholders.
  - Advanced technical/provenance details are secondary.
  - Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
  - Existing Measure Sheet save behavior remains preserved.

## Allowed files for future implementation

Future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If another runtime, test, route, Measure Sheet, Project Overview, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, docs, or untracked scratch file appears necessary during the future implementation pass, stop and report the exact required file and rationale before editing it.

## Allowed behavior for future implementation

Future implementation may allow only local UI-only behavior for the integrated Board Canvas Measure panel:

- selected measurement target row;
- pin/leg target selection UI;
- local draft value;
- local draft unit;
- local validation and empty-state hints;
- Canvas focus/highlight/preview linked to the selected target;
- optional affordance to continue the existing Measure Sheet save flow.

The technician workflow direction is:

```text
select component -> select pin/leg/target row -> enter local draft value/unit -> keep Canvas visible
```

## Required preservation

- Future implementation must remain non-writing unless a later writer scope explicitly authorizes Board Canvas write wiring.
- Functional Save remains in the accepted Measure Sheet path.
- Optional Board Canvas affordance may continue to the existing Measure Sheet save flow, but must not itself perform canonical save/write.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/highlight/preview/draft state.
- Board Canvas must not write `events.jsonl`, mutate `known_facts`, create canonical facts, or create canonical measurements under this scope.
- Board Canvas must not import, call, route to, or otherwise wire `v2_save_measurement_writer.dart`.
- Visual traces remain visual-only and never measured nets.
- Component/pin/leg/target selection remains UI state only and does not confirm identity, pin mapping, coordinates, nets, faults, packages, or electrical facts.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, Add Component local behavior, and Measure Sheet save behavior remain preserved.

## Explicitly forbidden

- Runtime/test edits in this active-lock sync pass.
- Runtime/test edits outside the exact future implementation allowlist.
- Direct implementation before this active-lock sync is accepted/pushed.
- Board Canvas canonical save/write behavior.
- Importing, calling, routing to, or otherwise wiring `v2_save_measurement_writer.dart` from Board Canvas.
- Edits to `lib/app/router.dart`.
- Edits to `lib/features/project/screens/project_overview_screen.dart`.
- Edits to `lib/features/measure_sheet/screens/measure_sheet_screen.dart`.
- Edits to `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- New writer/service behavior.
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

Because the future implementation is product/UI surface work, manual smoke must pass before Claude audit and the Claude audit packet must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

## Boundary for this active-lock sync

- This file was updated by a docs-only active-lock sync.
- This sync does not implement runtime behavior.
- This sync does not mark `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS` accepted/pushed.
- No untracked scratch files are touched or staged.

## Route

- Current sync pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Armed implementation pass after accepted/pushed sync: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_PASS`
