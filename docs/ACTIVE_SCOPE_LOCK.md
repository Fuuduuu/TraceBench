# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS`

## Type

`DOCS_SYNC / QA_PLAN`

## Lane

`CODEX / DOCS_SYNC`

## Mode

Create a docs-only manual Windows smoke-test plan for the accepted V2 technician workflow UI consolidation. Do not execute the smoke test in this pass.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_POST_AUDIT_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS.md`

## Plan scope

- Create a manual Windows smoke-test plan for Save Measurement, Add Component, and Edit Component.
- Use the real local app, real Python writer, real project folder, and real `events.jsonl` during the later run pass.
- Cover success, failure, idempotent resubmit, stale-projection, technical details, forbidden wording, narrow layout, and boundary checks.
- Record expected evidence to paste into the later smoke run pass.
- Keep the run blocked until the plan is post-audited and committed.

## Accepted UI consolidation baseline

- Save Measurement, Add Component, and Edit Component visible workflows were consolidated.
- Technician-first flow remains `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`.
- Success messages are shorter and clearer: `Salvestatud.`, `Lisatud.`, `Muudetud.`.
- Stale-projection messages are more consistent.
- Writer/event technical details are behind progressive disclosure.
- Hints/candidates/templates/photos/AI context remain visually subordinate and non-canonical.

## Boundary preservation

- Writer adapters unchanged.
- Event construction semantics unchanged.
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

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_POST_AUDIT_PASS`.