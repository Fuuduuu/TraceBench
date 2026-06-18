# Active Scope Lock

## Current pass

`V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS`

## Type

`CODEX / DOCS_MANUAL_QA_RECORD`

## Lane
Docs-only manual smoke recording for accepted implementation pass `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS`.
Governance docs are limited to `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS.md`.
No code/runtime/test edits are in scope. Do not stage, commit, or push in this pass.

## Current goal

Record manual smoke evidence for `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS` while preserving post-audit acceptance and route continuity.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS` is accepted/pushed as `ffba4ea` (`feat(board-canvas): refine workbench tool rail density`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS` is accepted/pushed as `289e21a` (`docs: record workbench tool rail impl post-audit`).
- `V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS` is accepted/pushed as `1cf63c0` (`docs: record workbench tool rail manual smoke`) and the current baseline for this pass is user wording "Muidu kõik töötab nii nagu peab".
- `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS` is accepted/pushed as `46bdc26` (`docs: lock workbench context panel disclosure scope`).
- `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS` is accepted/pushed as `a1c9080` (`feat(board-canvas): add workbench context panel disclosure`) after post-audit `ACCEPT_AS_IS`.
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only and not accepted as implementation.
- Board Canvas read-only boundaries and focus/top-chrome behavior were accepted in prior passes.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS.md`

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Strict forbidden implementation scope

- Runtime/test/other scope edits are out of scope in this post-audit pass.
- `renderer writes: none` must remain true.

## Current route lock

Current pass: `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS`

Next: `NEEDS_USER_DECISION`

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
- Pin/lock/info-bar contextual-panel affordance is deferred and is not required behavior for this pass.
