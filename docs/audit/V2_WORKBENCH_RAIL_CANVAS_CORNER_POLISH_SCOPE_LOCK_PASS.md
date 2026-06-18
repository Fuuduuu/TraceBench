# V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass for the future `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS` implementation. Runtime code, tests, tools, schemas, samples, generated/platform files, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` assets, staging, commit, or push actions are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `31ec25f` (`docs: record workbench context panel disclosure manual smoke`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `31ec25f` at `HEAD`, then `4ddfa57`, `a1c9080`, `46bdc26`, `1cf63c0`, and `ffba4ea`.
- `git diff --name-status`: clean before docs-only edits.
- `git diff --cached --name-status`: clean.
- `git diff --check`: PASS (CRLF normalization warnings only).

## FILES_READ

- user-provided `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS` prompt from attached pasted text.
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`

## SCOPE_LOCK_SUMMARY

Locked the implementation scope for `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS`:

- Docs-only scope lock focused on existing Workbench wide layout.
- Move `Focus canvas` out of the bulky left rail into a compact canvas-corner action.
- Refine left-rail discoverability and compactness (grouping, active/inactive affordances, labels, tooltips, icon sizing, spacing).
- Remove or de-emphasize the wide-rail `Hide inspector` action if redundant when contextual panel is panel-driven.
- Keep right contextual panel behavior read-only and preserve existing focus/show controls as recoverable.
- Keep existing `Placements` and `Safety / Evidence` rail/contextual behavior intact unless this scoped pass updates it as polish.
- Add scoped widget coverage for:
  - canvas-corner focus control presence/behavior,
  - show-controls restore clarity,
  - rail compactness and clarity,
  - redundant inspector-control removal/de-emphasis safety,
  - `renderer writes: none` visibility and no write-state behavior,
  - no runtime write/evidence-fact semantics.

## USER_DECISION_CAPTURE

The implementation target remains wide Workbench unless convention or local responsive tests require a safe narrow fallback.

## ROUTE_BEFORE_AFTER

- Before: accepted route `NEEDS_USER_DECISION` after `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_MANUAL_SMOKE_PASS`.
- After: current pass `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS`; next pass `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_SCOPE_LOCK_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`, `273` tests).
- `git status --short --branch`: tracked docs changed only for this scope-lock pass plus expected pre-existing untracked scratch/platform artifacts.
- `git diff --name-status`: docs-only changed files match expected scope-lock governance updates.
- `git diff --check`: PASS; CRLF normalization warnings only.

## SCOPE_DRIFT_CHECK

- No runtime code or tests were modified.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event changes.
- No placement/selection/tap-to-select/pan-zoom-fit, measurement, visual_trace, or photo-alignment runtime semantics were changed.
- No `_incoming` assets/code were copied into runtime.
- `renderer writes: none` behavior remains preserved by design intent for this pass.

## NEXT_STEP_FOR_USER

Proceed to `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS` implementation using this lock, then route to Claude Code read-only implementation post-audit.
