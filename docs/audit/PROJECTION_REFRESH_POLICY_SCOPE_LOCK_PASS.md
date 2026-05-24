# PROJECTION_REFRESH_POLICY_SCOPE_LOCK_PASS

- Status: completed
- Lane: DOCS_SYNC
- Scope: docs-only projection-refresh policy lock

## Files changed

- `docs/PROJECTION_REFRESH_SPEC.md`
- `docs/FLUTTER_EVENT_WRITE_SPEC.md`
- `docs/FLUTTER_UI_SPEC.md`
- `docs/PROJECT_ZIP_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECTION_REFRESH_AFTER_EVENT_WRITE_AUDIT_PASS.md`
- `docs/audit/PROJECTION_REFRESH_POLICY_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\validate_all.py` passed.

## Decisions

- POLICY_D export-time refresh is selected.
- Global stale banner is required on derived views after local event append.
- Python materializer (`tools/materialize_known_facts.py`) owns projection regeneration.
- Flutter must not mutate `known_facts.json` directly in V1.
- Mobile export remains placeholder and is deferred.
- ZIP structure and required paths are unchanged.

## Next recommended pass

- `PROJECTION_STALE_UI_SCOPE_LOCK_PASS` (`DOCS_SYNC`)

## Forbidden-surface confirmation

- No non-doc files were modified.
- No schemas/tools/samples/assets/lib/test/pubspec/tooling behavior changes.
- No `events.jsonl` or `known_facts.json` edits were introduced.
- No board graph or view state artifacts were added.
