# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`

## Goal

Close out the accepted and pushed `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS` after Claude Code / Opus post-audit returned `ACCEPT_AS_IS`.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_CLOSEOUT_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schemas, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted closeout record

- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS` accepted/pushed.
- Commit message: `docs: capture V2 event-writing architecture`.
- Claude Code / Opus post-audit: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- NITs only: `2.0-draft` schema label is acceptable and generic scope-lock row wording is acceptable.
- Validation recorded: `py -3 tools/validate_all.py` PASS, 236 tests.
- Implementation remains blocked.

## Next route lock

Next recommended pass is `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS`.

It is docs/spec-only scope lock for V2 event schema/spec planning. It must not implement schemas or code and must not route directly to validator, materializer, writer service, UI write flows, Project ZIP, Activity Timeline, or Measure Momentum implementation.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage/suspect/source/research/reference/candidate/note values are not proof or probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- V2 implementation remains blocked until later individually scoped/audited passes.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`