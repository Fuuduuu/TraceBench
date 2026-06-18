# V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_DESIGN_GAP_CAPTURE
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only design-gap capture and route-governance pass. Runtime code, tests, tools, schemas, samples, generated/platform files, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, `_incoming` artifact mutation/copying, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `10adac9` (`docs: record board canvas ui auto-hide smoke`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `10adac9` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS` prompt from attached pasted text
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_PASS.md`
- `docs/audit/V2_TECHNICIAN_FIRST_UI_REDESIGN_VISUAL_CAPTURE_CLOSEOUT_PASS.md`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\Technician Workbench Home - Design Review (standalone).html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\2026-06-14_workbench_home\workbench.css`

## REFERENCE_CAPTURE_SUMMARY

- Prompt requested inspection of `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\2026-06-14_workbench_home\`.
- That external `TraceBench_incoming` path was not present locally.
- The repo-local scratch/reference path was present and inspected:
  - `_incoming/ui_redesign/2026-06-14_workbench_home/Technician Workbench Home - Design Review (standalone).html`
  - `_incoming/ui_redesign/2026-06-14_workbench_home/workbench.css`
- The reference is registered as design-input-only:
  - non-runtime;
  - non-canonical;
  - no CSS/HTML/mockup code copy into Flutter runtime;
  - no image/assets copied into runtime;
  - `_incoming/` remains untracked scratch/reference input.
- This reference had previously appeared only as read-only/input context in Board Canvas renderer/pan-zoom scope history and as out-of-scope in the Board Canvas UI auto-hide smoke record; it had not been governed as the active integrated workbench target before this pass.

## DESIGN_GAP_CAPTURE_SUMMARY

- Current app has no left vertical tool/action rail.
- Current right panel is a read-only inspector, not an inline measurement-entry host.
- Measurement entry currently lives on the separate `/project/measure-sheet` page.
- The target wants one integrated technician bench workflow, driven by the board and current selection rather than a menu/card stack.
- The target keeps future tools visible only as inert or separately scoped concepts.
- Theme parity is separate and optional; it must not be mixed into layout or write-flow implementation.
- The reference design is direction only and does not authorize copying mockup HTML/CSS, adding runtime assets, or changing evidence/canonical behavior.

## TARGET_ARCHITECTURE_CAPTURE

- Left rail: vertical action/tool rail that reuses existing routes/actions first; future tools are inert until separately scoped.
- Center: dominant read-only board canvas/renderer surface. Integrated bench does not mean renderer writes.
- Right panel: contextual panel updated by selected component, initially read-only.
- Future measurement entry: a right-panel writer host, not renderer write behavior.
- If inline measurement entry is later implemented, it must reuse the accepted writer path, preserve explicit target selection and human confirmation, and create only accepted canonical measurement events.
- Standalone `/project/measure-sheet` should not be deleted casually; it should remain a fallback/redirect unless route consolidation is separately scoped.
- Protected future work begins at `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`.

## WORK_BREAKDOWN_CAPTURE

- W1 `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`: docs-only design-input capture and route governance.
- W2 `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`: docs-only scope-lock for 3-zone layout: left rail, center canvas, right contextual zone; UI-only, renderer read-only.
- W3 `V2_WORKBENCH_TOOL_RAIL_IMPL_PASS`: UI-only left rail implementation; reuse existing routes/actions; future tools inert.
- W4 `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS`: UI-only 3-zone responsive layout shell; no write behavior.
- W5 `V2_WORKBENCH_CONTEXT_PANEL_READONLY_IMPL_PASS`: right panel read-only arming on component selection; show selected designator/read-only metadata/readings; no Save control yet.
- W6 `V2_INTEGRATED_MEASUREMENT_PANEL_SCOPE_LOCK_PASS`: docs-only protected scope-lock for inline measurement-entry panel; crosses from read-only UI into write-flow territory.
- W7 `V2_INTEGRATED_MEASUREMENT_PANEL_IMPL_PASS`: implement inline value/unit/Save in right panel using accepted writer path only; high-risk and requires strict audit.
- W8 `V2_WORKBENCH_MEASUREMENT_NAV_CONSOLIDATION_PASS`: route/navigation consolidation; keep `/project/measure-sheet` fallback/redirect and do not delete the route casually.
- W9 `V2_WORKBENCH_DARK_THEME_SCOPE_LOCK_PASS`: optional later theme scope; do not mix with layout/write-flow work.
- W10 Per-slice test/fixture coverage: each implementation slice needs focused tests and fixtures appropriate to its risk.
- W11 `V2_WORKBENCH_INTEGRATED_PANEL_SMOKE_PASS`: manual Windows smoke after integrated panel/navigation work.

## ROUTE_BEFORE_AFTER

- Before: accepted route `NEEDS_USER_DECISION` after `V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS` was accepted/pushed as `10adac9`.
- After: current pass `V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS`; next recommended `V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`

`docs/SOURCES_INDEX_CURRENT.md` was touched to register the local scratch design reference as source/orientation input only. `docs/WORK_INTAKE_INDEX.md` was touched to park the W1-W11 route breakdown and protected write-flow warning as a work-intake item.

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS, 273 tests.
- `git diff --check`: PASS, CRLF warnings only.
- `git diff --name-status`: docs-only tracked changes.
- `git diff --cached --name-status`: clean; nothing staged.
- `git status --short --branch`: no staged changes; tracked edits limited to the expected docs set, with pre-existing untracked scratch/IDE/platform artifacts still untracked.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime behavior was not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, and `sequence` surfaces were not modified.
- No `_incoming` assets, HTML, CSS, screenshots, or mockup code were copied into runtime or tracked docs/source folders.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/SOURCES_INDEX_CURRENT.md docs/WORK_INTAKE_INDEX.md docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
