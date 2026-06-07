# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `TRACEBENCH_MEMORY_SCOPE_DOCS_DEDUP_CLEANUP_PASS`
- Lane: `CODEX / DOCS_SYNC`
- Mode: docs-only memory/scope cleanup
- Next recommended pass: `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`

## Goal

Apply the tight memory/scope cleanup recommended by Claude Code / Opus in `TRACEBENCH_MEMORY_SCOPE_AND_DOCS_DEDUP_AUDIT_PASS` before opening the first V2 UI write-flow scope lock.

This pass fixes memory/index owner drift only. It does not create new V2 architecture decisions and does not implement Save Measurement or any UI write behavior.

## Write allowlist

- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/ARCHITECTURE_BOUNDARIES.md`
- `docs/MODEL_ROUTING.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/TRACEBENCH_MEMORY_SCOPE_DOCS_DEDUP_CLEANUP_PASS.md`

Do not write outside these files.

## Forbidden surfaces

Do not modify runtime code, Flutter UI, tests, schemas, validators, tools, materializer, writer service, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

Do not implement Save Measurement. Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

Do not prune audit history, delete accepted audit docs, rewrite commit history, or introduce new V2 architecture decisions.

## Cleanup requirements

- Replace the stale `TRUTH_INDEX.md` drift-countdown owner row with the live `CURRENT_STATE.md` compaction trigger owner: `docs/MEMORY_MAINTENANCE.md`.
- Add compact V2 owner rows in `TRUTH_INDEX.md` for:
  - V2 event schema requirements: `docs/spec/V2_EVENT_SCHEMA_SPEC.md`,
  - V2 event validation / validator V2 path: `tools/validate_events_jsonl.py`,
  - V2 materializer projection / `known_facts.json` V2 projection: `tools/materialize_known_facts.py`,
  - V2 canonical event writer / append service: `tools/event_writer_service.py`.
- Refresh compact memory/routing notes only if needed so accepted validator, materializer, and writer backend implementations are not described as architecture-only future work.
- Preserve that UI write flows remain separately scoped and not yet implemented.

## Route lock

Next recommended pass returns to `V2_SAVE_MEASUREMENT_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the first UI write flow using the accepted writer service.

Do not route directly to Save Measurement implementation. Do not route to Add/Edit Component, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
