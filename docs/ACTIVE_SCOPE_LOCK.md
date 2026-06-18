# Active Scope Lock

## Current pass

`V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS`

## Type

`CLAUDE_CODE / AUDIT_ONLY`

## Lane

Claude Code implementation read-only post-audit pass. Runtime/tests remain unchanged.
Governance docs are limited to route/audit documents and `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS.md`.
Do not stage, commit, or push.

## Current goal

Verify and record post-audit acceptance for `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`:

- left vertical rail;
- center read-only Board Canvas as dominant surface;
- right read-only contextual panel container.

This pass is governance-only: `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` must remain unchanged and accepted/pushed.

## Baseline

- `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS` is accepted/pushed as `5d88998` (`docs: lock workbench bench layout scope`).
- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` is accepted/pushed as `3936cc2` (`feat(board-canvas): add workbench 3-zone layout shell`).
- `_incoming/ui_redesign/2026-06-14_workbench_home/` is design-input-only, non-runtime, non-canonical, not copied into Flutter runtime, and not accepted as implementation.
- Board Canvas is accepted/pushed/manual-smoke PASS.
- Board Canvas focus/top-chrome behavior has user smoke evidence: "Muidu käik töötas smoke testis".
- Renderer remains read-only.
- `renderer writes: none` must remain true.

## Post-audit summary

- `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` was independently reviewed and accepted as-is.
- No runtime code/test files were changed in this post-audit pass.
- Verification evidence confirms no forbidden-surface drift from this implementation.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS.md`

## Required checks

- `py -3 tools/validate_all.py`
- `git diff --check`
- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`

- Wide layout has three named zones.
- Center canvas remains dominant over rail/context panel.
- Renderer remains read-only.
- `renderer writes: none` remains visible or safely recoverable.
- Rail future tools remain inert.
- No events/facts are written.

## Strict forbidden implementation scope

- No inline measurement entry.
- No right-panel Save button.
- No new write path.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No routing/navigation consolidation.
- No deletion of `/project/measure-sheet`.
- No component/fact/event/coordinate/net/path/trace/probe/pin/pad semantic changes.
- No renderer behavior changes.
- No board-normalized placement semantics changes.
- No selected placement semantics changes.
- No tap-to-select behavior changes except preserving existing UI selection.
- No pan/zoom/fit behavior changes.
- No measurement association/count logic changes.
- No visual_trace geometry or interpretation changes.
- No photo-alignment semantics changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide dark theme or token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No copying `_incoming` HTML/CSS/assets into runtime.
- Renderer must remain read-only.
- `renderer writes: none` must remain true.

## Required validation

- `py -3 tools/validate_all.py`
- `git diff --check`

## Current route lock

Current pass: `V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS`

Next: `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`

## Scope carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Photo pixels are not facts.
- `visual_trace` is not a net.
- No V2 `sequence`.
- Project ZIP import/export remains out of scope.
