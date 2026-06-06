# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_EVENT_SCHEMA_SPEC_PASS`

## Goal

Close out accepted and pushed `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS` after Claude Code / Opus post-audit returned `ACCEPT_AS_IS`.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_CLOSEOUT_PASS.md`

## Forbidden surfaces

Do not modify runtime code, Flutter runtime, tests, schemas, JSON schema files, validators, tools, materializer behavior, event writer behavior, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, datasheet parsing, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Accepted closeout record

- `V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS` accepted/pushed.
- Commit message: `docs: lock V2 event schema spec scope`.
- Claude Code / Opus post-audit: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- NIT only: conflict clause in the scope-lock doc is terser than the bound architecture record; the bound architecture remains source of truth.
- Validation recorded: `py -3 tools\validate_all.py` PASS, 236 tests.
- Artifact scan passed.

## Binding scope

- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md` remains the accepted V2 architecture source.
- `docs/audit/V2_EVENT_SCHEMA_SPEC_SCOPE_LOCK_PASS.md` locks the future schema/spec documentation scope.
- Future `V2_EVENT_SCHEMA_SPEC_PASS` must remain docs/spec only.
- The future pass must not create schema files, JSON schema files, validator code, materializer code, writer service code, UI write behavior, tests, Project ZIP behavior, Activity Timeline implementation, or Measure Momentum implementation.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference Images remain local sidecar and non-canonical.
- Board Canvas remains read-only unless separately scoped.
- Guided Measurement remains read-only and must not author events.
- Activity Timeline remains distinct from `events.jsonl` and debug logs.
- V2 implementation remains blocked until later individually scoped and audited passes.

## Route lock

Next recommended pass is `V2_EVENT_SCHEMA_SPEC_PASS`.

Purpose: docs/spec-only event schema/spec documentation under the accepted scope lock.

Do not route to validator implementation, materializer implementation, writer service, UI write behavior, Project ZIP changes, Activity Timeline implementation, or Measure Momentum implementation from this pass.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
