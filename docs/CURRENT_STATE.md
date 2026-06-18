# Current State

## Current pass

`V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`

## Next recommended pass

`V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`

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
- Board Canvas UI auto-hide manual smoke is accepted/pushed as `10adac9` (`docs: record board canvas ui auto-hide smoke`); user evidence "Muidu käik töötas smoke testis" is recorded narrowly as Board Canvas focus/top-chrome flow worked in manual smoke.
- Project Overview / Workbench layout density is accepted/pushed/closed out as `19fc1c9` (`docs: close out project overview layout density`).
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, volatile focus mode, and persistent `renderer writes: none`.

## Current scope

This docs-only design-gap capture records `_incoming/ui_redesign/2026-06-14_workbench_home/` as design-input-only for an integrated technician workbench target. The reference is non-runtime and non-canonical; do not copy HTML/CSS/mockup code or assets into Flutter runtime.

Captured target: left vertical tool/action rail, center read-only board canvas as the dominant surface, and right contextual panel that updates on selected component. Future inline measurement entry belongs in the right panel as a writer host using the accepted writer path, explicit target selection, and human confirmation; it is not renderer write behavior and requires a separate protected scope-lock.

Next route is `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` for a UI-only 3-zone layout scope lock with renderer read-only.

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
