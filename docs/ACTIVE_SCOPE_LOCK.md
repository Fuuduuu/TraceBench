# ACTIVE_SCOPE_LOCK.md

## Current pass

`MEASUREMENT_EVENT_ID_COMPAT_SCOPE_LOCK_PASS`

## Goal

Lock the narrow future scope for fixing Dart measurement writer `event_id` generation so app-written `measurement_recorded` events are compatible with existing schema/validator format.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/MEASUREMENT_EVENT_ID_COMPAT_SCOPE_LOCK_PASS.md`

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
- Project ZIP tooling/files
- `board_graph.json`
- `view_state.json`
- renderer/UI implementation
- AI proposal persistence
- materializer/projection changes

## Locked decisions

1. Record `CODEBASE_CLEANUP_AND_EFFICIENCY_AUDIT_PASS` finding `F01`: Dart measurement writer currently emits `evt_flutter_*` IDs while schema/validator require `^evt_[0-9]{6}$`.
2. Lock next pass to `MEASUREMENT_EVENT_ID_COMPAT_FIX_PASS`.
3. Schema/validator `event_id` format remains source of truth for this fix.
4. The future fix pass must not modify `schemas/events.schema.json` or `tools/validate_events_jsonl.py`.
5. The future fix pass must not rewrite historical events or introduce migration.
6. The future fix pass must include tests proving writer output is validator-compatible.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
