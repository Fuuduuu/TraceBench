# V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS

Date: 2026-06-17
Lane: CODEX / DOCS_SYNC / SCOPE_LOCK
Status: in progress

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass. Runtime code, tests, tooling, schemas, samples, Project ZIP logic, staging, commits, and pushes are out of scope.

## PASS_METADATA

- PASS_ID: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS`
- Type: `DOCS_SYNC / SCOPE_LOCK`
- Mode: documentation scope-lock only
- Current route: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS`
- Next recommended route: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`
- Pushed first density implementation baseline: `16072fa` (`feat(board-canvas): reclaim canvas layout space`)

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `16072fa` (`feat(board-canvas): reclaim canvas layout space`)
- `git status --short --branch` showed `## main...origin/main` with no tracked or staged changes and only known pre-existing untracked scratch artifacts.
- `git log --oneline --decorate -10` confirmed `16072fa` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status` was clean.
- `git diff --cached --name-status` was clean.
- `git diff --check` exited clean.

## FILES_READ

- attached `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS` prompt
- user additional direction about Workbench / Project Overview density
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart` read-only

## USER_SCREENSHOT_FEEDBACK_SUMMARY

User visually reviewed the pushed first density slice and found it improved the screen but did not reclaim enough board/canvas space.

Recorded feedback:

- top Board Canvas app/banner/header area should be narrower;
- top/header area may optionally auto-hide like the Windows taskbar, but only behind an explicit on/off checkbox/toggle;
- Placement selection should become a collapsible/expandable menu like Safety / Evidence;
- Safety / Evidence should not sit open or consume valuable board space by default;
- right inspector should be collapsible, hideable, or movable to the right;
- board/canvas must get substantially more width and height;
- text/menu/control areas must remain usable but much more compact.

## WHY_FIRST_DENSITY_SLICE_WAS_NOT_ENOUGH

`V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS` removed the fixed selector column, compacted selector/safety placement, and moved legend/safety copy out of the canvas panel. User review shows that fixed top/header chrome, always-visible selector/safety/inspector regions, and right-side inspector occupancy still leave the board surface too constrained.

The next polish scope therefore targets additional chrome reduction and optional UI-only collapse/auto-hide behavior without changing Board Canvas data semantics or write behavior.

## OVERALL_DESIGN_DIRECTION

The same layout-density logic also applies to Workbench / Project Overview:

- board/workspace preview should become larger and more dominant;
- right-side action/navigation/future-tools rail should become more compact;
- Future tools should be collapsed or visually quieter by default;
- repeated helper/status text should become compact;
- action/menu areas should remain usable but should not consume excessive board/workspace area;
- optional collapse/auto-hide logic may apply to Workbench panels where safe.

This scope lock records the overall direction, but it does not allow a combined Board Canvas plus Project Overview runtime pass.

## REQUIRED_IMPLEMENTATION_SLICING

1. Next Board Canvas-only slice:
   - target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`
   - compact selector/menu areas;
   - Safety / Evidence collapsed or compact by default;
   - inspector hide/collapse direction may be implemented only if selected in that pass;
   - substantially more canvas space.

2. Later separate Workbench / Project Overview slice:
   - candidate target: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` or `V2_WORKBENCH_LAYOUT_DENSITY_IMPL_PASS`
   - larger board workspace;
   - compact right action/navigation rail;
   - collapsed or visually quieter Future tools;
   - less wasted vertical and horizontal space.

Because `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS` is already pushed as `16072fa`, this scope lock routes the second Board Canvas-only slice to `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS` rather than reopening or rewriting the pushed pass.

## ALLOWED_FUTURE_POLISH_SCOPE

Future Board Canvas implementation may:

1. Make top Board Canvas banner/header/appbar area more compact.
2. Optionally add UI-only auto-hide behavior for the top/header area.
3. Make Placement selection a compact collapsible/expandable panel/menu similar to Safety / Evidence.
4. Make Safety / Evidence collapsed by default or more compact by default while keeping safety/evidence copy available.
5. Make right inspector panel collapsible, hideable, or movable to the right.
6. Increase board/canvas visual dominance in both width and height.
7. Preserve existing Board Canvas behavior:
   - read-only renderer
   - tap-to-select
   - chip/selector selection
   - inspector content
   - measurement badge/count
   - measurement summary
   - visual-trace metadata
   - photo-alignment readiness metadata-only
   - pan/zoom/fit
   - `renderer writes: none`

## AUTO_HIDE_COLLAPSE_ACCESSIBILITY_RULES

- Auto-hide must be controlled by an explicit on/off checkbox/toggle.
- Auto-hide state must be UI-only and volatile unless separately scoped.
- Hover reveal may exist, but critical controls must not be hover-only.
- Collapsed panels must be restorable by mouse, keyboard, click/tap, and screen-reader semantics where practical.
- Safety/evidence copy must remain available and must not disappear.
- Hidden/collapsed inspector state must be UI-only and volatile unless separately scoped.

## STRICT_NON_GOALS

- new board semantics
- new facts/events/coordinates
- placement creation/editing
- marker editing/dragging/authoring
- measurement creation/editing
- probe/pin/pad anchors
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
- schema/model changes
- validator/materializer/projection changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence`
- `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad theme/token migration

## DO_NOT_REOPEN

- tap-to-select implementation
- measurement marker semantics
- association rules
- writer/schema/projection boundaries

## EXPECTED_FUTURE_TESTS

Future Board Canvas implementation must test:

1. Board Canvas still renders placements.
2. Canvas area is larger / not squeezed by always-open selector/safety/inspector chrome where practical to assert.
3. Placement selector remains usable when collapsed/expanded.
4. Safety / Evidence remains accessible when collapsed.
5. Inspector can be collapsed/hidden and restored.
6. Tap-to-select still works.
7. Pan/zoom/fit still works.
8. `renderer writes: none` remains visible.
9. No authoring controls appear.
10. Source-boundary guard remains intact.
11. No writer/schema/materializer/validator/projection/ZIP changes.

## SCOPE_DRIFT_CHECK

- This pass is docs-only.
- Runtime files were read-only and not modified.
- Test files were not modified.
- Tooling files were not modified.
- Schema files were not modified.
- Samples were not modified.
- Project ZIP logic was not modified.
- Writer, materializer, validator, projection, event, and known-facts behavior were not modified.
- No staging, commit, or push was performed.

## VALIDATION_RESULTS

- `git diff --name-status` shows tracked modifications limited to:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
- New audit artifact is untracked until the explicit post-audit staging step:
  - `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS.md`
- `git diff --cached --name-status` is clean.
- `git diff --check` exits clean; CRLF conversion warnings may appear.
- `git status --short --branch` shows `main...origin/main`, the four modified route docs, the new untracked layout-density polish scope-lock audit artifact, and pre-existing scratch/untracked artifacts.

## FINAL_CODEX_VERDICT

PASS pending validation for docs-only scope lock. The next implementation route is a Board Canvas-only polish slice. Workbench / Project Overview density is recorded as the same overall design direction but remains a later separate implementation pass.

## STAGING_SET_EXACT

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS.md`
