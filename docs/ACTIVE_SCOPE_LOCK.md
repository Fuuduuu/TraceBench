# ACTIVE_SCOPE_LOCK.md

## Current pass

`GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS`

## Goal

Lock global event.status policy/scope before any implementation changes to validator reference indexes or materializer accepted-only projection behavior.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PROJECT_MEMORY.md`
- `docs/TRUTH_INDEX.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/GLOBAL_EVENT_STATUS_SEMANTICS_SCOPE_LOCK_PASS.md`
- `docs/BOARD_GRAPH_SPEC.md` (only if needed for policy wording alignment)
- `docs/PROTECTED_SURFACES.md` (only if needed for policy wording alignment)

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
- schema implementation
- validator implementation
- materializer implementation
- known_facts schema/projection implementation
- Flutter/runtime code
- renderer/UI
- AI proposal persistence
- sample refresh

## Scope decisions

1. `GLOBAL_EVENT_STATUS_SEMANTICS_AUDIT_PASS` verdict is `SPLIT_FIX_NEEDED`.
2. Accepted events are canonical source for domain facts.
3. Non-accepted events may remain in `events.jsonl` as audit/history/review data.
4. Non-accepted events must not silently create current domain facts in `known_facts.json`.
5. Domain references must resolve to prior accepted source events unless a specific audit/metadata event family explicitly allows all-status references.
6. Reference semantics and projection semantics must be aligned.
7. `component_visual_placement_confirmed` remains stricter in current implementation:
   - validator accepted-only provenance references
   - materializer accepted + user-only
8. Split implementation sequence is locked:
   - `VALIDATOR_REFERENCE_STATUS_NORMALIZATION_PASS`
   - `MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS`
   - `STATUS_SEMANTICS_REGRESSION_PASS` only if impact requires fixture/ZIP alignment updates
9. No global materializer status behavior changes are allowed before `MATERIALIZER_ACCEPTED_ONLY_POLICY_PASS`.
10. No sample/fixture refresh is allowed before regression impact is measured and explicitly scoped.
11. Preserve:
   - placement visual/documentation-only boundary
   - no `visual_trace` -> measured-net promotion
   - no AI proposal -> confirmed fact promotion

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
