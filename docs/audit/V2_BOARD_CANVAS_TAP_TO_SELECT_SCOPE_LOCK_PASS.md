# V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS

Date: 2026-06-15
Lane: DOCS_SCOPE_LOCK
Status: in progress

## MODEL_ROUTING_CHECK

PASS. `CODEX / DOCS_SCOPE_LOCK` is the expected lane for a pre-implementation governance lock.

## PASS_METADATA

- PASS_ID: `V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS`
- Type: `DOCS_SCOPE_LOCK`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Mode: documentation scope-lock only

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Baseline commit: `3d66879` (`docs: close out board canvas selection inspector polish`)
- Baseline route before edit:
  - Current: `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS`
  - Next: `NEEDS_USER_DECISION`
- `git status --short --branch` before edit showed `main...origin/main` with no tracked or staged changes; only known scratch/untracked artifacts were present.
- `git log --oneline --decorate -12` confirmed the required closeout baseline.
- `git diff --name-status`, `git diff --cached --name-status`, and `git diff --check` were clean before edit.

## FILES_READ

- user-provided tap-to-select scope-lock prompt
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_MEASUREMENT_MARKERS_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_READONLY_RENDERER_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart` (read-only inspection)
- `test/widget/board_canvas_screen_test.dart` (read-only inspection)

## ROUTE_VERIFICATION

Confirmed expected baseline route and moved route docs to:

- Current: `V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS`
- Next recommended: `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS`

## CURRENT_SELECTION_BEHAVIOR

- Board Canvas already renders board-normalized placements through `InteractiveViewer` and `CustomPaint`.
- Placement selection is chip-driven through `_PlacementSelector`.
- Selection state is volatile UI state only (`_selectedPlacementKey`).
- Selecting a placement updates the existing inspector/measurement summary flow.
- Current canvas painting has no direct tap-to-select or hit-test behavior.
- Existing tests include a guard that canvas taps do not auto-select a placement.

## RATIONALE

Tap-to-select is the next narrow UX slice because technicians can already inspect a placement through chips, but the rendered footprint itself is not selectable. A future implementation should make the board view easier to operate while preserving the same selection semantics and read-only evidence boundaries.

## LOCKED_FUTURE_BEHAVIOR

Future implementation may:

- Add tap/click selection for already-rendered board-normalized component placements.
- Update only volatile UI selection state.
- Reuse existing `_PlacementEntry`, `selectedKey`, and inspector flow.
- Keep existing chip selector behavior intact.
- Preserve pan/zoom/fit behavior.
- Preserve read-only / zero-event behavior.
- Add focused tests for tap-to-select behavior and boundary guards.

Tap-to-select means only: select this existing rendered placement in the UI.

## STRICT_NON_GOALS

Future implementation must not add:

- component creation
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad authoring
- board coordinate authoring
- new fact/event semantics
- new association rule
- net/path/trace inference
- visual_trace geometry
- trace-color editing
- background photo rendering
- photo-local to board transform
- contour/layers
- AI/OCR/CV
- Save Measurement behavior changes
- Add Component behavior changes
- Edit Component behavior changes
- writer service changes
- `MeasurementEventWriter` changes
- event schema/model changes
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- custom unit / `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad Board Canvas redesign

## TAP_HIT_TEST_BOUNDARY

Future implementation may calculate a transient hit-test against already-rendered placement geometry.

That hit-test must be UI-only and ephemeral. It must not be stored as:

- event
- fact
- coordinate
- measurement
- placement
- marker
- trace
- net
- view-state file
- Project ZIP content

## PAN_ZOOM_INTERACTION_RISKS

Future implementation must handle or test:

- tap selects a rendered component when not panning,
- pan/zoom gestures still work,
- fit/reset still works,
- tap selection remains aligned under transformed canvas coordinates,
- no tap-vs-pan regression is introduced.

If safe tap gesture handling is not straightforward, future implementation must stop and report rather than weakening pan/zoom behavior.

## EXPECTED_FUTURE_TOUCH_SET

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance docs:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS.md`

Do not allow other runtime files unless implementation audit explicitly justifies it.

## FUTURE_TEST_INTENT

Future implementation tests should cover:

1. tapping a rendered placement selects it and updates inspector;
2. tapping one placement then another changes selected inspector content;
3. chip selector remains functional after tap-to-select is added;
4. tap-to-select does not write events;
5. tap-to-select does not mutate `known_facts`;
6. tap-to-select does not update Project ZIP;
7. `renderer writes: none` remains visible;
8. source-boundary guard remains intact;
9. pan/zoom/fit still works;
10. tap handling does not break `InteractiveViewer` gestures;
11. no edit/authoring controls appear;
12. no coordinate/probe/pin/net/trace/fact wording appears;
13. empty/no-placement states remain stable;
14. non-board-normalized placements remain non-renderable/non-selectable.

## SCOPE_DRIFT_CHECK

- This pass is docs-only.
- Runtime and test files were inspected but not modified.
- No toolchain, schema, writer, validator, materializer, projection, Project ZIP, event, or known-facts files are in scope.
- `AUDIT_INDEX` registers only this scope-lock audit doc; no implementation closeout doc is pre-registered.

## FINAL_CODEX_VERDICT

PASS. The scope lock is ready for independent audit before any implementation work.

## safe_for_reaudit

YES

## STAGING_SET_EXACT

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS.md`
