# ACTIVE_SCOPE_LOCK.md

## Current pass

`MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS`

## Goal

Implement narrow accepted-only materializer projection behavior in `tools/materialize_known_facts.py` without schema, validator, ZIP contract, sample/asset, or runtime/UI changes.

## Allowed surfaces

- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`
- `tests/test_project_zip.py` (only if narrowly needed)
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS.md`

## Forbidden surfaces

- `schemas/**`
- `tools/validate_events_jsonl.py`
- `tools/export_project_zip.py`
- `tools/validate_project_zip.py`
- `samples/**`
- `assets/**`
- `lib/**`
- `test/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Flutter/runtime implementation
- AI proposal persistence
- visual->electrical promotion
- hidden-layer inference
- Project ZIP contract changes

## Scope decisions

1. `known_facts.json` is current-domain projection, not audit-history projection.
2. Only `status == "accepted"` events may create/mutate current projected domain facts.
3. Non-accepted events remain in `events.jsonl` as audit/review/history data.
4. Accepted behavior for existing domain handlers must remain unchanged.
5. `project_id` resolution policy:
   - prefer `manifest.json` project_id,
   - if manifest is unknown, fallback to first accepted event project_id,
   - if none exists, keep `project_id = "unknown"`.
6. Placement remains visual/documentation-only and user-confirmed accepted-only.
7. No schema/validator/materializer-shape/ZIP-contract/runtime changes outside this narrow pass.

## Validate

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_materialize_known_facts`
- `py -3 -m unittest tests.test_project_zip`
- `git diff --name-only`
- `git status --short --branch`
