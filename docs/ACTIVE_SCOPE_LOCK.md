# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`

## Goal

Close out accepted and pushed `V2_EVENT_SCHEMA_SPEC_PASS` after Claude Code / Opus post-audit returned `ACCEPT_AS_IS`.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_EVENT_SCHEMA_SPEC_CLOSEOUT_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schema files, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted closeout record

- `V2_EVENT_SCHEMA_SPEC_PASS` accepted/pushed.
- Commit message: `docs: document V2 event schema spec`.
- Claude Code / Opus post-audit: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- Validation recorded: `py -3 tools\validate_all.py` PASS, 236 tests.
- The spec is Markdown-only and non-executable.
- The spec is the binding requirements source for later V2 schema, validator, materializer, writer, and UI passes.

## Binding scope

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md` remains the accepted V2 event schema/spec requirements source.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_PASS.md` remains the accepted spec pass record.
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md` remains the accepted architecture source.
- Future executable work must start with `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`, a docs-only validator scope lock.
- Do not route directly to validator implementation.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- `visual_trace` is not a net.
- `template_id` / footprint family is not electrical identity.
- Photo pixels and photo alignment are not facts or proof.
- Damage, suspect, source, research, reference, candidate, and note values are not proof or probability.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- Activity Timeline and Measure Momentum implementation remain deferred.

## Route lock

Next recommended pass is `V2_VALIDATOR_EXTENSION_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the first executable V2 surface after the accepted spec: validator extension.

Do not route directly to validator implementation, materializer implementation, writer service, UI write behavior, Save/Add/Edit, Project ZIP changes, Activity Timeline implementation, or Measure Momentum implementation from this pass.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
