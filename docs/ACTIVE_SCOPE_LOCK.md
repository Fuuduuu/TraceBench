# ACTIVE_SCOPE_LOCK.md

## Current pass

`KNOWN_FACTS_DART_PLACEMENT_PARITY_SCOPE_LOCK_PASS`

## Goal

Lock narrow pre-renderer scope: add Dart KnownFacts parity for `component_visual_placements` before any board-canvas renderer implementation.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/KNOWN_FACTS_DART_PLACEMENT_PARITY_SCOPE_LOCK_PASS.md`

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
- renderer/UI code
- `board_graph.json`
- `view_state.json`
- CustomPainter/canvas/scene-graph/spatial-index/hit-test implementation
- AI proposal persistence
- materializer/projection semantics changes

## Locked decisions

1. Record Pro verdict: `NEEDS_DART_MODEL_PARITY_FIRST`.
2. Lock KnownFacts Dart placement parity as mandatory precondition before renderer scope/implementation.
3. Lock next pass: `KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS`.
4. Lock future parity implementation allowlist:
   - `lib/shared/models/known_facts.dart`
   - relevant unit tests
   - docs ledger files
5. Explicitly forbid renderer implementation and renderer-side raw known-facts JSON parsing in this pass and in `KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS`.
6. Do not change schemas, tools/materializer, Project ZIP tooling, events/known_facts artifacts, or projection semantics.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
