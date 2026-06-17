# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`

## Type

`RECOVERY_REPLACE_SCOPE_LOCK / DOCS_SCOPE_LOCK`

## Lane

`CODEX / DOCS_SYNC / SCOPE_LOCK`

## Mode

Documentation scope-lock only. This pass replaces the uncommitted narrower fit/reset discoverability draft with the broader user-selected layout-density direction. No runtime, test, tooling, staging, commit, or push changes are allowed.

## Current goal

- Lock a future layout-density implementation scope for Board Canvas and Project Overview.
- Make board/canvas/workspace surfaces dominant while compacting fixed chrome.
- Preserve Board Canvas read-only, zero-event, projection, tap-to-select, pan/zoom/fit, measurement badge/count, inspector, visual-trace metadata, photo-alignment metadata-only, and `renderer writes: none` behavior.
- Keep safety/evidence copy available even if it moves, collapses, shortens, or becomes summary-first.

## Next recommended pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

## Scope decision

- scope type: `DOCS_SCOPE_LOCK`
- lane: `CODEX / DOCS_SYNC / SCOPE_LOCK`
- latest accepted baseline: `2d18a39` (`docs: record board canvas interaction smoke pass with nits`)
- upstream smoke result: `PASS_WITH_NITS`
- recovery action: discard/replace the uncommitted narrower fit/reset draft; do not keep it as the active route or queue target.
- future implementation target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

## File allowlist for this scope-lock pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`

## Design decision

Accepted layout-density recommendation: Variant B / persistent slim rails.

Direction:

- Board Canvas and Project Overview board/workspace areas should become the dominant visual surfaces.
- Fixed text, menu, legend, selector, and inspector chrome should be reduced where safe.
- Selector and inspector areas should remain compact but usable.
- Safety/evidence copy may move behind disclosure, popover, accordion, or compact legend treatment.
- Safety/evidence copy must not disappear and must remain reachable by click/tap/keyboard, not hover-only.
- Fit/reset discoverability is included inside this layout-density follow-up; it is not a separate active route.

## Smoke nits carried forward

This layout-density scope helps address:

- fit/reset discoverability nit;
- wasted canvas/workspace space;
- excessive legend/safety text footprint;
- oversized selector, inspector, and menu chrome.

This scope must not claim to fix:

- pan after zoom expected behavior;
- viewport appearance after zoom expected behavior;
- multi-placement smoke coverage gap.

## Locked future implementation scope

Future implementation may improve layout density only.

Allowed future implementation changes:

1. Reclaim Board Canvas width and height.
2. Replace the fixed selector column with a compact selector row or compact selector area.
3. Move Board Canvas legend/safety copy out of canvas vertical flow into collapsed Safety/Evidence disclosure, info popover, accordion, or compact legend row.
4. Make inspector more compact, narrower, collapsible, or summary-first.
5. Make fit/reset more discoverable while preserving existing reset behavior.
6. Reduce excessive padding/card chrome where safe.
7. For Project Overview, allow a later slice to expand the board preview/workspace and compact the action/navigation/future-tools rail.
8. Preserve keys where possible:
   - `board_canvas_fit_view_button`
   - `renderer_writes_none`
   - `placement_selector_*`
9. Preserve existing Board Canvas behavior:
   - read-only renderer
   - pan/zoom/fit
   - tap-to-select
   - chip selector
   - inspector
   - measurement badges/counts
   - visual-trace metadata
   - photo-alignment readiness metadata-only panel
   - `renderer writes: none`

## Downstream implementation slices

1. First smallest safe slice: Board Canvas width reclaim.
   - compact selector row
   - move legend/safety copy to collapsed disclosure/info
   - reduce padding
   - no selection, pan, zoom, or tap behavior change

2. Follow-up slice: fit/reset discoverability plus inspector compactness.
   - labeled fit/reset control
   - compact/collapsible inspector
   - summary-first sections

3. Deferred slice: Project Overview density.
   - board preview grows beyond fixed height
   - right action/navigation rail compacts
   - Future tools collapsed by default

## Expected future touch set

Runtime:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `lib/features/project/screens/project_overview_screen.dart`

Tests:

- `test/widget/board_canvas_screen_test.dart`
- relevant Project Overview widget tests if present

Governance:

- route docs and implementation audit doc for the future implementation pass

## Future test intent

Future implementation must test:

1. Board Canvas still renders placements.
2. Tap-to-select still works.
3. Chip selector still works.
4. Pan/zoom/fit still works.
5. Fit/reset is more discoverable.
6. Measurement badge/count remains safe and visible.
7. Safety/evidence copy remains accessible.
8. `renderer writes: none` remains visible.
9. No authoring controls appear.
10. Source-boundary guard remains intact.
11. Project Overview board workspace remains read-only.
12. No writer, schema, materializer, validator, projection, or ZIP changes occur.

## Strict non-goals / forbidden future implementation changes

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
- validator changes
- materializer changes
- projection contract changes
- Project ZIP import/export changes
- `known_facts` mutation
- `events.jsonl` write path changes
- `sequence` field
- custom unit / `Muu ühik`
- dependency/toolchain/generated/platform changes
- broad theme/token migration

## Current route lock

Current: `V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`

Next: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

## Scope-lock carry-forward

- Board Canvas remains read-only unless separately scoped.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper must not author canonical events or canonical facts.
- Project ZIP import/export remains out of scope.
- Measurement badges and inspector counts remain component-level evidence summaries only.
- Layout-density polish must not change reset semantics, pan/zoom semantics, tap-to-select semantics, selection semantics, event/fact behavior, or Project ZIP behavior.
