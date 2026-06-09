# CURRENT_STATE.md

## Current status

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted implementation commit: `16eca52 fix: harden save measurement project path handling`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- Save Measurement implementation and path/project-directory hardening are accepted, pushed, and closed out.
- Current pass is a docs-only scope lock for future Add Component; no implementation starts here.
- Future Add Component implementation must create only `component_created` through the accepted writer-service adapter; UI must never append directly to `events.jsonl`.
- Future events must preserve `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- AI/helper/reference/photo/vector/template/candidate context must not auto-confirm component identity; `template_id` / footprint / package family remains geometry or visual hint only.
- Save Measurement accepted behavior remains unchanged; Edit Component, Project ZIP, Activity Timeline, Measure Momentum, Board Canvas writes, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, and Visual Trace Shape Assist stay out of scope.
## Accepted Save Measurement state

- Event construction preserves `schema_version = 2.0-draft`, `actor.type = human`, `source.type = explicit_user_confirmation`, `confirmation.confirmed = true`, and `value_provenance`.
- Helper/reference/candidate values do not auto-fill the measured field.
- One-tap promotion remains forbidden.
- Error states distinguish not-saved outcomes.
- Existing idempotent writer results do not duplicate local `ProjectState.events`.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- No Add/Edit Component implementation, Project ZIP change, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, diagnosis/probability/confidence/fault ranking, net inference, component identity confirmation, automatic second event, or deterministic `clientOperationId` change.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full implementation/audit/security-triage detail in audit/spec docs only.

## Next recommended pass

`V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`
