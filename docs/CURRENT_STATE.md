# Current State

## Current pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_CLOSEOUT_PASS`

## Next recommended pass

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_IMPL_PASS`

## Latest accepted route

`V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS` recorded as `ACCEPT_AS_IS` with recheck `safe_to_commit: YES`.

Observed failures remaining for context:

- Save Measurement can still fail through the legacy `/project/measurements/new` flow.
- Root cause remains that stale legacy route path can still hit legacy `MeasurementEventWriter` in V2 projects.
- WI-060 sequence-integrity diagnosis is complete; fix scope is routed to legacy write-path retirement.
- Add Component framing and Save Measurement unit duplication remain out-of-scope of this pass.
- Boundary checks for this pass are closeout-scoping checks only.

## Visual design capture status

Captured visual redesign from:

`_incoming/ui_redesign/TraceBench_UI_Redesign_Visual_Design_Pass_standalone.html`

Capture status:

- source available locally
- content captured as markdown in `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS.md`
- raw standalone HTML artifact is not committed as runtime/source code or source-of-truth data asset.

Directional points recorded:

- PCB-first Project Overview.
- Add / Edit / Save shells are independent and locality-scoped.
- Save Measurement uses single unit input (`chips + Muu ühik`).
- Edit supports existing-component selector and visible empty-state path.
- Candidate/reference/context fields are visual hints, not canonical evidence.
- Runtime write and sequence remediation remain out-of-scope and explicitly deferred.

## Boundaries confirmed

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI is not a source of canonical truth.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- Template/footprint/photo/candidate/helper context remains hint/context only.
- No runtime/test/writer/schema/materializer/validator/Project ZIP/Board Canvas write/edit/Reference Images runtime/AI/OCR/CV/photo-markup/repair-map/visual-trace-shape-assist changes in this pass.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Smoke-test run audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS.md`
- Smoke-test triage audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS.md`
- Visual capture audit: `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS.md`
- Legacy write-path retirement scope lock: `docs/audit/V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_SCOPE_LOCK_PASS.md`
