# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_ZIP_DEVICE_PROFILES_DEDUP_CLOSEOUT_PASS`

## Goal

Document closeout recording for `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` after ACCEPT_AS_IS audit and preserve
existing ZIP contract boundaries.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_SCOPE_LOCK_PASS.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_CLOSEOUT_PASS.md`

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

For this closeout pass, implementation lane remains unchanged and no code changes are allowed.
Allowed focus is:
- docs governance/audit updates for closeout recording.

Implementation results recorded in `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_PASS` must preserve:
  - existing `.tracebench_local`, `.codex`, `.git`, `__pycache__`, `.env`, log exclusions,
  - `board_graph.json` / `view_state.json` rejection behavior.
- No Project ZIP contract expansion.
- No new event/schema/materializer/runtime behavior.
- No renderer/view write behavior.
- Evidence boundaries remain unchanged (no transform/photo overlay/reference-image path inclusion, no event-writing logic).

## Next recommended pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `py -3 -m unittest tests.test_project_zip`
