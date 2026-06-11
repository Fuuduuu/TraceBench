# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_CLOSEOUT_PASS`

## Type

`docs-closeout`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Close out the accepted and pushed V2 technician workflow UI consolidation implementation. Docs-only; record accepted post-audit, validation, route-label reconciliation, carried NIT, and next route review.

## Next recommended pass

`V2_POST_UI_CONSOLIDATION_ROUTE_REVIEW_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_CLOSEOUT_PASS.md`

## Closeout scope

- Record `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` as implemented, post-audited, accepted, committed, and pushed.
- Reconcile the route label `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_POST_AUDIT_PASS` with the chat label `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_POST_AUDIT_PASS` as one logical accepted implementation post-audit.
- Record accepted UI consolidation changes and validation.
- Carry forward the non-blocking duplicated `_TechnicalDetailsTile` extraction NIT.
- Route next to `V2_POST_UI_CONSOLIDATION_ROUTE_REVIEW_PASS`.

## Accepted implementation summary

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
- `events.jsonl`
- `known_facts.json`
- Project ZIP behavior
- Board Canvas runtime
- Reference Images runtime
- writer service behavior
- validator
- materializer
- schema / JSON schema
- AI/OCR/CV
- URL/source search
- Activity Timeline implementation
- Save/Add/Edit event construction semantic changes
- Measure Momentum implementation
- Photo Markup / Repair Map / Visual Trace Shape Assist
- platform/generated files
- tags/releases

## Route lock

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_CLOSEOUT_PASS`.
Next: `V2_POST_UI_CONSOLIDATION_ROUTE_REVIEW_PASS`.