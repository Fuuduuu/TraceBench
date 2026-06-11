# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS`

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_POST_AUDIT_PASS`

## Latest accepted route

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` is implemented, post-audited, accepted, committed, pushed, and closed out.

`V2_POST_UI_CONSOLIDATION_ROUTE_REVIEW_PASS` selected a manual Windows smoke-test plan before any cleanup or new feature track.

The three core V2 UI write flows remain accepted and pushed:

- Save Measurement -> `measurement_recorded`;
- Add Component -> `component_created`;
- Edit Component -> `component_updated`.

## Smoke-test plan scope

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS` creates a docs-only manual Windows smoke checklist for the accepted UI consolidation.

The future run must exercise the real local app, real Python writer, real project folder, and real `events.jsonl`.

The plan covers:

- reaching Save Measurement, Add Component, and Edit Component from Project Overview;
- technician-first copy: `Koht → Väärtus → Ühik → Salvesta / Lisa / Muuda`;
- disabled actions until required human input/confirmation exists;
- success copy: `Salvestatud.`, `Lisatud.`, `Muudetud.`;
- exactly one appended event of the expected type per valid submit;
- human actor, explicit user confirmation source, and confirmed confirmation fields;
- stale-projection message, idempotent resubmit, technical details disclosure, failure path, narrow layout, forbidden wording, and boundary checks.

This pass does not execute the smoke test.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- Writer adapters remain unchanged.
- Save/Add/Edit event construction semantics remain unchanged.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- Flutter does not append directly to `events.jsonl`; the accepted writer service remains the write boundary.
- No runtime, test, tool, validator, materializer, schema, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Implementation audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS.md`
- Implementation closeout audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_CLOSEOUT_PASS.md`
- Smoke-test plan audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS.md`