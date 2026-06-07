# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout for accepted V2 materializer projection implementation
- Next recommended pass: `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`

## Goal

Close out accepted and pushed `V2_MATERIALIZER_PROJECTION_PASS`.

This closeout records Claude Code / Opus post-audit acceptance, preserves the materializer projection boundaries, records the forward known_facts schema/ZIP note, and routes only to a docs-only event writer service scope lock.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_MATERIALIZER_PROJECTION_CLOSEOUT_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this closeout because no new stable product invariant is introduced beyond already-owned event/projection boundaries.

## Forbidden surfaces

Do not modify materializer code, tests, runtime code, Flutter UI, schema files, JSON schema files, validator code, writer service, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Accepted input

- `V2_MATERIALIZER_PROJECTION_PASS` was produced by Codex.
- User committed and pushed it as `feat: add V2 materializer projection`.
- Claude Code / Opus post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium findings.
- Validation passed:
  - focused materializer tests: 86/86,
  - `py -3 tools\validate_all.py`: PASS, 255 tests.

## Closeout boundary

This pass is docs-only. It records the accepted implementation and post-audit result. It does not alter the materializer, tests, schemas, runtime, writer service, UI, ZIP logic, assets, samples, generated artifacts, platform folders, tags, or releases.

Known forward note: before V2 `known_facts.json` projection is schema-contracted or exported through Project ZIP, a separate known_facts-schema / Project ZIP scope is required.

## Projection boundaries preserved

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical facts.
- No diagnosis, probability, confirmed net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof.
- No latest-timestamp-wins.
- No silent L3 cascade-drop.
- `board_graph.json` and `view_state.json` remain forbidden.
- No writer service.
- No UI writes.
- No Save/Add/Edit.
- No Project ZIP.
- No Activity Timeline.
- No Measure Momentum.

## Route lock

Next recommended pass is `V2_EVENT_WRITER_SERVICE_SCOPE_LOCK_PASS`.

Purpose: docs-only scope lock for the next executable V2 surface, the event writer service.

Do not route directly to writer implementation. Do not route to UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
