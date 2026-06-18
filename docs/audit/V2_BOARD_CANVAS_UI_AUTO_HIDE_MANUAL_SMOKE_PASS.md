# V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_MANUAL_QA_RECORD
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only manual smoke record for accepted Board Canvas UI focus mode / top-chrome behavior. Runtime code, tests, tools, schemas, samples, generated/platform files, Board Canvas behavior, writer/materializer/validator/projection/Project ZIP/fact/event surfaces, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `5b72aba` (`docs: close out board canvas ui auto-hide`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `5b72aba` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS` prompt
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS.md`

## SMOKE_RECORD_SUMMARY

Result: PASS, interpreted narrowly.

Source: user-reported manual smoke evidence after accepted/pushed Board Canvas UI auto-hide implementation and post-audit/closeout.

Exact user wording:

> "Muidu käik töötas smoke testis"

Narrow interpretation recorded:

- Board Canvas focus/top-chrome flow worked in manual smoke testing.

Accepted behavior covered by this smoke record:

- compact top app bar/header;
- compact Placement / Safety-Evidence / collapse-control row;
- deterministic volatile `Focus canvas` mode;
- `Focus canvas` hides top control band plus inspector/sidebar;
- `Show controls` restore strip remains visible;
- controls and read-only details are recoverable;
- `renderer writes: none` remains visible;
- renderer remains read-only;
- no persistence/cross-session memory;
- no timers;
- no writer/schema/materializer/validator/projection/Project ZIP/fact/event changes.

Out-of-scope clarification:

- The separate `_incoming/ui_redesign/2026-06-14_workbench_home` reference screenshot is not recorded as accepted implementation in this pass.
- That redesign reference remains a separate future route-review/design-gap topic unless explicitly scoped later.
- `docs/WORK_INTAKE_INDEX.md` was not touched because this pass only records smoke evidence and does not open or prioritize a redesign work item.

## ROUTE_BEFORE_AFTER

- Before: accepted route `NEEDS_USER_DECISION` after `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_POST_AUDIT_PASS` was accepted/pushed as `5b72aba`.
- After: current pass `V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS`; next recommended `NEEDS_USER_DECISION`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `273` unittest tests OK; known optional-photo warnings only).
- `git diff --check`: PASS; CRLF conversion warnings only.
- `git diff --name-status`: PASS; tracked modifications are limited to allowlisted governance docs, and this new allowlisted audit artifact is untracked.
- `git diff --cached --name-status`: PASS; index is clean.
- `git status --short --branch`: PASS; branch is `main...origin/main`, scoped docs changes only, known scratch/untracked artifacts remain unstaged.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime behavior was not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, and `sequence` surfaces were not modified.
- The `_incoming/ui_redesign/2026-06-14_workbench_home` reference was not recorded as accepted implementation.
- `docs/WORK_INTAKE_INDEX.md` was not touched.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_MANUAL_SMOKE_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
