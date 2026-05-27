# ACTIVE_SCOPE_LOCK.md

## Current pass

`VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS`

## Goal

Write the formal Vector Footprint Library specification before any renderer/UI implementation scope.

## Allowed surfaces

- `docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/VECTOR_FOOTPRINT_LIBRARY_SPEC_PASS.md`

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
- `board_graph.json`
- `view_state.json`
- Project ZIP tooling/files
- Flutter renderer implementation
- `CustomPainter` implementation
- scene graph implementation
- spatial index implementation
- hit testing implementation
- AI proposal persistence
- component editing UI
- camera/OCR/CV
- KiCad import/export
- source search

## Scope decisions

1. Footprint template model is formally specified as parametric package/geometry definitions.
2. `template_id` remains non-identity/non-electrical/non-fault evidence metadata.
3. Required template fields, pin-anchor model, and variant-parameter model are specified.
4. V1 template set and deferred template families are explicitly locked in spec.
5. Forbidden identity-leaking template naming is documented.
6. Renderer consumption is documented as future interface guidance only; no implementation choices are locked.
7. AI candidate suggestion boundary is documented as future non-canonical workflow only.
8. Top-3 AI candidate display remains outside core footprint library requirement.
9. Evidence/ownership boundaries remain unchanged:
   - accepted events are canonical domain truth,
   - `known_facts.json` remains projection,
   - no AI proposal canonicalization,
   - no `visual_trace` -> measured net promotion,
   - no `board_graph.json` / `view_state.json` in V1,
   - no Project ZIP contract change.
10. Next recommended pass after this specification is `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
