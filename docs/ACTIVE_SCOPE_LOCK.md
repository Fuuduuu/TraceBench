# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: docs-only scope lock for the future V2 event writer service pass
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock the scope for the future `V2_EVENT_WRITER_SERVICE_PASS`.

This pass only defines what the future writer service implementation is allowed to do. It must not implement append/write logic.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this scope lock because stable writer/evidence invariants already have canonical owners.

## Forbidden surfaces

Do not implement writer service code. Do not modify materializer, validator, schema files, JSON schema files, Flutter UI, tests, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Accepted input

- V2 event-writing architecture is accepted.
- V2 event schema/spec is accepted.
- V2 validator extension is implemented, audited, accepted, pushed, and closed out.
- V2 materializer projection is implemented, audited, accepted, pushed, and closed out.
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md` is the binding requirements source.
- `tools/validate_events_jsonl.py` validates V2 canonical events.
- `tools/materialize_known_facts.py` projects validated V2 events into `known_facts.json`.

## Binding sources

The future writer service implementation must bind to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`
- accepted materializer behavior in `tools/materialize_known_facts.py`

Do not reinterpret writer rules from chat memory.

## Future pass locked

- Future pass: `V2_EVENT_WRITER_SERVICE_PASS`
- Future lane: `WRITER_SERVICE_PASS`
- Future mode: implementation of narrow append/idempotency writer service only

The future writer service may touch only:

- minimal discovered writer/service files,
- focused writer/idempotency/crash-safety tests,
- docs/governance/audit files,
- accepted writer fixture/test inputs if needed.

Exact file names must be discovered in that future pass.

Any need to touch validator, materializer, schema files, JSON schema files, Project ZIP import/export, Flutter UI, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Writer requirements locked

- `events.jsonl` is the only canonical write target.
- `known_facts.json` is projection/cache and must not be directly edited as truth.
- Writer appends events; it does not project facts itself except by invoking existing materializer only if later explicitly scoped.
- Writer must not write `board_graph.json` or `view_state.json`.
- Writer accepts only explicit user-confirmed events.
- Candidate events must require `actor.type == human`, `source.type == explicit_user_confirmation`, and `confirmation.confirmed == true`.
- AI/helper/renderer/OCR/CV/reference image/activity timeline/debug log/localStorage must not author events.
- Writer must validate candidate events with the existing V2 validator before append.
- Invalid events, unsupported `schema_version`, unknown canonical `event_type`, prohibited fields, and unsafe promotions must not be appended.
- Writer must append new events only and must not edit, delete, reorder, or rewrite existing events.
- Corrections, invalidations, and supersessions remain new events.

## Idempotency, locking, and crash-safety locked

- Writer must use `client_operation_id` as idempotency key.
- Same `client_operation_id` plus equivalent payload returns existing event or no-op.
- Same `client_operation_id` plus different payload rejects as conflict.
- Rapid double-click must produce one event.
- Retry after successful append must not duplicate.
- Retry after failed append may succeed safely.
- Future writer pass must enforce a project write lock or single-writer guard before any UI write ships.
- Concurrent app instances appending to the same `events.jsonl` are corruption risk.
- If locking cannot be implemented safely in the future pass, that pass must stop and rescope.
- Future implementation must define or implement safe sequence: validate event, acquire writer lock, append durably, verify append/readback, release lock, and optionally trigger projection refresh only if scoped.

## Error states locked

Future writer pass must define safe behavior:

- append failure means not saved,
- validation failure means not saved,
- duplicate idempotent retry means existing event/no duplicate,
- idempotency conflict is rejected,
- lock conflict is retryable or a clear error,
- materialization failure after append, if applicable, must not erase the canonical event.

## Future test requirements locked

Future implementation must include focused tests for valid event append, invalid event rejection before append, append-only preservation, no edit/delete/reorder of prior events, idempotent duplicate operation no-op/existing event, same `client_operation_id` different payload conflict, rapid double-submit one event, retry behavior, lock/single-writer guard, crash/partial-write safety where testable, V2 validator integration, no AI/helper-authored events appended, no `board_graph.json` / `view_state.json` generation, and V1/V1.1 project compatibility.

## Route lock

Next recommended pass is `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_POST_AUDIT_PASS`.

Purpose: independent Claude Code / Opus audit of this writer service scope lock before any writer implementation.

Do not route directly to `V2_EVENT_WRITER_SERVICE_PASS` until this scope lock is post-audited. Do not route to UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
