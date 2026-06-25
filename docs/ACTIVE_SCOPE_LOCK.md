# Active Scope Lock

## Current armed implementation pass

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS`

## Prepared by

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

FLUTTER_UI_PROTECTED_IMPLEMENTATION / BOARD_CANVAS_APP_VISUAL_POLISH / PROTECTED_UI_LANE_B_ADJACENT

## Goal

Arm the narrow future implementation pass for Board Canvas/app visual-language polish.

The future implementation may polish only existing Board Canvas/app visual density, spacing, hierarchy, technician-facing copy, existing Board Canvas chrome/rails/right-panel/footer/status/controls/canvas-surface presentation, existing local UI-only empty/selection/active/focus states, existing non-writing right-panel Measure/Add Component visual alignment where owned by the Board Canvas screen, and compact readability/overflow behavior.

This active-lock sync is protected-UI / Lane-B-adjacent because it arms Board Canvas UI near accepted measurement and Add Component boundaries. It does not authorize canonical writes, schema/projection changes, or global app redesign.

## Baseline

- Latest accepted/pushed scope-lock: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS` at `3ff38fe` (`docs: lock Board Canvas app visual polish scope`).
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS` at `8b140d6` (`feat(board-canvas): polish measurement panel density`).
- Current active-lock sync pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- This lock arms the implementation route only after the active-lock sync is accepted/pushed.
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for future implementation

Future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

If another runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, docs, or untracked scratch file appears necessary during the future implementation pass, stop and report the exact required file and rationale before editing it.

## Allowed behavior for future implementation

Future implementation may only:

- polish existing Board Canvas/app visual density, spacing, and hierarchy;
- improve technician-facing copy and label hierarchy;
- polish existing Board Canvas chrome, rails, right panel, footer/status, controls, and canvas-surface presentation;
- polish existing local UI-only empty, selection, active, and focus states;
- improve visual alignment of existing non-writing right-panel Measure/Add Component surfaces where owned by Board Canvas screen;
- make compact control/readability improvements that prevent awkward wrapping or overflow;
- add or update widget tests for UI structure, local-only state, and no-write boundary preservation.

## Design source status

The Board Canvas HTML remains `DESIGN_INPUT_ONLY`.

It has:

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

The future implementation must not stage it, edit it, copy it into runtime assets, depend on `_incoming` at runtime, or infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, or AI facts from it.

## Required preservation

- Future implementation must remain local UI-only and non-writing.
- Board Canvas renderer remains read-only with `renderer writes: none`.
- Existing integrated Measure panel behavior and hierarchy remain preserved unless the polish is strictly visual within this allowlist.
- Existing non-writing Measure panel controls remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
- Existing Measure Sheet save behavior remains preserved.
- Existing Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, Project Overview behavior, and router behavior remain preserved.
- `BenchBeep` remains the user-facing app/product name, `TraceBench` remains the repo/platform/project name, and `BoardFact` remains the data-fact/subsystem name.

## Explicitly forbidden

- Runtime/test edits in this active-lock sync pass.
- Runtime/test edits outside the exact future implementation allowlist.
- Direct implementation before this active-lock sync is accepted/pushed.
- Global app redesign.
- Global theme migration.
- Home launcher, Open existing, Import project, Back/Home behavior, Menu System, Add Component behavior, Measure Sheet save behavior, or canonical write behavior changes.
- Board Canvas canonical save/write behavior.
- Importing, calling, routing to, or otherwise wiring `v2_save_measurement_writer.dart` from Board Canvas.
- Edits to `lib/app/router.dart`.
- Edits to Home, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files.
- Canonical event/fact writes from Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation from Board Canvas.
- Schema, writer, validator, materializer, projection, or Project ZIP changes.
- AI/OCR/CV fact creation.
- Placement, coordinate, net, electrical, package, pin-mapping, identity, fault-evidence, or electrical-proof semantics changes.
- Confirm/write/Edit Layout behavior.
- Add Component Confirm/write behavior.
- Command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- Turning visual traces or From -> To context into confirmed connectivity.
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

If `python` is unavailable but `py` works, use:

```powershell
py -3 tools\validate_all.py
```

Because the future implementation is product/UI surface work, manual smoke must pass before Claude audit and the Claude audit packet must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

## Boundary for this active-lock sync

This pass may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Route after accepted/pushed: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS`
