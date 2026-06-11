# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_CLOSEOUT_PASS`

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS`

## Latest accepted route

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS` is planned, post-audited, accepted, committed, and pushed.

Post-audit: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_POST_AUDIT_PASS` returned `ACCEPT_AS_IS` with `safe_to_commit: YES`.

Accepted plan commit: `docs: plan V2 technician workflow UI smoke test`.

## Smoke-test plan summary

The accepted plan is docs-only and did not execute the smoke test.

The future RUN pass must exercise:

- real local app;
- real Python writer;
- real disposable project folder;
- real `events.jsonl`.

The plan covers Save Measurement, Add Component, Edit Component, Project Overview navigation, technician-first copy, disabled action states, success copy, idempotent resubmit behavior, `Tehnilised detailid` collapsed/expanded behavior, stale-projection message, failure/not-saved behavior, narrow layout, forbidden wording scan, and boundary checks.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Writer adapters remain unchanged.
- Save/Add/Edit event construction semantics remain unchanged.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- Flutter does not append directly to `events.jsonl`; the accepted writer service remains the write boundary.
- No runtime, test, tool, validator, materializer, schema, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Smoke-test plan audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_PASS.md`
- Smoke-test plan closeout audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_PLAN_CLOSEOUT_PASS.md`