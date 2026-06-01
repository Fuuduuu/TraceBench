# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS`

## Goal

Lock a narrow Project ZIP export hardening pass to eliminate duplicate archive path emission for
`device_profiles/default.json` before any implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `schemas/**` (no schema changes in this scope lock pass)
- `tools/**` (implementation deferred to next `TOOLS_PASS`)
- `lib/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- schema/materializer/runtime/tooling surface changes
- fixture/sample/asset or generated-artifact edits
- Git tag actions
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry inference
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Docs-only scope lock only.
- Next implementation pass is fixed as:
  - `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` (lane: `TOOLS_PASS`)
- Allowed implementation file set for the next pass:
  - `tools/export_project_zip.py`
  - `tests/test_project_zip.py`
  - `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS.md`
- Implementation must preserve:
  - existing `.tracebench_local`, `.codex`, `.git`, `__pycache__`, `.env`, log exclusions,
  - `board_graph.json` / `view_state.json` rejection behavior.
- No Project ZIP contract expansion.
- No new event/schema/materializer/runtime behavior.
- No renderer/view write behavior.
- Evidence boundaries remain unchanged (no transform/photo overlay/reference-image path inclusion, no event-writing logic).

## Next recommended pass

`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git status --short --branch`
