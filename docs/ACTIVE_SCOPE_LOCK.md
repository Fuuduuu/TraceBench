# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`

## Type

`DOCS_SYNC / QA_RUN`

## Lane

`CODEX / QA_RUN`

## Mode

Record the user-observed manual Windows smoke-test result for the accepted V2 technician workflow UI consolidation. Do not implement fixes.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS.md`

## Run-record scope

- Record user-observed GUI smoke evidence as `FAIL / PARTIAL`.
- Record that screenshots were provided in chat context.
- Record no successful all-flow smoke evidence was obtained.
- Do not claim writer/event boundary PASS, exact append count PASS, idempotency PASS, or artifact boundary PASS.
- Route next to triage.

## Observed smoke findings

- Add Component form semantics are confusing and over-apply generic `Koht → Väärtus → Ühik` labels to component creation.
- Edit Component is blocked because no existing component can be selected or the dropdown appears unusable; Project Overview showed component count `0`.
- Save Measurement fails with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
- Measure Sheet unit selection appears duplicated and save remains disabled or does not work as expected.

## Triage scope to open next

- Add Component form semantics.
- Edit Component empty-state and selection behavior.
- Save Measurement sequence failure and smoke project `events.jsonl` validity.
- Save Measurement unit UI duplication.
- Boundary preservation while investigating.

## Forbidden surfaces for this run-record pass

- `lib/**`
- `test/**`
- `tools/**` except running existing validation commands
- `schemas/**`
- `samples/**`
- `assets/**`
- generated files
- platform files
- tags/releases
- Project ZIP
- Activity Timeline
- Measure Momentum
- Board Canvas write/edit
- Reference Images runtime
- AI/OCR/CV
- Photo Markup
- Repair Map
- Visual Trace Shape Assist
- writer service
- validator/materializer/schema

## Route lock

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`.