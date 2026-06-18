# Current State

## Current pass

`V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current accepted route before this pass

`NEEDS_USER_DECISION`

## Latest accepted pushed work

- Source/orientation refresh is accepted/pushed as `7269648` (`docs: refresh project source orientation`).
- Board Canvas top-chrome density scope lock is accepted/pushed as `d6797fd` (`docs: lock board canvas top-chrome density scope`).
- Board Canvas top-chrome density implementation is accepted/pushed as `462eab2` (`feat(board-canvas): compact top chrome density`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Board Canvas top-chrome density route is closed out as `669d9f5` (`docs: close out board canvas top-chrome density`).
- Board Canvas UI auto-hide scope lock is accepted/pushed as `e55b1f8` (`docs: lock board canvas ui auto-hide scope`).
- Board Canvas UI auto-hide implementation is accepted/pushed as `dd69545` (`feat(board-canvas): add canvas focus mode`) after Claude Code implementation post-audit `ACCEPT_AS_IS` with `SAFE_FOR_COMMIT_PUSH: YES`.
- Board Canvas UI auto-hide post-audit/closeout is accepted/pushed as `5b72aba` (`docs: close out board canvas ui auto-hide`); accepted route is `NEEDS_USER_DECISION`.
- Project Overview / Workbench layout density is accepted/pushed/closed out as `19fc1c9` (`docs: close out project overview layout density`).
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, volatile focus mode, and persistent `renderer writes: none`.

## Current scope

This docs-only manual smoke record captures user evidence for the accepted Board Canvas compact top-chrome and UI focus mode. User wording: "Muidu käik töötas smoke testis". This is interpreted narrowly as: Board Canvas focus/top-chrome flow worked in manual smoke testing.

This pass does not accept or promote the separate `_incoming/ui_redesign/2026-06-14_workbench_home` reference screenshot as current implementation. That reference remains a separate future route-review/design-gap topic unless explicitly scoped later. Route remains `NEEDS_USER_DECISION`.

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
