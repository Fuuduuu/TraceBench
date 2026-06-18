# V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: current / pending Claude Code read-only audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope lock. Runtime code, tests, tooling, schemas, samples, generated/platform files, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `669d9f5` (`docs: close out board canvas top-chrome density`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `669d9f5` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS` prompt from attached pasted text
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
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_POST_AUDIT_PASS.md`

## SCOPE_LOCK_SUMMARY

Problem statement:

- Board Canvas density and top-chrome density work are accepted/pushed/closed out.
- The safe next UI-only density option is to let selected Board Canvas chrome move out of the way while the technician focuses on the canvas.
- Auto-hide/collapse can make the canvas feel more dominant only if every hidden control remains explicit, recoverable, discoverable, and semantically unchanged.

Goal:

- Prepare `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS` for a narrow Board Canvas-only UI polish.
- The future implementation may add volatile local auto-hide/collapse behavior for the inspector/sidebar and top control band.
- The future implementation must preserve all renderer, placement, selection, measurement, evidence, fact/event, and write semantics.

Future implementation surfaces:

- Runtime: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Tests: `test/widget/board_canvas_screen_test.dart`
- Governance: current/queue/lock/index docs plus `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS.md`

A local Board Canvas UI helper may be touched only if repo inspection proves it already belongs to this exact Board Canvas screen surface; the implementation audit must explain why.

Allowed future implementation scope:

- Volatile local UI auto-hide/collapse for the Board Canvas inspector/sidebar.
- Volatile local UI auto-hide/collapse for the Board Canvas top control band.
- Explicit restore/show controls for hidden or collapsed chrome.
- Compact size, padding, spacing, alignment, and responsive density adjustments needed for the auto-hide/collapse UI.
- Compact safety/read-only copy only where meaning remains clear.
- Focused Board Canvas widget tests for no writes, recoverability, visible or recoverable read-only boundaries, and behavior equivalence.

Strict design requirements:

- Auto-hide/collapse must be reversible and discoverable.
- Hidden chrome must not create trapped UI state.
- Safety/read-only meaning must not be permanently hidden.
- State must be volatile local UI state only unless a separate future pass explicitly accepts persistence.
- Prefer explicit and safe interactions over aggressive timers.
- Avoid flaky timer-based behavior and brittle timer-based tests.
- Do not make the UI cryptic just to save pixels.

Forbidden future implementation scope:

- No renderer behavior changes.
- No board-normalized placement semantics changes.
- No selected placement semantics changes.
- No tap-to-select behavior changes.
- No pan/zoom/fit behavior changes.
- No measurement association/count logic changes.
- No measurement summary semantics changes.
- No visual_trace geometry or interpretation changes.
- No photo-alignment semantics changes.
- No new facts/events/coordinates/net/path/trace/probe/pin/pad semantics.
- No writer/schema/materializer/validator/projection/Project ZIP changes.
- No `events.jsonl` or `known_facts.json` write/mutation changes.
- No AI/OCR/CV/photo inference behavior.
- No broad app-wide theme/token/design-system migration.
- No generated/platform/dependency/pubspec changes.
- No auto-hide persistence or cross-session memory.
- Renderer must remain read-only and `renderer writes: none` must remain true.

Implementation audit requirements:

- verify UI-only scope;
- verify no event/fact/write surfaces changed;
- verify renderer remains read-only;
- verify `renderer writes: none` remains true and visible or recoverable;
- verify hidden/collapsed controls are recoverable;
- verify safety/read-only boundary copy is preserved or recoverable;
- verify existing Board Canvas behavior remains equivalent;
- verify tests are not flaky or timer-brittle.

## ROUTE_BEFORE_AFTER

- Before: current accepted route `NEEDS_USER_DECISION`.
- After: current pass `V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS`; next recommended `V2_BOARD_CANVAS_UI_AUTO_HIDE_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS.md`

`docs/WORK_INTAKE_INDEX.md` was read but not touched. `PASS_QUEUE.md` is the canonical routing owner, and WI-070 remains a broader set of future options rather than a single option that must be closed by this scope lock.

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `273` unittest tests OK; known optional-photo warnings only).
- `git diff --name-status`: PASS; tracked modifications are limited to allowlisted governance docs, and this new allowlisted audit artifact is untracked.
- `git diff --cached --name-status`: PASS; index is clean.
- `git diff --check`: PASS; CRLF conversion warnings only.
- `git status --short --branch`: PASS; branch is `main...origin/main`, scoped docs changes only, known scratch/untracked artifacts remain unstaged.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime/tests were not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, and `sequence` surfaces were not modified.
- No auto-hide runtime behavior was implemented.
- No persistence or cross-session memory was introduced.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_UI_AUTO_HIDE_SCOPE_LOCK_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
