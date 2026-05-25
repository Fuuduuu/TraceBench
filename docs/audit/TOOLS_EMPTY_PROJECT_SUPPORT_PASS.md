# TOOLS_EMPTY_PROJECT_SUPPORT_PASS

## Status
completed

## Lane
TOOLS_PASS

## Scope decisions
- Implemented empty-project materialization support in `tools/materialize_known_facts.py`.
- No Flutter implementation was added.
- No schema changes were required.
- No new `project_created` event handling was introduced.

## File behavior changes
- `tools/materialize_known_facts.py` now treats empty or whitespace-only `events.jsonl` as a valid empty project.
- For empty events input, it now writes a minimal valid `known_facts.json` and exits `0`.
- Empty output now contains:
  - `project_id` from `manifest.json` when available
  - `"unknown"` when manifest is missing or invalid
  - empty collections for all projection arrays and maps.
- Existing non-empty materialization behavior remains intact.

## Test coverage updates
- `tests/test_materialize_known_facts.py`
  - Added empty-input tests:
    - `test_empty_events_produces_valid_known_facts`
    - `test_empty_events_known_facts_has_project_id_from_manifest`
    - `test_empty_events_all_collections_are_empty`
    - `test_empty_events_component_pin_index_is_empty_dict`
    - `test_empty_events_without_manifest_uses_unknown_project_id`
    - `test_whitespace_only_events_is_treated_as_empty`
- `tests/test_project_zip.py`
  - Added empty project round-trip coverage:
    - `test_export_empty_project_succeeds`
    - `test_validate_empty_project_zip_passes`
    - `test_import_empty_project_zip_round_trip`

## Routing and next milestone
- `USER_DECISION_NEXT_FEATURE_PASS` blocking reason is resolved.
- Next recommended pass is now `FLUTTER_NEW_PROJECT_WIZARD_SCOPE_LOCK_PASS`.

## Known-facts / security checks
- `known_facts.json` is still Python-materializer owned.
- No `events.jsonl` mutation introduced by materializer.
- No `board_graph.json`/`view_state.json` path usage changes.
- Existing ZIP security checks (symlinks + absolute/traversal photo paths) remain in place.

## Forbidden-surface confirmation
- No Flutter code changed.
- No schema files changed.
- No `board_graph.json` or `view_state.json` added.
- No Project ZIP contract expansion.
