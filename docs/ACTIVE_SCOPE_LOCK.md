# Active Scope Lock

## Current pass

`V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS`

## Type

`CODEX / DOCS_SCOPE_LOCK`

## Lane
Docs-only scope lock for Workbench contextual panel disclosure flow on the accepted 3-zone layout.
Governance docs are limited to `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS.md`.
Do not stage, commit, or push in this pass.

## Current goal

Lock the next narrow implementation slice for a wide Workbench contextual-panel disclosure mode in read-only readback behavior and route to implementation.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS` is accepted/pushed as `ffba4ea` (`feat(board-canvas): refine workbench tool rail density`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS` is accepted/pushed as `289e21a` (`docs: record workbench tool rail impl post-audit`).
- `V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS` is accepted/pushed as `1cf63c0` (`docs: record workbench tool rail manual smoke`) and the current baseline for this lock was user wording "Muidu kõik töötab nii nagu peab".
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only and not accepted as implementation.
- Board Canvas read-only boundaries and focus/top-chrome behavior were accepted in prior passes.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS.md`

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Strict forbidden implementation scope

- No runtime/test/tooling/schema/materializer/validator/projection/Project ZIP changes.
- No board-canvas runtime behavior changes.
- No board-normalized placement/selection semantics changes.
- No top-band UI changes for this pass unless moved into rail disclosure.
- No inline measurement entry, Save, unit selector, or value editing.
- No writer/schema/materializer/validator/projection/Project ZIP/event/fact path changes.
- No `/project/measure-sheet` deletion or delete route consolidation.
- Renderer must remain read-only.
- `renderer writes: none` must remain true.

## Current route lock

Current pass: `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS`

Next: `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
- Future inline measurement entry (value/unit/Save) is deferred to `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`.
- Pin/lock/info-bar contextual-panel affordance is deferred and is not required behavior for this scope-lock.
