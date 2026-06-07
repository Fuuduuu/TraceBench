# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout for accepted V2 event writer service scope lock
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_PASS`

## Goal

Close out accepted and pushed `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`.

This closeout records Claude Code / Opus post-audit acceptance, preserves the writer-service boundaries, and routes only to the first executable canonical writer service implementation pass under the accepted lock.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_CLOSEOUT_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this closeout because no new stable product invariant is introduced beyond already-owned event/writer boundaries.

## Forbidden surfaces

Do not implement writer service code. Do not modify runtime code, Flutter UI, tests, schema files, JSON schema files, validator code, materializer code, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Accepted input

- `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS` was produced by Codex as a docs-only scope lock.
- User committed and pushed it as `docs: lock V2 event writer service scope`.
- Claude Code / Opus post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- Validation passed: `py -3 tools\validate_all.py` PASS, 255 tests.

## Closeout boundary

This pass is docs-only. It records the accepted scope lock and post-audit result. It does not implement writer service code, append/write logic, tests, schemas, validator changes, materializer changes, runtime changes, UI writes, ZIP logic, assets, samples, generated artifacts, platform folders, tags, or releases.

Writer implementation remains blocked until this closeout is accepted.

## Writer service binding preserved

The future writer service remains bound to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`

Do not reinterpret writer rules from chat memory.

## Writer boundaries preserved

- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache and must not be directly edited as truth.
- Writer must append only; no edit, delete, reorder, or rewrite of existing events.
- Writer must validate candidate events with the existing V2 validator before append.
- Writer accepts only explicit human-confirmed events.
- AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage must not author events.
- `client_operation_id` remains the idempotency key.
- Future writer pass must enforce a project write lock or single-writer guard before UI writes.
- No `board_graph.json` or `view_state.json` generation.
- No UI writes.
- No Save/Add/Edit.
- No Project ZIP.
- No Activity Timeline.
- No Measure Momentum.

## Route lock

Next recommended pass is `V2_EVENT_WRITER_SERVICE_PASS`.

Purpose: first executable canonical writer service implementation pass under the accepted writer-service scope lock.

Do not route to UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
