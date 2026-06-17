# V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS

Date: 2026-06-17
Lane: CODEX / DOCS_SCOPE_LOCK
Status: drafted / pending independent audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local docs-only scope-lock pass. Runtime code, tests, tooling, schemas, samples, Project ZIP logic, staging, commits, and pushes are out of scope.

## PASS_METADATA

- PASS_ID: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Type: `DOCS_SYNC / SCOPE_LOCK`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Mode: documentation scope-lock only
- Current route: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Next recommended route: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`
- Future implementation target: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `d6cb892` (`docs: record board canvas layout density polish smoke`)
- `git status --short --branch` before edit showed `## main...origin/main` with no tracked or staged changes and only known pre-existing untracked scratch artifacts.
- `git log --oneline --decorate -10` confirmed `d6cb892` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status` was clean.
- `git diff --cached --name-status` was clean.
- `git diff --check` exited clean.
- Route precheck: the latest pushed route had `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS` as current and `NEEDS_USER_DECISION` as next recommended, so this scope lock opens from the user-decision route.

## FILES_READ

- attached `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS` prompt
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_CLOSEOUT_PASS.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SMOKE_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `AGENTS.md`
- `lib/features/project/screens/project_overview_screen.dart` read-only
- `test/widget/project_overview_screen_test.dart` read-only

## WHY_THIS_FOLLOWS_BOARD_CANVAS_DENSITY_POLISH

Board Canvas layout-density polish is accepted, pushed, closed out, and manually smoke-recorded as PASS. The accepted Board Canvas work compacted app bar/footer/padding, collapsed Placement selection, kept Safety / Evidence compact/collapsed, moved status into the canvas overlay, added volatile inspector hide/show, made the canvas larger, and preserved read-only behavior.

During that Board Canvas scope lock, the same density direction was explicitly recorded for Workbench / Project Overview but deferred into a separate later implementation pass. This pass is that separate docs-only scope lock. It does not reopen Board Canvas implementation and does not implement Project Overview runtime changes.

## SURFACE_ALIAS

Repo runtime uses `ProjectOverviewScreen` in `lib/features/project/screens/project_overview_screen.dart`. Existing screen copy and tests refer to the central Project Overview surface as Workbench / workbench zone, including `overview-workbench-zone` and `overview-workbench-board-preview`. In this pass, "Project Overview" and "Workbench" refer to that same Project Overview / Workbench Home screen surface.

## USER_DIRECTION_RECORDED

The same layout-density logic that improved Board Canvas should apply to Workbench / Project Overview:

- board/workspace preview should become larger and more dominant;
- right-side action/navigation/future-tools rail should become more compact;
- Future tools should be collapsed or visually quieter by default;
- repeated helper/status text should become compact;
- action/menu areas should remain usable but should not consume excessive board/workspace area;
- optional collapse/hide behavior may apply to Workbench panels where safe;
- UI should remain technician-first and fast to scan.

## ALLOWED_FUTURE_IMPLEMENTATION_SCOPE

Future implementation may improve Project Overview / Workbench layout density only:

1. Make the main project/workspace/board preview area larger and more dominant.
2. Compact top/header/status/helper text where possible.
3. Compact the right action/navigation rail.
4. Collapse or visually quiet Future tools by default.
5. Keep primary actions discoverable and usable.
6. Keep read-only/future-tool boundaries clear.
7. Allow UI-only volatile collapse/hide behavior for panels if safe.
8. Preserve all existing project navigation and existing enabled actions.

Expected future implementation touch set:

Runtime:

- `lib/features/project/screens/project_overview_screen.dart`

Tests:

- `test/widget/project_overview_screen_test.dart`

Governance:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS.md`

Do not touch Board Canvas runtime/tests in the Project Overview implementation unless a separate pass is selected.

## STRICT_ACCESSIBILITY_RULES

- Critical actions must not become hover-only.
- Collapsed panels must remain restorable by click/tap/keyboard.
- Labels and semantics should remain understandable.
- Future/disabled tools must remain clearly disabled/inert, not misleadingly active.

## STRICT_NON_GOALS

Do not allow future implementation to change:

- Board Canvas runtime
- Board Canvas tap-to-select/pan/zoom/fit/layout
- Save Measurement behavior
- Add Component behavior
- Edit Component behavior
- Reference Images behavior
- writer service
- `MeasurementEventWriter`
- schema/model
- validator/materializer/projection
- Project ZIP import/export
- `known_facts` mutation
- `events.jsonl` write path
- facts/events/coordinates
- placement/measurement/marker editing
- probe/pin/pad anchors
- net/path/trace inference
- visual_trace geometry
- photo/layers/AI/OCR/CV
- `sequence`
- `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad app-wide theme/token migration

## EXPECTED_FUTURE_TESTS

Future implementation should test:

1. Project Overview / Workbench screen still renders.
2. Main workspace/preview area is more dominant where practical to assert.
3. Right action/navigation/future-tools rail remains usable but more compact.
4. Future tools remain disabled/inert/visually quiet where applicable.
5. Primary actions remain discoverable.
6. Collapsed/hidden panels, if implemented, can be restored.
7. No Board Canvas runtime changed.
8. No writer/schema/materializer/validator/projection/Project ZIP changes.
9. No authoring/write behavior changes unless already existing and explicitly enabled.
10. Source-boundary guard remains intact if the repo has one.

## ROUTE_STATUS

Route docs are updated to:

- Current: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
- Next recommended: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`

## VALIDATION_RESULTS

- `git diff --name-status`: PASS; tracked modifications are limited to `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`.
- New scope-lock audit artifact remains untracked until the explicit post-audit staging step: `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`.
- `git diff --cached --name-status`: PASS; no staged files.
- `git diff --check`: PASS; CRLF working-copy warnings only.
- `git status --short --branch`: PASS; branch remains `main...origin/main`, with allowed modified docs, the new scope-lock audit artifact, and known pre-existing scratch/untracked artifacts.

## SCOPE_DRIFT_CHECK

- This pass is docs-only.
- Runtime files were read-only and not modified.
- Test files were read-only and not modified.
- Tooling files were not modified.
- Schema files were not modified.
- Samples were not modified.
- Pubspec files were not modified.
- Project ZIP logic was not modified.
- Writer, materializer, validator, projection, event, and known-facts behavior were not modified.
- Board Canvas runtime/tests were not modified.
- No implementation behavior, tags, release objects, generated artifacts, or forbidden surfaces were changed.
- No staging, commit, or push was performed.

## FINAL_CODEX_VERDICT

PASS pending docs-only validation. The separate Project Overview / Workbench layout-density implementation route is now scope-locked and should proceed to `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` after independent audit/acceptance of this lock.

## STAGING_SET_EXACT

`git add docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`
