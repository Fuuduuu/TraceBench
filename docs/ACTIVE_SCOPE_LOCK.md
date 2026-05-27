# ACTIVE_SCOPE_LOCK.md

## Current pass

`VECTOR_FOOTPRINT_LIBRARY_SPEC_FIXUP_PASS`

## Goal

Apply narrow docs-only fixups requested by `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_PASS` before implementation-scope routing.

## Allowed surfaces

- `docs/VECTOR_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/VECTOR_FOOTPRINT_LIBRARY_SPEC_FIXUP_PASS.md`

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
2. Human-facing identity-leakage guardrails are tightened across `template_id`, `display_name`, `description`, `package_family`, accessibility labels, and style labels.
3. Unknown fallback policy is explicit (`unknown_rect`, `unknown_2pin`, `unknown_3pin`, `unknown_multi_pin`).
4. Template-local coordinate convention is explicit (normalized units, centered default origin, `x` right, `y` down, shared frame for geometry anchors).
5. Field semantics are tightened for `origin`, `bounding_box`, `pin_count_rules`, `allowed_variants`, `default_style_tokens`, `lod_hints`, and `hit_test_shape`.
6. Pin anchors remain geometric-only and cannot imply/create `pin_defined` facts.
7. Variant relationship constraints are explicit (bbox/extents/label-anchor/determinism/template-identity separation).
8. Renderer consumption remains future interface guidance only; no implementation choices are locked.
9. AI candidate suggestion boundary remains future non-canonical workflow only.
10. Top-3 AI candidate display remains outside core footprint library requirement.
11. Evidence/ownership boundaries remain unchanged:
   - accepted events are canonical domain truth,
   - `known_facts.json` remains projection,
   - no AI proposal canonicalization,
   - no `visual_trace` -> measured net promotion,
   - no `board_graph.json` / `view_state.json` in V1,
   - no Project ZIP contract change.
12. Next recommended pass after this fixup is `VECTOR_FOOTPRINT_LIBRARY_SPEC_AUDIT_02_PASS`.

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
