# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS`

## Goal

Implement a narrow Project ZIP export hardening pass to eliminate duplicate archive path emission for
`device_profiles/default.json` while preserving existing ZIP contract behavior.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `Project ZIP contract files outside this pass (no contract expansion)`
- `lib/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling files outside allowed implementation set
- schema/materializer/runtime surface changes
- fixture/sample/asset or generated-artifact edits
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry inference
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Implementation lane: `TOOLS_PASS`.
- Allowed implementation file set:
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

`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_POST_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git status --short --branch`
