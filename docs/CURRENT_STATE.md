# CURRENT_STATE.md

## Current status

- Current pass: `V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `999a766 feat: add V2 event writer service`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- V2 event writer service is implemented, pushed, post-audited `ACCEPT_AS_IS`, and is being closed out by the current docs-only pass.
- Current pass is docs-only closeout; no writer code, tests, runtime, schema, UI, ZIP, asset/sample, generated, platform, tag, or release change is authorized.
- Next recommended pass is a docs-only Save Measurement scope lock: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.
- Do not route directly to Save Measurement implementation.
- Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Writer service accepted state

- Writer service file: `tools/event_writer_service.py`.
- Focused tests: `tests/test_event_writer_service.py`.
- Writer tests passed: 13/13.
- Full validation passed: `py -3 tools\validate_all.py`, 268 tests.
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
- Non-blocking NITs: stale-lock recovery deferred; crash-mid-append partial-line recovery fails closed and is deferred hardening; idempotency fingerprint ignores `event_id`, `created_at`, and `confirmation.confirmed_at` for retry tolerance.

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
- Accepted writer service implementation: `V2_EVENT_WRITER_SERVICE_PASS`.
- Current writer service closeout: `V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS`.
- Future work must remain staged: Save Measurement scope lock, then separately audited implementation if accepted.

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
