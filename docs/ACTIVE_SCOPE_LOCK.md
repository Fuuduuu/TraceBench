# Active Scope Lock

## Current pass

`V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`

## Type

DOCS_SCOPE_LOCK / PROTECTED_UI_WORKFLOW

## Goal

Docs-only protected scope lock for a future visual-first integrated measurement workflow on Board Canvas.

## Baseline

- Latest accepted/pushed closeout: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_POST_AUDIT_PASS` at `2270e0c` (`docs: record measurement navigation consolidation`).
- Latest accepted/pushed implementation: `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS` at `4a7ac96` (`feat(board-canvas): consolidate measurement navigation`).
- Current route before this pass: `NEEDS_USER_DECISION`.
- No runtime/test implementation pass is armed at this baseline.
- Existing accepted behavior preserves standalone Measure Sheet route, `/project/measure-sheet` compatibility, Board Canvas read-only renderer behavior, and Add Component local behavior.

## Allowed files for this scope lock

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS.md`

If another runtime, test, tooling, schema, sample, asset, platform, or unrelated docs file appears necessary, stop and report the exact rationale before editing it.

## Future workflow intent

- Board Canvas should stay visible as much as practical while measuring.
- Measure should eventually open as a right-side contextual panel on Board Canvas, similar to Add Component.
- Component selection should use user-defined component names when available.
- Hover/focus may highlight the component on Canvas as UI focus/preview only.
- Selecting a component should show component and visual-trace preview context without treating visual trace as a net or electrical proof.
- Selecting a pin/leg may reveal value/unit/save inputs under the visual context only in a separately armed implementation pass.
- Technician-facing flow should remain measure-first: `Koht -> Väärtus -> Ühik -> Salvesta`.

## Future implementation gate

This scope lock does not authorize runtime implementation.

Before any implementation:

- `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS` or equivalent docs-only active-lock sync must be accepted/pushed.
- The live `docs/ACTIVE_SCOPE_LOCK.md` must name the implementation pass.
- The live lock must list the exact runtime/test allowlist.
- Product/UI surface work must receive manual smoke before Claude audit.
- Any write path must preserve accepted human-authored save semantics and use accepted writer/service boundaries; new canonical writer/schema/materializer/projection/event/fact behavior requires a separate protected scope.

## Required preservation for future implementation

- Existing standalone Measure Sheet route remains alive unless a separate accepted route migration explicitly preserves compatibility.
- `/project/measure-sheet` direct/fallback route behavior remains compatible.
- Existing accepted Measure Sheet save behavior remains preserved.
- Board Canvas renderer remains read-only except for separately authorized local UI focus/preview state.
- Canvas hover/focus/selection visuals do not create facts, measurements, placement records, nets, or electrical proof.
- Visual traces remain visual-only and are never promoted to measured nets.
- Component/pin selection does not confirm identity, package, pin mapping, coordinates, nets, or fault evidence.
- BenchBeep Home launcher remains preserved.
- `Open existing` remains preserved.
- `Import project` remains preserved.
- Back/Home returns to BenchBeep Home, not the legacy start screen.
- Menu System behavior remains preserved.
- Add Component catalog, builder, ghost, click-to-place, and drag-to-place behavior remain preserved.

## Explicitly forbidden in this scope-lock pass

- Runtime/test edits.
- Integrated measurement panel runtime implementation.
- Measure Sheet UI changes.
- Board Canvas runtime changes.
- Save/write behavior.
- Canonical event/fact writes.
- Schema, writer, validator, materializer, projection, or Project ZIP changes.
- AI/OCR/CV fact creation.
- Placement, coordinate, net, electrical, package, or identity semantics changes.
- Confirm/write/Edit Layout behavior.
- Command menu, context menu, audio/save beep, full redesign, or canvas token migration.
- Dependency on `_incoming`, screenshots, docs/sources, mockups, or source indexes as runtime truth.

## Boundary

- This lock authorizes only docs-only scope-lock edits listed above.
- It records protected future intent and boundaries without arming implementation.
- It does not authorize product behavior changes, write flows, Add Component write behavior, or protected data/write surfaces.
- It does not mark any future implementation accepted/pushed.
- `_incoming`, screenshots, docs/sources, and mockups remain design/reference input only, never runtime truth.
- No untracked scratch files are touched or staged.

## Route

- Current pass: `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`
- Route after accepted/pushed: `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Required validation

```powershell
git status --short --branch
git diff --name-status
git diff --cached --name-status
git diff --check
```
