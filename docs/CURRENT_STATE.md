# CURRENT_STATE.md

## Current status

- Current pass: `V2_SAVE_MEASUREMENT_GEMINI_SECURITY_TRIAGE_PASS`
- Next recommended pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this triage: `e9afa94 docs: close out V2 save measurement flow`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_SAVE_MEASUREMENT_PASS` is implemented, audited, accepted, committed, pushed, and closed out.
- Save Measurement is the first accepted V2 UI write-flow.
- Save Measurement creates only `measurement_recorded` through the accepted writer service adapter.
- UI never appends directly to `events.jsonl`.
- GPT Pro substitute post-audit recheck accepted Save Measurement as `ACCEPT_AS_IS` after the small patch for hard event-type enforcement and idempotent local-event duplicate prevention.
- Gemini external advisory audit returned `SAFE_TO_CONTINUE` and does not invalidate the accepted Save Measurement pass.
- Gemini TRC-01 is recorded as MEDIUM candidate hardening for project-directory/path canonicalization around `V2SaveMeasurementService` / `_joinPath`.
- Gemini TRC-03 is design-sensitive: do not blindly replace deterministic `clientOperationId` with random UUID/ULID until idempotency/retry semantics are reviewed.
- TRC-02 and TRC-04 are recorded as low/info hardening notes, not active vulnerabilities on current evidence.
- Add Component remains the intended next V2 write surface, but it is temporarily behind the Save Measurement path-canonicalization hardening scope lock.

## Accepted Save Measurement state

- Event construction preserves `schema_version = 2.0-draft`, `actor.type = human`, `source.type = explicit_user_confirmation`, `confirmation.confirmed = true`, and `value_provenance`.
- Helper/reference/candidate values do not auto-fill the measured field.
- One-tap promotion remains forbidden.
- Error states distinguish not-saved outcomes.
- Existing idempotent writer results do not duplicate local `ProjectState.events`.
- Board Canvas, Reference Images, Guided Measurement Helper, Reference Values Panel, and Activity Timeline remain read-only/non-writing surfaces.

## V2 backend accepted state

- Schema/spec requirements: `docs/spec/V2_EVENT_SCHEMA_SPEC.md`.
- Validator V2 path: `tools/validate_events_jsonl.py`.
- Materializer V2 projection: `tools/materialize_known_facts.py`.
- Writer service append path: `tools/event_writer_service.py`.
- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache.
- Writer appends only and validates through the existing validator before append and again under lock.
- Writer uses `client_operation_id` idempotency, atomic `events.jsonl.lock`, durable append, `fsync`, and readback verification.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper may suggest, organize, and surface gaps only.
- AI/helper must not create canonical facts or canonical events.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
- No Add/Edit Component implementation, Project ZIP change, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, diagnosis/probability/confidence/fault ranking, net inference, component identity confirmation, or automatic second event.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full implementation/audit/security-triage detail in audit/spec docs only.

## Next recommended pass

`V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_SCOPE_LOCK_PASS`
