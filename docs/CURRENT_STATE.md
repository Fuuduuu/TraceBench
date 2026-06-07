# CURRENT_STATE.md

## Current status

- Current pass: `V2_VALIDATOR_EXTENSION_CLOSEOUT_PASS`
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `7e7c84c feat: add V2 event validator support`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_VALIDATOR_EXTENSION_PASS` is accepted/pushed.
- User committed and pushed the validator implementation as `feat: add V2 event validator support`.
- Claude Code / Opus post-audit accepted `V2_VALIDATOR_EXTENSION_PASS` as `ACCEPT_AS_IS`; `safe_to_commit: YES`; no blocker/high/medium findings.
- The accepted implementation added V2 support in `tools/validate_events_jsonl.py` and focused tests in `tests/test_validate_events_jsonl.py`.
- Validator support covers V2 schema version `2.0-draft`, accepted canonical event types, unsafe alias/source/provenance/prohibited-field rejection, detectable relation-cycle rejection, and V1/V1.1 legacy compatibility.
- Validation passed: focused V2 validator tests 11/11, full `validate_events_jsonl` tests 114/114, and `py -3 tools\validate_all.py` PASS with 247 tests.
- Next route is `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`, docs-only scope lock for materializer projection from V2 events into `known_facts.json`.
- Do not route directly to materializer implementation, writer service, UI writes, Save/Add/Edit, Project ZIP changes, Activity Timeline, or Measure Momentum.

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
- Accepted validator implementation post-audit: `V2_VALIDATOR_EXTENSION_POST_AUDIT_PASS` (`ACCEPT_AS_IS`).
- Current validator closeout: `V2_VALIDATOR_EXTENSION_CLOSEOUT_PASS`.
- Future work must remain staged: materializer scope lock, materializer implementation, materializer audit, writer service, writer audit, then UI write flows.

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

`V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`
