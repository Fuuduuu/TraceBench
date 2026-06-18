# Current State

## Current pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS`

## Current accepted route before this pass

`V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`

## Latest accepted pushed work

- Source/orientation refresh is accepted/pushed as `7269648` (`docs: refresh project source orientation`).
- Board Canvas top-chrome density scope lock is accepted/pushed as `d6797fd` (`docs: lock board canvas top-chrome density scope`).
- Project Overview / Workbench layout density is accepted/pushed/closed out as `19fc1c9` (`docs: close out project overview layout density`).
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, and persistent `renderer writes: none`.

## Current scope

This pass implements `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`, a Board Canvas-only UI density polish for top chrome/header and the selector/control row.

User screenshot review identified two remaining density issues:

- the top app bar/header with back button and "Board Canvas" title can be narrower/shorter;
- the row containing Placements, Safety / Evidence, and collapse/expand controls can be narrower and more compact.

The implementation goal is to compact the header and top control row so the board area becomes more dominant, without changing Board Canvas behavior or evidence/write boundaries.

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
