# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITER_SERVICE_PASS`
- Lane: `CODEX / WRITER_SERVICE_PASS`
- Mode: scoped writer service implementation
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`

## Goal

Implement a narrow V2 canonical event writer service that appends validated human-confirmed canonical events to `events.jsonl` safely.

This pass opens only the writer-service tooling surface and focused writer-service tests under the accepted writer-service scope lock.

## Write allowlist

- `tools/event_writer_service.py`
- focused writer-service tests
- accepted writer fixture/test inputs if needed
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/V2_EVENT_WRITER_SERVICE_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this pass because stable writer/evidence invariants already have canonical owners and this pass records implementation evidence in its audit doc.

## Forbidden surfaces

Do not modify Flutter UI, Save/Add/Edit UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, platform folders, generated artifacts, tags, or release objects.

Do not modify validator or materializer behavior. If validator/materializer changes are needed, stop and report.

Do not create schema files or JSON schema files. Do not implement UI write behavior. Do not change Project ZIP behavior.

## Binding sources

The writer service implementation binds to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_CLOSEOUT_PASS.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`

Do not reinterpret writer rules from chat memory.

## Writer requirements

- `events.jsonl` is the only canonical write target.
- `known_facts.json` remains projection/cache and must not be directly edited as truth.
- Writer appends line-delimited JSON events only.
- Writer must not edit, delete, reorder, or rewrite existing event lines.
- Writer validates the candidate stream with the existing V2 validator before append.
- Invalid events, unsupported schema versions, unknown event types, prohibited fields, and unsafe promotions are not appended.
- Writer accepts only explicit human-confirmed events that pass validator rules.
- AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage-authored events must not append.
- `client_operation_id` is the idempotency key.
- Same `client_operation_id` plus equivalent operation payload returns the existing event without appending.
- Same `client_operation_id` plus different operation payload rejects as conflict.
- Writer must use a project write lock or single-writer guard.
- Append must be durable and followed by readback verification.
- No `board_graph.json` or `view_state.json` generation.

## Route lock

Next recommended pass is `V2_EVENT_WRITER_SERVICE_POST_AUDIT_PASS`.

Purpose: independent Claude Code / Opus audit of the writer service implementation.

Do not route to UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- focused writer service tests
- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
