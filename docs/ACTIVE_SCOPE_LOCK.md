# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_PLACEMENT_REFERENCE_STATUS_FIX_SCOPE_LOCK_PASS`

## Goal

Lock narrow scope for a placement-reference status fix where `component_visual_placement_confirmed` references must resolve only to prior accepted create-events.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_PLACEMENT_REFERENCE_STATUS_FIX_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tests/**`
- `schemas/**`
- `tools/**`
- `samples/**`
- `assets/**`
- `pubspec.yaml`
- `pubspec.lock`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- materializer implementation
- known_facts schema/projection
- Flutter/runtime code
- renderer/UI
- AI proposal persistence
- global status semantics refactor

## Scope decisions

1. Future narrow implementation pass is `BOARD_PLACEMENT_REFERENCE_STATUS_FIX_PASS` (validator + tests only).
2. Placement reference checks must use prior accepted create-events only:
   - `component_id` -> prior accepted `component_created`
   - `photo_local.source_photo_id` -> prior accepted `photo_added`
3. Non-accepted `component_created` / `photo_added` events must not satisfy placement reference existence.
4. `component_updated` / `component_marked_unknown` must not create component existence for placement reference checks.
5. Forward component/photo references remain rejected.
6. Placement after component removal remains allowed as visual/documentation history.
7. Do not change materializer behavior, schemas, known-facts projection shape, or global event-status semantics in this narrow fix.
8. Broader status lifecycle consistency is explicitly deferred to `GLOBAL_EVENT_STATUS_SEMANTICS_AUDIT_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
