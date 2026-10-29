# Code Map: `lib/features/board_canvas/widgets/component_navigator.dart`

- Source: `lib/features/board_canvas/widgets/component_navigator.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `none`

## File purpose

An independently importable, stateless Component Navigator. It owns category,
count, list, ordering, inspector and placement-choice presentation. Inputs use
public component/placement facts and selected IDs; seven callbacks express
intent. Board Canvas owns selection, filter eligibility, preview state,
project lifecycle, Canvas hit testing and placement actions. This module has
no Session, provider, writer, route or persistence dependency.

The historical same-library description is retained in
`component_navigator.part.dart.md`; the part source has been removed. Source,
tests and canonical owners outrank this map.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Shared presentation policy | `ComponentCategory`, `ComponentCategoryPresentation`, `componentCategoryFor`, `componentPrimaryLabel`, `componentNavigatorPlacementId` | Fixed category order/aliases/fallback, labels and the existing composite placement key used by both host and module. |
| 2. Mode and selection resolution | `ComponentNavigator`, `build`, `selectedCategory`, `selectedComponentId`, `selectedPlacementId` | Resolve a visible selected component in its category; render overview, category list or inspector. |
| 3. Overview/counts/hover | `_placedComponentIds`, `_componentsInCategory`, `_buildCategoryOverview`, `_buildCategoryRow` | Suppress absent categories, show placed/unplaced or visible/hidden counts and semantics; preview Canvas-visible placements. |
| 4. Component list/filter/order | `_compareComponents`, `_naturalComponentIdCompare`, `_buildCategoryList`, `_buildComponentSection`, `_buildComponentRow` | Apply caller eligibility, partition placed/unplaced, sort measured first then natural ID; render empty states, row intents and hover. |
| 5. Inspector and actions | `_buildComponentInspector`, `onBackToCategory`, `onPlaceComponent`, `onPlacementSelected` | Render unplaced, hidden, single-visible or multi-visible placement branches; dispatch local-place or placement-ID intent. |
| 6. Placement presentation | `_buildPlacementSummary`, `_buildPlacementChoice`, `_benchBeepNavigatorControlStyle`, `onPreviewKeysChanged` | Keep board/coordinate copy, selection semantics, keys, gold controls and hover/clear presentation. |

## State and data flow

1. `[D]` The caller supplies `components`, all `placements`, Canvas-visible
   `canvasPlacements`, `visibleComponentIds`, `hideUnmeasured`, measurement
   counts, a nullable category and nullable selected IDs.
2. `[D]` Grouping, counting, lookup and sorting derive local collections without
   changing the inputs. No state is retained between builds.
3. `[D]` A selected component is shown only when its ID is visible and its
   shared classification matches the selected category. Otherwise the category
   list remains reachable, including the zero-visible state.
4. `[D]` All placements determine placed/unplaced membership; the separate
   Canvas-visible subset determines hover targets and actionable placements.
5. `[D]` Measured components sort before unmeasured components within each
   section; the unchanged natural-ID comparator resolves each subgroup.
6. `[D]` Selection and hover dispatch component facts, placement-ID strings or
   preview-ID sets. Back/category/place controls dispatch intent only.
7. `[D]` The host resolves a placement ID into its private render entry and
   owns all ensuing selection or local Placement-draft changes.

`componentNavigatorPlacementId` preserves `componentId|sourceEventId` exactly.
It is a presentation/selection key, not a new persisted placement identity.
The host's `_PlacementEntry.key` delegates to this helper. No DTO is introduced.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material, layout, gestures and semantics | presentation output | Stateless widgets, pointer/button callbacks, focus and selected states. |
| `ComponentFact`, `ComponentVisualPlacementFact` / `known_facts.dart` | immutable projected input | Component identity/type/designator and placement board/coordinate/source context. |
| `BoardCanvasPalette` / `board_canvas_palette.dart` | immutable visual input | The existing Navigator colors, outlines and selected/hover/focus treatments. |
| Dart core and `dart:math` | local derivation | Collections, natural numeric-token comparison and common-length calculation. |
| `BoardCanvasScreen` | caller, not imported | Adapts facts/IDs; implements all seven callbacks and owns their lifetime. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Category policy, labels and key helper | `ZERO_WRITE` | `[D]` Pure projected-model/string resolution. |
| Filtering, partitioning, counts, sorting and rendering | `ZERO_WRITE` | `[D]` Only local derived collections and widget construction. |
| Category/back/component/placement callbacks | `UI_LOCAL` | `[D]` Host callbacks alter transient category, selection and preview state. |
| `onPreviewKeysChanged` | `UI_LOCAL` | `[D]` Host stores a transient preview-key set. |
| `onPlaceComponent` | `UI_LOCAL` | `[D]` Host initializes the existing local Placement flow; this callback is not a canonical save. |
| Existing explicit Placement save | `CANONICAL_EVENT` | `[D]` Excluded workflow remains in `board_canvas_placement_panel.dart`; it is not imported here. |

## Zero-write zones

All declarations in this library render or derive presentation. There is no
mutable State, `setState`, provider read, async work, filesystem access, event
append or projection mutation. Aggregate callback behavior is `UI_LOCAL` only
because the current host implements transient-state actions; other callers
must establish their own callback boundary.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Categories/aliases/labels/IDs | `[D]` shared policy and exact key helper | Host filter recovery, Placement labels and render-entry keys | `ZERO_WRITE` | direct classifier matrix; host fixed order/alias cases |
| Mode/count/filter/order | `[D]` local collections and selected-ID guards | Host eligibility and count producers | `ZERO_WRITE` | direct overview/list/hidden cases; host section/filter/sort cases |
| Hover and selection | `[D]` visible placement IDs and intent callbacks | Host preview lifetime, Canvas highlighting and selection | `UI_LOCAL` | direct hover/selected semantics; host category/component preview cases |
| Inspector and placement intent | `[D]` all/visible cardinality branches | Host private entry adapter and existing Placement holder | `UI_LOCAL` | direct four-branch cases; host Paiguta and P0/C0 regressions |

## Relevant tests and helpers

- `test/widget/component_navigator_test.dart` imports this normal library
  without the host or its private declarations. It tests aliases/order,
  counts/semantics, visible hover IDs, partition/sort/input preservation,
  filtered/empty branches, unplaced intent, single/hidden/multiple placements,
  selected styling and compact/wide callers with enlarged text.
- `test/widget/board_canvas_screen_test.dart` retains the host Navigator,
  selection, filtering, hover, responsive and Placement behavior coverage.
  Helpers include `_componentNavigatorState`, `_hoverWidgetByKey`,
  `_painterPreviewKeys`, `_painterDimmedKeys` and `_selectPlacement`.
- Existing P0/C0/M0/I0 families remain regression evidence for adjacent host
  workflows; this library does not own those workflow implementations.

## Dangerous combinations

- Treating a category classification or measurement-count ordering rule as a
  canonical type/measurement assertion.
- Replacing the all-placement list with only visible placements, which would
  incorrectly turn hidden placements into unplaced components.
- Moving host selection, preview lifetime, hit testing or Placement actions
  into this Stateless module.
- Changing the composite key format, aliases, labels or callback payloads
  while assuming that a library-boundary refactor is behavior-neutral.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Category presentation | `ComponentCategoryPresentation`, `_buildCategoryRow` | Host eligibility and shared classifier consumer | order/alias/count/semantics cases |
| List presentation | `_buildCategoryList`, `_buildComponentRow` | Count producer and Canvas-visible subset | partition, ordering, hidden and hover cases |
| Inspector presentation | `_buildComponentInspector`, `_buildPlacementChoice` | Host intent adapters and selected IDs | four branches, selected semantics and Paiguta regressions |

## Future extraction seams

None required by this boundary. The library is directly importable already;
descriptive ownership does not authorize another feature or refactor.

## Freshness and review triggers

Review category/key policy, data inputs, selection guards, grouping/filtering,
ordering, branches, callbacks, keys, copy, semantics or tokens when they change.
Recheck host adapters for callback payload/state-lifetime drift. Do not infer
new writer, persistence or canonical authority from presentation changes.

## Known uncertainty

- `[D]` The current host callback closure is bounded and transient. Callback
  safety for a future caller must be verified rather than inherited.
- `[D]` Direct and host tests characterize declared cases, not every possible
  combination of arbitrary caller inputs or semantics-label strings.
