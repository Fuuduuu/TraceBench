# BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_PASS

Lane: `DOCS_SYNC`  
Mode: docs-only scope lock  
Status: completed

## Verdict

Scope lock accepted.

## Inputs confirmed

- `KNOWN_FACTS_DART_PLACEMENT_PARITY_PASS` is accepted and pushed.
- Dart KnownFacts now exposes `componentVisualPlacements`, satisfying the renderer-precondition gate.
- Claude Design “Board Canvas Read-Only Renderer — V1 UX Spec v2” is accepted as primary V1 UX input.

## Locked renderer scope (V1)

1. Renderer intent is strictly read-only and projection-consumer-only.
2. Renderer consumes `ProjectState.knownFacts` and footprint registry metadata, not raw JSON/event logs.
3. Renderer writes none:
   - no `events.jsonl`
   - no `known_facts.json`
   - no Project ZIP artifacts
   - no `board_graph.json`
   - no `view_state.json`
4. First renderer implementation excludes:
   - background photo helper layer
   - edit handles / drag / rotate / resize
   - confirm/save/apply/export/print/share actions
   - AI proposal UI and Top-3 candidate UI
   - event-writing UI
5. Empty states must be read-only and CTA-free.
6. Chrome/status must visibly include `renderer writes: none`.

## Evidence and semantics boundaries preserved

- `component_visual_placements` remain visual/documentation facts only.
- `template_id` does not prove electrical identity/function.
- `visual_trace` remains visual-only and must not promote to electrical net.
- trace color remains visual metadata only.
- measured evidence may be displayed only when already present in known facts; no inference/recalculation.
- damage/suspect are context-only and not confirmed fault conclusions.
- AI proposals remain non-canonical (`unconfirmed_ai_proposal`) and out of V1 renderer scope.

## Deferred surfaces

- background photo helper layer and photo alignment/opacity controls
- persisted layer/view state
- AI proposal layer and Top-3 workflow
- placement/template assignment editing
- event-writing UI
- performance-heavy renderer internals (scene graph/spatial index/hit testing caching)

## Locked future implementation split

1. `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`
2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`
3. `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
4. `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
5. `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`

## Next recommended pass

`BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`

