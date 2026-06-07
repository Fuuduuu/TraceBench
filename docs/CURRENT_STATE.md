# CURRENT_STATE.md

## Current status

- Current pass: `V2_EVENT_WRITER_SERVICE_PASS`
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `f3669d9 docs: close out V2 event writer service scope`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- V2 event writer service scope lock is accepted, pushed, post-audited, and closed out.
- Current pass implements the narrow writer service only.
- No Flutter UI, Save/Add/Edit UI, Project ZIP, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, platform folders, generated artifacts, tags, or releases are authorized.
- Validator and materializer behavior must remain unchanged.
- Next recommended pass is independent Claude Code / Opus post-audit: `V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`.
- Do not route to UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Writer service implementation summary

- Writer service file: `tools/event_writer_service.py`.
- Focused tests: `tests/test_event_writer_service.py`.
- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache and is not edited by the writer.
- Writer appends only; prior event lines are not edited, deleted, reordered, or rewritten.
- Candidate streams are validated with existing `tools/validate_events_jsonl.py` before append and again under the writer lock.
- `client_operation_id` is the idempotency key.
- Equivalent retry returns the existing event and appends nothing.
- Same operation ID with different operation payload rejects as conflict.
- Writer uses an atomic `events.jsonl.lock` file as the project write lock.
- Append uses durable binary append, `flush`, `fsync`, and readback verification.
- Writer does not generate `board_graph.json`, `view_state.json`, or `known_facts.json`.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- The read-only technician layer is accepted through manual smoke.
- Measure Sheet remains read-only in V1.1: Reference Values Panel and Guided Measurement Helper are display/helper surfaces only.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.
- Sourced/reference/research/candidate/note values remain non-canonical and must not look measured.

## V2 architecture state

- Accepted architecture scope-lock record: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS`.
- Accepted schema/spec doc pass: `V2_EVENT_SCHEMA_SPEC_PASS`.
- Accepted validator implementation: `V2_VALIDATOR_EXTENSION_PASS`.
- Accepted materializer projection implementation: `V2_MATERIALIZER_PROJECTION_PASS`.
- Accepted writer service scope lock: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`.
- Current writer service implementation: `V2_EVENT_WRITER_SERVICE_PASS`.
- Future work must remain staged: writer post-audit, then separately scoped UI write flows.

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

`V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`
