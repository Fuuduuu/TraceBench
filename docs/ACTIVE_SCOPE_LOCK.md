# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK

## Goal

Create a docs-only implementation-lock for the next Add Component UI slice: right-panel visual-contact builder implementation.

## Baseline

- Current route before this implementation-lock: `NEEDS_USER_DECISION`.
- Add Component visual-contact builder scope-lock is accepted/pushed as `61ed41e` (`docs: lock add component visual-contact builder scope`) and post-audit as `535fe8e` (`docs: record add component visual-contact builder scope-lock post-audit`).
- Add Component template-list implementation is accepted/pushed as `bec9583` (`feat(board-canvas): add read-only add component template-list panel`).
- Add Component design-input artifacts remain source-only:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`
- GPT Pro review verdict was `READY_FOR_DOCS_CAPTURE`.
- Add Component product-boundary decisions were captured in:
  - `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`
  - `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`

## Status labels to record

- `ROUTE_EFFECT: IMPLEMENTATION_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_PASS`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_SCOPE_LOCK_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

The implementation-lock for this pass is docs-only and only narrows allowlist + boundaries:

- Add Component template selection may transition into right-panel visual-contact builder mode.
- Builder state is local volatile widget state for side counts:
  - `top`
  - `right`
  - `bottom`
  - `left`
- Right panel preview is local/volatile UI-only.
- Starter template defaults may seed builder controls.
- Invalid or empty states are UI-only only:
  - zero contact markers
  - excessive marker count
  - reset-to-default behavior
- Existing template-list behavior remains intact.
- Wording remains `visual contact`, `contact marker`, `template family`, and `rectangular-perimeter layout`.
- Do not introduce canonical terms: `pin`, `pad`, `net`, `trace`, `probe`, `electrical identity`.
- Add Component Project Overview entry remains deferred.

## Implementation allowlist

The future implementation pass may touch only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The implementation-boundary lock for this slice remains:

- right-panel visual-contact builder only,
- local volatile widget state only,
- side-count fields only: `top`, `right`, `bottom`, `left`,
- right-panel-only rectangular-perimeter preview,
- no canvas ghost/placement/drag/click-to-place,
- no rotation draft,
- no Confirm/write,
- no persistence,
- no schema/writer/materializer/validator/projection/Project ZIP/event/fact changes,
- no canonical pin/pad/net/trace/probe/electrical semantics.

## Pro review constraints

- Do not accept the artifact's internal V4 pass ID as repo pass ID.
- Do not treat HTML/CSS as runtime source.
- Do not update `PROJECT_MEMORY.md` as accepted architecture.
- Do not accept canonical footprint/pin/pad/net/trace/probe/electrical semantics.
- Confirm payload remains unresolved and deferred.
- Preserve this as implementation-lock-only docs; do not implement runtime in this pass.

## Open product decisions

- visual-contact terminology: locked.
- rectangular-perimeter first model: selected and pre-authorized for implementation.
- geometry-first reduced starter taxonomy: selected and pre-authorized for implementation.
- editable side-count builder intent: pre-authorized for implementation.
- builder local volatility: pre-authorized for implementation.
- Add Component deep-link route deferral: selected.
- Confirm payload: unresolved.
- Edit Layout: separate protected future track.

## Forbidden files / surfaces

- Runtime test/runtime code edits.
- Additional widget/unit/integration/golden test files.
- `_incoming` design artifact edits.
- `docs/PROJECT_MEMORY.md` accepted architecture updates.
- `schema`/writer/materializer/validator/projection/Project ZIP/event/fact or canonical routing edits.
- Canonical footprint, pin, pad, net, trace, probe, or electrical semantics.
- Add Component ghost placement.
- `Add Component` canvas placement, drag-to-place, or confirm flow.
- rotation draft/authoring, Edit Layout runtime flow, or Project Overview deep-link rewiring.
- `Measure Sheet` behavior changes.
- direct runtime implementation route selection.
- canvas placement/ghost/rotation/Confirm/write implementation.
- persistence of builder state.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_SCOPE_LOCK_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_IMPL_PASS`.

## Required validation

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

Stop and report if this pass needs runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, canvas placement/ghost, rotation authoring, Confirm implementation, `Project Overview` rewiring, Measure Sheet changes, `_incoming`, or accepted-architecture changes.
