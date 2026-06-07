# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_EVENT_WRITER_SERVICE_CLOSEOUT_RECOVERY_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT_RECOVERY`
- Mode: docs-only targeted recovery
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`

## Goal

Recover the missing writer-service closeout audit artifact before opening the first V2 UI write-flow scope lock:

- `docs/audit/V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS.md`

This pass creates only the missing closeout evidence file and aligns the active route. It does not create new V2 architecture decisions and does not implement Save Measurement or any UI write behavior.

## Write allowlist

- `docs/audit/V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`

Do not write outside these files.

## Forbidden surfaces

Do not modify runtime code, writer service code, tests, validator, materializer, schemas, JSON schemas, Flutter UI, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

Do not implement Save Measurement. Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

Do not rewrite history, rename old commits, delete accepted audit docs, or introduce new V2 architecture decisions.

## Recovery requirements

- Create `docs/audit/V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS.md`.
- Record that `V2_EVENT_WRITER_SERVICE_PASS` was accepted/pushed.
- Record Claude Code / Opus post-audit `ACCEPT_AS_IS`, `safe_to_commit: YES`, no blocker/high/medium/low findings, writer tests 13/13, and `py -3 tools\validate_all.py` PASS with 268 tests.
- Record the accepted writer service implementation summary and non-blocking NITs.
- Preserve all writer, event, projection, UI, ZIP, Activity Timeline, and Measure Momentum boundaries.
- Ensure governance references to `docs/audit/V2_EVENT_WRITER_SERVICE_CLOSEOUT_PASS.md` resolve.

## Route lock

Next recommended pass returns to `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the first UI write flow using the accepted writer service.

Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
