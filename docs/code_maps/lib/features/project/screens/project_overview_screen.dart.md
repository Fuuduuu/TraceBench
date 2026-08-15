# Code Map: `lib/features/project/screens/project_overview_screen.dart`

- Source: `lib/features/project/screens/project_overview_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This screen is the read-oriented project Workbench overview. It watches the
loaded `ProjectState`, renders a responsive shell with a board-placement
preview and derived counters, exposes existing project routes, and keeps
future controls visibly inert. It does not own project loading, placement
editing, event creation, projection materialization, or route definitions.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen and provider boundary | `ProjectOverviewScreen.build`, `projectStateProvider`, `beginnerModeProvider` | Handles the no-project state, reads the current projection, toggles only the UI mode, and composes the screen. |
| 2. App bar and breadcrumb | `AppBar`, `_WorkbenchMenuBreadcrumb`, `overview-home-menu-button` | Presents Home navigation, the mode toggle, the localized breadcrumb, and the disabled menu affordance. |
| 3. Responsive shell | `_WorkbenchShellLayout`, `overview-workbench-zone`, `overview-actions-panel` | Switches between wide row and stacked layouts while keeping the Workbench visually primary. |
| 4. Workbench summary | `_WorkbenchZoneCard`, `overview-status-strip`, `_OverviewChip` | Shows read-only non-freshness status tags, projected counters, sample identity, and the placeholder-or-preview decision. Freshness ownership remains solely above the shell. |
| 5. Placement selection for preview | `componentVisualPlacements`, `coordinateSpace == 'board_normalized'` | Selects only board-normalized placement facts for the local preview without changing them. |
| 6. Read-only board preview | `_WorkbenchBoardReadOnlyCanvas`, `_WorkbenchGridPainter`, `_WorkbenchPlacementBadge` | Draws the grid and projected placement badges with bounded normalized coordinates. |
| 7. Empty projection presentation | `_WorkbenchPlaceholder` | Keeps the Workbench available when no confirmed visual placements exist. |
| 8. Existing route actions | `_ActionRailCard`, `context.go` | Navigates to measurement, component, canvas, graph, photo, fact, event, and report surfaces. |
| 9. Disabled future controls | `overview-future-tools-panel`, `overview-future-contour-button`, `overview-future-photo-button`, `overview-future-layers-button`, `overview-future-trace-colors-button` | Exposes collapsed future-tool copy with null callbacks. |
| 10. Local visual vocabulary | `_ProjectHomeShellColors`, `_EvidenceTag`, `_OverviewChip` | Owns screen-local dark Workbench colors, tags, and compact counter presentation. |
| 11. Projection freshness presentation | `ProjectionStaleBanner`, `projectState.projectionFreshness` | Renders exactly one shared tri-state banner above `_WorkbenchShellLayout`; no freshness boolean or `PROJECTION STALE` evidence tag is passed into shell/card widgets. |

## State and data flow

- `[D]` `ProjectOverviewScreen.build` watches `projectStateProvider`; null
  produces only the no-project scaffold.
- `[D]` Loaded state supplies manifest metadata, known-facts counters,
  placements, and authoritative `projectionFreshness` for the single shared
  banner.
- `[D]` `_WorkbenchShellLayout` and `_WorkbenchZoneCard` no longer accept a
  freshness boolean. The old local `PROJECTION STALE` evidence tag is removed,
  preventing duplicate/contradictory warning presentation.
- `[D]` Board placement facts are filtered to `board_normalized`, indexed
  against component facts, clamped for display, and rendered locally.
- `[D]` The responsive layout moves the same Workbench and action-rail widgets
  between row and column shapes; it does not create a second data flow.
- `[D]` Action callbacks change GoRouter location. The only provider mutation
  is the transient beginner-mode toggle.
- `[D]` No event, fact, placement, report, file, or projection is persisted by
  this source.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input | Supplies loaded projected state and derived counters. |
| `beginnerModeProvider` | UI-local read/write | Supplies and toggles the presentation mode only. |
| `ProjectState` | input model | Carries manifest, known facts, authoritative tri-state freshness, and counters. |
| `ComponentFact`, `ComponentVisualPlacementFact` | input models | Supply labels and normalized read-only board positions. |
| `ProjectionStaleBanner` | child presentation | Renders exactly one distinct stale/unknown warning above the shell; fresh is absent. |
| `GoRouter` / `context.go` | outbound navigation | Enters existing named project surfaces without owning routes. |
| Flutter layout and painter APIs | presentation | Provide responsive composition, local paint, and styling. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `ref.read(beginnerModeProvider.notifier).state` | `UI_LOCAL` | `[D]` Changes only the app's transient display mode. |
| `context.go(...)` callbacks | `ZERO_WRITE` | `[D]` Change route location and invoke no writer in this source. |
| Placement filtering and preview painting | `ZERO_WRITE` | `[D]` Consume known facts and paint local pixels only. |
| Counter, report-state, and manifest reads | `ZERO_WRITE` | `[D]` Display projected values without mutation. |
| Future-tool buttons | `ZERO_WRITE` | `[D]` All four callbacks are null. |
| Freshness banner and status strip | `ZERO_WRITE` | `[D]` The banner reads tri-state metadata; the strip retains only its non-freshness evidence tags. |

Canonical event/fact writes, placement confirmation, measurement saving,
component editing, Project ZIP behavior, and projection refresh remain owned
by their exact destination services and screens. A navigation label or button
does not transfer those write classes here.

## Zero-write zones

- `[D]` `_WorkbenchZoneCard`, `_WorkbenchBoardReadOnlyCanvas`,
  `_WorkbenchGridPainter`, `_WorkbenchPlacementBadge`, `_WorkbenchPlaceholder`,
  `_EvidenceTag`, and `_OverviewChip` only derive or render values.
- `[D]` The placement preview has no gesture, selection, save, or writer path.
- `[D]` The action rail invokes navigation only; future controls are disabled.
- `[D]` Project identifiers hidden from visible copy remain available only in
  the source state and are not rewritten.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Provider/shell entry | `[D]` null/loaded branch | App bar, Workbench, action rail | `UI_LOCAL` + `ZERO_WRITE` | `test/widget/project_overview_screen_test.dart` |
| Responsive layout | `[D]` width threshold in `_WorkbenchShellLayout` | Workbench dominance, action reachability | `ZERO_WRITE` | wide dominance and density tests |
| Placement preview | `[D]` normalized filter, clamp, painter, badge | known-facts models and Board Canvas terminology | `ZERO_WRITE` | placeholder/read-only preview tests |
| Warning presentation | `[D]` exactly one top banner from authoritative tri-state input; no shell/card freshness parameter or local stale tag | `ProjectionStaleBanner`, status strip | `ZERO_WRITE` | stale/unknown one-banner, no-legacy-tag, and shell-copy tests |
| Existing routes | `[D]` exact `context.go` paths | router owner and destination screens | `ZERO_WRITE` | route and no-event-mutation tests |
| Disabled tools | `[D]` null callbacks | localized shell copy | `ZERO_WRITE` | collapsed/inert future-tools test |
| UI mode toggle | `[D]` beginner provider assignment | surfaces consuming the shared mode | `UI_LOCAL` | shell and routed destination tests |

## Relevant tests and helpers

- `test/widget/project_overview_screen_test.dart` directly covers route
  identity, exactly one stale banner, distinct unknown warning, absence of the
  removed `PROJECTION STALE` tag, explicit fresh fixture behavior, shell copy,
  responsive geometry, placement
  preview, placeholders, inert controls, destination navigation, and zero
  event mutation.
- `test/integration/projection_stale_banner_end_to_end_test.dart` traverses the
  overview as one derived-data surface.
- `test/widget/board_canvas_screen_test.dart` verifies the primary Board Canvas
  reached from this overview; it does not transfer Canvas ownership here.
- `lib/app/router.dart` owns the exact route table and compatibility redirects.

## Dangerous combinations

- `[P]` Reintroducing a shell/card freshness parameter or local
  `PROJECTION STALE` evidence tag would recreate duplicate/contradictory
  ownership beside the shared tri-state banner.
- `[P]` Changing placement filtering, clamp math, or preview sizing together
  can make the local board preview look authoritative or geometrically wrong.
- `[P]` Route-label changes can look harmless while breaking exact destination
  expectations or read-only navigation tests.
- `[P]` Responsive threshold and fixed action-rail width changes can hide
  actions or remove Workbench dominance at intermediate widths.
- `[H]` Turning any future control on would create new product authority and
  cannot be inferred from its existing placeholder copy.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One overview warning change | `ProjectOverviewScreen.build`, `ProjectionStaleBanner`, `_WorkbenchShellLayout` | shared banner, status strip, duplicate-tag exclusion | stale/unknown one-banner and no-legacy-tag tests |
| One responsive geometry change | `_WorkbenchShellLayout` | preview height and action reachability | wide layout tests |
| One preview-only change | `_WorkbenchBoardReadOnlyCanvas`, `_WorkbenchGridPainter` | placement models and placeholder branch | preview/placeholder tests |
| One existing route action | `_ActionRailCard` | router and destination | exact route test plus no-event guard |
| One inert-tools copy change | `overview-future-tools-panel` | all four null callbacks | future-tools test |

These slices describe impact only. They authorize no source, route, writer,
test, or protected-surface change.

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Local Workbench visual tokens | `[S]` Several private widgets share one color vocabulary. | `NONE` |
| Action-rail route metadata | `[S]` Repeated buttons pair labels and fixed routes. | `NONE` |
| Read-only board preview | `[S]` Painter and badge logic form a cohesive private unit. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for provider or private-anchor `SYMBOL_DRIFT`,
  projection-to-preview `FLOW_DRIFT`, navigation or write-class
  `BOUNDARY_DRIFT`, linked overview coverage `TEST_DRIFT`, or responsibility
  `STRUCTURE_DRIFT`.
- Recheck warning ownership when stale/fresh state shape, shared banner input,
  shell/card parameters, or status-tag content changes.
- Recheck source and router together when any path callback changes.
- Formatting, imports, comments, and line movement alone do not stale the map.

## Known uncertainty

- `[D]` The preview is display-only and intentionally simpler than Board
  Canvas; visual similarity does not imply shared renderer ownership.
- `[P]` Destination behavior after `context.go` is outside this file.
- `[S]` The extraction seams are descriptive only and carry no refactor or
  implementation authority.
