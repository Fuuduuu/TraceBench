# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_DESIGN_PASS`

## Goal

Define a formal design/spec for a future boardview-like vector canvas and internal vector footprint library while preserving TraceBench evidence boundaries and protected surfaces.

## Allowed surfaces

- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_DESIGN_PASS.md`

## Forbidden surfaces

- `lib/**`
- `test/**`
- `tools/**`
- `schemas/**`
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
- event-writing implementation
- component editing UI implementation
- camera/OCR/CV
- AI diagnostics/fault probability
- source search
- KiCad/boardview import/export
- BLE/cloud

## Scope decisions to lock

1. This pass is design/spec-only and does not introduce runtime behavior.
2. Every AI-placed/suggested object starts as `status = "unconfirmed_ai_proposal"`.
3. Unconfirmed AI proposals are render-layer drafts only:
   - not canonical facts
   - not written to `events.jsonl`
   - not materialized as confirmed facts in `known_facts.json`
4. Human confirmation must happen one object at a time.
5. No `confirm all AI suggestions` workflow in initial design.
6. `visual_trace` remains visual-only; electrical/net confirmation still requires accepted measurement/source-backed evidence.
7. Trace colors/categories are visual metadata only unless backed by accepted measurement/net evidence.
8. Vector footprint template and electrical identity remain separate concepts.
9. Renderer/projection remain read-only derived surfaces and write nothing to Project ZIP artifacts.
10. Boardview design baseline supports both dark and light visual themes.
11. Default boardview is vector-only; optional reference photo layer may be toggled ON/OFF with adjustable opacity.
12. Vector component rendering supports adjustable opacity/transparency for practical overlay work.
13. AI proposals use visually distinct reddish unconfirmed styling (ghosted/transparent + dashed + unconfirmed badge) and never claim electrical certainty.
14. Customer-facing report/export default remains confirmed facts only; unconfirmed AI proposals are excluded unless a future explicitly scoped pass adds clearly labeled proposal export.

## Validate

- `py -3 tools\validate_all.py`
