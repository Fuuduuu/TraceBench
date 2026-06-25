# Active Scope Lock

## Current pass

`V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_MEASURE_PANEL

## Goal

Lock the next narrow non-writing Measure panel UX slice: a visual pin/leg selector inside the accepted integrated Board Canvas Measure panel.

No runtime/test implementation is currently armed. This pass only records scope, boundaries, and the next route to an active-lock sync before any implementation.

## Baseline

- Latest pushed HEAD verified before this scope-lock: `7a84dcb` (`docs: record Board Canvas app visual polish`), aligned with `origin/main`.
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS` at `7a84dcb` (`docs: record Board Canvas app visual polish`).
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS` at `f7dec73` (`feat(board-canvas): polish app visual language`).
- Prior accepted/pushed Measure panel visual-density closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Prior accepted/pushed Measure panel target-capture closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_POST_AUDIT_PASS` at `d39db25` (`docs: record measurement target capture`).
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this scope-lock

This scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS.md`

If any runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary, stop and report the exact required file and rationale before editing it.

## Scope locked for future implementation

Future implementation may only improve the integrated Board Canvas Measure panel pin/leg selection UX.

Future implementation may allow:

- a more visual pin/leg selector inside the existing Measure panel;
- clearer selected pin/leg state in the component visual preview;
- technician-facing pin/leg labels;
- better selected, unselected, and disabled local UI states;
- tighter link between selected measured-value row and visual pin/leg cue;
- local UI-only highlight/focus behavior;
- widget tests proving visual selection state and the no-write boundary.

This scope-lock does not arm implementation directly.

## Future active-lock sync requirement

After this scope-lock is accepted/pushed, route to:

`V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS`

That active-lock sync must inspect live repo files and arm the smallest exact future implementation allowlist. Likely files, if still sufficient:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The active-lock sync must not implement runtime behavior and must not claim the future implementation is accepted/pushed.

## Required preservation

- Board Canvas remains read-only.
- Integrated Measure panel remains non-writing.
- Existing measured-value rows and local draft value/unit behavior remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- From -> To context remains display/provenance-only.
- Visual traces remain visual-only and never become nets.
- Visual pin/leg selection remains local UI-only and must not become confirmed pin mapping.
- Existing Add Component, Board Canvas navigation, Home, Project Overview, Measure Sheet, and Menu System behavior remain preserved.
- `BenchBeep` remains the user-facing app/product name, `TraceBench` remains the repo/platform/project name, and `BoardFact` remains the data-fact/subsystem name.

## Explicitly forbidden

- Runtime/test edits in this scope-lock.
- Direct runtime implementation or arming implementation directly in this scope-lock.
- Board Canvas canonical save/write behavior.
- Importing, calling, routing to, or otherwise wiring `v2_save_measurement_writer.dart` from Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation from Board Canvas.
- Creating canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual pin/leg selection into confirmed pin mapping.
- Turning visual traces or From -> To context into confirmed connectivity.
- Edits to `lib/app/router.dart`.
- Edits to Home, Project Overview, Measure Sheet screen, Measure Sheet writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files.
- Home launcher, Open existing, Import project, Back/Home behavior, Menu System, Add Component behavior, Measure Sheet save behavior, or canonical write behavior changes.
- Confirm/write/Edit Layout behavior.
- Add Component Confirm/write behavior.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Route

- Current pass: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS`
- Route after accepted/pushed: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS`
