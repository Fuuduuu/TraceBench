# CURRENT_STATE.md

## Current status

- Current pass: `TRACEBENCH_MEMORY_SCOPE_DOCS_DEDUP_CLEANUP_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted V2 backend commit before this pass: `a2e3787 feat: add V2 event writer service`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- V2 event writer service is implemented, pushed, post-audited `ACCEPT_AS_IS`, and closed out in route state.
- Current pass is docs-only memory/scope cleanup before the first V2 UI write-flow scope lock.
- No runtime code, Flutter UI, tests, schema, validator, materializer, writer service, ZIP, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL/source search, asset/sample, generated, platform, tag, or release change is authorized.
- Next recommended pass returns to docs-only Save Measurement scope lock: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.
- Do not route directly to Save Measurement implementation.
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
- UI write flows remain blocked until separately scoped and audited.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- The read-only technician layer is accepted through manual smoke.
- Measure Sheet remains read-only in V1.1: Reference Values Panel and Guided Measurement Helper are display/helper surfaces only.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.
- Sourced/reference/research/candidate/note values remain non-canonical and must not look measured.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- AI/helper may suggest, organize, and surface gaps only.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full architecture/spec/detail in audit/spec docs only.

## Next recommended pass

`V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`
