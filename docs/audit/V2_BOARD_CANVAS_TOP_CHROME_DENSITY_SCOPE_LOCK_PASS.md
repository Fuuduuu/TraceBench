# V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS

Date: 2026-06-18
Lane: CODEX / DOCS_SCOPE_LOCK
Status: current / pending Claude Code read-only audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope lock. Runtime code, tests, tooling, schemas, samples, generated/platform files, staging, commits, and pushes are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `7269648` (`docs: refresh project source orientation`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `7269648` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS` prompt
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
- `AGENTS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS.md`
- `docs/audit/PROJECT_SOURCE_GUIDE_REFRESH_PASS.md`
- Board Canvas surface discovery with `rg --files lib test | rg "board_canvas"`

## SCOPE_LOCK_SUMMARY

Problem statement:

- Board Canvas top chrome and selector/control rows still consume too much vertical and horizontal space.
- User screenshot review identified that the top app bar/header with back button and "Board Canvas" title can be narrower/shorter.
- User screenshot review also identified that the row containing Placements, Safety / Evidence, and the collapse/expand control can be narrower and more compact.
- No screenshot asset is added by this docs-only pass.

Goal:

- Prepare `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS` to compact the Board Canvas header and top control row so the board area becomes more dominant.
- Preserve all read-only renderer behavior and accepted Board Canvas interactions.

Future implementation surfaces confirmed from repo inspection:

- Runtime: `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Tests: `test/widget/board_canvas_screen_test.dart`
- Governance: current/queue/lock/index docs plus `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS.md`

Allowed future implementation scope:

- Board Canvas app bar/header visual density.
- Board Canvas top title/back row height, padding, and spacing.
- Placement selector row visual density.
- Safety / Evidence collapsed control visual density.
- Collapse/show-hide control size, padding, spacing, and alignment.
- Visual-only layout polish that gives more space to the board canvas.
- UI-only responsive behavior if needed.
- Existing read-only labels/copy may be shortened only if meaning and safety boundary remain clear.

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
- No runtime writes, authoring, save, edit, apply, confirm, or promote controls.
- No Project Overview / Workbench layout changes.
- Renderer must remain read-only and `renderer writes: none` must remain true.

Implementation audit requirements:

- verify read-only renderer remains read-only;
- verify `renderer writes: none` remains visible/true;
- verify no event/fact/write surfaces changed;
- verify Board Canvas behavior remains functionally equivalent;
- verify only visual density changed;
- verify tests cover compact top chrome without brittle pixel-perfect assertions.

## ROUTE_BEFORE_AFTER

- Before: current pass `PROJECT_SOURCE_GUIDE_REFRESH_PASS`; current accepted route `NEEDS_USER_DECISION`; next recommended `NEEDS_USER_DECISION`.
- After: current pass `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS`; next recommended `V2_BOARD_CANVAS_TOP_CHROME_DENSITY_IMPL_PASS`.

## FILES_CHANGED

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS.md`

`docs/WORK_INTAKE_INDEX.md` was read but not touched. `PASS_QUEUE.md` is the canonical routing owner, and WI-070 remains a broader set of future options rather than a single option that must be closed by this scope lock.

## VALIDATION_RESULTS

- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; existing optional-photo ZIP warnings only).
- `git diff --name-status`: PASS; tracked modifications are limited to allowlisted governance docs, and this new allowlisted audit artifact is untracked.
- `git diff --cached --name-status`: PASS; index is clean.
- `git diff --check`: PASS; CRLF warnings only.
- `git status --short --branch`: PASS; branch is `main...origin/main`, scoped docs changes only, known scratch/untracked artifacts remain unstaged.

## SCOPE_DRIFT_CHECK

- Runtime code was not modified.
- Tests were not modified.
- Board Canvas runtime/tests were not modified.
- Tooling, schemas, samples, generated/platform files, pubspec files, writer, materializer, validator, projection, Project ZIP, fact, event, coordinate, placement, measurement, marker, net/path/trace, visual_trace, photo/layers/AI/OCR/CV, `sequence`, and `Muu ühik` surfaces were not modified.
- No screenshot/image asset was added.
- No staging, commit, or push was performed.

## EXPECTED_STAGING_SET_EXACT

Do not stage in this pass. Expected explicit staging set after Claude Code read-only audit:

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_TOP_CHROME_DENSITY_SCOPE_LOCK_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only audit before staging, commit, or push.
