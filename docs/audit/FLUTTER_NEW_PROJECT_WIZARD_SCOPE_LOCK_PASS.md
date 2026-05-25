# FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS

Status: completed

Lane: DOCS_SYNC

## Scope lock summary

- V1 New Project Wizard scope is locked to blank local project bootstrap only.
- No project facts are authored in wizard V1.
- `project_id` is generated in Dart as:
  - `prj_<8 lowercase hex chars>`
  - must match `^prj_[a-f0-9]{8}$`
  - user-editable project_id is explicitly disallowed.
- Project creation writes:
  - `manifest.json`
  - empty `events.jsonl`
  - initial `known_facts.json` via materializer (`tools/materialize_known_facts.py`)
  - `metadata/schema_versions.json`
  - `exports/customer_report.md` placeholder
  - `device_profiles/` present/copy-resolved by existing tooling strategy.
- Optional `photos/` and `notes/` directories are explicitly non-required.
- Initial wizard-loaded state is non-stale (`isProjectionStale == false`) with empty collections.
- No event schema changes and no Dart-native materializer changes in this scope.

## Locked V1 constraints

- No `project_created` event in V1.
- No component/pin/measurement/net/repair fact creation.
- No `known_facts` direct JSON assembly in Dart.
- No component pin/net repair event writing.
- No mobile export expansion in this pass.
- No project ZIP contract expansion.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.

## Forbidden surface confirmation

- No `lib/**` implementation changes.
- No `tools/**` implementation changes.
- No `schemas/**`, `samples/**`, `assets/**`, or platform folder changes.
- No pubspec changes.
- No Flutter export/materializer/tooling contract expansion.

## Files changed

- `docs/FLUTTER_NEW_PROJECT_WIZARD_SPEC.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PASS_QUEUE.md`
- `docs/CURRENT_STATE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS.md`

## Validation

- `py -3 tools\\validate_all.py`
- `git diff --check`
- `git diff --name-only`
- `git status --short --branch`

## Next recommended pass

- `DOCS_DRIFT_MINI_CLEANUP_10_PASS` (DOCS_SYNC) as docs cleanup.
- Implementation candidate after cleanup: `FLUTTER_NEW_PROJECT_WIZARD_PASS`.
