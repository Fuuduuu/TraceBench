# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_FIXUP_PASS`

## Goal

Apply docs-only renderer-readiness fixups from Claude audit (`PASS_WITH_NITS`) before any renderer implementation pass.

## Allowed surfaces

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/BOARD_CANVAS_READONLY_RENDERER_SPEC.md`
- `docs/BOARD_GRAPH_SPEC.md` (only if renderer scope wording needs alignment)
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` (only if renderer scope wording needs alignment)
- `docs/FLUTTER_UI_SPEC.md` (only if read-only renderer UX scope needs alignment)
- `docs/audit/BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_FIXUP_PASS.md`

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

1. Record Claude audit verdict: `PASS_WITH_NITS`.
2. V1 board canvas renderer intent remains strict read-only projection rendering; it must not behave as an editor.
3. Accepted UX input remains Claude Design “Board Canvas Read-Only Renderer — V1 UX Spec v2”.
4. Pro precondition remains satisfied: Dart KnownFacts exposes `componentVisualPlacements`; renderer must consume `ProjectState.knownFacts`.
5. Renderer may consume only projection/model inputs:
   - `ProjectState.knownFacts`
   - `KnownFacts.componentVisualPlacements`
   - `KnownFacts.components`
   - `KnownFacts.pins` / `measurements` / `visualTraces` / `damageRegions` / `suspectRegions` only where already modeled and coordinate-compatible
   - vector footprint registry metadata
6. Renderer must not consume raw `known_facts.json` directly in renderer code, `events.jsonl`, Project ZIP files, `board_graph.json`, `view_state.json`, or AI proposal stores.
7. Renderer writes: none. No writes to `events.jsonl`, `known_facts.json`, Project ZIP artifacts, `board_graph.json`, or `view_state.json`; no mutation of canonical facts.
8. First implementation pass is locked to `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS` only:
   - route/screen shell,
   - empty states (`no project`, `no components`, `components/no placements`),
   - status chrome includes `renderer writes: none`,
   - optional layer toggles only as volatile in-memory UI state.
9. Shell pass explicitly excludes:
   - `CustomPainter`
   - component placement drawing
   - coordinate math
   - read-only inspector
10. Explicitly deferred from shell pass and this fixup:
    - component placement rendering
    - visual_trace rendering
    - damage/suspect rendering
    - `photo_local` board-canvas rendering
    - background photo helper layer
    - AI proposal UI/persistence
    - edit/confirm/save/export actions
    - persisted view state and any `view_state.json` path
11. `photo_local` rule is locked:
    - `photo_local` visual evidence must not render on board canvas until accepted coordinate mapping is scoped in a dedicated pass.
12. V1 visual scope for later renderer passes may include confirmed visual placements, template-bound outlines, safe template fallback, unknown-identity styling, empty states, dark/light styling, and read-only status chrome.
13. First renderer implementation excludes:
   - background photo helper layer
   - edit handles/drag/rotate/resize
   - confirm/save/apply/export/print/share actions
   - AI proposal/Top-3/event-writing UI
14. Empty states must be read-only and CTA-free (no add/detect/import/upload/start/run actions).
15. Template/identity boundary is strict: `template_id` never confirms component identity or electrical function.
16. Visual/electrical boundary is strict:
    - `visual_trace` remains visual-only
    - trace color remains visual metadata
    - no net derivation from visual trace, intersections, or color
17. Measured evidence rendering is display-only from existing known facts; renderer must not infer, average, recalculate, or create measurements/nets.
18. Damage/suspect rendering is contextual only and must not imply confirmed fault conclusions.
19. Inspector may be read-only only; it must not expose confirm/edit/promote/measure/AI actions.
20. View/chrome state (pan/zoom/selection/layer visibility/side/theme) remains volatile in-memory V1; no `view_state.json`.
21. Future implementation split is locked:
    1. `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`
    2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`
    3. `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
    4. `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
    5. `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`

## Validate

- `py -3 tools\validate_all.py`
- `git diff --name-only`
- `git status --short --branch`
