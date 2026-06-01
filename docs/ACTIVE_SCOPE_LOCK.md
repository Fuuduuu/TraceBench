# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for a narrow defense-in-depth follow-up: constrain reference-image preview path resolution to the sidecar image directory.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/**`
- `lib/**`
- `test/**`
- `tests/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- schema/materializer semantics changes
- fixture/sample implementation or edits
- generated data or artifact changes
- git tag creation/push/delete/move
- background photo helper
- transform/matrix computation
- photo-local evidence conversion
- visual_trace/damage/suspect canvas geometry rendering
- measurement canvas overlay
- event-writing/edit/confirm/save/apply controls

## Scope boundary (locked)

- Scope-lock-only pass; no implementation changes.
- Record accepted LOW post-audit note and lock the next implementation pass to narrow path clamp/revalidation for preview reads.
- Lock implementation intent: reject absolute/escape traversal read paths and preserve valid generated sidecar paths.
- Preserve Model-B boundary: local sidecar only, non-canonical, outside ZIP/events/known_facts/Board Canvas evidence rendering/AI-OCR-CV, and no URL import.
- No fixture/sample/asset/generated-artifact changes.
- No evidence-boundary weakening.
- No tag or release-object mutation.

## Next recommended pass

`REFERENCE_IMAGE_LOCAL_SIDECAR_VIEWER_PATH_CLAMP_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
