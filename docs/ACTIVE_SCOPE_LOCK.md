# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK

## Goal

Close out the Add Component Workbench interaction scope lock as an accepted docs-only audit step before implementation planning.

## Baseline

- Current route before this lock: `NEEDS_USER_DECISION`.
- Measurement overlay track is accepted and closed through manual smoke.
- Accepted overlay implementation: `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Measurement overlay manual smoke record: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS` (`PASS_WITH_NIT`).
- Add Component remains deferred/protected.
- Add Component product-boundary decisions were captured in:
  - `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`
  - `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`
- User-provided design input files:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`
- GPT Pro review verdict: `READY_FOR_DOCS_CAPTURE`.

## Status labels to record

- `ROUTE_EFFECT: FLOW_SCOPE_LOCK`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

Lock the Add Component interaction surface with deferred runtime semantics:

- Entry point: `Board Canvas` rail first; Project Overview Add Component deep-link remains deferred.
- First geometry model: rectangular-perimeter visual contact layout; side intent `top`, `right`, `bottom`, `left`.
- Terminology: `visual contact`, `contact marker`, `template family` only; avoid canonical pin/pad/electrical-identity wording.
- Starter taxonomy: geometry-first reduced set.
- Rotation: `90`-degree steps in phase one; arbitrary `0-360` rotation deferred.
- Interaction conflict: Add Component ghost/placement mode and measurement-overlay controls remain mutually exclusive or explicitly disarmed on switch.
- Template list, builder, ghost, and rotation draft are local/UI-only for this scope.
- Confirm payload boundary unresolved and remains deferred.
- Edit Layout is a separate protected future track.

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

- Runtime implementation files.
- Widget, unit, integration, or golden tests.
- `_incoming` design artifact edits.
- `docs/PROJECT_MEMORY.md` accepted architecture updates.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, or canonical routing semantics.
- Canonical footprint, pin, pad, contact, net, measurement, board-side, rotation, designator, or Confirm payload semantics.
- Project Overview rewiring.
- Measure Sheet behavior changes.
- Direct implementation route selection.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_POST_AUDIT_PASS`.
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

Stop and report if this pass needs runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, Project Overview rewiring, Measure Sheet, `_incoming`, or accepted-architecture changes.
