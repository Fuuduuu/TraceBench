# V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_MANUAL_QA_RECORD
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only manual smoke record for the accepted Workbench 3-zone layout and left tool rail behavior. Runtime code, tests, tooling, schemas, samples, generated/platform files, writer/materializer/validator/projection/Project ZIP surfaces, `_incoming`, and commit/push actions are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `289e21a` (`docs: record workbench tool rail impl post-audit`)
- `git status --short --branch`: tracked tree clean on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `289e21a` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean before docs-only edits (tracked files only).
- `git diff --cached --name-status`: clean.
- `git diff --check`: PASS, CRLF conversion warnings only.

## FILES_READ

- user-provided `V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS` prompt
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_POST_AUDIT_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`

## SMOKE_RECORD_SUMMARY

Result: PASS, interpreted narrowly.

Source:

> "Muidu kõik töötab nii nagu peab."

Narrow interpretation recorded:

- Workbench 3-zone layout and left rail flow worked in manual smoke.

Observed as still-accepted behavior for this smoke evidence:

- compact 3-zone Workbench layout (left tool rail, dominant read-only center canvas, read-only contextual zone),
- refined left rail controls and disabled inert future tools,
- focus/inspector behavior remains recoverable,
- right-context read-only panel behavior remains passive/selection-oriented,
- no runtime writes were required for the smoke result and no semantics changed from accepted implementation.

## FUTURE_POLISH_NOTES

Future UX-only/read-only direction captured from user-provided screenshot notes (not implemented in this pass):

- move current top Placements and Safety/Evidence boxes into the left rail/menu;
- clicking those left-rail items should open their content in the right contextual panel;
- hide the right panel by default when it has no useful content;
- selecting a component should open/update the right contextual panel;
- clicking empty canvas should deselect and auto-hide the panel unless it is pinned;
- add a small lock/pin/info-bar affordance to keep the right panel open when desired.

These items are forward-looking and are not part of accepted runtime behavior.

## ROUTE_BEFORE_AFTER

- Before: accepted current route was `NEEDS_USER_DECISION` after `V2_WORKBENCH_TOOL_RAIL_IMPL_POST_AUDIT_PASS` (`docs: record workbench tool rail impl post-audit`, `289e21a`).
- After: current pass `V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS`; next `NEEDS_USER_DECISION`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `273` tests; optional photo warning notes unchanged).
- `git diff --check`: PASS; CRLF conversion warnings only.
- `git diff --name-status`: PASS; allowlisted docs files plus new smoke artifact.
- `git status --short --branch`: PASS; expected docs edits plus pre-existing untracked scratch artifacts.

## SCOPE_DRIFT_CHECK

- Runtime code in `lib/` was not modified.
- Tests in `test/` were not modified.
- No `tools/`, `schemas/`, `samples/`, generated/platform, pubspec, `docs/WORK_INTAKE_INDEX.md` policy changes, `_incoming`, writer/materializer/validator/projection/Project ZIP, fact/event, coordinate, placement, measurement, trace, photo, or AI inference surfaces were modified.
- No behavior, read-only boundary, or renderer semantics changes introduced.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage/commit/push in this pass.

Expected explicit staging set after the Claude Code read-only audit step:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_WORKBENCH_TOOL_RAIL_MANUAL_SMOKE_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only post-audit before staging, commit, or push.
