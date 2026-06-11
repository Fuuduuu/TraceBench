# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_CLOSEOUT_PASS`

## Type

`docs-closeout`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only closeout for the accepted/pushed technician-first UI consolidation scope lock. Do not implement UI changes in this pass.

## Next recommended pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_CLOSEOUT_PASS.md`

## Closeout scope

- Record `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_PASS` as accepted, post-audited, committed, and pushed.
- Record post-audit verdict `ACCEPT_AS_IS` and `safe_to_commit: YES`.
- Preserve locked future implementation scope for Save/Add/Edit UI consolidation only.
- Carry post-audit LOW findings into the implementation handoff.
- Route next to `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`.

## Locked future implementation may touch

- Minimal Measure Sheet / component flow UI files required for visual/workflow consolidation.
- Shared UI widgets/components if already in the project or minimally introduced.
- Focused widget tests for Save/Add/Edit UI behavior and layout states.
- Governance/audit docs.

## Locked future implementation must not touch

- Event writer service behavior.
- Save Measurement / Add Component / Edit Component event construction semantics.
- Validator/materializer/schema.
- Project ZIP.
- Activity Timeline.
- Measure Momentum.
- Board Canvas write/edit.
- Reference Images runtime.
- AI/OCR/CV.
- Photo Markup / Repair Map / Visual Trace Shape Assist.
- Assets/samples/platform/generated/tags/releases.

## Post-audit LOW findings carried forward

- `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` should explicitly list binding sources/specs/files.
- `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS` should pin the validation command sequence.

## Test requirements to lock

- Save/Add/Edit still call the writer exactly as before.
- Event types remain `measurement_recorded`, `component_created`, and `component_updated`.
- Not-saved messages remain clear and consistent.
- Success states remain clear and non-diagnostic.
- Stale-projection state remains visible where relevant.
- Hints remain visually subordinate.
- No forbidden wording: verified/good/correct/detected/probability/diagnosis/fault ranking.
- Empty states guide the user without creating facts.
- Narrow layout remains usable.
- No Project ZIP / Board Canvas / Reference Images / AI write path appears.

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

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SCOPE_LOCK_CLOSEOUT_PASS`.
Next: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_IMPL_PASS`.
