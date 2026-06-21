# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_SCOPE_LOCK_POST_AUDIT_PASS`

## Type

CLAUDE_CODE / DOCS_SYNC_CLOSEOUT

## Goal

Record docs-only post-audit closeout for the accepted/pushed Add Component visual-contact builder scope-lock (`61ed41e`).

## Baseline

- Current route before this scope-lock: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_MANUAL_SMOKE_PASS`.
- Add Component template-list scope-lock is accepted/pushed as `26ce000` (`docs: lock add component template-list ui slice scope`) and post-audit as `be752e1` (`docs: record add component template-list scope-lock post-audit`).
- Template-list implementation is accepted/pushed as `bec9583` (`feat(board-canvas): add read-only add component template-list panel`).
- Add Component design-input artifacts remain source-only:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`
- GPT Pro review verdict was `READY_FOR_DOCS_CAPTURE`.
- Add Component product-boundary decisions were captured in:
  - `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`
  - `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`

## Status labels to record

- `ROUTE_EFFECT: SCOPE_LOCK_POST_AUDIT`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_SCOPE_LOCK_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

Right-panel visual-contact builder scope remains UI-local and does not authorize runtime writes.

- Template selection may open a right-panel visual-contact builder state.
- Builder is UI-local/volatile only; no persistence.
- Builder uses rectangular-perimeter layout.
- Builder allows editable side counts:
  - `top`
  - `right`
  - `bottom`
  - `left`
- Live preview is visible in the right panel only.
- Starter template defaults may seed the builder.
- Invalid and empty visual states are UI-only:
  - zero contact markers
  - excessive marker count
  - reset to template defaults
- Template-list behavior remains intact in this lock.
- Wording must remain `visual contact`, `contact marker`, `template family`, and `rectangular-perimeter layout`.
- Do not introduce canonical terms: `pin`, `pad`, `net`, `trace`, `probe`, `electrical identity`.
- Add Component Project Overview entry remains deferred.

## Pro review constraints

- Do not accept the artifact's internal V4 pass ID as repo pass ID.
- Do not treat HTML/CSS as runtime source.
- Do not update `PROJECT_MEMORY.md` as accepted architecture.
- Do not accept canonical footprint/pin/pad/net/trace/probe/electrical semantics.
- Confirm payload remains unresolved and deferred.
- Do not proceed directly to runtime builder implementation.

## Open product decisions

- visual-contact terminology: locked.
- rectangular-perimeter first model: selected.
- geometry-first reduced starter taxonomy: selected.
- editable side-count builder intent: selected.
- builder local volatility: selected.
- Confirm payload: unresolved.
- Add Component deep-link route deferral: selected.
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

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_SCOPE_LOCK_POST_AUDIT_PASS`.
- Next route: `NEEDS_USER_DECISION`.

## Required validation

```powershell
cd C:\Users\Kasutaja\Desktop\TraceBench
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
py -3 tools\validate_all.py
```

## Stop conditions

Stop and report if this pass needs runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, canvas placement/ghost, rotation authoring, Confirm implementation, `Project Overview` rewiring, Measure Sheet changes, `_incoming`, or accepted-architecture changes.
