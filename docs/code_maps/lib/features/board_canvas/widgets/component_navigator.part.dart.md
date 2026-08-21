# Code Map: `lib/features/board_canvas/widgets/component_navigator.part.dart`

- Source: `lib/features/board_canvas/widgets/component_navigator.part.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable production behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_BOARD_CANVAS_COMPONENT_NAVIGATOR_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the private Stateless Component Navigator presentation extracted from
Board Canvas while remaining the third temporary same-library Dart part of
`board_canvas_screen.dart`. It derives category, list, count, sorting,
inspector, and placement-choice presentation from host-supplied projected data
and dispatches only to host-owned transient selection, preview, navigation, and
local placement-draft callbacks. It owns no mutable state, provider, writer,
route, filesystem action, or canonical semantics. Source, tests, canonical
owners, and active locks remain authoritative.

## Qualification

`[D]` The committed production part owns at least eight independently testable
contracts:

1. selection-aware dispatch among category overview, category list, and
   component inspector;
2. suppression of absent categories in fixed host-defined category order;
3. placed/unplaced or visible/hidden category counts, semantics, and hover
   preview/clear behavior;
4. hide-unmeasured filtering plus explicit zero-visible presentation;
5. placed/unplaced partitioning with measured-first and natural component-ID
   ordering;
6. component label, kind, measurement-count, hover-preview, and selection rows;
7. unplaced, hidden-placement, single-placement, and multiple-placement
   inspector branches with distinct actions; and
8. placement summary, selected-choice semantics/styling, hover preview, and
   explicit placement selection.

These cohesive presentation responsibilities have distinct inputs and
observable outputs, so automatic qualification condition 3 applies without a
score worksheet.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Navigator mode and selection resolution | `_ComponentNavigatorPanel`, `build`, `selectedCategory`, `selection` | Resolves a currently visible selected component and dispatches to overview, category-list, or inspector presentation. |
| 2. Category overview, counts, and hover | `_placedComponentIds`, `_componentsInCategory`, `_buildCategoryOverview`, `_buildCategoryRow` | Lists represented categories, derives placed/unplaced or visible/hidden counts and semantics, previews visible placements, and enters a category. |
| 3. Component filter, partition, order, and rows | `_compareComponents`, `_buildCategoryList`, `_buildComponentSection`, `_buildComponentRow` | Filters by host eligibility, partitions placed/unplaced components, sorts measured first then naturally, renders empty/row states, previews, and selects. |
| 4. Inspector and action branching | `_buildComponentInspector`, `onBackToCategory`, `onPlaceComponent`, `onPlacementSelected` | Presents unplaced, hidden-placement, single-placement, or multiple-placement states and dispatches back, local-place, or selection actions. |
| 5. Placement summaries, choices, and preview | `_buildPlacementSummary`, `_buildPlacementChoice`, `onPreviewKeysChanged` | Presents board-side/coordinate-space context, selected styling and semantics, hover preview/clear, and explicit placement choice. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every selected literal resolves as an
exact substring in the committed part. The map uses no line-number anchors.

## State and data flow

```text
host-projected components, placements, Canvas-visible entries and IDs,
measurement counts, selected category, and typed Canvas selection
-> pure grouping, filtering, counting, ordering, and branch derivation
-> Stateless Flutter overview/list/inspector/placement-choice tree
-> seven callbacks
-> host-owned transient category, selection, preview, and local draft state
```

- `[D]` `entries` contains all known placement entries; `canvasEntries`
  contains the host-filtered Canvas-visible subset used for previews and
  visible-placement branches.
- `[D]` `visibleComponentIds` and `hideUnmeasured` are host-derived eligibility
  inputs; this part neither owns nor persists the filter.
- `[D]` `measurementCountsByComponentId` affects category copy, row copy, and
  measured-first ordering without changing a measurement or fact.
- `[D]` `selection` chooses component and placement presentation state; all
  selection mutation remains behind callbacks implemented in the host.
- `[D]` Hover paths allocate preview-key sets and dispatch them to the host;
  preview lifetime and deduplication remain host-owned.
- `[D]` `onPlaceComponent` enters the existing host-local placement-draft flow;
  it performs no canonical placement write.
- `[D]` The part owns no `State`, controller, lifecycle method, provider, or
  mutable project/projection object.

Exact callback inputs are `onCategorySelected`, `onBackToCategories`,
`onBackToCategory`, `onComponentSelected`, `onPlacementSelected`,
`onPlaceComponent`, and `onPreviewKeysChanged`. Their signatures remain
unchanged; callback implementations and affected state lifetimes remain
host-owned.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `board_canvas_screen.dart` | same-library host | Supplies the reciprocal `part`, shared imports, constructor call, callback implementations, state lifetime, and canonical writers. |
| `ComponentFact` | read-only model input through host import | Supplies component identity and IDs used for grouping, counts, and ordering; host helpers supply labels and kinds. |
| `CanvasSelection`, `ComponentSelection`, `ComponentPlacementSelection` | read-only same-library input | Supplies typed selection used only to choose presentation state. |
| `_PlacementEntry`, `_ComponentCategory` | private same-library input | Supplies placement association, board/coordinate copy, category order, labels, and stable IDs. |
| `_componentCategoryFor`, `_componentPrimaryLabel`, `_componentKindLabel`, `_naturalComponentIdCompare` | private host helpers | Supplies membership, labels, and natural-ID comparison without moving ownership. |
| `_benchBeepNavigatorControlStyle` | private host style helper | Supplies unchanged back and single-placement action styling. |
| `_kBoardCanvasTile`, `_kBoardCanvasNavy`, `_kBoardCanvasMuted`, `_kBoardCanvasDim`, `_kBoardCanvasSignal`, `_kBoardCanvasSignalTint`, `_kBoardCanvasReady`, `_kBoardCanvasRule` | private same-library visual input | Reuses the host's existing Navigator color vocabulary. |
| Host-derived eligibility, preview, and measurement-count collections | read-only input | Couples Canvas visibility, preview targets, placement branches, counts, and ordering without importing producers. |
| Flutter widget, layout, Material, interaction, semantics, and styling APIs | presentation output | Builds the Stateless Navigator and dispatches pointer/button interactions. |
| Dart core collections and scalar operations | local derivation | Supports non-mutating grouping, filtering, counting, set construction, and local-list sorting. |

The part has no import or export. No production owner imports it directly;
private access exists only through the Board Canvas library.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_placedComponentIds`, `_componentsInCategory`, `_compareComponents` | `ZERO_WRITE` | `[D]` Read constructor inputs and return locally derived sets, lists, or comparison results. |
| `build` and every `_build*` method | `ZERO_WRITE` | `[D]` Build widgets, text, semantics, and local collections without provider, State, filesystem, event, fact, or projection mutation. |
| Category/back/component/placement callbacks | `UI_LOCAL` | `[D]` Host implementations mutate only transient category, typed-selection, and preview state through host `setState`. |
| `onPreviewKeysChanged` | `UI_LOCAL` | `[D]` Host `_setPreviewPlacementKeys` stores an unmodifiable transient preview-key set. |
| `onPlaceComponent` | `UI_LOCAL` | `[D]` Host `_beginUnplacedComponentPlacement` initializes the existing local template/ghost draft only. |
| Host explicit placement save | `CANONICAL_EVENT` | `[D]` Excluded `_confirmAddComponentTemplatePlacement -> v2PlacementWriterProvider` remains outside this part. |
| Other host writer paths | `CANONICAL_EVENT` | `[D]` Component-create, component-edit, and measurement writers remain host-owned and are not dependencies of this part. |

The aggregate part is `UI_LOCAL`; pure derivation and rendering are
`ZERO_WRITE`. Reading projected component, placement, and count inputs does not
confirm identity, connectivity, measurement meaning, evidence, or canonical
truth.

## Zero-write zones

Every getter, filter, count, comparator, lookup, branch decision, label,
semantics derivation, and widget construction path is `ZERO_WRITE`. The file
contains no provider, `ref`, State owner, `setState`, writer invocation, event
append, projection mutation, route mutation, asynchronous action, or filesystem
access. It is not classified wholly `ZERO_WRITE` only because controls dispatch
`UI_LOCAL` callbacks whose implementations and lifetime remain in the host.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Mode/selection resolution | `[D]` typed switch plus visible-ID/category guard | host category/selection reset and filter state | `ZERO_WRITE` / `UI_LOCAL` | selection, back-path, hidden-selected recovery |
| Category overview/count/hover | `[D]` category filter, counts, semantics, preview sets | host classifier, visible entries, preview lifetime | `ZERO_WRITE` / `UI_LOCAL` | order/aliases/absence, both count modes, hover |
| Component list/filter/order/row | `[D]` visibility filter, placed split, measured/natural sort | host count producer and Canvas eligibility | `ZERO_WRITE` / `UI_LOCAL` | sections, sorting, filter, row hover/selection |
| Inspector branches/actions | `[D]` all/visible cardinality branches and actions | host local draft, typed selection, filter recovery | `ZERO_WRITE` / `UI_LOCAL` | unplaced, local-place, single/multiple placement |
| Placement summary/choice/preview | `[D]` copy, selected semantics/style, preview set | host preview keys and Canvas selection rendering | `ZERO_WRITE` / `UI_LOCAL` | multiple choice, single flow, hover/zero-write |

## Relevant tests and helpers

`test/widget/board_canvas_screen_test.dart` exercises the part through its host
library. Relevant helpers include `_componentNavigatorState`, `_harness`,
`_selectPlacement`, `_hoverWidgetByKey`, `_painterPreviewKeys`,
`_painterDimmedKeys`, and `_canvasSemanticsLabels`.

Direct behavior families cover fixed category order/aliases/absence; normal and
filtered category counts; category and component hover; placed/unplaced
partition; measured-first natural-ID sorting; component row copy and selection;
both visible back paths; default/hide/restore filter behavior; zero-visible
recovery; unplaced local-draft entry; single and multiple placement selection;
and zero canonical writer calls. The focused suite does not import or
source-read the part directly and does not transfer host state or writer
ownership into it.

## Dangerous combinations

- Do not combine presentation changes with migration of category, selection,
  preview, filter, draft, controller, or lifecycle ownership.
- Filtering couples menu rows, selected-component recovery, Canvas rendering,
  hit eligibility, previews, badges, and measurement targets.
- Measured-first sorting consumes host-derived counts; keep ordering separate
  from measurement association, fact, writer, or validity semantics.
- `onPlaceComponent` is a local-draft boundary; do not combine it with
  canonical placement save behavior.
- Same-library work must not silently promote private names, redesign the
  constructor, create DTOs/view models, or convert to a normal library.
- Callback, key, copy, semantics, layout, or token changes can affect several
  Navigator families even when no state owner moves.
- This is the third and final temporary Board Canvas part. No fourth part or
  further extraction is implied by this map.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| Overview/count correction | `_buildCategoryOverview`, `_buildCategoryRow` | host classifier, visible IDs, Canvas entries | order/alias/absence and count cases |
| List/filter/order correction | `_buildCategoryList`, `_compareComponents` | host filter/count producers and Canvas eligibility | partition, sorting, hide/restore, zero-visible |
| Component-row correction | `_buildComponentRow` | host labels/counts and preview lifetime | row hover/selection and measurement copy |
| Inspector correction | `_buildComponentInspector` | host selection and local placement draft | unplaced, local-place, single/multiple placement |
| Placement-choice correction | `_buildPlacementSummary`, `_buildPlacementChoice` | host preview keys and Canvas selection rendering | multiple choice, selected placement, zero-write |

## Future extraction seams

- `[S]` A normal feature-internal library may replace this temporary part only
  through a dedicated architecture pass with intentional privacy and API
  design.
- `[S]` State/controller ownership can be reconsidered only after all three
  Board Canvas parts are assessed together for conversion, consolidation,
  lifetime, and internal boundaries.

These seams are descriptive and authorize no conversion, visibility change,
state movement, callback redesign, fourth part, or source/test write.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for Navigator symbol, input, grouping, filtering,
counting, ordering, branch, callback, key, copy, semantics, dependency,
write-class, host/part ownership, same-library, or linked-test drift. Recheck
the host map when callback implementations, state owners, filter/Canvas
coupling, part directives, or writers change. Recheck the focused-test map when
a linked behavior/helper or source-read assumption changes. Any fourth part
proposal requires architecture review rather than routine map refresh.

## Known uncertainty

- `[D]` The same-library bridge intentionally shares private host models,
  helpers, callbacks, and tokens; it is temporary committed structure, not a
  repository-wide decomposition convention.
- `[P]` Placement-choice hover uses the same preview callback and is adjacent
  to direct multiple-placement/hover coverage, but has no separately titled
  placement-choice-hover test.
- `[P]` Category and placement semantics are source-verifiable and exercised
  by interaction families, but every exact semantics-label string is not
  claimed as independently characterized.
- `[D]` Aggregate `UI_LOCAL` depends on verified host callback implementations;
  callback rewiring requires boundary review.
