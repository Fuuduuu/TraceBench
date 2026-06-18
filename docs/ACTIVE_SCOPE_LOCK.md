# Active Scope Lock

## Current pass

`V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane

Docs-only scope-lock for the next narrow Workbench rail/canvas-corner polish implementation pass `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS`.
Governance docs are limited to `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS.md`.
No code/runtime/test edits are in scope. Do not stage, commit, or push in this pass.

## Current goal

Lock the implementation scope for `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS`:

- move the existing `Focus canvas` control toward a compact canvas-corner action style;
- make the wide Workbench left rail clearer and denser with better grouping, labels, tooltips, and icon sizing;
- remove or de-emphasize the wide-rail `Hide inspector` control if it is redundant once context-panel-driven flow is clear;
- keep context-panel disclosure behavior, read-only renderer semantics, and focus/show controls intact;
- preserve no-write and no-canonical-semantic changes.

## Baseline

- `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS` is accepted/pushed as `422416f` (`docs: capture workbench home redesign design gap`).
- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS` is accepted/pushed as `ffba4ea` (`feat(board-canvas): refine workbench tool rail density`) and `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS` is accepted/pushed as `289e21a`.
- `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS` is accepted/pushed as `46bdc26` (`docs: lock workbench context panel disclosure scope`).
- `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS` is accepted/pushed as `a1c9080` (`feat(board-canvas): add workbench context panel disclosure`) and `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_POST_AUDIT_PASS` is accepted/pushed as `4ddfa57` (`docs: record workbench context panel disclosure impl post-audit`).
- `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS` is accepted/pushed as `31ec25f` (`docs: record workbench context panel disclosure manual smoke`).
- `NEEDS_USER_DECISION` is the accepted route before this lock.
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only and not accepted as implementation.
- `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS` remains the deferred route for inline value/unit/Save/read-write panel work.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS.md`

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Strict forbidden implementation scope

- Runtime or test changes are out of scope in this lock pass.
- Wide Workbench layout only unless implementation proves a safe narrow fallback is required.
- No placement, selection, tap-to-select, pan/zoom/fit, measurement association/count, visual_trace geometry/interp, photo-alignment, or route-consolidation changes.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event edits.
- No inline measurement value/unit entry, Save behavior, new write path, theme/token migration, or generated/platform/pubspec changes.
- `renderer writes: none` must remain present and visible.

## Current route lock

Current pass: `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS`

Next: `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth; `known_facts.json` is projection/cache.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Board Canvas focus controls are local UI state only.
- Focus-canvas canvas-corner polish and inspector-hide refinement are implemented only in the next implementation pass.
