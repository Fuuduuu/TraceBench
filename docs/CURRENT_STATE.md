# Current State

## Current pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

## Next recommended pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS`

## Current accepted route before this pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`

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
- Project Overview / Workbench layout density is accepted/pushed/closed out as `19fc1c9` (`docs: close out project overview layout density`).
- Board Canvas layout-density polish is accepted/pushed and manual-smoke PASS with user wording: "kõik on passed. ja töötab". The accepted Board Canvas state includes read-only renderer shell, board-normalized placements, chip/selector flow, read-only inspector, measurement summary, visual-trace metadata, photo-alignment readiness metadata-only panel, pan/zoom/fit, component-level measurement badges/counts, selected inspector related-measurement count, UI-only tap-to-select, compact chrome, collapsed Placement and Safety / Evidence controls, canvas status overlay, volatile inspector hide/show, volatile focus mode, and persistent `renderer writes: none`.

## Current scope

This local implementation pass adds the UI-only 3-zone Board Canvas / Workbench shell: left vertical rail, center read-only Board Canvas zone as the dominant surface, and right read-only contextual panel container.

The `_incoming/ui_redesign/2026-06-14_workbench_home/` reference remains design-input-only: non-runtime, non-canonical, no HTML/CSS/mockup code copied into Flutter runtime, no runtime assets copied, and not accepted as implementation.

Next route is `V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS` for Claude Code read-only implementation audit. The implementation must remain UI-only: no inline measurement entry, Save controls, new write paths, routing consolidation, `/project/measure-sheet` deletion, renderer behavior changes, or canonical/event/fact/projection/schema/Project ZIP changes.

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
