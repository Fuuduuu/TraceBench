# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS`

## Goal

Lock the V1 read-only board canvas renderer implementation boundary after KnownFacts Dart placement parity, without implementing renderer/UI code.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_GRAPH_SPEC.md` (only if renderer scope wording needs alignment)
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (only if renderer scope wording needs alignment)
- `docs/FLUTTER_UI_SPEC.md` (only if read-only renderer UX scope needs alignment)
- `docs/audit/BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS.md`

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
- CustomPainter implementation
- Canvas rendering
- scene graph implementation
- spatial index implementation
- hit testing implementation
- component editing UI
- event-writing UI
- AI proposal persistence
- camera/OCR/CV
- source search
- KiCad/boardview import/export
- BLE/cloud

## Locked decisions

1. V1 board canvas renderer intent is strict read-only projection rendering; it must not behave as an editor.
2. Accepted UX input: Claude Design “Board Canvas Read-Only Renderer — V1 UX Spec v2”.
3. Pro precondition is satisfied: Dart KnownFacts exposes `componentVisualPlacements`; renderer must consume `ProjectState.knownFacts`.
4. Renderer may consume only projection/model inputs:
   - `ProjectState.knownFacts`
   - `KnownFacts.componentVisualPlacements`
   - `KnownFacts.components`
   - `KnownFacts.pins` / `measurements` / `visualTraces` / `damageRegions` / `suspectRegions` only where already modeled and coordinate-compatible
   - vector footprint registry metadata
5. Renderer must not consume raw `known_facts.json` directly in renderer code, `events.jsonl`, Project ZIP files, `board_graph.json`, `view_state.json`, or AI proposal stores.
6. Renderer writes: none. No writes to `events.jsonl`, `known_facts.json`, Project ZIP artifacts, `board_graph.json`, or `view_state.json`; no mutation of canonical facts.
7. V1 visual scope may include confirmed visual placements, template-bound outlines, safe template fallback, unknown-identity styling, empty states, dark/light styling, and read-only status chrome.
8. First renderer implementation excludes:
   - background photo helper layer
   - edit handles/drag/rotate/resize
   - confirm/save/apply/export/print/share actions
   - AI proposal/Top-3/event-writing UI
9. Empty states must be read-only and CTA-free (no add/detect/import/upload/start/run actions).
10. Template/identity boundary is strict: `template_id` never confirms component identity or electrical function.
11. Visual/electrical boundary is strict:
    - `visual_trace` remains visual-only
    - trace color remains visual metadata
    - no net derivation from visual trace, intersections, or color
12. Measured evidence rendering is display-only from existing known facts; renderer must not infer, average, recalculate, or create measurements/nets.
13. Damage/suspect rendering is contextual only and must not imply confirmed fault conclusions.
14. Inspector may be read-only only; it must not expose confirm/edit/promote/measure/AI actions.
15. View/chrome state (pan/zoom/selection/layer visibility/side/theme) remains volatile in-memory V1; no `view_state.json`.
16. Future implementation split is locked:
    1. `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`
    2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`
    3. `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
    4. `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
    5. `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
