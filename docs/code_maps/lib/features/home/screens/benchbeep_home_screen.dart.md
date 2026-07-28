# Code Map: `lib/features/home/screens/benchbeep_home_screen.dart`

- Source: `lib/features/home/screens/benchbeep_home_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — production file owns 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

## File purpose

Owns the BenchBeep black/gold startup launcher. It renders responsive launcher
choices, project/load detail, branding, hover/focus affordances, and the exit
confirmation dialog while delegating all project and window actions through
callbacks. Its accepted contract includes `onCreateProject`; the
`Loo projekt nullist` card is enabled, has no `Tulekul` badge, and delegates
pure navigation to its parent.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Public launcher contract | `BenchBeepHomeScreen`, `hasProject`, `onCreateProject`, callback fields | Defines project availability plus create, load, open, workbench, and exit callback inputs. |
| Load-detail state lifecycle | `_BenchBeepHomeScreenState`, `_showLoadDetail`, `initState`, `didUpdateWidget` | Selects loaded-project or load-project detail and resets it when project availability changes. |
| Load-choice focus and scrolling | `_rightColumnKey`, `_selectLoadDetail`, `Scrollable.ensureVisible` | Selects the load panel and brings its detail into view after layout. |
| Responsive launcher shell | `build`, `LayoutBuilder`, `isWide`, `isCompact`, `benchbeep_home_frame` | Chooses stacked or two-column structure and sizes the desktop body. |
| Menu, brand, and exit | `_MenuBar`, `_confirmExit`, `_CompactBrand`, `_Pill` | Renders product identity/settings/exit controls and confirms window closure. |
| Launcher rail choices | `_LauncherRail`, `benchbeep_home_new_project_deferred`, `benchbeep_home_load_project_choice` | Renders four numbered modes, project availability, the active new-project action, and the deferred phone action. |
| Mode interaction state | `_ModeButton`, `_ModeButtonState`, `_SoonBadge` | Resolves enabled, active, hover, focus, badge, border, and tap behavior. |
| Project/load detail | `_RightColumn`, `_DetailPanel` | Switches between loaded-project continuation and ZIP/folder acquisition actions. |
| Secondary action controls | `_SampleProjectButton`, `_ActionButton`, `_ActionButtonState`, `benchbeep_home_import_project_button` | Always renders the ZIP and folder actions, derives nullable enablement from their callbacks, and owns hover/focus state. |
| Status and hero presentation | `_RailStatus`, `_LauncherIntro`, `_HeroBoard` | Presents project status, technician-first copy, and accepted brand imagery. |

## State and data flow

1. `[D]` `initState` shows load detail when no project is open.
2. `[D]` `didUpdateWidget` resets detail selection to the inverse of the new
   `hasProject` value.
3. `[D]` `_selectLoadDetail` sets `_showLoadDetail` and schedules a guarded
   `Scrollable.ensureVisible` for the right column.
4. `[D]` Root layout uses width thresholds of 1,400 and 900 pixels to choose
   two-column, stacked, and compact sample-action placement.
5. `[D]` `_LauncherRail` enables project continuation only when `hasProject`
   is true and treats the load parent as navigation to detail rather than a
   picker action.
6. `[D]` `_LauncherRail` passes `onCreateProject` to the card keyed
   `benchbeep_home_new_project_deferred`; that card is enabled and has no badge.
7. `[D]` `_ModeButtonState` creates an interactive tap only when both
   `enabled` and `onPressed` are present.
8. `[D]` `_DetailPanel` shows loaded-project copy and `Ava töölaud` when a
   project exists and load detail is not selected.
9. `[D]` Load detail always renders the `Ava ZIP` `_ActionButton`. Its
   `onPressed` is null when `onImportProject` is null and otherwise invokes
   `onImportProject(context)`; `Ava kaust` always invokes
   `onOpenProjectFolder(context)`.
10. `[D]` `_confirmExit` invokes `onExitRequested` only after the explicit
    confirm result is true.
11. `[D]` The screen does not select a route or assign project state itself;
    the accepted parent create callback opens `/new-project`.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework/UI | Supplies widget lifecycle, dialogs, responsive layout, interaction, animation, and styling. |
| Parent `hasProject` input | inbound projection | Chooses continuation enablement, detail content, and status copy. |
| Create-project callback | outbound navigation boundary | Delegates the active new-project action to the parent shell. |
| Project acquisition callbacks | outbound callback boundary | Delegate bundled sample, ZIP, and directory loading to owners outside this file. |
| Workbench callbacks | outbound navigation boundary | Delegate existing-project and Board Canvas opening to the parent shell. |
| Exit callback | outbound application lifecycle | Requests desktop-window closure only after confirmation. |
| `assets/brand/benchbeep_mark.png` | outbound presentation asset | Supplies compact BenchBeep identity with an empty fallback. |
| `assets/brand/pcb_board.png` | outbound presentation asset | Supplies the hero image with an empty fallback. |

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| `_showLoadDetail`, `_hovered`, `_focused` | `UI_LOCAL` | Mutate only transient widget selection and interaction state. |
| `_selectLoadDetail` and `Scrollable.ensureVisible` | `UI_LOCAL` | Change local selection and viewport position without persistent writes. |
| `onCreateProject` | `ZERO_WRITE` | Inspected parent wiring selects `/new-project`; it creates no request, project state, directory, or file. |
| `onLoadBundledProject` | `PROJECTION_STATE` | Accepted parent wiring loads bundled data into in-memory project state. |
| `onImportProject` | `PROJECTION_STATE` | Accepted parent/action call path reads ZIP data and replaces in-memory project state. |
| `onOpenProjectFolder` | `PROJECTION_STATE` | Accepted parent/action call path reads a selected project directory and replaces in-memory state. |
| `onOpenProject`, `onOpenWorkbench` | `ZERO_WRITE` | Accepted parent wiring changes navigation/router presentation without project persistence. |
| `onExitRequested` | `ZERO_WRITE` | Accepted parent wiring closes the window; this file performs no project write. |
| Deferred phone card | `ZERO_WRITE` | The disabled card has a null tap handler and performs no action. |
| Render, branding, and status widgets | `ZERO_WRITE` | Read inputs and render accepted UI only. |

The file contains no direct filesystem, canonical event/fact, Project ZIP,
schema, materializer, projection-file, `ProjectCreator`, or application-state
assignment. Write classes for callbacks come from inspected accepted call
paths, not button labels.

## Zero-write zones

- `[D]` `_LauncherIntro`, `_CompactBrand`, `_Pill`, `_SoonBadge`,
  `_RailStatus`, and `_HeroBoard` are presentation only.
- `[D]` Responsive branching changes layout, not persisted state.
- `[D]` The new-project action delegates navigation only.
- `[D]` Load-parent selection invokes no picker; only child ZIP/folder actions
  cross acquisition callback boundaries.
- `[D]` A null `onImportProject` disables the still-rendered `Ava ZIP` action;
  it does not remove that widget.
- `[D]` The disabled phone card has no `InkWell.onTap`.
- `[D]` Dialog cancel closes only the transient dialog.
- `[D]` Asset error builders render empty placeholders and perform no fallback
  write.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Constructor contract | `[D]` Parent-supplied fields define every external action. | `TraceBenchApp._buildLauncherHome`, `_LauncherRail`, `_DetailPanel` | `ZERO_WRITE`; acquisition callbacks may cross `PROJECTION_STATE` | Full Home harness and app tests |
| Detail state | `[D]` `hasProject` and `_showLoadDetail` select one detail branch. | Load parent, project loading callbacks | `UI_LOCAL` | Load-parent separation; loaded project |
| Responsive shell | `[D]` Width/height thresholds control hierarchy and reachability. | Rail, detail, hero, menu | `ZERO_WRITE` | Wide and medium layout |
| Exit dialog | `[D]` Only true confirmation invokes the callback. | Parent window callback, dialog styles | `UI_LOCAL`; `ZERO_WRITE` | Exit cancel/confirm |
| New-project action | `[D]` Required callback, enabled flag, absent badge, and tap are coupled. | Parent `/new-project` wiring | `ZERO_WRITE` | Callback isolation; real app Home-to-Wizard route |
| Load actions | `[D]` Parent card selects detail; the ZIP child is always rendered but disabled for a null callback, while enabled ZIP/folder children invoke their callbacks. | Project action owners and provider state | `PROJECTION_STATE` | Load parent; folder and ZIP flows |
| Existing-project continuation | `[D]` `hasProject` enables rail/detail workbench callbacks. | Parent router seam and `/project` | `ZERO_WRITE` | Sample, loaded project, folder/ZIP success |
| Hover/focus affordances | `[D]` Local booleans alter border/surface only. | `_ModeButtonState`, `_ActionButtonState` | `UI_LOCAL` | Gold hover accent |
| Brand and hero | `[D]` Fixed copy/assets define current product identity. | Asset declarations and layout | `ZERO_WRITE` | Identity and legacy-removal assertions |

## Relevant tests and helpers

Primary suite:
`test/widget/benchbeep_home_screen_test.dart`.

- `_homeHarness` injects the create callback and all existing callbacks without
  external project writes.
- The launcher identity test proves the new-project card is enabled and
  unbadged while the phone action remains deferred.
- A focused callback test proves only `onCreateProject` fires and fires once.
- A real `TraceBenchApp` test proves Home opens the existing Wizard route while
  project state stays null.
- Wide and medium tests cover the two-column/stacked hierarchy and reachability.
- Load-parent tests distinguish navigation-to-detail from picker invocation.
- Sample, folder, ZIP, and loaded-project tests preserve accepted behavior.
- The exit test covers presentation and exactly-once confirmation.

`lib/app/app.dart` is the direct parent wiring owner.

## Dangerous combinations

- `[D]` Changing the constructor contract and `_LauncherRail` wiring together
  can expose an action without a parent callback or silently drop a callback.
- `[D]` Changing enabled, badge, and callback values separately can produce a
  visually active but untappable card or a hidden active action.
- `[D]` Changing `hasProject`, detail selection, and continuation enablement
  together can show a loaded route while no project state exists.
- `[D]` Changing load-parent and child actions together can make the parent
  invoke a picker, violating navigation-only behavior.
- `[D]` Changing width thresholds and fixed desktop body sizing together can
  reintroduce overflow or a third main column.
- `[D]` Adding creator or persistence calls inside this UI file would cross
  accepted protected boundaries.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Exit copy/style only: `_MenuBar._confirmExit` and its focused test; exclude
  parent lifecycle behavior.
- Load-parent selection only: `_selectLoadDetail` and the `03 Lae projekt`
  card; exclude ZIP/folder callbacks.
- One responsive breakpoint only: root `LayoutBuilder` plus geometry tests;
  exclude action semantics.
- Home create action only: public constructor, `_LauncherRail`, parent callback,
  and two focused tests; preserve navigation-only and zero-write assertions.
- Hover affordance only: `_ActionButtonState` or `_ModeButtonState` with its
  focused interaction test.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Menu/exit presentation may be separable from launcher choices.
- `[S]` Loaded/load detail branches may be separate widgets if callback
  ownership remains explicit.
- `[S]` Mode and action interaction styling may share a presentation helper
  without merging semantics.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when constructor fields, launcher keys, mode/detail
widgets, or callback anchors change; `FLOW_DRIFT` when detail selection,
create callback threading, enablement, or parent routing changes;
`BOUNDARY_DRIFT` when project creation or persistent work enters the file;
`TEST_DRIFT` when action availability, layout, identity, or callback assertions
change; and `STRUCTURE_DRIFT` when rail/detail/hero responsibility moves.

## Known uncertainty

- `[D]` The active new-project card retains the historical key suffix
  `_deferred`; tests use it only as a stable widget anchor.
- `[D]` No test directly covers `didUpdateWidget` resetting detail after
  `hasProject` changes while load detail is selected.
- `[D]` No focused test passes a null `onImportProject` directly to prove the
  rendered `Ava ZIP` action is disabled.
- `[D]` No test directly covers asset error-builder branches.
- `[D]` The screen trusts the parent callback's zero-write behavior; it cannot
  enforce route or persistence semantics internally.
