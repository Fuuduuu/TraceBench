# Code Map: `lib/features/project/screens/new_project_wizard_screen.dart`

- Source: `lib/features/project/screens/new_project_wizard_screen.dart`
- Type: `production`
- Status: `MAINTAINED`
- Qualification: `AUTO — 5+ independently testable behaviors`
- Audit evidence: `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_HOME_ACTIVATION_LOCK_PASS.md`

## File purpose

Owns the accepted six-step New Project Wizard foundation. It captures a
widget-local Step 1 draft, selects and displays a parent path, gates step
navigation, preserves draft values, distinguishes completed input from viewed
placeholder progress, confirms dirty cancellation, and renders responsive
wide/compact layouts. Steps 2–6 are visible placeholders. The screen contains
no final create action and performs no project, directory, file, event, fact,
projection, or ZIP write.

## Responsibility zones

| Zone | Stable symbol anchors | Responsibility |
| --- | --- | --- |
| Step catalogue | `_wizardSteps`, `_WizardStepDefinition` | Defines the six exact Estonian labels, placeholder detail, and icons. |
| Picker/platform seams | `NewProjectWizardScreen`, `directoryPicker`, `platformInfo`, `_isMobile` | Supplies injected or default folder-picker and platform capability behavior. |
| Step 1 draft lifecycle | `_projectNameController`, `_deviceNameController`, `_additionalInfoController`, `_selectedParentPath`, `_handleDraftTextChanged`, `_draftTouched`, `dispose` | Owns all transient draft inputs, arms dirty state from text changes or accepted folder selection, and disposes controllers. |
| Folder selection | `_pickFolder`, `_isPickingFolder`, `FilePicker.platform.getDirectoryPath`, `_showMessage` | Guards mobile/duplicate use, catches picker failures, and stores a nonblank returned path while arming dirty-draft state. |
| Navigation gates | `_canAdvanceFromStepOne`, `_goNext`, `_goBack`, `_currentStep` | Requires project name plus selected path for Step 1 and bounds navigation to six steps. |
| Cancellation | `_cancelWizard`, `wizard-cancel-dialog-continue`, `wizard-cancel-dialog-confirm` | Returns untouched drafts directly Home and confirms before discarding touched drafts. |
| Responsive shell | `build`, `_buildHeader`, `_buildWideProgress`, `_buildCompactProgress`, `_buildEditorCard` | Chooses the wide or compact hierarchy and renders the current editor. |
| Progress semantics | `_buildProgressTile`, `Valmis`, `Vaadatud`, `Praegune samm` | Marks only completed Step 1 as ready and prior non-functional steps as viewed. |
| Step content | `_buildStepOne`, `_buildFolderPicker`, `_buildPlaceholder`, `_WizardPlaceholder` | Renders four Step 1 fields and honest non-functional Steps 2–6. |
| Action and safety copy | `_buildActionBar`, `_WizardSafetyCard`, `wizard-next`, `wizard-back`, `wizard-cancel` | Renders navigation controls and explicit zero-write/future-integration copy without a create CTA. |

## State and data flow

1. `[D]` `_wizardSteps` fixes the order:
   `Projekti andmed`, `Plaadi kontuur`, `Komponentide asetus`,
   `Probleemi kirjeldus`, `Kontroll ja kinnitus`, `Kokkuvõte`.
2. `[D]` Three controllers plus `_selectedParentPath` hold the complete
   widget-local Step 1 draft; `_handleDraftTextChanged` sets `_draftTouched`
   for every text-field change.
3. `[D]` `_canAdvanceFromStepOne` requires a trimmed nonblank project name and
   a trimmed nonblank selected parent path. Device name and additional info are
   optional.
4. `[D]` `_pickFolder` rejects mobile use, ignores duplicate opens, invokes the
   injected picker or `FilePicker.platform.getDirectoryPath`, catches failures,
   checks `mounted`, and stores only a nonblank result. Inside that accepted
   nonblank branch it also sets `_draftTouched = true`.
5. `[D]` Selecting a path does not derive a child path, check writability, or
   create anything.
6. `[D]` `_goNext` enforces the Step 1 gate and increments only through Step 6;
   `_goBack` decrements without clearing controllers or the selected path.
7. `[D]` `_cancelWizard` routes an untouched draft directly to `/`. A touched
   draft opens the confirmation dialog; continue preserves state and confirm
   routes to `/`.
8. `[D]` `build` chooses compact progress under 1,050 pixels and tighter outer
   padding under 600 pixels. Step 1 moves its safety card below the form when
   the editor is compact or narrower than 820 pixels.
9. `[D]` `_buildProgressTile` labels prior Step 1 `Valmis`, prior placeholder
   steps `Vaadatud`, the selected step `Praegune samm`, and future steps
   `Järgmine samm`.
10. `[D]` Steps 2–6 render placeholders. Step 6 removes `wizard-next`, provides
    no create CTA, and states that final integration belongs later.
11. `[D]` `_WizardSafetyCard` states that final creation is not implemented and
    folder selection creates no folder or file.

## Direct dependencies

| Dependency | Direction | Purpose |
| --- | --- | --- |
| Flutter Material | framework and UI state | Provides the stateful screen, controllers, responsive layout, dialogs, fields, buttons, semantics, and styling. |
| `FilePicker` | outbound picker service | Selects a parent directory when no picker callback is injected. |
| `PlatformInfo` / `DefaultPlatformInfo` | inbound capability service | Supplies the mobile/non-mobile picker gate. |
| GoRouter | outbound UI navigation | Routes cancellation to `/`. |

There is no Riverpod, `ProjectCreator`, `ProjectCreationRequest`,
`projectStateProvider`, materializer, writer, or project-model dependency.

## Write and protected boundaries

| Symbol or flow | Write class | Boundary evidence |
| --- | --- | --- |
| Controllers, `_selectedParentPath`, `_currentStep`, `_draftTouched`, `_isPickingFolder` | `UI_LOCAL` | Mutate only transient widget state. |
| `_pickFolder` | `UI_LOCAL` | Stores a selected nonblank path and arms `_draftTouched`; it does not create, validate, or modify that path. |
| `_goNext`, `_goBack` | `UI_LOCAL` | Change only the visible step. |
| `_cancelWizard` dialog state | `UI_LOCAL` | Reads transient draft state and displays a transient confirmation. |
| `context.go('/')` | `ZERO_WRITE` | Navigates Home without assigning or persisting project state. |
| `_showMessage` | `UI_LOCAL` | Mutates transient SnackBar state only. |
| Rendering, progress, placeholders, and safety copy | `ZERO_WRITE` | Read widget state and render accepted UI only. |

The file contains no creator call, project request, application-project-state
assignment, canonical event/fact append, schema mutation, materializer or
writer implementation, Project ZIP operation, board/outline/component/
placement write, or direct filesystem write.

## Zero-write zones

- `[D]` `_wizardSteps` is immutable presentation metadata.
- `[D]` Folder selection stores only the returned string and marks the
  widget-local draft as touched.
- `[D]` Step navigation and progress status are widget-local.
- `[D]` Placeholder Steps 2–6 execute no functional workflow.
- `[D]` The final step exposes no create action.
- `[D]` Cancellation navigation does not save or create draft content.
- `[D]` `build`, palette, pills, safety card, and placeholder widgets are
  presentation-only.
- `[D]` `dispose` releases controllers without persisting their values.

## Impact matrix

| Change zone | Evidence | Inspect-only coupled zones | Write class | Relevant tests |
| --- | --- | --- | --- | --- |
| Step catalogue | `[D]` Fixed list drives progress and placeholder content. | Progress tiles, current editor | `ZERO_WRITE` | Exact six-step labels; placeholder traversal |
| Draft fields and gate | `[D]` Name/path gate and optional fields feed only local state; text changes and nonblank folder selection arm dirty state. | Picker, navigation, cancellation, action bar | `UI_LOCAL` | Four fields; both disabled-gate tests; valid advance; cancellation tests |
| Folder picker | `[D]` Injected/default picker stores a path after capability and async guards. | `PlatformInfo`, `FilePicker`, SnackBar | `UI_LOCAL` | Path/copy contract; mobile gate |
| Navigation retention | `[D]` Step changes leave controllers/path intact. | Progress and editor rebuilding | `UI_LOCAL` | Back/forward retention; multiline input |
| Cancellation | `[D]` `_draftTouched` selects direct or confirmed Home return. | GoRouter `/`, dialog controls | `UI_LOCAL`; `ZERO_WRITE` | Untouched, continue, and confirm tests |
| Progress semantics | `[D]` Step index plus functional status select labels/icons. | Wide and compact progress | `ZERO_WRITE` | Completion-versus-viewed contract |
| Responsive layout | `[D]` Width thresholds change hierarchy, not behavior. | Header, progress, editor, action bar | `ZERO_WRITE` | Wide and compact overflow tests |
| Placeholder/final boundary | `[D]` Steps 2–6 expose copy only and Step 6 has no next/create action. | Later product decisions | `ZERO_WRITE` | Placeholder traversal; no creator/project route |

## Relevant tests and helpers

Primary focused suite:
`test/widget/new_project_wizard_screen_test.dart`.

Its eighteen widget tests cover:

- exact six-step labels and all four Step 1 fields;
- both Step 1 gate halves and valid advance;
- selected-path display plus honest no-create/no-folder copy;
- complete draft retention across back/forward navigation;
- Steps 2–6 as non-functional placeholders;
- multiline additional information without accidental navigation;
- untouched cancellation, dirty confirmation, continue retention, and confirmed
  cancellation;
- mobile picker suppression;
- wide and compact no-overflow layouts;
- `Valmis` only for completed Step 1 and `Vaadatud` for visited placeholders;
- absence of creator, project-state assignment, create CTA, and `/project`
  navigation.

## Dangerous combinations

- `[D]` Changing the Step 1 gate, controller listeners, and picker state
  together can enable navigation with incomplete input or lose dirty state.
- `[D]` Changing async picker guards and mounted handling together can allow
  duplicate pickers or state updates after disposal.
- `[D]` Changing navigation indices, progress classification, and placeholder
  rendering together can label non-functional steps as complete.
- `[D]` Changing cancellation routing and `_draftTouched` together can discard
  entered values without confirmation or block untouched cancellation.
- `[D]` Changing compact breakpoints, fixed progress widths, and action layout
  together can reintroduce overflow.
- `[D]` Adding creator, project-state, filesystem, or final-create behavior here
  would cross the accepted zero-write boundary.

## Safe SNIPER slices

These are descriptive candidates only and authorize no work.

- Step 1 copy only: `_WizardSafetyCard` and its exact focused assertions;
  exclude picker and navigation behavior.
- Gate only: `_canAdvanceFromStepOne`, `wizard-next`, and the two gate tests;
  exclude placeholder steps.
- Picker capability only: `_isMobile`, `_pickFolder`, and the mobile test;
  exclude final creation.
- Progress semantics only: `_buildProgressTile` and the progress test; preserve
  the distinction between `Valmis` and `Vaadatud`.
- Cancellation only: `_handleDraftTextChanged`, the nonblank-selection branch
  of `_pickFolder`, `_draftTouched`, `_cancelWizard`, and the three cancel
  branches; exclude draft persistence outside the widget.
- One responsive branch only: the relevant `LayoutBuilder` and focused
  overflow test; exclude action semantics.

## Future extraction seams

Descriptive, non-authorizing candidates:

- `[S]` Progress presentation may be separable from draft/navigation state if
  the status classification remains explicit.
- `[S]` Step 1 form and safety copy may be a component if controller ownership
  and the zero-write boundary remain visible.
- `[S]` Cancellation confirmation may be separable behind a boolean result.
- `[S]` Placeholder content may become individual step owners only through
  later human scope decisions.

## Freshness and review triggers

Review for `SYMBOL_DRIFT` when named widget, state, picker, step, or key anchors
change; `FLOW_DRIFT` when draft, picker, navigation, cancellation, or progress
ordering changes; `BOUNDARY_DRIFT` when persistent work, creator calls, project
state, or final creation enters this file; `TEST_DRIFT` when copy, responsive,
retention, or zero-write assertions change; and `STRUCTURE_DRIFT` when step
ownership moves between widgets or services.

## Known uncertainty

- `[D]` Focused tests do not cover picker exceptions, picker cancellation, or
  whitespace-only picker output.
- `[D]` No focused test disposes the widget while a picker future is pending.
- `[D]` No focused test isolates folder selection as the only action before
  dirty-draft cancellation, although the `_pickFolder` assignment is direct.
- `[D]` The screen displays the selected parent path but intentionally does not
  validate permissions, collisions, or a derived project destination.
- `[P]` Functional behavior for `Plaadi kontuur` and all other placeholder
  steps requires separate future human decisions; this map authorizes none.
