# ACTIVE_SCOPE_LOCK.md

## Current pass

`PHOTO_ALIGNMENT_MATERIALIZER_PASS`

## Goal

Implement narrow materializer + known_facts schema projection for `photo_to_board_alignment_confirmed` only.

## Allowed surfaces

- `tools/materialize_known_facts.py`
- `schemas/known_facts.schema.json`
- `tests/test_materialize_known_facts.py`
- `tests/test_project_zip.py` (compatibility assertions only)
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PHOTO_ALIGNMENT_MATERIALIZER_PASS.md`

## Forbidden surfaces

- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `tools/validate_project_zip.py`
- `tools/validate_all.py`
- `lib/**`
- `test/**`
- `samples/**`
- `assets/**`
- `pubspec*`
- `events.jsonl`
- `known_facts.json`
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter UI/runtime changes
- Dart KnownFacts model changes

## Materializer boundary (locked)

- no side effects into components
- no side effects into pins
- no side effects into nets
- no side effects into measurements
- no side effects into visual_traces
- no side effects into faults/fault_candidates
- no side effects into repair conclusions
- no changes to `excluded_from_fault_candidates`
- no photo-local geometry conversion
- no transform matrix computation
- no homography/affine/similarity matrix output
- no render-ready overlay data
- no `board_graph.json`
- no `view_state.json`
- no Project ZIP contract change

## Next recommended pass

`PHOTO_ALIGNMENT_MATERIALIZER_AUDIT_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `py -3 -m unittest tests.test_materialize_known_facts`
- `py -3 -m unittest tests.test_project_zip`
- `git diff --name-only`
- `git status --short --branch`
