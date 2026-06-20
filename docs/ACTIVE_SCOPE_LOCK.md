# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`

## Type

CODEX / DOCS_PRODUCT_BOUNDARY_DECISION

## Goal

Record product-boundary decisions for Add Component Workbench flow and explicit deferred semantics before flow scope-locking.

## Baseline

- Current route before this decision track: `NEEDS_USER_DECISION`.
- Measurement overlay track is accepted and closed through manual smoke.
- Accepted overlay implementation: `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Measurement overlay manual smoke record: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`, result `PASS_WITH_NIT`.
- Add Component remains deferred/protected.
- User-provided design input files:
  - `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
  - `_incoming/ui_redesign/Components/builder.css`
- GPT Pro review verdict: `READY_FOR_DOCS_CAPTURE`.

## Status labels to record

- `SOURCE_STATUS: DESIGN_INPUT_ONLY`
- `RUNTIME_STATUS: NOT_ACCEPTED`
- `ARCHITECTURE_STATUS: NOT_ACCEPTED`
- `CANONICAL_SEMANTICS: NONE`
- `ROUTE_EFFECT: PRODUCT_BOUNDARY_DECISION`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

Record additive boundary decisions only:

- Terminology: `visual contact`, `contact marker`, `template family`; avoid canonical pin/pad/electrical-identity wording.
- First geometry model: rectangular-perimeter visual contacts, top/right/bottom/left side intent; symbolic visual layout only.
- Starter taxonomy: geometry-first reduced set.
- Entry point: Board Canvas rail first; Project Overview Add Component deep-link deferred.
- Rotation: `90`-degree steps in first scope; arbitrary `0-360` rotation deferred.
- Interaction conflict: Add Component ghost/placement mode and measurement-overlay controls are mutually exclusive or explicitly disarmed on mode switch.
- Confirm boundary: payload remains unresolved; no canonical write accepted in this pass.
- Writer/schema/materializer/validator/projection/event/fact/Project ZIP/authored routing decisions remain deferred.
- Edit Layout is a separate protected future track.

## Pro review constraints

- Do not accept the artifact's internal V4 pass ID as repo pass ID.
- Do not treat HTML/CSS as runtime source.
- Do not update `PROJECT_MEMORY.md` as accepted architecture yet.
- Do not accept canonical footprint/pin/pad/net/trace semantics.
- Do not accept Confirm payload.
- Do not proceed directly to implementation.

## Open product decisions

- visual-contact terminology: set to `visual contact`, `contact marker`, `template family`.
- rectangular-perimeter first model: selected for phase 1.
- reduced starter taxonomy: selected for phase 1.
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

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_PRODUCT_BOUNDARY_DECISION_PASS`.
- Next route: `V2_WORKBENCH_ADD_COMPONENT_FLOW_SCOPE_LOCK_PASS`.

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
