# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_PASS`

## Goal

Compact docs-only cleanup and routing realignment after `PROJECT_ZIP_DEVICE_PROFILES_DEDUP_CLOSEOUT_PASS`.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_ZIP_DEVICE_PROFILES_DEDUP_CLOSEOUT_PASS.md`
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_PASS.md`

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

For this cleanup pass:

- Docs-only updates only.
- Update governance files to keep current/next routing compact and consistent:
  - [CURRENT_STATE.md](docs/CURRENT_STATE.md)
  - [PASS_QUEUE.md](docs/PASS_QUEUE.md)
  - [AUDIT_INDEX.md](docs/AUDIT_INDEX.md).
- Preserve all evidence boundaries.
- No code/tool/schema/materializer/runtime/sample/tag/release-object modifications.
- Maintain next pass as `V1_1_POST_DEDUP_NEXT_ROUTE_REVIEW_PASS` unless governance selects a higher-priority queued V1.1 pass.

## Next recommended pass

`V1_1_POST_DEDUP_NEXT_ROUTE_REVIEW_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `py -3 -m unittest tests.test_project_zip`
- `git diff --name-only`
