# V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS

## MODEL_ROUTING_CHECK

PASS.
`CODEX / DOCS_SCOPE_LOCK` is the expected lane for a narrow pre-implementation governance lock.

## PASS_METADATA

- PASS_ID: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS`
- Type: `DOCS_SCOPE_LOCK`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Mode: docs-only lock before implementation

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Commit tip: `b5612e4` (`docs: close out board canvas qa regression polish`)
- Baseline route before edit:
  - Current: `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS`
  - Next: `NEEDS_USER_DECISION`
- `git status --short --branch` before edit showed only scratch/untracked files and a clean index.
- `git log --oneline --decorate -12` confirmed the required baseline commit.

## FILES_READ

- user-provided pass context/pasted prompt (selection-inspector scope-lock request and constraints)
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart` (read-only inspection)
- `test/widget/board_canvas_screen_test.dart` (read-only inspection)

## ROUTE_VERIFICATION

- Confirmed route precondition and moved lock route forward to:
  - Current: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS`
  - Next: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS`

## CURRENT_SELECTION_INSPECTOR_STATE

- Board Canvas remains read-only.
- Selection is currently done through `_PlacementSelector` chips, not canvas gesture hit-testing.
- Unselected state copy is still: `Select a placement to view read-only details.`
- Inspector structure remains placement identity first, then measurement badge safety block, then values panel.
- Existing gap for lock: `selectedMeasurementCount` is computed but not shown as an inspector count in selected-state UI.

## ALLOWED_FUTURE_IMPLEMENTATION_SCOPE

The future implementation pass may:
- render existing related measurement count in the inspector,
- preserve exact meaning: **component-level related measurement count only**,
- keep all existing read-only constraints,
- optionally adjust section ordering,
- keep all existing semantics unchanged (no board coordinates, probe points, pin/pad anchors, net/path/trace inference, or canonical facts).

## STRICT_NON_GOALS

- no canvas tap-to-select / hit-testing
- no gesture routing work
- no selection grouping/a11y overhauls
- no net/path/trace geometry changes
- no measurement coordinate, point, anchor, endpoint-line, or board-metric semantics
- no writer/service/schema/validator/materializer projection or ZIP changes
- no Save/Add/Edit behavior changes

## EXPECTED_FUTURE_IMPLEMENTATION_TOUCH_SET

- Runtime (locked): `lib/features/board_canvas/screens/board_canvas_screen.dart`
- Tests (locked): `test/widget/board_canvas_screen_test.dart`
- Governance docs (required): `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS.md`

## FUTURE_TEST_INTENT

1. one related measurement on selected component shows count copy in inspector
2. multiple related measurements on selected component shows count copy in inspector
3. selection count uses existing delimiter-safe measurement↔component association
4. `Q2` does not count `Q20` (`Q20` false-prefix guard)
5. unselected state stays read-only and explicitly empty
6. no canvas tap-to-select behavior is introduced
7. measurement summary card still owns numeric values/details
8. renderer/write semantics remain `none`
9. source-boundary guard remains intact
10. no edit/authoring controls appear
11. no writer/schema/materializer/validator/projection/ZIP changes are introduced

## SCOPE_DRIFT_CHECK

- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md` now point to the new current pass and next implementation pass consistently.
- The new scope-lock audit row is registered in `docs/AUDIT_INDEX.md`.
- This scope-lock did not edit runtime or test files.

## safe_for_reaudit

YES

## STAGING_SET_EXACT

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS.md`
