# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs-only architecture scope-lock capture
- Next recommended pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_POST_AUDIT_PASS`

## Goal

Capture the accepted V2 event-writing architecture as a durable repo governance/audit artifact after GPT Pro architecture-first review and Claude Code / Opus re-audit returned `ACCEPT_READY_FOR_CODEX_SCOPE_LOCK`.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted architecture record

- GPT Pro architecture-first: completed.
- Claude Code / Opus re-audit: `ACCEPT_READY_FOR_CODEX_SCOPE_LOCK`.
- Full patched architecture text is captured in `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`.
- P1-P10 prior findings are recorded as resolved.
- L1-L4 are recorded as open items for later schema/spec/materializer passes.
- Implementation remains blocked.

## Hard implementation block

No implementation may start from this pass. This pass authorizes no code/schema/validator/materializer/writer/UI/ZIP changes.

Next implementation-adjacent work must begin with schema/spec docs only, followed by separately scoped validator, materializer, writer, UI, ZIP, Activity Timeline, and Measure Momentum passes.

## Evidence boundaries

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
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Reference Images remain local sidecar only and must not become evidence/canonical source.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`