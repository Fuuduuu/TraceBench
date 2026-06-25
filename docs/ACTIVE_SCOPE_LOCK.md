# Active Scope Lock

## Current pass

`V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT / PROTECTED_UI_MEASURE_PANEL

## Goal

Record the accepted/pushed local UI-only visual pin/leg selector implementation and release the implementation active lock.

This pass is docs-only. It records manual-smoke evidence, Claude audit acceptance, exact implementation files, accepted behavior, and preserved protected boundaries. It does not implement runtime behavior, edit tests, or arm a new implementation pass.

## Baseline

- Latest pushed HEAD verified before this closeout: `d573933` (`feat(board-canvas): add visual pin leg selector`), aligned with `origin/main`.
- Accepted/pushed implementation: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_PASS` at `d573933` (`feat(board-canvas): add visual pin leg selector`).
- Full implementation SHA: `d5739338a792a5e76ff24f8abbc517adef7d2122`.
- Prior accepted/pushed active-lock sync: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_ACTIVE_LOCK_SYNC_PASS` at `aed1698` (`docs: arm Measure panel pin leg selector implementation`).
- Prior accepted/pushed scope-lock: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_SCOPE_LOCK_PASS` at `521e5e4` (`docs: lock Measure panel pin leg selector scope`).
- Manual smoke before Claude audit: user-reported PASS; Measure panel visual selector appeared, selected measured-value row and visual pin/leg cue stayed linked, previous Board Canvas behavior remained intact, and no write/canonical behavior appeared.
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this closeout

This closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS.md`

If any runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary for this closeout, stop and report the exact required file and rationale before editing it.

## Accepted implementation files

The accepted implementation changed exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Accepted behavior recorded

- Integrated Board Canvas Measure panel now has a local UI-only visual pin/leg selector.
- Selected measured-value row and visual selector cue stay linked.
- Selected pin/leg state is clearer in the component preview.
- Technician-facing visual labels are improved.
- Missing pin/leg data degrades gracefully without inventing pins.
- Visual selector remains local UI-only.
- No visual pin/leg selection becomes confirmed pin mapping.
- Board Canvas remains read-only and non-writing.
- Existing measured-value rows and local draft value/unit behavior remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- From -> To context remains display/provenance-only.
- Visual traces remain visual-only and never become nets.
- Existing Add Component, Board Canvas navigation, Home, Project Overview, Measure Sheet, and Menu System behavior remain preserved.

## Explicitly forbidden

- Runtime/test edits in this closeout.
- Arming a new implementation pass.
- Board Canvas canonical save/write behavior.
- Claiming canonical measurement writing is accepted.
- Claiming visual pin/leg selection is confirmed pin mapping.
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

- Current pass: `V2_MEASURE_PANEL_PIN_LEG_VISUAL_SELECTOR_IMPL_POST_AUDIT_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`
