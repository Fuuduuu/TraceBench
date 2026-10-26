# Code Map: `lib/features/project/widgets/workbench_shell.dart`

- Source: `lib/features/project/widgets/workbench_shell.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_SHARED_WORKBENCH_FOUNDATION_V1_CODE_MAP_MAINTENANCE_PASS.md`

## File purpose

Owns secondary loaded-project chrome: one compact warm instrument header,
inline project/current-page context, a transient twelve-entry project menu,
Home and independent beginner mode. Board Canvas bypasses this State and reuses
the sole destination inventory. Legacy palette/surface remain separate from
warm shared values. Photos/Overview opt into warm content in their own owners.
No destination workflow, writer, persistence, freshness or route declaration
belongs here; Home retains in-memory Session close before root navigation.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Legacy palette | `WorkbenchShellColors`, `background`, `greenTint` | Existing constants for legacy destinations; shared warm values live elsewhere. |
| Legacy surface | `WorkbenchDestinationSurface`, `workbench-destination-surface`, `ListTileThemeData`, `ExpansionTileThemeData` | Opaque-child Theme/Material wrapper; no domain ownership. |
| Model/inventory | `WorkbenchDestination`, `workbenchDestinations`, `Board Canvas`, `Project Overview` | Sole ordered twelve entries, icons and locations; Home/workflow leaves excluded. |
| Active parent | `activeWorkbenchDestination`, `/project/components/add`, `/project/components/edit`, `/project/measure-sheet` | Pure Add/Edit/Measure parent normalization. |
| Shell lifetime/input | `WorkbenchShell`, `_WorkbenchShellState`, `GoRouterState.of`, `beginnerModeProvider`, `manifest?.projectName?.trim()` | Stateful secondary frame; route, mode and display identity reads. |
| Compact frame/theme | `workbench-shell`, `workbench-shell-app-bar`, `toolbarHeight: 44`, `buildWorkbenchTheme`, `SizedBox.expand(child: widget.child)` | Header-only warm Theme, one decorative rule, full-width original-theme child. |
| Home/mode | `workbench-home-button`, `workbench-beginner-mode-button`, `closeProject`, `context.go('/')` | Close before root go; mode toggles only its provider. |
| Inline context | `_WorkbenchBreadcrumb`, `workbench-breadcrumb`, `showIdentity`, `activeDestination.label` | Separate exact current-page Text; optional identity abbreviation/full tooltip. |
| Menu/focus | `workbench-project-menu`, `CheckedPopupMenuItem<String>`, `workbench-destination-`, `focused`, `TextDecoration.underline`, `context.go(location)` | Checked entries/icons, transient routing and visible border/underline focus cue. |

## Anchor inventory and verification

Selection rule: take every backtick-delimited token in the responsibility
table's Stable symbol anchors column, split comma-separated tokens, trim, and
de-duplicate in first-appearance order. Every listed literal resolves as an
exact substring in committed source. The map uses no line-number anchors.

## Ordered navigation contract

The sole top-level project inventory is:

1. `/project` — Board Canvas
2. `/project/overview` — Project Overview
3. `/project/components` — Komponendid
4. `/project/measurements` — Mõõtmised
5. `/project/pins` — Pinnid
6. `/project/not-populated` — Täitamata
7. `/project/photos` — Foto tõendid
8. `/project/reference-images` — Viitepildid
9. `/project/graph` — Advanced graph
10. `/project/events` — Sündmused
11. `/project/known-facts` — Teadaolevad faktid
12. `/project/report` — Raport

Home is a separate AppBar action. Add Component, Edit Component, and Measure
Sheet remain workflow destinations and select their top-level parent rather
than becoming additional entries.

## State and data flow

1. The router's loaded-project gate owns child selection. Canvas is shell-free;
   secondary leaves retain one Element/State across navigation.
2. URI passes through the active-parent resolver; Session manifest supplies
   trimmed projectName or projectId/Projekt display fallback.
3. Separate beginner state supplies the visible mode caption and toggle.
4. A local warm Theme wraps only the 44 px AppBar and captured popup, followed
   by a one-pixel rule. The opaque child expands under its original Theme.
5. A 500-pixel available-title constraint abbreviates identity. This is not a
   navigation breakpoint; current-page Text stays exact and tooltip full.
6. The popup renders the sole twelve-entry inventory. Checked state derives
   from the active parent; selection returns a location and calls go. Outside
   click/Escape/cancel dismiss transient UI without changing the project.
7. Home closes Session before go('/'); mode remains separate. No destination
   writer, project reload or materializer is invoked by chrome.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material/layout/focus | presentation | AppBar, popup, checked semantics and focus cue. |
| `buildWorkbenchTheme` / `WorkbenchColors` | shared input | Warm header and captured popup; app_theme.dart owns values. |
| GoRouter | route input / UI-local output | URI and existing go callbacks. |
| Beginner provider | UI-local read/write | Independent transient mode. |
| ProjectSession/provider | read / explicit command | Manifest identity and Home close only. |
| Router child | opaque inbound content | Full-width original ambient Theme. |
| App router / ProjectGate | construction | Secondary shell and Canvas bypass. |
| Board Canvas | model consumer | Shared inventory, separate bar/popup. |
| Legacy destinations | surface consumers | Original local surface/old palette. |

## Write and protected boundaries

| Symbol or flow | Write class | Evidence |
| --- | --- | --- |
| Palette/surface/inventory/parent/context | `ZERO_WRITE` | Constants, path normalization, identity reads and widgets only. |
| Menu/focus/go | `UI_LOCAL` | Transient route and presentation state. |
| Beginner toggle | `UI_LOCAL` | Existing boolean provider only. |
| Home close then go | `PROJECTION_STATE` + `UI_LOCAL` | Existing in-memory clear before root navigation. |
| Child composition | `ZERO_WRITE` | Downstream effects remain destination-owned. |

No load/replace/materialize/save, event/fact mutation, file operation or ZIP
write originates here. A destination's write authority is not transferred by
including its route in the menu.

## Zero-write zones

- Legacy surface, pure metadata/resolver and identity/theme presentation.
- Header/context build only; focus/menu/mode are transient UI.
- Home is the explicit in-memory Session exception, not a canonical write.
- The routed child retains independent domain and presentation ownership.

## Impact matrix

| Zone | Evidence | Inspect-only coupling | Write class | Tests |
| --- | --- | --- | --- | --- |
| Legacy surface | [D] original local Theme/Material | six loaded consumers/global fallback | `ZERO_WRITE` | seven-case body/theme matrix |
| Inventory/parent | [D] one list/resolver | router/aliases/Canvas menu | `ZERO_WRITE` | literal inventory/parent/twelve routes |
| Compact frame | [D] full-width child, no rail/Drawer | Overview local 960 | `ZERO_WRITE` | widths, scaling and geometry |
| Popup/focus | [D] checked entries, keyboard and border/underline | shared theme | `UI_LOCAL` | both menus, cancel/keyboard/focus |
| Home/mode | [D] close-before-go/boolean | Session generation/launcher | `PROJECTION_STATE` / `UI_LOCAL` | Home and mode-survival |
| Shell identity | [D] one State across leaves | gate/router push/pop | `ZERO_WRITE` | Shell/Gate matrices |

## Relevant tests and helpers

- Shell tests contain two pure and thirteen widget declarations, generating
  seventeen cases through two two-width loops. They cover both twelve-entry
  menus, checked state, focus/keyboard/cancel, exact Photos Text and Canvas
  absence, provider/State identity and Home/mode/data/writer/file guards.
- Seven Batch-1 cases retain original body signatures and legacy surface
  roles, both Events modes and facts/events/freshness/file observations.
- Gate tests retain all-fifteen null/loaded targets, nested stack, primary
  bypass and unsettled-transition Material evidence.
- Overview owns local 960 content math; Canvas owns its separate renderer/bar
  thresholds. Neither consumes a Shell rail.
- Theme/frame tests independently cover palette/roles and transient capture.

## Dangerous combinations

- Applying the header Theme to its opaque child silently recolors legacy
  destinations; warm content is opt-in.
- Duplicate metadata or changed parent normalization drifts routing/selection.
- Recreating Shell State or moving the gate breaks lifetime/recovery evidence.
- Adding persistence to Home/menu changes current write boundaries.
- Changing frame allocation and Overview math together can conceal width loss.
- Legacy WorkbenchShellColors and shared WorkbenchColors are different owners.

## Safe SNIPER slices

- Header/context/focus: build/breadcrumb, warm/keyboard and width/scale cases;
  inspect child Theme and Overview allocation.
- One inventory/parent change: model/resolver, router and both menu matrices.
- Home/mode: callback with Session/generation/mode guards.
- Legacy surface: exact wrapper with seven-case role/body matrix.

## Future extraction seams

- [S] Pure metadata is cohesive but currently shared by both menu consumers.
- [S] The inline project menu is a local leaf; no move is prescribed.

## Freshness and review triggers

Review menu/header/context keys, identity fallback, mode/Home callbacks,
parent normalization, captured Theme, child allocation and router lifetime.
The removed rail/Drawer is not an active contract. Recheck actual source/tests
when symbol, flow, boundary, test or structure ownership changes.

## Known uncertainty

- [D] Owner-local no-write evidence does not prove destination internals.
- [D] Title abbreviation is distinct from destination responsive thresholds.
- [S] Seams describe possibilities and authorize no refactor.
