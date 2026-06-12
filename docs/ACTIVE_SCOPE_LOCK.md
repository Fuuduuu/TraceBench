# Active Scope Lock

## Current pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`

## Type

`DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Docs-only scope lock for retiring stale legacy measurement write-path compatibility gaps.
No runtime or schema/validator/materializer/write changes in this pass.

## Next recommended pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`

## Direction captured in this pass

- Root cause locked: stale legacy write route still exists:
  `/project/measurements/new` -> `MeasurementRecordScreen` -> `MeasurementEventWriter`.
- V2 write path remains accepted:
  `/project/measure-sheet` -> `MeasureSheetScreen` -> `V2SaveMeasurementWriter`.
- Scope lock is restricted to legacy V1 write-path retirement (routing/retirement isolation) only.
- Adding `sequence` to V2 events is explicitly out of scope; V2 event shape remains accepted.
- WI-060 stays diagnosis-complete until implementation lands and pass closes.

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tools/**` except running existing validation commands
- `schemas/**`
- `samples/**`
- `assets/**`
- generated files
- platform files
- tags/releases
- writer service
- validator/materializer/schema
- Project ZIP
- Activity Timeline
- Measure Momentum
- Board Canvas write/edit
- Reference Images runtime
- AI/OCR/CV
- Photo Markup
- Repair Map
- Visual Trace Shape Assist
- event envelope semantics
- evidence status lifecycle
- `valid_from_event_id` / `valid_until_event_id`
- repair action semantics
- `stale_after_repair`
- conflict workflow
- `not_populated`
- `forbidden_ai_actions`
- project ZIP self-contained contract
- add component flow redesign
- unit selector redesign
- PCB-first Project Overview redesign
- Add Component domain-form rewrite
- Save Measurement unit interaction redesign

## Route lock

Current: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
Next: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_POST_AUDIT_PASS`.
