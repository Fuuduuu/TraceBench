# Current State

## Current pass

`PROJECT_SOURCE_GUIDE_REFRESH_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current accepted route

`NEEDS_USER_DECISION`

## Latest accepted pushed work

- Latest pushed closeout: `19fc1c9` (`docs: close out project overview layout density`).
- `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS` is accepted/pushed and records Claude Code `ACCEPT_AS_IS` for `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`.
- Project Overview / Workbench layout density is accepted, pushed, and closed out: the read-only board/workbench preview is larger and dominant; the right rail was compacted from 300px to 252px; rail spacing/status chips/helper copy were tightened; Future tools collapse by default through a restorable `ExpansionTile`; expanded Future tools remain disabled/inert; primary actions, existing routes, read-only preview behavior, and existing keys were preserved.
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety/Evidence controls, canvas status overlay, volatile inspector hide/show, and persistent `renderer writes: none`.
- No Board Canvas runtime/tests were changed by the Project Overview density pass.
- writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces were not touched by the Project Overview density pass.

## Safe future options

- Manual Project Overview / Workbench visual smoke record.
- UI-only auto-hide scope lock.
- Multi-placement fixture coverage.
- Another route-review if needed.

## Core boundaries

- `events.jsonl` is canonical truth; `known_facts.json` is projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- Board Canvas remains read-only unless separately scoped.
- No V2 `sequence`.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Pointers

- Current/next pass routing: `docs/PASS_QUEUE.md`
- Active allowed/forbidden surfaces: `docs/ACTIVE_SCOPE_LOCK.md`
- Accepted history and audit evidence: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`
- Stable architecture truth: `docs/PROJECT_MEMORY.md`
- Source/orientation index: `docs/SOURCES_INDEX_CURRENT.md`
