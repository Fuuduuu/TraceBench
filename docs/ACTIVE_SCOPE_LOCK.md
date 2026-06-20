# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`

## Type

CODEX / DOCS_MANUAL_QA_RECORD

## Goal

Record user-provided manual visual smoke evidence for the accepted read-only Workbench measurement overlay implementation and route onward.

## Baseline

- Accepted implementation commit: `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- Previous closeout route: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS` accepted/pushed as `300d2c2` (`docs: record workbench measurement overlay impl post-audit`).
- Claude Code implementation audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.
- Current route: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`.
- Next route: `NEEDS_USER_DECISION`.

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS.md`

## Forbidden files / surfaces

- Runtime implementation files.
- Widget or unit tests.
- Schema, writer, materializer, validator, projection, Project ZIP, event, fact, routing, or protected-surface semantics.
- Measurement authoring/value/unit/Save paths.
- Canonical visibility events or persisted overlay visibility state.
- Add Component implementation or activation.

## Manual smoke evidence to record

Result: `PASS_WITH_NIT`.

Observed evidence:

- Board Canvas opens.
- Measurement overlay control is visible.
- Global Show All / Hide All works visually.
- Measurement badge appears near the component.
- Badge displays one value + unit: `0.1 ohm`.
- Selected component inspector opens/updates.
- `renderer writes: none` remains visible.
- Measure Sheet remains available.
- Board Canvas overlay flow does not activate Add Component.
- Add Component remains deferred for Board Canvas / overlay work.

Nit:

- Project Overview still shows an existing Add Component action.
- This is non-blocking because this overlay pass did not implement or activate Add Component inside Board Canvas / Workbench overlay flow.
- Add Component remains a separate protected future track.

## Boundary confirmations

- Read-only overlay remains accepted.
- `renderer writes: none` remains preserved.
- Measure Sheet remains unchanged.
- No value/unit/Save/authoring was introduced.
- No canonical visibility events were introduced.
- Add Component remains deferred.
- No schema/writer/materializer/validator/projection/Project ZIP/event/fact changes are allowed in this pass.

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

Stop and report if any runtime/code/test/protected-surface change is required or if manual smoke recording cannot remain docs-only.