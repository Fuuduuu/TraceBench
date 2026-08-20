# Code Map: `lib/features/project/screens/project_overview_screen.dart`

- Source: `lib/features/project/screens/project_overview_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_SHELL_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns the read-oriented Project Overview destination content inside the shared
Workbench shell. It watches loaded `ProjectState`, renders projected summary
and freshness information, a responsive read-only placement preview or honest
placeholder, three existing workflow routes, and four visibly inert future
tools. Shared Home/mode/breadcrumb/navigation chrome and the dark color
vocabulary no longer originate here. The screen does not load projects,
materialize projections, edit placements, append events, or define routes.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Screen and provider boundary | `ProjectOverviewScreen`, `build`, `projectStateProvider`, `No project loaded` | Handles the direct no-project branch, reads the current projected state, and composes destination content only. |
| Destination wrapper | `SingleChildScrollView`, `EdgeInsets.fromLTRB(12, 12, 12, 16)`, `BoxConstraints(maxWidth: 1320)` | Retains Overview-owned scrolling, 24-pixel horizontal framing, centering, and maximum width. |
| Local responsive layout | `_WorkbenchShellLayout`, `constraints.maxWidth >= 960`, `overview-workbench-zone`, `overview-actions-panel` | Switches retained content between a wide row and stacked form at the destination-local 960 threshold. |
| Workbench summary | `_WorkbenchZoneCard`, `overview-status-strip`, `_OverviewChip` | Shows non-freshness status tags, projected counters, sample identity, and preview/placeholder choice. |
| Placement selection | `componentVisualPlacements`, `coordinateSpace == 'board_normalized'` | Selects only board-normalized placement facts for local read-only preview. |
| Read-only board preview | `_WorkbenchBoardReadOnlyCanvas`, `_WorkbenchGridPainter`, `_WorkbenchPlacementBadge` | Draws grid and projected badges with bounded normalized coordinates. |
| Empty projection presentation | `_WorkbenchPlaceholder` | Keeps Overview useful when no confirmed visual placements exist. |
| Retained workflow actions | `_ActionRailCard`, `overview-measurement-record-button`, `overview-add-component-button`, `overview-edit-component-button` | Navigates only to Measure Sheet, Add Component, and Edit Component workflows. |
| Disabled future controls | `overview-future-tools-panel`, `overview-future-contour-button`, `overview-future-photo-button`, `overview-future-layers-button`, `overview-future-trace-colors-button` | Exposes collapsed future-tool copy with four null callbacks. |
| Shared visual vocabulary | `WorkbenchShellColors`, `panelRaised`, `greenBright` | Consumes the shell-owned dark vocabulary for retained destination content without duplicating values. |
| Projection freshness | `ProjectionStaleBanner`, `projectState.projectionFreshness` | Renders exactly one tri-state banner above the local layout; no local stale evidence tag exists. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

## State and data flow

- `[D]` `ProjectOverviewScreen.build` watches `projectStateProvider`; null
  produces the retained no-project scaffold for direct mounts.
- `[D]` Loaded state supplies manifest/sample metadata, known-facts counters,
  placements, and authoritative `projectionFreshness`.
- `[D]` Placement facts are filtered to `board_normalized`, indexed against
  component facts, clamped for display, and painted locally.
- `[D]` The scroll wrapper contributes exactly 12 pixels per horizontal side;
  `_WorkbenchShellLayout` receives the remaining width and keeps its own `960`
  cutover, independent of the outer shell's `1228` decision.
- `[D]` The same Workbench and action widgets move between row and column
  shapes; they do not create parallel data flows.
- `[D]` The retained action rail calls `context.go` only for Measure Sheet,
  Add Component, and Edit Component. Top-level project navigation is shell-owned.
- `[D]` No provider is mutated by this source; Home and beginner mode moved to
  `WorkbenchShell`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| `projectStateProvider` | input | Supplies loaded projected state and derived counters. |
| `ProjectState` | input model | Carries manifest, known facts, freshness, and counters. |
| `ComponentFact`, `ComponentVisualPlacementFact` | input models | Supply labels and normalized read-only board positions. |
| `ProjectionStaleBanner` | child presentation | Renders one stale/unknown warning; fresh is absent. |
| `WorkbenchShellColors` | imported presentation vocabulary | Styles retained Overview cards, preview, actions, tags, and counters. |
| GoRouter / `context.go` | outbound workflow navigation | Enters three existing destination-owned workflows. |
| Flutter layout and painter APIs | presentation | Provide scrolling, local responsive composition, and drawing. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Project/manifest/counter reads | `ZERO_WRITE` | Display projected values without mutation. |
| Placement filtering and preview painting | `ZERO_WRITE` | Consume facts and paint local pixels only. |
| `context.go` workflow callbacks | `UI_LOCAL` | Change transient route location and invoke no writer here. |
| Future-tool buttons | `ZERO_WRITE` | All four callbacks are null. |
| Freshness banner and status strip | `ZERO_WRITE` | Read tri-state metadata; retain no local freshness boolean/tag. |
| Shared color constants | `ZERO_WRITE` | Consume immutable values owned by the shared shell. |

Canonical event/fact writes, placement confirmation, measurement saving,
component editing, Project ZIP behavior, and projection refresh remain owned
by their destination services/screens. A workflow navigation control does not
transfer those write classes here.

## Zero-write zones

- `_WorkbenchZoneCard`, preview widgets/painter/badges, placeholder, evidence
  tags, and chips only derive or render values.
- The placement preview has no gesture, selection, save, or writer path.
- The future controls remain disabled.
- Project identifiers hidden from visible copy are not rewritten.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Provider/content entry | `[D]` null/loaded branch and wrapper | outer gate/shell and direct mounts | `ZERO_WRITE` | route, freshness, shell-copy cases |
| Local responsive layout | `[D]` exact 960 comparison | shell 1228 cutover, preview height, action reachability | `ZERO_WRITE` | six-width monotonic and 1500 density cases |
| Placement preview | `[D]` normalized filter/clamp/painter | known-facts models and Board terminology | `ZERO_WRITE` | placeholder/read-only preview tests |
| Freshness presentation | `[D]` one banner above local layout | shared banner and status strip | `ZERO_WRITE` | stale/unknown one-banner cases |
| Workflow routes | `[D]` three exact `context.go` paths | router and destination screens | `UI_LOCAL` | Measure/Add/Edit route cases and event guard |
| Disabled tools | `[D]` four null callbacks | future product authority | `ZERO_WRITE` | collapsed/inert tools case |
| Shared visual vocabulary | `[D]` imported constants replace local copy | Workbench shell token owner | `ZERO_WRITE` | shell/color/copy assertions |

## Relevant tests and helpers

- `test/widget/project_overview_screen_test.dart` contains 19 widget tests for
  named route identity, stale/unknown warning ownership, shared-shell copy and
  color use, exact six-width routed monotonic geometry, 1500-pixel density,
  status counters, preview/placeholder, raw-ID hiding, inert future controls,
  retained Measure/Add/Edit routes, and event preservation.
- `test/widget/workbench_shell_test.dart` owns top-level project navigation,
  Home/mode controls, shell identity, and shared responsive navigation.
- `test/widget/project_gate_test.dart` proves loaded Overview appears inside
  one gate and one shared shell.
- `lib/app/router.dart` owns paths, names, nesting, and aliases.

## Dangerous combinations

- Changing the local 960 threshold or 24-pixel framing with the shell 1228
  cutover can reintroduce non-monotonic composition.
- Reintroducing Home/mode/breadcrumb/top-level navigation here would create a
  competing shell owner.
- Duplicating shell colors locally can drift the shared dark visual contract.
- Changing placement filtering, clamp math, and preview sizing together can
  make the preview look authoritative or geometrically wrong.
- Enabling a future control requires separate product/write authority.

## Safe SNIPER slices

| One outcome | Primary anchors | Inspect only | Focused evidence |
| --- | --- | --- | --- |
| One warning change | `ProjectOverviewScreen.build`, `ProjectionStaleBanner` | shared banner and status strip | stale/unknown cases |
| One responsive change | `_WorkbenchShellLayout` | outer shell threshold/framing and preview | six-width plus 1500 cases |
| One preview change | `_WorkbenchBoardReadOnlyCanvas`, `_WorkbenchGridPainter` | placement models/placeholder | preview and placeholder cases |
| One workflow action | `_ActionRailCard` and exact key | router/destination | matching route plus event guard |
| One inert-tool change | `overview-future-tools-panel` | all four null callbacks | inert-tools case |

## Future extraction seams

- `[S]` The read-only board preview is a cohesive private painter cluster.
- `[S]` The three retained workflow actions could use pure local metadata if
  doing so does not recreate top-level navigation ownership.

## Freshness and review triggers

Set `REVIEW_REQUIRED` for provider/private-anchor `SYMBOL_DRIFT`, projection or
workflow `FLOW_DRIFT`, navigation/write-class `BOUNDARY_DRIFT`, linked suite
`TEST_DRIFT`, or content/shell `STRUCTURE_DRIFT`. Recheck source and shell maps
together when framing, local cutover, shared colors, or chrome ownership moves.

## Known uncertainty

- `[D]` The preview is intentionally simpler than Board Canvas; shared colors
  do not imply shared renderer ownership.
- `[P]` Destination behavior after `context.go` remains outside this file.
- `[S]` Extraction seams are descriptive and non-authorizing.
