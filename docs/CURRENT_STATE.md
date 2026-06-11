# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`

## Latest accepted route

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS` is planned, post-audited, accepted, committed, pushed, and closed out.

The manual Windows smoke run was observed by the user and is recorded as `FAIL / PARTIAL`; screenshots were provided in chat context. The correct next route is triage, not closeout.

## Smoke evidence summary

Observed issues:

- Add Component form labels are semantically confusing and over-apply `Koht → Väärtus → Ühik` to component creation.
- Edit Component screen opens, but the existing component dropdown cannot be used; Project Overview showed component counts as `0`; no edit could be saved.
- Save Measurement accepts entered values but save fails with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
- Measure Sheet shows duplicated unit selection affordances and save remains disabled or does not work as expected.

Do not claim PASS for writer/event boundary, exact append count, idempotency, or artifact boundary checks from this run.

## Triage targets

- Add Component form semantics: component type, numeric value, unit, marking text, rail/function/belongs-to, and comment distinctions.
- Edit Component empty-state/selection: distinguish no existing components from broken dropdown; preserve existing-component-only boundary.
- Save Measurement sequence failure: inspect smoke project `events.jsonl` and determine setup/data versus app/project-init/writer compatibility issue.
- Save Measurement unit UI: decide whether dropdown, unit buttons, or both should exist.
- Preserve canonical write boundaries while triaging.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Writer adapters remain unchanged in this run-record pass.
- Save/Add/Edit event construction semantics remain unchanged in this run-record pass.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- No runtime, test, tool, validator, materializer, schema, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Smoke-test plan audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS.md`
- Smoke-test run audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS.md`