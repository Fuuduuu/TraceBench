# BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS

## PASS_ID
`BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_SCOPE_LOCK_PASS`

## Lane
`DOCS_SYNC`

## Mode
Docs-only scope lock.

## Decision
Future board-canvas visual-trace support is locked to read-only inspector/list metadata only.

## Context and dependency
- Photo evidence alignment closeout decision remains: `DEFER_PHOTO_ALIGNMENT_IMPLEMENTATION`.
- `visual_trace` geometry remains photo-local/photo-tied for board-canvas purposes.
- No accepted photo-to-board transform/alignment model exists.
- No background photo helper layer is accepted in this scope.

## Future implementation pass
`BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`

## Allowed future direction
- Add read-only visual-trace metadata summary to existing board-canvas inspector/list area.
- Consume `ProjectState.knownFacts.visualTraces` only.
- Use only currently exposed Dart `VisualTraceFact` metadata fields:
  - `traceId`
  - `photoId`
  - `evidenceType`
  - `fromComponent`
  - `toComponent`
  - `fromPin`
  - `toPin`
  - `confidence`
  - `layer`
  - `notes`
- Show explicit warning/safety copy:
  - `Visual trace — read-only metadata`
  - `Visual trace is not a confirmed electrical net`
  - `Photo-local evidence; no board coordinate available`
  - `Does not create or confirm connectivity`
- Preserve existing board-canvas rendering/inspector/measurement-summary behavior.
- Preserve required chrome: `renderer writes: none`.

## Strict association rule
Visual trace may be associated with selected component only if:
- `trace.fromComponent == componentId`
- `trace.toComponent == componentId`
- `trace.fromPin` starts with `componentId + "."`
- `trace.toPin` starts with `componentId + "."`

Explicitly forbidden:
- loose prefix matching (`Q2` must not match `Q20`)
- matching by proximity/nets/measurements/template/overlap

## Explicitly forbidden in future implementation
- visual-trace canvas polyline/geometry rendering
- reading/rendering `from_point`/`to_point` geometry on board canvas
- photo-local to board transform/alignment implementation
- background photo helper layer
- net/connectivity inference/promotion from visual traces
- event writing or known-facts mutation
- `board_graph.json` / `view_state.json` behavior
- Project ZIP contract changes

## Boundaries reaffirmed
- visual_trace is visual-only evidence.
- trace color is visual metadata only.
- visual_trace is not measured connectivity.
- renderer writes nothing.

## Next recommended pass
`BOARD_CANVAS_VISUAL_TRACE_INSPECTOR_PASS`
