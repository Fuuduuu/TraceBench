# Current State

## Current pass

`V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS`

## Current accepted route before this pass

`NEEDS_USER_DECISION`

## Current accepted route during this pass

`V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS`

## Latest accepted pushed work

- Source/orientation refresh is accepted/pushed as `7269648` (`docs: refresh project source orientation`).
- Board Canvas top-chrome density scope lock is accepted/pushed as `d6797fd` (`docs: lock board canvas top-chrome density scope`).
- Board Canvas top-chrome density implementation is accepted/pushed as `462eab2` (`feat(board-canvas): compact top chrome density`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Board Canvas top-chrome density route is closed out as `669d9f5` (`docs: close out board canvas top-chrome density`).
- Board Canvas UI auto-hide scope lock is accepted/pushed as `e55b1f8` (`docs: lock board canvas ui auto-hide scope`).
- Board Canvas UI auto-hide implementation is accepted/pushed as `dd69545` (`feat(board-canvas): add canvas focus mode`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Board Canvas UI auto-hide post-audit/closeout is accepted/pushed as `5b72aba` (`docs: close out board canvas ui auto-hide`); accepted route is `NEEDS_USER_DECISION`.
- Board Canvas UI auto-hide manual smoke is accepted/pushed as `10adac9` (`docs: record board canvas ui auto-hide smoke`); user evidence "Muidu käik töötas smoke testis" is recorded narrowly as Board Canvas focus/top-chrome flow worked in manual smoke.
- Workbench Home redesign design-gap capture is accepted/pushed as `422416f` (`docs: capture workbench home redesign design gap`); `_incoming/ui_redesign/2026-06-14_workbench_home/` is registered as design-input-only and W1-W11 routing is captured.
- Workbench bench-layout scope lock is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`); implementation is limited to UI-only 3-zone Board Canvas / Workbench layout shell.
- Workbench 3-zone Board Canvas shell implementation is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`); `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` post-audit was accepted `AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Workbench tool rail refinement is accepted/pushed as `ffba4ea` (`feat(board-canvas): refine workbench tool rail density`) after implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Workbench manual smoke evidence record is accepted/pushed as `1cf63c0` (`docs: record workbench tool rail manual smoke`) indicating user wording "Muidu kõik töötab nii nagu peab" as narrow smoke pass for the current 3-zone layout and left-rail flow.
- Workbench context-panel disclosure implementation is accepted/pushed as `a1c9080` (`feat(board-canvas): add workbench context panel disclosure`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Workbench canvas-corner polish implementation is accepted/pushed as `c8bfd3b` (`feat(board-canvas): move focus canvas to canvas-corner action`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Workbench canvas-corner polish manual smoke evidence is accepted as `027e594` (`docs: record workbench rail canvas-corner polish manual smoke`) with user report interpreted narrowly as flow PASS.
- Project Overview / Workbench layout density is accepted/pushed/closed out as `19fc1c9` (`docs: close out project overview layout density`).
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, volatile focus mode, and persistent `renderer writes: none`.

## Current scope

Current acceptance context after post-audit:

- Active work in scope is a new lock for Workbench rail-button polish. Current accepted runtime behavior remains:
  - 3-zone Workbench layout with dominant read-only canvas.
  - selection-driven contextual right panel for inspector/placement/safety modes;
  - `Focus canvas` as canvas-corner control;
  - `Hide/Show controls` recovery behavior;
  - `Placements` and `Safety / Evidence` rail/contextual behavior preserved.
- Scope-lock changes are now locked for the next implementation pass and include:
  - remove `Hide inspector` from the wide rail;
  - remove redundant Workbench/title-like rail item if present;
  - make the wide rail explicitly a contextual panel-mode switcher;
  - keep future tools visible but clearly disabled/inert;
  - require clear icon + label + tooltip rail actions without truncation;
  - keep all read-only, `renderer writes: none`, and panel-content behavior unchanged.
- `_incoming/ui_redesign/2026-06-14_workbench_home/` remains design-input-only and is not part of accepted runtime behavior.

## Current accepted behavior evidence

- Workbench context-panel disclosure flow passed manual smoke in a user test report ("Kõik passed aga teeks paar muudatust"), interpreted narrowly as:
  - Workbench wide layout with left-rail-discovered `Placements` and `Safety / Evidence` disclosures,
  - right contextual panel opening from rail selection or component selection,
  - panel empty/default state when no meaningful contextual mode is selected,
  - empty-canvas deselection clearing local UI state and collapsing the right panel.
- Workbench rail/canvas-corner polish manual smoke passed in user report ("hide inspector nupp on ikka alles..."), interpreted narrowly as flow PASS with current behavior and `renderer writes: none` preserved.

Next route is `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS`.

## Core boundaries

- `events.jsonl` is canonical truth; `known_facts.json` is projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- Board Canvas remains read-only unless separately scoped.
- `renderer writes: none` must remain true.
- No V2 `sequence`.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Pointers

- Current/next pass routing: `docs/PASS_QUEUE.md`
- Active allowed/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Accepted history and audit evidence: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
- Stable architecture truth: `docs/PROJECT_MEMORY.md`
- Source/orientation index: `docs/SOURCES_INDEX_CURRENT.md`
