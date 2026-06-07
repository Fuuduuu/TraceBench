# CURRENT_STATE.md

## Current status

- Current pass: `V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS`
- Next recommended pass: `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`
- Branch: `main`
- Latest accepted commit before this closeout: `9a1e176 docs: document V2 event schema spec`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture scope-lock record, schema/spec scope lock, and V2 event schema spec are accepted/pushed.
- Claude Code / Opus post-audit returned `ACCEPT_AS_IS` for `V2_EVENT_SCHEMA_SPEC_PASS` with no blocker/high/medium/low findings.
- Current pass closes out the accepted Markdown-only spec and post-audit.
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is the binding requirements source for later V2 schema, validator, materializer, writer, and UI passes.
- Next route is `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`, docs-only. Do not route directly to validator implementation, materializer implementation, writer service, Save/Add/Edit UI, Project ZIP changes, Activity Timeline, or Measure Momentum.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- The read-only technician layer is accepted through manual smoke.
- Measure Sheet remains read-only in V1.1: Reference Values Panel and Guided Measurement Helper are display/helper surfaces only.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.
- Sourced/reference/research/candidate/note values remain non-canonical and must not look measured.

## V2 architecture state

- Accepted architecture scope-lock record: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS`.
- Accepted architecture post-audit: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS` (`ACCEPT_AS_IS`).
- Accepted schema/spec scope lock: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`.
- Accepted schema/spec scope-lock closeout: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_CLOSEOUT_PASS`.
- Accepted schema/spec doc pass: `V2_EVENT_SCHEMA_SPEC_PASS`.
- Accepted schema/spec doc post-audit: `V2_EVENT_SCHEMA_SPEC_POST_AUDIT_PASS` (`ACCEPT_AS_IS`).
- Current closeout: `V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS`.
- Future work must remain staged: validator scope lock, validator, validator audit, materializer, materializer audit, writer service, writer audit, then UI write flows.

## Hard boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- AI/helper may suggest, organize, and surface gaps only.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep this handoff compact; keep full architecture/spec detail in audit/spec docs only.

## Next recommended pass

`V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`
