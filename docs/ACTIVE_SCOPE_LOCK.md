# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK

## Goal

Activate the implementation lock for the accepted first Add Component template-list UI slice and define the narrow runtime/test allowlist.

## Baseline

- Current route before this lock: `NEEDS_USER_DECISION`.
- Measurement overlay track is accepted and closed through manual smoke.
- Add Component template-list scope-lock is accepted/pushed as `be752e1` (`docs: record add component template-list scope-lock post-audit`).
- Add Component remains deferred outside this implementation slice.
- Add Component product-boundary decisions were captured in:
  - `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`
  - `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`
- User-provided design input files:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`
- GPT Pro review verdict: `READY_FOR_DOCS_CAPTURE`.

## Status labels to record

- `ROUTE_EFFECT: IMPLEMENTATION_LOCK`
- `ROUTE_EFFECT_NEXT: V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_POST_AUDIT_PASS`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_SCOPE_LOCK_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_SCOPE_LOCK_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

Activate the first Add Component runtime-toplevel UI slice for implementation pass:

- Entry point: `Board Canvas` rail Add Component action only.
- Right-side contextual panel opens directly in template-list mode.
- Template list, per-template contact-marker rendering previews, and template selection are UI-only local state.
- Selection updates are local-only and remain volatile.
- No runtime/template placement builder, ghost placement mode, rotation draft, or placement confirmation in this pass.
- Geometry model stays rectangular-perimeter visual-contact only, side-wise (`top` / `right` / `bottom` / `left`) intent, and geometry-first reduced starter taxonomy.
- Terminology remains `visual contact`, `contact marker`, `template family`; no canonical pin/pad/electrical identity wording.
- Interaction conflict: this slice must not alter Add Component placement/ghost runtime flow and is local panel-only.
- Confirm payload remains unresolved and deferred.
- Project Overview Add Component deep-link remains deferred.
- Edit Layout stays a separate protected future track.

## Implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Pro review constraints

- Do not accept the artifact's internal V4 pass ID as repo pass ID.
- Do not treat HTML/CSS as runtime source.
- Do not update `PROJECT_MEMORY.md` as accepted architecture.
- Do not accept canonical footprint/pin/pad/net/trace semantics.
- Do not accept Confirm payload.
- Do not proceed directly to implementation.

## Open product decisions

- visual-contact terminology: locked.
- rectangular-perimeter first model: selected.
- reduced starter taxonomy: selected.
- rotation scope: `90`-degree steps first.
- board-side deferral: selected.
- designator policy: deferred.
- Confirm payload boundary: unresolved.
- Edit Layout as separate protected future track: selected.

## Forbidden files / surfaces

- Additional runtime implementation files.
- Additional widget/unit/integration/golden test files.
- `_incoming` design artifact edits.
- `docs/PROJECT_MEMORY.md` accepted architecture updates.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, or canonical routing semantics.
- Canonical footprint, pin, pad, contact, net, measurement, board-side, rotation, designator, or Confirm payload semantics.
- Project Overview rewiring.
- Measure Sheet behavior changes.
- Direct implementation route selection.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_SCOPE_LOCK_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_TEMPLATE_LIST_IMPL_POST_AUDIT_PASS`.

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

Stop and report if this pass needs runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, Project Overview rewiring, Measure Sheet, `_incoming`, or accepted-architecture changes.
