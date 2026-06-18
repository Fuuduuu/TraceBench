# V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass for the future `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS` implementation. Runtime code, tests, tools, schemas, samples, generated/platform files, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` assets, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `1cf63c0` (`docs: record workbench tool rail manual smoke`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `1cf63c0` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean (CRLF normalization warnings only if present).

## FILES_READ

- User-provided `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS` prompt from attached pasted text
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
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`

## USER_DECISION_CAPTURE

- The next implementation should be **wide Workbench layout only**.
- Move `Placements` and `Safety / Evidence` controls from the top control band into left rail/menu entries.
- Rail item selection opens read-only content in the right contextual panel.
- Component selection opens/updates right panel inspector content.
- Empty-canvas click clears local selection and auto-hides panel.
- Right panel stays hidden by default when no useful content exists.
- `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS` owns inline measurement/Save/value/unit/write-flow future work.
- Pin/lock/info-bar affordance is explicitly deferred as future UX polish, not implemented in this pass.

## SCOPE_LOCK_SUMMARY

Locked the implementation scope for `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS`:

- UI-only, docs-only scope-lock for a read-only contextual-panel disclosure mode in the existing Workbench 3-zone shell.
- Narrow behavior to wide layout only in this slice.
- Left rail receives the existing `Placements` and `Safety / Evidence` discoverability/selection roles as read-only modes.
- Right contextual panel should become rail-mode aware and component-aware with explicit read-only empty-state hiding when not useful.
- Keep `renderer writes: none` visible; preserve existing read-only canvas and selection semantics.
- Add focused widget coverage for rail control relocation, component-driven panel updates, and empty-canvas hide behavior.

Forbidden in this scope:

- No inline measurement/value/unit entry, no Save control, no pin/lock/info-bar behavior, no writer/schema/materializer/validator/projection/Project ZIP/fact/event edits.
- No board-normalized placement semantics changes.
- No tap-to-select, pan/zoom/fit, measurement, visual_trace, photo-alignment, or route consolidation changes.

## FUTURE_WRITE_FLOW_SEPARATION

- Integrated measurement entry/value/unit/Save remains separated from this scope and is routed to:
  - `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`
  - `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`
- Measurement/value semantics and write behavior remain read-only and non-implemented in this pass.
- `/project/measure-sheet` route is not deleted or consolidated in this scope.
- Pin/lock/info-bar is explicitly deferred future polish.

## ROUTE_BEFORE_AFTER

- Before: accepted route `NEEDS_USER_DECISION` after `V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS` accepted/pushed as `1cf63c0` (`docs: record workbench tool rail manual smoke`).
- After: current pass `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS`; next `V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `273` tests; no scope-specific additional validation required).
- `git status --short --branch`: only expected tracked/untracked pre-existing scratch artifacts plus the expected tracked docs in this pass.
- `git diff --name-status`: docs-only tracked changes limited to the expected set.
- `git diff --cached --name-status`: clean; nothing staged.
- `git diff --check`: PASS; CRLF normalization warnings only.

## SCOPE_DRIFT_CHECK

- No runtime code was modified (`lib/` unchanged).
- No tests were modified (`test/` unchanged).
- No tooling, schemas, samples, generated/platform, pubspec, writer, materializer, validator, projection, Project ZIP, fact, or event files changed.
- No `_incoming` content was copied into runtime.
- No staging/commit/push is performed in this pass.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_WORKBENCH_CONTEXT_PANEL_DISCLOSURE_SCOPE_LOCK_PASS.md`

## NEXT_STEP_FOR_USER

Requesting Claude Code read-only implementation post-audit before staging, commit, or push.
