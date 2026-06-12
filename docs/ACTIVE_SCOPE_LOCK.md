# Active Scope Lock

## Current pass

`V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS`

## Type

`DOCS_SYNC / DIAGNOSIS_CAPTURE`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Docs-only read-only capture of a high-confidence Save Measurement sequence root-cause diagnosis from smoke evidence.
No runtime change.

## Next recommended pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS.md`
- `docs/DEFERRED_FEATURES.md` only if needed

## Direction captured in this pass

- Root cause captured: `/project/measurements/new` still routes to legacy `MeasurementRecordScreen`
  and legacy `MeasurementEventWriter` for existing V2 events.
- Existing `events.jsonl` V2 shape remains sequence-less and valid by validator contract.
- Sequence remediation stays out-of-scope in this pass.
- WI-060 marked diagnosis-complete and routed to legacy path retirement scope lock.

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

## Route lock

Current: `V2_SAVE_MEASUREMENT_SEQUENCE_INTEGRITY_DIAGNOSIS_PASS`.
Next: `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS`.
