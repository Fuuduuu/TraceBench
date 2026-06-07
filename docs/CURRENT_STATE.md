# CURRENT_STATE.md

## Current status

- Current pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `18867c3 docs: close out V2 materializer projection`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- Current pass is a docs-only scope lock for the future event writer service.
- No writer service code, append/write logic, tests, schema, validator, materializer, UI, ZIP, runtime, assets, samples, platform folders, tags, or releases are authorized by this pass.
- Future implementation pass is `V2_EVENT_WRITER_SERVICE_PASS`, but it remains blocked until this scope lock is post-audited.
- Next recommended pass is independent Claude Code / Opus post-audit: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`.
- Do not route directly to writer implementation, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Writer service scope-lock summary

- Future writer service must bind to `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`, accepted validator behavior in `tools/validate_events_jsonl.py`, and accepted materializer behavior in `tools/materialize_known_facts.py`.
- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache and must not be directly edited as truth.
- Writer must append only; it must not edit, delete, reorder, or rewrite existing events.
- Writer must validate candidate V2 events with the existing validator before append.
- Writer accepts only explicit human-confirmed events: `actor.type == human`, `source.type == explicit_user_confirmation`, and `confirmation.confirmed == true`.
- AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage must not author events.
- `client_operation_id` is the idempotency key; duplicate equivalent operations must not duplicate events, and same key with different payload must reject as conflict.
- Future writer pass must enforce a project write lock or single-writer guard before any UI write ships.
- Crash-safety must cover validate, lock, durable append, readback verification, release, and projection refresh only if explicitly scoped.
- Writer must not generate `board_graph.json` or `view_state.json`.

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
- Accepted materializer projection closeout: `V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS`.
- Current writer service scope lock: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`.
- Future work must remain staged: writer service scope-lock audit, writer service implementation, writer audit, then UI write flows.

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

`V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`
