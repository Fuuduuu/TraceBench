# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`

## Goal

Close out the accepted and pushed `V2_EVENT_WRITER_SERVICE_PASS`.

Record that the writer service implementation was accepted, pushed, and post-audited as `ACCEPT_AS_IS`, then route only to a docs-only Save Measurement scope lock.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if needed for a compact pointer
- `docs/audit/V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this closeout because stable writer/evidence invariants already have canonical owners and the accepted implementation evidence belongs in the audit record.

## Forbidden surfaces

Do not modify writer service code, tests, validator, materializer, schemas, JSON schemas, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

Do not implement Save Measurement. Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Closeout facts to preserve

- `V2_EVENT_WRITER_SERVICE_PASS` was produced by Codex.
- User committed and pushed it with commit message `feat: add V2 event writer service`.
- Claude Code / Opus post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- Validation recorded by audit context:
  - writer tests: 13/13,
  - `py -3 tools\validate_all.py`: PASS, 268 tests.
- Writer service was added in `tools/event_writer_service.py`.
- Focused tests were added in `tests/test_event_writer_service.py`.

## Writer implementation boundaries

- Writer appends only to `events.jsonl`.
- Existing validator is used before append and again under lock.
- `known_facts.json` remains projection/cache and is not edited by the writer.
- `board_graph.json` and `view_state.json` are not generated.
- `client_operation_id` idempotency is implemented.
- Atomic `events.jsonl.lock` single-writer guard is implemented.
- Durable append uses `fsync` and readback verification.
- No UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum were opened.

## Non-blocking NITs

- Stale-lock recovery is deferred.
- Crash-mid-append partial-line recovery fails closed and is deferred hardening.
- Idempotency fingerprint ignores `event_id`, `created_at`, and `confirmation.confirmed_at` for retry tolerance.

## Route lock

Next recommended pass is `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the first UI write flow using the accepted writer service.

Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
