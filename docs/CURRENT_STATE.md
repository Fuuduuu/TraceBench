# CURRENT_STATE.md

## Current status

- Current pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS`
- Next recommended pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`
- Branch: `main`
- Latest accepted commit before this record: `bd38ff7 docs: record post-smoke V2 route review`
- Release tags present: `v1.0.0-rc1`, `v1.1.0-rc1`
- Validation baseline: `py -3 tools\validate_all.py`

## Live handoff

- V2 event-writing architecture has completed GPT Pro architecture-first review and Claude Code / Opus re-audit.
- This pass captures the full accepted patched architecture text in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`.
- Implementation remains blocked until the scope-lock record is post-audited and accepted.
- Do not route directly to schema implementation, validator implementation, materializer implementation, writer service, Save/Add/Edit UI, Project ZIP changes, Activity Timeline, or Measure Momentum.

## Accepted V1.1 baseline

- V1.1 RC tag `v1.1.0-rc1` remains the protected release-candidate baseline.
- The read-only technician layer is accepted through manual smoke.
- Measure Sheet remains read-only in V1.1: Reference Values Panel and Guided Measurement Helper are display/helper surfaces only.
- Reference Images remain Model B local sidecar only: non-canonical, outside Project ZIP, outside `events.jsonl`, outside `known_facts.json`, outside materializer, outside Board Canvas evidence, outside AI/OCR/CV, and no URL import.
- Board Canvas remains read-only: metadata and projection display only, `renderer writes: none`, no transform/photo overlay/event-writing behavior.
- Sourced/reference/research/candidate/note values remain non-canonical and must not look measured.

## V2 architecture state

- Accepted scope-lock record: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS`.
- Next required review: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`.
- Future work must be staged: schema/spec, schema audit, validator, validator audit, materializer, materializer audit, writer service, writer audit, then UI write flows.
- Activity Timeline and Measure Momentum remain deferred until after accepted V2 write architecture guardrails and relevant implementation passes.

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
- Photo pixels are not facts.
- Photo alignment is not identity, pin mapping, net confirmation, measurement, or fault proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Maintenance note

- `docs/MEMORY_MAINTENANCE.md` owns the compaction trigger: compact `docs/CURRENT_STATE.md` when it exceeds approximately 120 lines.
- Keep full architecture text in the audit doc only; keep this handoff compact.

## Next recommended pass

`V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`