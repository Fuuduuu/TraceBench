# Active Scope Lock

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW

## Scope

Docs-only protected UI scope-lock for the next integrated measurement panel UX slice: target selection plus local value/unit draft capture.

This pass does not implement runtime behavior and does not arm runtime implementation directly.

## Baseline

- Latest accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_POST_AUDIT_PASS` at `934a5a4` (`docs: record integrated measurement panel shell`).
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS` at `0d015c9` (`feat(board-canvas): add integrated measurement panel shell`).
- Accepted integrated Measure panel behavior:
  - Board Canvas Measure entry opens a right-side contextual panel in the workbench-shell UI.
  - Canvas stays visible.
  - The panel is a non-writing shell.
  - Measured values list is the main content.
  - Quick local capture controls are inert/local UI-only placeholders.
  - Advanced technical/provenance details are secondary.
  - Existing standalone Measure Sheet route and `/project/measure-sheet` compatibility remain preserved.
  - Existing Measure Sheet save behavior remains preserved.

## Allowed files for this scope-lock pass

This docs-only pass may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS.md`

If any runtime, test, schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, or untracked scratch file appears necessary, stop and request a new scope decision before editing it.

## Future behavior locked by this pass

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

## Future implementation gate

Runtime implementation may begin only after a later docs-only active-lock sync is accepted/pushed.

Required next pass:

- `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`

That active-lock sync must:

- name the implementation pass explicitly;
- list exact runtime/test files;
- keep the future implementation narrow;
- preserve Board Canvas non-writing behavior;
- preserve standalone Measure Sheet and `/project/measure-sheet` compatibility;
- preserve existing Measure Sheet save behavior;
- require manual smoke before Claude audit because the future implementation is product/UI surface work;
- stop before editing if target-capture implementation requires router, Project Overview, Measure Sheet screen, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, asset, sample, or any other unlisted file.

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

- Runtime/test edits in this scope-lock pass.
- Direct runtime implementation route from this pass.
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

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_SCOPE_LOCK_PASS`
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_TARGET_CAPTURE_IMPL_ACTIVE_LOCK_SYNC_PASS`
