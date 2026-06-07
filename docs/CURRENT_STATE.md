# CURRENT_STATE.md

## Current status

- Current pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS`
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_PASS`
- Branch: `main`
- Latest accepted commit before this pass: `0cd4939 docs: lock V2 materializer projection scope`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS` was produced by Codex as a docs-only scope lock.
- User committed and pushed it as `docs: lock V2 materializer projection scope`.
- Claude Code / Opus post-audit accepted the scope lock as `ACCEPT_AS_IS`; `safe_to_commit: YES`; no blocker/high/medium/low findings.
- Validation passed: `py -3 tools\validate_all.py` PASS with 247 tests.
- No materializer code was implemented in the scope-lock pass.
- Current pass closes out the accepted scope lock.
- Materializer implementation remains blocked until this closeout is accepted.
- Next recommended pass is `V2_MATERIALIZER_PROJECTION_PASS`, the first executable materializer implementation pass under the accepted scope lock.
- Do not route to writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Materializer scope-lock summary

- Future materializer implementation must bind to `docs/spec/V2_EVENT_SCHEMA_SPEC.md`, `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`, and accepted validator behavior in `tools/validate_events_jsonl.py`.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache and must never be treated as source of truth.
- Future V2 projection scope is limited to validated `measurement_recorded`, `component_created`, `component_updated`, and `event_invalidated` events.
- Projection may include measurement history/current summaries, target linkage, value provenance, component current display fields, component history pointers, invalidation/supersession history, and conflict markers.
- Projection must not derive diagnosis, probability, confirmed net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof.
- Unsuperseded divergent human measurements must surface conflicts; latest-timestamp-wins is forbidden.
- L3 component-invalidation orphan handling must surface dependent measurements and must never silently cascade-drop them.
- V1/V1.1 projection compatibility must not regress.

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
- Current materializer scope-lock closeout: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS`.
- Future work must remain staged: materializer implementation, materializer audit, writer service, writer audit, then UI write flows.

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

`V2_MATERIALIZER_PROJECTION_PASS`
