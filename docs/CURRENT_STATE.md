# CURRENT_STATE.md

## Current status

- Current pass: `V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS`
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `85c476b feat: add V2 materializer projection`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_MATERIALIZER_PROJECTION_PASS` was produced by Codex, committed, and pushed as `feat: add V2 materializer projection`.
- Claude Code / Opus post-audit accepted the materializer implementation as `ACCEPT_AS_IS`; `safe_to_commit: YES`; no blocker/high/medium findings.
- Validation passed: focused materializer tests 86/86 and `py -3 tools\validate_all.py` PASS with 255 tests.
- Materializer support was added in `tools/materialize_known_facts.py`.
- Focused tests were added in `tests/test_materialize_known_facts.py`.
- Current pass closes out the accepted implementation without modifying code/tests/runtime.
- Next recommended pass is `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`, a docs-only scope lock for the event writer service.
- Do not route directly to writer implementation, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Materializer accepted behavior

- V2 projection supports `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated`.
- Projection preserves value provenance.
- Component updates preserve history.
- Invalidation preserves history and marks affected projected entries instead of deleting history.
- Supersession marks superseded measurements and keeps the replacement active.
- Divergent unsuperseded measurements surface `measurement_conflicts`; latest-timestamp-wins remains forbidden.
- Component invalidation surfaces `orphaned_measurements`; silent L3 cascade-drop remains forbidden.
- `board_graph.json` and `view_state.json` are not generated.
- V1/V1.1 materialization compatibility is preserved.
- `known_facts.schema.json` was not changed.
- Forward note: before V2 `known_facts.json` projection is schema-contracted or exported through Project ZIP, a separate known_facts-schema / Project ZIP scope is required.

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
- Accepted materializer projection scope lock: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`.
- Accepted materializer projection implementation: `V2_MATERIALIZER_PROJECTION_PASS`.
- Accepted materializer projection post-audit: `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS` (`ACCEPT_AS_IS`).
- Current materializer implementation closeout: `V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS`.
- Future work must remain staged: writer service scope lock, writer service implementation, writer audit, then UI write flows.

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

`V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`
