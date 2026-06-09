# CURRENT_STATE.md

## Current status

- Current pass: `V2_SAVE_MEASUREMENT_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this closeout: `f0cba24 feat: add V2 save measurement flow`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_SAVE_MEASUREMENT_PASS` is implemented, audited, accepted, committed, and pushed.
- GPT Pro substitute post-audit recheck returned `ACCEPT_AS_IS` with `safe_to_commit: YES` after the small patch.
- The small patch fixed both prior HIGH findings: Save Measurement hard-codes `event_type = measurement_recorded`, and existing idempotent writer results no longer duplicate local `ProjectState.events`.
- Save Measurement is the first accepted V2 UI write-flow.
- Save Measurement creates only `measurement_recorded` through the accepted writer service adapter.
- UI never appends directly to `events.jsonl`.
- Writer service remains responsible for validation-before-append, lock handling, idempotency, durable append, and readback.
- Final validation recorded for implementation context: focused Flutter tests PASS (`24`), full Flutter suite PASS (`220`), `py -3 tools\validate_all.py` PASS (`268`), changed-file Dart analyze PASS, and full analyzer residuals only in known pre-existing baseline issues outside changed files.
- Next recommended pass is `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`; Add Component is a protected write surface and must start with scope lock, not implementation.

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
- No Add/Edit Component opened in this closeout.
- No Project ZIP changes, Activity Timeline, Measure Momentum, Photo Markup, Repair Map, Visual Trace Shape Assist, diagnosis/probability/confidence/fault ranking, net inference, component identity confirmation, or automatic second event.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full implementation/audit detail in audit/spec docs only.

## Next recommended pass

`V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
