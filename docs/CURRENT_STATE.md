# CURRENT_STATE.md

## Current status

- Current pass: `V2_SAVE_MEASUREMENT_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted route commit before this pass: `d37f12c docs: close out V2 save measurement scope`
- Latest accepted V2 backend implementation commit: `a2e3787 feat: add V2 event writer service`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- V2 event writer service is implemented, pushed, post-audited `ACCEPT_AS_IS`, closed out, and its closeout artifact is recovered.
- `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS` was accepted/pushed as `docs: lock V2 save measurement scope`.
- Claude Code / Opus post-audit accepted the Save Measurement scope lock as `ACCEPT_AS_IS` with no blocker/high/medium/low findings.
- Current pass implements the first V2 Save Measurement UI write flow under the accepted scope lock.
- Save Measurement writes only `measurement_recorded` through the accepted writer service.
- Next recommended pass is audit-only review: `V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`.
- Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## V2 backend accepted state

- Schema/spec requirements: `docs/spec/V2_EVENT_SCHEMA_SPEC.md`.
- Validator V2 path: `tools/validate_events_jsonl.py`.
- Materializer V2 projection: `tools/materialize_known_facts.py`.
- Writer service append path: `tools/event_writer_service.py`.
- Writer tests passed: 13/13.
- Full validation passed for writer implementation context: `py -3 tools\validate_all.py`, 268 tests.
- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache.
- Writer appends only and validates through the existing validator before append and again under lock.
- Writer uses `client_operation_id` idempotency, atomic `events.jsonl.lock`, durable append, `fsync`, and readback verification.

## Save Measurement implementation state

- `V2_SAVE_MEASUREMENT_PASS` is scoped to Save Measurement UI flow only.
- Save Measurement creates only `measurement_recorded`.
- UI uses the accepted writer service adapter and never appends directly to `events.jsonl`.
- Event construction preserves `schema_version = 2.0-draft`, `actor.type = human`, `source.type = explicit_user_confirmation`, `confirmation.confirmed = true`, and `value_provenance`.
- Helper/reference/candidate values must not auto-fill the confirmable measured field.
- One-tap promotion from helper/reference/candidate value to canonical measurement remains forbidden.
- Error states must distinguish not-saved outcomes.
- Successful save may keep selected `Koht`/context and show confirmation, but must not infer net identity, confirmed pin mapping, component identity, diagnosis, probability, confidence, or fault ranking.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces for this route.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- The read-only technician layer is accepted through manual smoke.
- Measure Sheet read-only/history remains accepted baseline before V2 write-flow implementation.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full architecture/spec/detail in audit/spec docs only.

## Next recommended pass

`V2_SAVE_MEASUREMENT_POST_AUDIT_PASS`
