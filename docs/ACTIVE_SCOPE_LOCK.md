# Active Scope Lock

## Current pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS`

## Type

`CODEX / DOCS_SYNC_CLOSEOUT`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only confirmation pass that records accepted and pushed route-remediation
runtime implementation, verifies post-audit closure, and releases the active
implementation scope lock.

## Next recommended pass

`NEEDS_USER_DECISION`

## Write allowlist for this pass

- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS.md`

## Closeout direction

Confirm and lock the accepted runtime behavior of:

- `/project/measurements/new` compatibility redirect to `/project/measure-sheet`.
- Project Overview `Lisa mõõtmine` route to `/project/measure-sheet`.
- Legacy `MeasurementRecordScreen` is not part of normal Overview measurement flow.

## Forbidden surfaces

- `docs/AUDIT_INDEX.md` / `docs/WORK_INTAKE_INDEX.md` / `docs/CURRENT_STATE.md` / `docs/PASS_QUEUE.md` updates must match runtime-accepted and routed implementation.
- No additional runtime, test, schema, validator, materializer, writer-service,
  Project ZIP, Board Canvas write/edit, Reference Images runtime, Activity
  Timeline, Measure Momentum, AI/OCR/CV, or dead-code cleanup changes are part
  of this pass.

## Route lock

Current: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_CLOSEOUT_PASS`
Next: `NEEDS_USER_DECISION`
