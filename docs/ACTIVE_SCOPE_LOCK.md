# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS`

## Type

`DOCS_SYNC / SCOPE_LOCK`

## Lane

`CODEX / DOCS_SYNC / SCOPE_LOCK`

## Mode

Documentation scope-lock only. Do not modify runtime code, tests, tooling, schemas, samples, Project ZIP logic, staging, commits, or pushes.

## Current goal

- Create the scope lock for a second Board Canvas layout-density polish slice after user screenshot review of the pushed first density implementation.
- Lock future UI-only Board Canvas chrome-density work so the board/canvas can become substantially larger.
- Preserve all Board Canvas read-only, zero-event, projection, tap-to-select, pan/zoom/fit, measurement badge/count, inspector-content, visual-trace metadata, photo-alignment metadata-only, and `renderer writes: none` behavior.

## Next recommended pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`

## Baseline

- Prior scope lock: `af8425d` (`docs: lock board canvas layout density`)
- First density implementation: `16072fa` (`feat(board-canvas): reclaim canvas layout space`)
- User review result: first density slice improved layout, but did not reclaim enough Board Canvas width/height.

## User screenshot feedback recorded

The next polish scope responds to user-marked screenshots and review notes:

- top Board Canvas app/banner/header area should be narrower;
- top/header area may auto-hide like a Windows taskbar, but only behind an explicit on/off checkbox/toggle;
- auto-hide reveal may support hover, but critical controls must remain accessible by click/tap/keyboard and not hover-only;
- Placement selection should become a collapsible/expandable menu similar to Safety / Evidence;
- Safety / Evidence should be compact or collapsed by default and must not consume valuable board space by default;
- right inspector should be collapsible, hideable, or movable to the right so the board view can become larger;
- board/canvas must gain substantially more width and height;
- text/menu/control areas must remain usable but much more compact.

## Overall layout-density design direction

The same layout-density logic also applies to the Workbench / Project Overview screen:

- board/workspace preview should become larger and more dominant;
- right-side action/navigation/future-tools rail should become more compact;
- Future tools should be collapsed or visually quieter by default;
- repeated helper/status text should become compact;
- action/menu areas should remain usable but should not consume excessive board/workspace area;
- the same optional collapse/auto-hide logic may apply to Workbench panels where safe.

This pass records that overall design direction, but it does not combine Board Canvas and Workbench / Project Overview runtime implementation.

## File allowlist for this scope-lock pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS.md`

## Locked future implementation scope

Future implementation target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`

This target is the next Board Canvas-only polish slice. It follows the already pushed `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS` (`16072fa`) without rewriting or reusing that pushed pass.

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`

Governance docs:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS.md`

Allowed future changes:

1. Make the top Board Canvas banner/header/appbar area more compact.
2. Optionally add UI-only auto-hide behavior for the top/header area.
3. Make Placement selection a compact collapsible/expandable panel/menu similar to Safety / Evidence.
4. Make Safety / Evidence collapsed by default or more compact by default while keeping safety/evidence copy available.
5. Make the right inspector panel collapsible, hideable, or movable to the right.
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

## Auto-hide and collapse accessibility rules

- Auto-hide must be controlled by an explicit on/off checkbox/toggle.
- Auto-hide state must be UI-only and volatile unless separately scoped.
- Hover reveal may exist, but must not be the only path to critical controls.
- Collapsed panels must be restorable by click/tap and keyboard.
- Screen-reader semantics should be preserved where practical.
- Safety/evidence copy must remain available and must not disappear.
- Hidden/collapsed inspector state must be UI-only and volatile unless separately scoped.

## Deferred / not in this polish scope

- Project Overview / Workbench density remains deferred to a later separate implementation pass, such as `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` or `V2_WORKBENCH_LAYOUT_DENSITY_IMPL_PASS`.
- Multi-placement fixture/sample coverage remains deferred unless separately scoped.
- Manual smoke rerun remains deferred until after implementation.
- No closeout docs are pre-registered by this scope lock.

## Required implementation slicing

1. Next Board Canvas implementation slice:
   - target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`
   - Board Canvas only
   - compact selector/menu areas
   - Safety / Evidence collapsed or compact by default
   - inspector hide/collapse direction may be implemented only if selected inside that pass
   - more canvas space

2. Later separate Workbench / Project Overview implementation slice:
   - candidate target: `V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_IMPL_PASS` or `V2_WORKBENCH_LAYOUT_DENSITY_IMPL_PASS`
   - Project Overview / Workbench only
   - larger board workspace
   - compact right action/navigation rail
   - collapsed or visually quieter Future tools
   - less wasted vertical and horizontal space

The first implementation after this scope lock must remain Board Canvas only unless the user explicitly chooses otherwise.

## Strict non-goals / forbidden changes

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

## Do not reopen

- tap-to-select implementation
- measurement marker semantics
- association rules
- writer/schema/projection boundaries

## Future test intent

Future implementation must test:

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

## Required validation for this docs-only scope lock

- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `git status --short --branch`

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_LAYOUT_DENSITY_POLISH_IMPL_PASS`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Layout-density polish must not change reset semantics, pan/zoom semantics, tap-to-select semantics, selection semantics, event/fact behavior, or Project ZIP behavior.
