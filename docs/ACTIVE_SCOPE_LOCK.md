# Active Scope Lock

## Current pass

`V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_CLOSEOUT_PASS`

## Type

`CODEX / DOCS_SYNC_CLOSEOUT`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Doc-sync closeout for visual redesign capture. Record the accepted visual capture evidence, route decision, preserved boundaries, and deferred items without changing runtime/write/validator/materializer/surface behavior. No implementation or source mutation in this pass.

## Next recommended pass

`V2_POST_VISUAL_REDESIGN_ROUTE_REVIEW_PASS`

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_CLOSEOUT_PASS.md`
- `docs/DEFERRED_FEATURES.md` only if needed

## Direction captured in this pass

- PCB-first Overview with one status card and ≤4 primary actions.
- Add Component shell removed measurement-triplet framing.
- Edit Component has list-backed selector and explicit empty state.
- Save Measurement uses a single unit control (chips + `Muu ühik`).
- Candidate/reference/hint data is subordinate and non-canonical.
- Honest empty/error/sequence-failure states and technical detail disclosure are preserved as display behavior.

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

Current: `V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_CLOSEOUT_PASS`.
Next: `V2_POST_VISUAL_REDESIGN_ROUTE_REVIEW_PASS`.
