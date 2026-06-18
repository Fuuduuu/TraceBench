# Active Scope Lock

## Current pass

`V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS`

## Type

`CLAUDE_CODE / AUDIT_ONLY`

## Lane
Docs-only post-audit implementation closeout for `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`.
Governance docs are limited to `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS.md`.
Do not stage, commit, or push in this pass.

## Current goal

Record that the `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS` implementation was independently
post-audited as `ACCEPT_AS_IS` and is accepted/pushed with `SAFE_FOR_COMMIT_PUSH: YES`, then route to `NEEDS_USER_DECISION`.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS` is accepted/pushed as `ffba4ea` (`feat(board-canvas): refine workbench tool rail density`).
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only and not accepted as implementation.
- Board Canvas read-only boundaries and focus/top-chrome behavior were accepted in prior passes.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS.md`

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Strict forbidden implementation scope

- No runtime/test/tooling/schema/materializer/validator/projection/Project ZIP changes.
- No board-canvas runtime behavior changes.
- Renderer must remain read-only.
- `renderer writes: none` must remain true.

## Current route lock

Current pass: `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS`

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
