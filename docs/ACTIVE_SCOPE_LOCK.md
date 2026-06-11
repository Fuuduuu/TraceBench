# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_CLOSEOUT_PASS`

## Type

`docs-closeout`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Close out the accepted and pushed V2 technician workflow UI consolidation smoke-test plan. Docs-only; do not execute the smoke test.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_CLOSEOUT_PASS.md`

## Closeout scope

- Record `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS` as planned, post-audited, accepted, committed, and pushed.
- Record post-audit `ACCEPT_AS_IS` and `safe_to_commit: YES`.
- Record that the plan is docs-only and did not execute the smoke test.
- Record that the future RUN pass must use the real local app, real Python writer, real disposable project folder, and real `events.jsonl`.
- Route next to `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`.

## Accepted smoke-plan coverage

- Save Measurement.
- Add Component.
- Edit Component.
- Project Overview navigation.
- Technician-first copy: `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Disabled action states.
- Success copy: `Salvestatud.`, `Lisatud.`, `Muudetud.`.
- Idempotent resubmit behavior.
- `Tehnilised detailid` collapsed/expanded behavior.
- Stale-projection message.
- Failure path / not-saved behavior.
- Narrow layout.
- Forbidden wording scan.
- Boundary checks.

## Boundary preservation

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Writer adapters unchanged.
- Save/Add/Edit event construction semantics unchanged.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- No direct Flutter append to `events.jsonl`.
- No validator/materializer/schema changes.

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tools/**`
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

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_CLOSEOUT_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`.