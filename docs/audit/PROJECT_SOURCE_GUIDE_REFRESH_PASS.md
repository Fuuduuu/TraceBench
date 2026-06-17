# PROJECT_SOURCE_GUIDE_REFRESH_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SOURCE_ORIENTATION
Status: current / pending Claude Code read-only audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs/source-orientation refresh. Runtime code, tests, tooling, schemas, samples, generated/platform files, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `19fc1c9` (`docs: close out project overview layout density`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `19fc1c9` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `PROJECT_SOURCE_GUIDE_REFRESH_PASS` prompt
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/MEMORY_PROTOCOL.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS.md`
- `AGENTS.md`
- `README.md`

## SOURCE_ORIENTATION_FINDINGS

- `TraceBench_Project_Source_Guide.md` is external/non-repo orientation-only material and is not tracked in this repository.
- The tracked repo-local source/orientation index is `docs/SOURCES_INDEX_CURRENT.md`.
- The latest pushed closeout is `19fc1c9` (`docs: close out project overview layout density`).
- Route docs still needed a compact source-orientation refresh because they named `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS` as the current pass after the closeout commit.
- `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS` is accepted/pushed.
- The current accepted route after the closeout is `NEEDS_USER_DECISION`.

## DOCS_UPDATE_SUMMARY

- Updated live handoff docs to record `PROJECT_SOURCE_GUIDE_REFRESH_PASS` as the active auditable docs refresh pass and `NEEDS_USER_DECISION` as the current accepted route / next recommendation.
- Updated source orientation to record the latest accepted pushed Project Overview / Workbench layout-density closeout without creating a duplicate repo-local source guide.
- Updated governance ledgers to mark the Project Overview density post-audit bookkeeping as accepted/pushed in `19fc1c9`.
- Added safe future options to work intake: manual Project Overview visual smoke record, UI-only auto-hide scope lock, multi-placement fixture coverage, or another route-review.

## ROUTE_BEFORE_AFTER

- Before: current pass `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_POST_AUDIT_PASS`; next recommended `NEEDS_USER_DECISION`.
- After: current pass `PROJECT_SOURCE_GUIDE_REFRESH_PASS`; current accepted route `NEEDS_USER_DECISION`; next recommended `NEEDS_USER_DECISION`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/PROJECT_SOURCE_GUIDE_REFRESH_PASS.md`

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; existing optional-photo ZIP warnings only).
- `git diff --name-status`: PASS; only allowlisted tracked docs are modified and the new allowlisted audit artifact is untracked.
- `git diff --cached --name-status`: PASS; index is clean.
- `git diff --check`: PASS; CRLF warnings only.
- `git status --short --branch`: PASS; branch is `main...origin/main`, scoped docs changes only, known scratch/untracked artifacts remain unstaged.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime/tests were not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, `sequence`, and `Muu ühik` surfaces were not modified.
- No duplicate repo-local source guide or orientation file was created.
- No staging, commit, or push was performed.

## EXTERNAL_SOURCE_GUIDE_NOTE

`TraceBench_Project_Source_Guide.md` remains external/non-repo orientation-only material. Repo governance docs remain canonical and win over assistant/source guide files.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/WORK_INTAKE_INDEX.md docs/SOURCES_INDEX_CURRENT.md docs/audit/PROJECT_SOURCE_GUIDE_REFRESH_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
