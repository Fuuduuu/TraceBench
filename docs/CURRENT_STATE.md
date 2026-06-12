# Current State

## Current pass

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS`

## Next recommended pass

`V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS`

## Latest accepted route

`V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS` recorded the manual Windows smoke result as `FAIL / PARTIAL` from user-observed GUI evidence. The run found no successful all-flow smoke evidence and did not prove writer/event boundary, idempotency, or artifact-boundary PASS.

This triage route intentionally does not open immediate bugfix implementation. The observed issues expose a broader interaction-model mismatch, and the next safe step is visual redesign capture/review before further Flutter fixes.

## Failed smoke issues recorded

- Add Component labels are semantically confusing because the generic `Koht -> Väärtus -> Ühik` framing over-applies measurement UI to component creation.
- Edit Component opens but cannot be used when no components exist; the existing-component selector appears dead instead of showing a clear empty state.
- Save Measurement accepts values but fails with `MeasurementWriteException: Existing events contain missing or non-integer sequence`.
- Measure Sheet unit UI is duplicated/confusing because unit appears both as dropdown and button/chip selection.
- Boundary checks cannot be claimed PASS from this run.

## Technician-first redesign direction

- Project Overview should become PCB-first: clean board/schematic view, components as main visible anchors, not a long action list.
- Component click/tap should open local actions; measurement should be contextual to the component rather than a permanently noisy global control.
- Component map should default sparse; labels and markings appear only when technician-confirmed, with filters for additional layers.
- Future component drawing/design input may include manually defined shape, pins/legs, basic footprint, and optional height for physically tall parts.
- Future onboarding may start with repair-item outline/body contour setup from phone photo plus marker/reference scale, with manual drawing as an option.
- Future photo-grid decomposition may divide the board/item into grid cells with close photos for better overview plus detail.
- Future AI/photo/component draft features remain unconfirmed drafts only; human confirmation is required before any marker/component becomes canonical.
- Measurement becomes more precise and contextual after components/markers are confirmed.

## Visual design artifact status

A standalone visual design HTML artifact exists in chat context: `TraceBench UI Redesign - Visual Design Pass (standalone).html`.

The artifact is not captured in the repo in this pass. The next route should capture user-provided visual artifact content before any new implementation pass. If the artifact cannot be supplied, the fallback route is a fresh visual design pass.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI does not create canonical facts.
- Photo pixels are not facts.
- AI draft components are not real components until human confirmed.
- `visual_trace` is not a net.
- Component shape, height, footprint, template, photo, helper, candidate, and AI context are not electrical identity.
- Any AI/photo/grid/component-draft feature requires a separate future architecture/scope lock.
- No runtime, test, writer-service, schema, validator, materializer, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, asset/sample, generated artifact, platform, tag, or release work in this triage pass.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Smoke-test run audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_RUN_PASS.md`
- Smoke-test triage audit: `docs/audit/V2_TECHNICIAN_WORKFLOW_UI_CONSOLIDATION_SMOKE_TEST_TRIAGE_PASS.md`
