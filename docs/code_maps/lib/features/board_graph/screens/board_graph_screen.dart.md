# Code Map: `lib/features/board_graph/screens/board_graph_screen.dart`

- Source: `lib/features/board_graph/screens/board_graph_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_PROJECTION_FRESHNESS_PROVENANCE_LOCK_PASS.md`

## File purpose

This screen is an advanced, read-only inspection surface for the materialized
Board Graph projection. It derives a graph from loaded known facts, applies
beginner/advanced layer filters and optional component focus, lays out the
result, and presents both a canvas and a bounded text list. Its local controls
change only presentation state; it owns no event, fact, graph, or file writer.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| 1. Screen and local state | `BoardGraphScreen`, `_BoardGraphScreenState`, `_focusComponent`, `_showVisualTraces`, `_showHistory` | Owns focus and advanced-layer UI state. |
| 2. Provider boundary | `projectStateProvider`, `beginnerModeProvider`, `build` | Handles no-project state and reads projected facts plus display mode. |
| 3. Graph projection | `BoardGraphProjector.fromKnownFacts`, `baseProjection` | Converts loaded known facts into an in-memory graph projection. |
| 4. Layer and validity filter | `_buildFilter`, `LayerFilter`, `LayerTag`, `IncludeValidity` | Defines beginner and advanced visibility without changing source facts. |
| 5. Focus projection | `baseProjection.filter`, `baseProjection.focus`, `_focusComponent` | Narrows the visible graph to one component and depth when requested. |
| 6. Layout | `GraphLayoutEngine.layout`, `layout.nodePositions` | Computes in-memory node positions for the active projection. |
| 7. Warning and role presentation | `ProjectionStaleBanner`, `board-graph-role-copy` | Shows projection warning state and the explicit advanced/no-write role. |
| 8. Summary and controls | `_SummaryChip`, `FilterChip`, `DropdownButton<String>` | Presents source counts, mode controls, and component focus selection. |
| 9. Graph rendering | `BoardGraphCanvas` | Renders the active projection and layout with mode-dependent detail. |
| 10. Text fallback/list | `activeProjection.nodes.take(30)`, `board-graph-list-` | Exposes a bounded readable node listing below the canvas. |

## State and data flow

- `[D]` Loaded `KnownFacts` flow into `BoardGraphProjector`, then through either
  `filter` or `focus`, then into `GraphLayoutEngine.layout`.
- `[D]` The active projection and computed positions flow to
  `BoardGraphCanvas`; up to thirty active nodes also flow to text rows.
- `[D]` Beginner mode selects `LayerFilter.beginner`; advanced mode builds a
  fixed layer set and conditionally adds visual trace and history layers.
- `[D]` Focus, trace, and history controls mutate only widget-local state.
- `[D]` The banner receives `projectState.projectionFreshness` directly:
  `fresh` renders no warning, while `stale` and `unknown` remain distinct,
  nonblocking states above the graph content.
- `[D]` The app-bar mode toggle mutates only `beginnerModeProvider`.
- `[D]` No projected value is written back to `ProjectState` or disk.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input | Supplies current materialized known facts and authoritative tri-state freshness. |
| `beginnerModeProvider` | UI-local read/write | Selects beginner versus advanced presentation. |
| `BoardGraphProjector` | derived-data transform | Builds and filters/focuses the in-memory graph. |
| `LayerFilter`, `LayerTag`, `EvidenceLevel`, `IncludeValidity` | filter contract | Express visible graph layers and validity policy. |
| `GraphLayoutEngine` | derived layout | Computes node positions for the active graph. |
| `BoardGraphCanvas` | child renderer | Paints the projection supplied by this screen. |
| `ProjectionStaleBanner` | child presentation | Displays distinct stale/unknown warning copy from `projectionFreshness`; fresh is absent. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Focus and filter-chip callbacks | `UI_LOCAL` | `[D]` Call `setState` for three private fields only. |
| Beginner-mode toggle | `UI_LOCAL` | `[D]` Updates presentation mode, not project data. |
| Projector, filter, focus, and layout calls | `PROJECTION_STATE` | `[D]` Create derived in-memory graph/layout values without persistence. |
| `BoardGraphCanvas` and node list | `ZERO_WRITE` | `[D]` Consume derived values for display. |
| Loaded known facts | `ZERO_WRITE` | `[D]` Are read as projector input and never mutated here. |

Electrical-net meaning, visual-trace evidence, damage/suspect semantics,
measurement validity, canonical events, and projection materialization remain
owned by their model, projector, schema, tool, and writer owners. UI layer
visibility cannot promote or confirm evidence.

## Zero-write zones

- `[D]` Summary chips, role copy, warning, canvas, and node rows are display
  only.
- `[D]` Focus and layer controls rebuild local projection views only.
- `[D]` No writer provider, file API, subprocess, export, or materializer is
  imported.
- `[D]` `includeStale` changes visibility when history is shown; it does not
  change measurement validity.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Provider/no-project entry | `[D]` build branch | warning, projector, controls | `ZERO_WRITE` | `test/widget/board_graph_screen_test.dart` |
| Beginner filter | `[D]` `LayerFilter.beginner` | canvas/list and mode copy | `PROJECTION_STATE` | beginner rendering test |
| Advanced filter toggles | `[D]` conditional layer additions | projector semantics and node visibility | `UI_LOCAL` + `PROJECTION_STATE` | advanced and no-write tests |
| Focus | `[D]` `baseProjection.focus` | dropdown items and layout | `UI_LOCAL` + `PROJECTION_STATE` | focused screen tests; projector unit tests |
| Layout/canvas | `[D]` engine result feeds canvas | graph model and horizontal viewport | `PROJECTION_STATE` + `ZERO_WRITE` | graph screen and end-to-end graph tests |
| Warning/role copy | `[D]` direct tri-state banner input plus explicit text | shared banner and derived-surface integration | `ZERO_WRITE` | stale/unknown screen and integration tests |

## Relevant tests and helpers

- `test/widget/board_graph_screen_test.dart` covers beginner rendering,
  advanced controls, stale/unknown warning presence, focus affordance, and zero event
  mutation after filter interactions.
- `test/unit/board_graph_projection_test.dart` covers projector/filter model
  behavior independently of this screen.
- `test/integration/board_graph_end_to_end_test.dart` exercises the assembled
  graph path.
- `test/integration/projection_stale_banner_end_to_end_test.dart` visits this
  screen as one derived-data warning surface.

## Dangerous combinations

- `[P]` Changing layer membership and `IncludeValidity` together can expose or
  hide evidence classes beyond the intended mode.
- `[P]` Changing focus depth, projection filtering, and layout together can
  make missing nodes look like source-data loss.
- `[P]` Mode controls and canvas detail flags can drift, showing advanced data
  while copy still describes beginner mode.
- `[P]` Reintroducing a boolean banner input would collapse provenance-unknown
  into fresh-looking UI even though graph actions remain available.
- `[H]` Any persistence or confirmation action would violate the explicit
  advanced/debug, no-canonical-write role.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning presentation change | `ProjectionStaleBanner` call and `projectState.projectionFreshness` | shared banner and integration route | stale/unknown screen tests plus routed integration |
| One layer toggle | `_buildFilter`, matching `FilterChip` | projector and canvas | advanced/no-write tests plus projector tests |
| One focus behavior | `_focusComponent`, `baseProjection.focus` | dropdown and layout | screen focus coverage plus projector tests |
| One summary change | `_SummaryChip` call sites | known-facts owner | key-label screen test |
| One list presentation change | `activeProjection.nodes.take(30)` | canvas parity | screen rendering test |

## Future extraction seams

| Observed seam | Evidence | Authorization |
| --- | --- | --- |
| Advanced filter controls | `[S]` Two toggles feed one filter builder. | `NONE` |
| Projection-to-layout assembly | `[S]` A compact build segment composes projector and engine. | `NONE` |

## Freshness and review triggers

- Set `REVIEW_REQUIRED` for local-state or filter `SYMBOL_DRIFT`, projector or
  layout `FLOW_DRIFT`, writer/evidence `BOUNDARY_DRIFT`, linked graph coverage
  `TEST_DRIFT`, or responsibility `STRUCTURE_DRIFT`.
- Recheck protected owners when layer, evidence, validity, or repair-history
  meaning changes.
- Recheck this map when banner input, tri-state model semantics, or distinct
  stale/unknown test coverage changes.
- Formatting and physical line movement alone do not stale this map.

## Known uncertainty

- `[P]` The child canvas's internal paint and hit behavior is outside this
  file and must be verified in its own source.
- `[P]` Projector and layout correctness are imported behavior, not proved by
  this screen map.
- `[S]` Extraction seams are descriptive and non-authorizing.
