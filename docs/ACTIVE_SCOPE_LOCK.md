# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS`

## Goal

Docs-only scope lock for photo-alignment data-model direction before any schema/validator/materializer/Dart/runtime implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_DATA_MODEL_SCOPE_LOCK_PASS.md`
- `docs/PHOTO_FLOW_SPEC.md` only if needed to align locked direction
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md` only if needed to preserve board-canvas boundary text

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tests/**`
- `schemas/**`
- `tools/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter implementation
- schema implementation
- validator implementation
- materializer implementation
- Dart KnownFacts implementation
- photo alignment implementation
- background photo helper
- damage/suspect rendering
- visual_trace rendering
- measurement rendering
- coordinate transform implementation
- AI proposal persistence
- edit/confirm/save/export/event-writing UI
- raw known_facts JSON parsing

## Locked decisions

1. `BOARD_CANVAS_PHOTO_EVIDENCE_ALIGNMENT_SCOPE_AUDIT_PASS` verdict is locked as `NEEDS_SCOPE_FIRST`.
2. Placeholder policy is locked:
   - `photo_reference_points_set` and `photo_layer_aligned` remain placeholder-only,
   - writer usage is unsafe until schema + validator + materializer + tests are formally scoped and accepted.
3. Canonical alignment principle is locked:
   - if alignment affects board-canvas evidence placement/report/export/repeatable project state, it must be canonical, event-backed, human-confirmed, and materialized.
   - hidden UI state, local cache truth, `view_state.json`, `board_graph.json`, AI-only transforms, and background-photo drag state are not canonical truth.
4. Volatile preview principle is locked:
   - preview-only alignment is allowed only as explicit non-canonical preview,
   - no save/export/materialize/report usage,
   - resets on reload,
   - never treated as accepted board-canvas truth.
5. Next recommended pass:
   - `PHOTO_ALIGNMENT_EVENT_SCHEMA_SCOPE_LOCK_PASS` (or `PHOTO_FLOW_SPEC_AUDIT_PASS` if governance requires audit-first routing).

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
