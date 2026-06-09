# CURRENT_STATE.md

## Current status

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_PASS`
- Branch: `main`
- Latest accepted scope-lock commit: `004d2cc docs: lock V2 add component scope`
- Latest accepted implementation commit: `16eca52 fix: harden save measurement project path handling`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_ADD_COMPONENT_SCOPE_LOCK_PASS` is accepted, post-audited, pushed, and ready to close out.
- Post-audit verdict: `ACCEPT_AS_IS`; `safe_to_commit: YES`.
- Future Add Component implementation is now the next route, but only through `V2_ADD_COMPONENT_PASS`.
- Future Add Component creates only `component_created` through the accepted writer-service adapter; UI must never append directly to `events.jsonl`.
- Human confirmation is required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hints/context only and must not auto-confirm component identity.
- Do not route to Edit Component, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas writes, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, or Visual Trace Shape Assist.

## Accepted Save Measurement state

- Save Measurement implementation and path/project-directory hardening are accepted, pushed, and closed out.
- Save Measurement remains `measurement_recorded` only.
- Accepted writer-service boundary remains responsible for validation-before-append, lock handling, idempotency, durable append, and readback.
- Deterministic `clientOperationId` remains unchanged unless separately scoped.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- No automatic identity confirmation, diagnosis/probability/confidence/fault ranking, net inference, or automatic second event.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep full implementation/audit detail in audit/spec docs only.

## Next recommended pass

`V2_ADD_COMPONENT_PASS`