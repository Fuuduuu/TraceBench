# CURRENT_STATE.md

## Current status

- Current pass: `V2_MATERIALIZER_PROJECTION_PASS`
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `f38e944 docs: close out V2 materializer projection scope`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS` and closeout are accepted, pushed, and post-audited.
- This pass implements the first scoped V2 projection path in `tools/materialize_known_facts.py`.
- The materializer now projects validated V2 `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated` events into `known_facts.json`.
- Focused materializer tests were added in `tests/test_materialize_known_facts.py`.
- Focused materializer validation passed: `py -3 -m unittest tests.test_materialize_known_facts.MaterializeKnownFactsTests -v` PASS, 86 tests.
- Full validation passed: `py -3 tools\validate_all.py` PASS, 255 tests.
- Next recommended pass is independent Claude Code / Opus post-audit as `V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`.
- Do not route to writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Materializer implementation summary

- V2 events use `schema_version: 2.0-draft`; V1/V1.1 events stay on the existing legacy materializer path.
- `measurement_recorded` projection preserves target, reading, value provenance, conditions, source event, origin event, and validity fields.
- `component_created` projection preserves display/navigation fields and hint fields as hints only.
- `component_updated` applies safe field-level changes to the projection and preserves update history.
- `event_invalidated` preserves invalidation history and marks affected projected entries instead of deleting history.
- Explicit `supersedes_event_id` marks superseded measurements and keeps the replacement active.
- Unsuperseded divergent measurements for the same target/mode/context surface `measurement_conflicts`; latest-timestamp-wins remains forbidden.
- Component invalidation surfaces dependent measurements in `orphaned_measurements`; dependent measurements are not cascade-dropped.
- `board_graph.json` and `view_state.json` are not generated.

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
- Accepted materializer projection scope-lock post-audit: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_POST_AUDIT_PASS` (`ACCEPT_AS_IS`).
- Accepted materializer projection scope-lock closeout: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS`.
- Current materializer implementation pass: `V2_MATERIALIZER_PROJECTION_PASS`.
- Future work must remain staged: materializer audit, writer service, writer audit, then UI write flows.

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

`V2_MATERIALIZER_PROJECTION_POST_AUDIT_PASS`
