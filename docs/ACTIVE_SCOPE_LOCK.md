# Active Scope Lock

## Current pass

`V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`

## Type

CODEX / DOCS_DESIGN_INPUT_CAPTURE

## Goal

Capture the Add Component Footprint Builder design artifacts as design-input-only / gap evidence without accepting runtime behavior, architecture, canonical semantics, writer payloads, or implementation routing.

## Baseline

- Current route before this decision track: `NEEDS_USER_DECISION`.
- Measurement overlay track is accepted and closed through manual smoke.
- Accepted overlay implementation: `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Manual smoke record: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`, result `PASS_WITH_NIT`.
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
- `ROUTE_EFFECT: GAP_CAPTURE_ONLY`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS.md`

## Reference-only files

- `_incoming/ui_redesign/Components/Add Component Footprint Builder - Design Review.html`
- `_incoming/ui_redesign/Components/builder.css`

These files may be read as design input only. They must not be edited, staged, or treated as runtime source.

## Capture scope

Record the design direction only:

- Add Component as future protected Workbench flow.
- Geometry-first template/list direction.
- Per-side visual contact builder: top/right/bottom/left.
- Local ghost preview before Confirm.
- Rotation intent remains local until separately scoped.
- Confirm and Edit Layout are protected future writer tracks.
- Board Canvas rail should be first entry point.
- Project Overview entry should not be rewired yet.
- Measure Sheet remains unchanged.

## Pro review constraints

- Do not accept the artifact's internal V4 pass ID as repo pass ID.
- Do not treat HTML/CSS as runtime source.
- Do not update `PROJECT_MEMORY.md` as accepted architecture yet.
- Do not accept canonical footprint/pin/pad semantics.
- Do not accept Confirm payload.
- Do not proceed directly to implementation.

## Open product decisions

- visual-contact terminology;
- rectangular-perimeter first model;
- reduced starter taxonomy;
- rotation scope;
- board-side deferral;
- designator policy;
- Confirm payload boundary;
- Edit Layout as separate protected future track.

## Forbidden files / surfaces

- Runtime implementation files.
- Widget, unit, integration, or golden tests.
- `_incoming` design artifact edits.
- `docs/PROJECT_MEMORY.md` accepted architecture updates.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, or canonical routing semantics.
- Canonical footprint, pin, pad, contact, net, measurement, board-side, rotation, designator, or Confirm payload semantics.
- Project Overview rewiring.
- Measure Sheet changes.
- Direct implementation route selection.

## Route

- Current pass: `V2_WORKBENCH_ADD_COMPONENT_DESIGN_GAP_CAPTURE_PASS`.
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

Stop and report if capture requires runtime, schema, writer, materializer, validator, projection, Project ZIP, event, fact, Project Overview rewiring, Measure Sheet, `_incoming`, or accepted-architecture changes.