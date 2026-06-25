# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS`

## Type

CODEX / DOCS_POST_AUDIT_CLOSEOUT

## Goal

Record the accepted/pushed Board Canvas/app visual-language polish implementation and release the prior implementation active lock.

No runtime/test implementation is currently armed. This closeout records `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS` as accepted/pushed at `f7dec73` and routes next to `NEEDS_USER_DECISION`.

## Baseline

- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS` at `f7dec73` (`feat(board-canvas): polish app visual language`).
- Prior accepted/pushed active-lock sync: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS` at `fb7067e` (`docs: arm Board Canvas app visual polish implementation`).
- Prior accepted/pushed scope-lock: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS` at `3ff38fe` (`docs: lock Board Canvas app visual polish scope`).
- Prior accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this closeout

This closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS.md`

If any runtime, test, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary, stop and report the exact required file and rationale before editing it.

## Accepted implementation recorded

- Implementation pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS`.
- Accepted/pushed commit: `f7dec73` (`feat(board-canvas): polish app visual language`).
- Full implementation SHA: `f7dec73514d288ae19b4ca61a352785601087d4b`.
- Manual smoke evidence supplied by user: `all passed`.
- Claude audit verdict: `ACCEPT_AS_IS`.
- Claude safety gate: `SAFE_FOR_STAGING: YES`.
- Safe implementation staging set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Board Canvas HTML was used only as `DESIGN_INPUT_ONLY`.
- `_incoming` HTML/design files are not runtime dependencies and are not canonical repo truth.

## Design source status

The Board Canvas HTML remains `DESIGN_INPUT_ONLY`.

It has:

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

This closeout does not stage it, edit it, copy it into runtime assets, depend on `_incoming` at runtime, or infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, or AI facts from it.

## Required preservation

- No future implementation is armed by this closeout.
- Board Canvas renderer remains read-only with `renderer writes: none`.
- Existing integrated Measure panel behavior and hierarchy remain preserved as accepted; this closeout performs no additional visual polish.
- Existing non-writing Measure panel controls remain local UI-only.
- Functional Save remains in the accepted Measure Sheet path.
- Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
- Existing Measure Sheet save behavior remains preserved.
- Existing Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain local/UI-only.
- BenchBeep Home launcher, `Open existing`, `Import project`, back/home to BenchBeep Home, Menu System behavior, Project Overview behavior, and router behavior remain preserved.
- `BenchBeep` remains the user-facing app/product name, `TraceBench` remains the repo/platform/project name, and `BoardFact` remains the data-fact/subsystem name.

## Explicitly forbidden

- Runtime/test edits in this closeout.
- Runtime/test edits of any kind.
- Direct implementation or arming a new implementation route in this closeout.
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

## Route

- Current pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS`
- Route after accepted/pushed: `NEEDS_USER_DECISION`
