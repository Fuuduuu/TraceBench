# CURRENT_STATE.md

## Current status

- Current pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted commit before this implementation: `37cc386 docs: close out save measurement path canonicalization scope`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_SAVE_MEASUREMENT_PASS` is implemented, audited, accepted, pushed, and closed out.
- `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS` is accepted, pushed, and post-audited `ACCEPT_AS_IS` with `safe_to_commit: YES`.
- Save Measurement remains the first accepted V2 UI write-flow and creates only `measurement_recorded` through the accepted writer service adapter.
- Gemini TRC-01 is accepted as MEDIUM hardening input around `V2SaveMeasurementService` / `_joinPath`.
- Current pass implements only Save Measurement path/project-directory canonicalization hardening under the accepted scope lock.
- The implementation must fail closed for unsafe or non-canonical project paths, prevent `events.jsonl` escape outside the selected local project, and preserve accepted writer-service boundaries.
- TRC-03 remains excluded: deterministic `clientOperationId` is tied to idempotent retry / duplicate prevention semantics and must not be blindly changed to UUID/ULID/random IDs in this route.
- Add Component remains deferred until after Save Measurement path-canonicalization hardening is implemented, audited, and closed out.

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

`V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_POST_AUDIT_PASS`
