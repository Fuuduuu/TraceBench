# BOARD_CANVAS_READONLY_RENDERER_SPEC.md

Status: scope-locked design/implementation sequencing spec (no renderer code in this pass)

## 1. Intent

Define the V1 read-only board-canvas renderer scope and split sequence after KnownFacts Dart placement parity.

Renderer is a projection reader, not a fact editor.

## 2. Canonical boundaries

- `events.jsonl` remains canonical event truth.
- accepted events remain canonical current-domain truth.
- `known_facts.json` remains Python-materialized current projection.
- renderer consumes app projection state only; it does not create facts.
- no renderer writes to:
  - `events.jsonl`
  - `known_facts.json`
  - Project ZIP artifacts
  - `board_graph.json`
  - `view_state.json`
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.

## 3. Required renderer data path

Renderer must consume:

- `ProjectState.knownFacts`
- KnownFacts typed fields (including `componentVisualPlacements`)
- vector footprint registry metadata

Renderer must not consume:

- raw `known_facts.json` parsing inside renderer code
- direct `events.jsonl` reads
- direct Project ZIP reads
- AI proposal storage

## 4. Evidence boundaries

- `component_visual_placements` are visual/documentation facts only.
- `template_id` is geometry metadata only and does not prove electrical identity.
- `visual_trace` is visual-only and must not be promoted to measured/electrical net.
- trace color is visual metadata only.
- measured values may be displayed only if already present in known facts.
- renderer must not infer, average, recalculate, or synthesize evidence.
- damage/suspect overlays are context only and not fault proof.

## 5. Locked implementation split

1. `BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`
2. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS`
3. `BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_PASS`
4. `BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS`
5. `BOARD_CANVAS_READONLY_INSPECTOR_PASS`
6. `BOARD_CANVAS_VISUAL_TRACE_AND_EVIDENCE_SCOPE_AUDIT_PASS`
7. `BOARD_CANVAS_READONLY_RENDERER_QA_PASS`
8. `BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS`
9. `BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`

## 6. First implementation pass lock

First implementation pass is strictly:

`BOARD_CANVAS_READONLY_RENDERER_SHELL_PASS`

### 6.1 Shell pass allowed scope

- route/screen shell only
- empty states only:
  - no project loaded
  - no components
  - components present but no placements
- bottom/status chrome includes exact read-only cue:
  - `renderer writes: none`
- optional layer toggles only if volatile in-memory UI state

### 6.2 Shell pass forbidden scope

- `CustomPainter`
- any component drawing
- coordinate math/mapping
- inspector/details panel
- edit/confirm/save/export actions
- AI proposal UI
- event-writing UI

## 7. Second implementation pass scope lock (placement rendering)

`BOARD_CANVAS_COMPONENT_PLACEMENT_RENDERING_SCOPE_LOCK_PASS` locks the next implementation pass to:

- render read-only component visual placements only.
- render only `coordinate_space = board_normalized`.
- consume only:
  - `ProjectState.knownFacts.componentVisualPlacements`
  - `ProjectState.knownFacts.components`
  - vector footprint registry metadata
- preserve exact chrome text:
  - `renderer writes: none`
- preserve read-only/no-write boundaries from this spec.

It also locks explicit deferrals for this stage:

- no `photo_local` board rendering or coordinate conversion.
- no visual_trace, damage_region, suspect_region, or measurement rendering.
- no inspector/details panel.
- no AI proposal/UI actions.
- no background photo helper layer.
- no edit/confirm/save/export/event-writing actions.

## 8. Third implementation pass scope lock (read-only inspector)

`BOARD_CANVAS_READONLY_INSPECTOR_SCOPE_LOCK_PASS` locks the next implementation pass to:

- add a read-only inspector/details panel for selected, already-rendered placements/components only.
- use `ProjectState.knownFacts` typed models only:
  - `KnownFacts.componentVisualPlacements`
  - `KnownFacts.components`
  - vector footprint metadata
- keep selection state volatile/in-memory only.
- preserve route/render behavior and required status chrome:
  - `renderer writes: none`.

First inspector implementation selection rule:

- avoid canvas hit-testing in first inspector pass.
- use non-mutating selection controls (list/row/control selection) only.

Inspector deferrals and prohibitions in first inspector pass:

- no edit/confirm/save/export actions.
- no AI identify/detect/suggest actions.
- no event writing imports or callbacks.
- no `events.jsonl` direct read, no Project ZIP direct read.
- no raw `known_facts.json` parsing.
- no `board_graph.json` / `view_state.json`.
- no measurement/damage/suspect/visual_trace inspector expansion beyond separately scoped audits.

## 9. Deferred scope (explicit)

Deferred to later passes/audits:

- `CustomPainter` drawing implementation
- component placement rendering
- read-only inspector
- visual_trace rendering
- damage/suspect rendering
- `photo_local` rendering on board canvas
- background photo helper layer
- AI proposal UI/persistence
- view-state persistence and any `view_state.json` path

## 10. photo_local rule

`photo_local` visual evidence must not be rendered on board canvas until accepted coordinate mapping is scoped and audited in a dedicated pass.

## 11. UX safety constraints (V1 read-only)

- no edit handles
- no drag/rotate/resize
- no confirm/save/apply/export/print/share controls
- no Top-3 AI candidate UI
- empty states contain no action CTAs

## 12. Acceptance criteria for future renderer implementation

Future renderer acceptance requires all:

- strictly read-only behavior
- no event writing
- no known-facts mutation
- no Project ZIP contract change
- no `board_graph.json` / `view_state.json`
- no AI proposal rendering/persistence in V1
- no `template_id` to identity promotion
- no `visual_trace` to electrical-net promotion
- no background photo layer in first renderer implementation
- no raw JSON parsing inside renderer code

## 13. Audit note

Claude independent readiness audit verdict: `PASS_WITH_NITS`.
This spec captures the nits as locked sequencing and deferred-surface requirements before implementation.

## 14. Measurement summary scope-lock addendum

`BOARD_CANVAS_MEASUREMENT_SUMMARY_SCOPE_LOCK_PASS` locks measurement support direction to read-only inspector/list metadata only.

Allowed future direction (`BOARD_CANVAS_MEASUREMENT_SUMMARY_PASS`):

- consume `ProjectState.knownFacts.measurements` only.
- show values verbatim as read-only metadata.
- keep `renderer writes: none` boundary intact.

Forbidden future direction:

- no measurement canvas overlays.
- no inferred board/canvas anchors from measurement endpoint strings.
- no coordinate inference.
- no net/proximity inference from measurement summaries.
- no event writing, no known-facts mutation, no file writes.

Strict measurement-to-component association rule:

- include only when endpoint is exact `componentId` or begins with `componentId + "."`.
- no loose prefix matching (`Q2` must not match `Q20`).
