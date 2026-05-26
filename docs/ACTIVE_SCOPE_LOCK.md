# ACTIVE_SCOPE_LOCK.md

## Current pass

`DOCS_DRIFT_MINI_CLEANUP_11_PASS`

## Goal

Run a narrow docs-only drift cleanup after placement/schema/projection acceptance and align canonical docs to current repository truth.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_GRAPH_SPEC.md` (only if stale wording needs alignment)
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (only if stale wording needs alignment)
- `docs/audit/DOCS_DRIFT_MINI_CLEANUP_11_PASS.md`

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
- Flutter implementation
- schema implementation
- validator implementation
- materializer implementation
- renderer implementation
- event-writing UI
- component editing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Scope decisions

1. `component_visual_placement_confirmed` is accepted in schema/validator and must remain visual/documentation-only.
2. `known_facts.json` top-level `component_visual_placements` projection is accepted and must remain non-electrical evidence.
3. AI proposal boundary remains strict: `unconfirmed_ai_proposal` is non-canonical until explicit human confirmation.
4. `graph_layout` remains non-canonical.
5. `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
6. External AI Component Reading Simulation Lab is out-of-repo scope and must not be mixed into TraceBench repo truth.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
