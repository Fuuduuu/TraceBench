# ACTIVE_SCOPE_LOCK.md

## Current pass

`PROJECT_STATE_RELOAD_AFTER_EXPORT_SCOPE_LOCK_PASS`

## Goal

Lock a narrow docs-only scope for later implementation: after a successful desktop/dev Project ZIP export, refresh in-memory `ProjectState` from disk via existing `ProjectLoader` path.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_STATE_RELOAD_AFTER_EXPORT_SCOPE_LOCK_PASS.md`
- `docs/audit/PROJECT_STATE_RELOAD_AFTER_EXPORT_PASS.md` (as implementation pass target index entry)
- `docs/PROJECTION_REFRESH_POLICY_SCOPE_LOCK_PASS.md` (read-only reference)

## Forbidden surfaces

- `lib/**` implementation changes in this pass
- `test/**`
- `tools/**`
- `schemas/**`
- `samples/**`
- `assets/**`
- `pubspec.yaml`
- `pubspec.lock`
- `events.jsonl`
- `known_facts.json`
- `project_zip_contract` expansion
- Project ZIP tooling changes
- `mobile` export implementation
- `event-writing` changes
- `measurement` auto-refresh after every write
- `Dart-native known_facts materializer` or direct `known_facts.json` mutation in Flutter
- direct stale-banner action changes

## Scope decisions to lock

1. The follow-up implementation pass is explicitly `PROJECT_STATE_RELOAD_AFTER_EXPORT_PASS`.
2. Refresh in-memory state **only** after successful desktop/dev `Export ZIP` (success result from `ProjectExporter`).
3. The refresh path must reload from `projectState.projectDirectory` using existing `ProjectLoader` path.
4. Failed export must not reload, must not replace state, and must not clear `isProjectionStale`.
5. `measurement_recorded` save/write flow must not auto-materialize or auto-reload in this pass.
6. `known_facts.json` remains Python-materializer-owned and remains unchanged by Flutter.
7. Projection stale banner remains passive display-only (no action/button wiring).
8. Mobile export remains placeholder as locked by V1 export scope.

## Validate

- `py -3 tools\validate_all.py`
