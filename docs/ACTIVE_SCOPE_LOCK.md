# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_VALIDATOR_EXTENSION_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout for accepted V2 validator implementation
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`

## Goal

Close out the accepted and pushed `V2_VALIDATOR_EXTENSION_PASS` after Claude Code / Opus post-audit returned `ACCEPT_AS_IS`.

This closeout records the accepted validator implementation, preserves boundaries, and routes only to a docs-only scope lock for the next executable V2 surface.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_VALIDATOR_EXTENSION_CLOSEOUT_PASS.md`

`docs/PROJECT_MEMORY.md` was not needed for this closeout.

## Forbidden surfaces

Do not modify validator code, tests, runtime code, Flutter UI, schemas, JSON schema files, materializer, writer service, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Accepted input

- `V2_VALIDATOR_EXTENSION_PASS` was produced by Codex.
- User committed and pushed it as `feat: add V2 event validator support`.
- Validator support was added in `tools/validate_events_jsonl.py`.
- Focused validator tests were added in `tests/test_validate_events_jsonl.py`.
- Claude Code / Opus post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium findings.
- Validation passed:
  - focused V2 validator tests: 11/11,
  - full `validate_events_jsonl` tests: 114/114,
  - `py -3 tools/validate_all.py`: PASS, 247 tests.

## Closeout summary

The accepted validator implementation supports V2 schema version `2.0-draft` and accepted canonical event types from `docs/spec/V2_EVENT_SCHEMA_SPEC.md`.

It rejects unsafe aliases, canonical authors/sources, provenance violations, prohibited fields, and relation cycles where detectable. It preserves V1/V1.1 legacy baseline compatibility.

No materializer, writer service, UI writes, Project ZIP, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, schema, asset, sample, generated artifact, platform folder, tag, or release changes are authorized by this closeout.

## Evidence boundaries

- Human is the sensor. AI is the graph engine.
- AI/helper must not author canonical events or facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection/cache.
- `board_graph.json` and `view_state.json` remain forbidden across V1/V1.1/V2 unless separately scoped.
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

Next recommended pass is `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the next executable V2 surface, materializer projection from V2 events into `known_facts.json`.

Do not route directly to materializer implementation. Do not route to writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
