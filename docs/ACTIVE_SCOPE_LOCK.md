# Active Scope Lock

## Current pass

`V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`

## Type

`DOCS_SYNC / SCOPE_LOCK`

## Lane

`CODEX / DOCS_SCOPE_LOCK`

## Mode

Documentation scope-lock only. Do not modify runtime code, tests, tooling, schemas, samples, Project ZIP logic, writer/materializer/validator/projection files, stage, commit, or push.

## Current goal

- Create the separate Project Overview / Workbench layout-density scope lock that was deferred during Board Canvas layout-density polish.
- Keep this pass docs-only.
- Lock future implementation target:
  - `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`
- Return route docs to:
  - Current: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`
  - Next recommended: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`

## Next recommended pass

`V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`

## Baseline

- Board Canvas density polish implementation: `4fe7ade` (`feat(board-canvas): polish layout density`)
- Board Canvas density polish closeout: `09cdeb7` (`docs: close out board canvas layout density polish`)
- Board Canvas density polish smoke record: `d6cb892` (`docs: record board canvas layout density polish smoke`)
- Board Canvas manual smoke result: PASS, user wording "kõik on passed. ja töötab"
- The Board Canvas density scope lock explicitly deferred the same density direction for Workbench / Project Overview as a separate implementation pass.

## Naming / surface alias

Repo runtime uses `ProjectOverviewScreen` in:

- `lib/features/project/screens/project_overview_screen.dart`

Repo tests use:

- `test/widget/project_overview_screen_test.dart`

Existing screen copy and tests also refer to the central surface as Workbench / workbench zone (`overview-workbench-zone`). In this scope lock, "Project Overview" and "Workbench" refer to that same Project Overview / Workbench Home screen surface, not Board Canvas.

## File allowlist for this scope-lock pass

Docs only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`

## Expected future touch set

Future implementation should likely touch only:

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

Do not touch Board Canvas runtime/tests in this Project Overview implementation unless a separate pass is selected.

## Locked Future Implementation Scope

Allow future implementation to improve Project Overview / Workbench layout density only:

1. Make the main project/workspace/board preview area larger and more dominant.
2. Compact top/header/status/helper text where possible.
3. Compact the right action/navigation rail.
4. Collapse or visually quiet Future tools by default.
5. Keep primary actions discoverable and usable.
6. Keep read-only/future-tool boundaries clear.
7. Allow UI-only volatile collapse/hide behavior for panels if safe.
8. Preserve all existing project navigation and existing enabled actions.

## User Direction To Preserve

- The same layout-density logic that improved Board Canvas should apply to Workbench / Project Overview.
- Board/workspace preview should become larger and more dominant.
- Right-side action/navigation/future-tools rail should become more compact.
- Future tools should be collapsed or visually quieter by default.
- Repeated helper/status text should become compact.
- Action/menu areas should remain usable but should not consume excessive board/workspace area.
- Optional collapse/hide behavior may apply to Workbench panels where safe.
- UI should remain technician-first and fast to scan.

## Strict Accessibility Rules

- Critical actions must not become hover-only.
- Collapsed panels must remain restorable by click/tap/keyboard.
- Labels and semantics should remain understandable.
- Future/disabled tools must remain clearly disabled/inert, not misleadingly active.

## Strict Non-Goals / Forbidden Changes

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

## Expected Future Tests

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

## Required validation

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS`

Next: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- This scope lock does not reopen Board Canvas layout-density implementation.
- This scope lock does not implement Project Overview / Workbench runtime changes.
