# Active Scope Lock

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`

## Type

`DOCS_TRIAGE / ROUTE_DECISION`

## Lane

`CODEX / DOCS_TRIAGE`

## Mode

Record triage for the failed/partial V2 Technician Workflow UI Consolidation smoke run and route away from immediate fixes toward technician-first visual UI redesign capture/review.

Do not implement fixes in this pass.

## Next recommended pass

`V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md` only if needed
- `docs/PROJECT_MEMORY.md` only if needed as a compact durable product pointer
- `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS.md`

## Triage scope

- Record the manual smoke result as `FAIL / PARTIAL`.
- Record the known smoke issues without claiming boundary PASS.
- Record the user's broader technician-first UI redesign direction as product/design input, not implementation permission.
- Record that the standalone visual design HTML artifact exists outside the repo and should be captured from user-provided content in the next route.
- Route to visual redesign capture/review before any small bugfix implementation.

## Failed smoke issues to preserve

- Add Component labels are semantically confusing and over-apply generic `Koht -> Väärtus -> Ühik` labels to component creation.
- Edit Component opens but cannot be used when no components exist; the selector appears dead instead of showing a clear empty state.
- Save Measurement fails with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
- Measure Sheet unit selection is duplicated/confusing.
- Boundary checks cannot be claimed PASS for this run.

## User design direction to preserve

- Project Overview should be PCB-first and visually clean, with components as main anchors rather than a long global action list.
- Component click/tap should open local actions; measurement should be contextual and not permanently noisy.
- Component map defaults sparse; confirmed labels/markings and filters reveal more detail when useful.
- Future manual component drawing/design may include shape, pins/legs, footprint, and optional height.
- Future onboarding may include outline/body contour setup from phone photo plus marker/reference scale, with manual drawing available.
- Future photo-grid decomposition may combine overview and close-up images by board/item grid cell.
- Future AI may assemble drafts and unconfirmed markers only; humans must confirm or deny before anything becomes canonical.

## Visual design artifact status

A standalone visual design artifact exists in chat context: `TraceBench UI Redesign - Visual Design Pass (standalone).html`.

If Codex cannot access the artifact directly, the next pass should capture it from user-provided content. If capture is not possible, route to a fresh visual design pass.

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

Current: `V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`.
Next: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS`.
