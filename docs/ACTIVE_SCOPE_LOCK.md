# ACTIVE_SCOPE_LOCK.md

## Active pass

- Current pass: `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS`
- Lane: `CODEX / DOCS_SYNC_CLOSEOUT`
- Mode: docs-only closeout for accepted V2 materializer projection scope lock
- Next recommended pass: `V2_MATERIALIZER_PROJECTION_PASS`

## Goal

Close out accepted and pushed `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS`.

This closeout records Claude Code / Opus post-audit acceptance, preserves the materializer projection boundaries, and routes only to the first executable materializer implementation pass under the accepted scope lock.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/PROJECT_MEMORY.md` only if a compact stable pointer is needed
- `docs/audit/V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_CLOSEOUT_PASS.md`

`docs/PROJECT_MEMORY.md` is not required for this closeout because no new stable product invariant is introduced.

## Forbidden surfaces

Do not implement materializer code. Do not modify runtime code, Flutter UI, tests, schema files, JSON schema files, validator code, tools, writer service, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, source search, assets, samples, generated artifacts, platform folders, tags, or release objects.

## Accepted input

- `V2_MATERIALIZER_PROJECTION_SCOPE_LOCK_PASS` was produced by Codex as a docs-only scope lock.
- User committed and pushed it as `docs: lock V2 materializer projection scope`.
- No materializer code was implemented in the scope-lock pass.
- Claude Code / Opus post-audit verdict: `ACCEPT_AS_IS`.
- `safe_to_commit`: `YES`.
- No blocker/high/medium/low findings.
- Validation passed: `py -3 tools\validate_all.py` PASS, 247 tests.

## Binding sources preserved

Future materializer implementation remains bound to:

- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_RECORD_PASS.md`
- accepted validator behavior in `tools/validate_events_jsonl.py`

Do not reinterpret projection rules from chat memory.

## Closeout boundary

Materializer implementation remains blocked until this closeout is accepted. After closeout acceptance, the only recommended implementation route is `V2_MATERIALIZER_PROJECTION_PASS`.

The future materializer pass remains limited to the accepted scope-lock boundary: implementation of V2 materializer projection only. Any need to touch validator, schema files, writer service, Flutter UI, Project ZIP import/export, Board Canvas, Reference Images runtime, AI/OCR/CV, URL/source search, platform folders, generated artifacts, tags, or releases must stop and require separate scope.

## Evidence and projection boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache and must never be source of truth.
- Materializer projection must not derive diagnosis, probability, net identity, confirmed pin mapping, component identity, visual-trace connectivity, or template/photo proof.
- Unsuperseded divergent measurements must surface conflict.
- Latest-timestamp-wins remains forbidden for divergent measurements.
- L3 orphan handling requires dependent measurements to be surfaced and never silently cascade-dropped.
- No writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum is authorized by this closeout.

## Route lock

Next recommended pass is `V2_MATERIALIZER_PROJECTION_PASS`.

Purpose: first executable materializer implementation pass under the accepted scope lock.

Do not route to writer service, UI writes, Save/Add/Edit, Project ZIP, Activity Timeline, or Measure Momentum.

## Validation

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
