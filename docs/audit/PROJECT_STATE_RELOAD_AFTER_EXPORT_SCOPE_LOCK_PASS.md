# PROJECT_STATE_RELOAD_AFTER_EXPORT_SCOPE_LOCK_PASS

Status: completed

Lane: DOCS_SYNC

Scope: docs-only. Lock narrow post-export in-memory reload behavior before implementation.

## Audit finding recorded

From `PROJECT_OVERVIEW_COUNTER_RELOAD_AUDIT_PASS`:

1. Measurement events append to `events.jsonl` correctly.
2. `tools/materialize_known_facts.py` correctly materializes measurements into `known_facts.json`.
3. `ProjectOverviewScreen` counters use `ProjectState.knownFacts`.
4. Current export flow (`ProjectExporter.exportProjectZip`) calls materializer and export, but does not reload `ProjectState`.
5. UI counters remain stale (e.g., 0) until user re-imports/reloads project from ZIP.

## Locked narrow implementation direction

- Introduce a follow-up implementation pass:
  - `PROJECT_STATE_RELOAD_AFTER_EXPORT_PASS`
- Refresh scope:
  - Refresh in-memory `ProjectState` only after successful desktop/dev Export ZIP.
  - Reload through existing `ProjectLoader` path from local `projectDirectory`.
  - Replace `projectStateProvider` with the reloaded state.
- Failure behavior:
  - Failed export must not reload.
  - Failed export must not clear `isProjectionStale`.
- No other auto-refresh behavior:
  - Do not auto-materialize or auto-reload after every `measurement_recorded` write in this pass.
- Canonical ownership remains unchanged:
  - `events.jsonl` is canonical event truth.
  - `known_facts.json` remains Python-materializer-owned.
  - Flutter does not mutate `known_facts.json` directly.
  - Mobile export remains placeholder.

## Files changed

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_STATE_RELOAD_AFTER_EXPORT_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
