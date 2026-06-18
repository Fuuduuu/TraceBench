# V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass for the future `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` implementation. Runtime code, tests, tools, schemas, samples, generated/platform files, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` assets, staging, commit, and push actions are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `027e594` (`docs: record workbench rail canvas-corner polish manual smoke`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `027e594` at HEAD, then `df2dbe9`, `c8bfd3b`, `2f03346`, `31ec25f`, and `4ddfa57`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: PASS (`CRLF` normalization warnings only if present).

## FILES_READ

- User-provided pasted scope-lock prompt for `V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS`
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/audit/V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS.md`

## DESIGN_INPUT_SUMMARY

- Accept the existing 3-zone Workbench as baseline direction.
- Keep the rail as the contextual panel-mode switcher with clear icon+label+tooltip actions.
- Remove `Hide inspector` from the wide rail.
- Remove redundant Workbench/title-like rail item if present.
- Keep `Focus canvas` as a canvas-corner action, not a rail control.
- Keep future tools visible but clearly ghosted/inert.
- Preserve read-only behavior: right panel content remains read-only, selection still drives inspector mode, and `renderer writes: none` remains present.

## SCOPE_LOCK_SUMMARY

Locked implementation scope for `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS`:

- Docs-only lock for Workbench wide-rail button grammar only.
- Replace current rail chrome with grouped mode entries:
  - `Inspector` (selected component/placement mode),
  - `Placements`,
  - `Safety`,
  - `Trace` (future),
  - `Repair map` (future),
  - optional `More` only if implementation can remain inert/safe.
- Rail actions should be explicit panel-mode switches; active mode should be visible via semantics beyond color only (indicator/tint/weight/border).
- `Hide inspector` removed from wide rail; empty-canvas click remains the default dismiss behavior.
- No movement of canonical placement/selection semantics, renderer behavior, tap-to-select, pan/zoom/fit, measurement association/count, visual_trace geometry/interp, photo-alignment, or route consolidation.
- No inline value/unit/Save write-flow behavior.

## ROUTE_BEFORE_AFTER

- Before: current accepted route `NEEDS_USER_DECISION` after `V2_WORKBENCH_RAIL_CANVAS_CORNER_POLISH_MANUAL_SMOKE_PASS` at `027e594`.
- After: current pass `V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS`; next `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `273` tests).
- `git diff --name-status`: expected docs-only changed file set.
- `git diff --cached --name-status`: clean.
- `git diff --check`: PASS; CRLF normalization warnings only if present.

## SCOPE_DRIFT_CHECK

- No runtime files under `lib/` were changed.
- No test files under `test/` were changed.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event tooling or surface files were changed.
- No `_incoming` content copied to runtime.
- `renderer writes: none` remains part of accepted behavior context.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after the next implementation pass and post-audit is:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_WORKBENCH_RAIL_BUTTON_POLISH_SCOPE_LOCK_PASS.md`

## NEXT_STEP_FOR_USER

Proceed to `V2_WORKBENCH_RAIL_BUTTON_POLISH_IMPL_PASS` with this scope-lock, then route back through Claude Code read-only implementation post-audit before staging, commit, or push.
