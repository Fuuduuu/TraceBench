# Active Scope Lock

## Current armed implementation pass

`V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS`

## Type

LANE_B_ADJACENT / FLUTTER_UI_PROTECTED_IMPLEMENTATION / PROJECT_HOME_VISUAL_SHELL

## Active-lock sync source

- Active-lock sync pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Accepted/pushed scope-lock: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS` at `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Accepted/pushed design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- This lock arms the future implementation pass only; the current sync pass is docs-only and does not implement runtime behavior.
- Claude Code is temporarily unavailable for the sync pass; review status is `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.

## Target surface decision

Future implementation target: Project Overview / Workbench Home.

Rationale from live repo inspection:

- `/project` routes to `ProjectOverviewScreen` in `lib/features/project/screens/project_overview_screen.dart`.
- The screen owns the existing project/workbench landing shell through `overview-workbench-zone`, `overview-workbench-board-preview`, `overview-actions-panel`, the Project Overview app bar/breadcrumb, and Project Overview navigation actions.
- Focused widget coverage already lives in `test/widget/project_overview_screen_test.dart`.
- Prior repo docs identify Project Overview / Workbench Home as the existing Workbench Home surface and keep it separate from Board Canvas implementation tracks.
- `BenchBeepHomeScreen` is the global BenchBeep launcher and is not the first Project Home dark EDA shell target in this implementation slice.
- `HomeScreen` is the router fallback / legacy root route surface and is not the first Project Home dark EDA shell target in this implementation slice.
- `BoardCanvasScreen` is a separate accepted Board Canvas surface and is not included in this first Project Home shell slice.

## Future implementation allowlist

`V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` may edit only:

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

If implementation appears to require any other runtime, test, route, Home, Board Canvas, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, generated, asset, sample, unlisted docs, design-source, or scratch file, stop and report the exact file and rationale before editing it.

## Future implementation may only

- Apply local visual shell polish to the selected existing Project Overview / Workbench Home surface.
- Move that surface toward the dark EDA / bench-instrument visual language.
- Use restrained dark surfaces, technical typography direction, compact shell spacing, and read-only/project identity presentation.
- Align visually toward the provided dark EDA HTML/CSS without copying HTML/CSS or assets.
- Preserve the existing project/workbench route and actions while changing presentation only.
- Add or update focused widget tests for the existing route/surface rendering and preservation of current navigation behavior.

## Future implementation must preserve

- Existing BenchBeep Home launcher behavior.
- Existing `Open existing` behavior.
- Existing `Import project` behavior.
- Existing Back/Home behavior.
- Existing Menu System behavior.
- Existing Board Canvas behavior.
- Existing Project Overview route behavior and enabled actions.
- Existing Measure Sheet save behavior.
- Existing `/project/measure-sheet` direct/fallback compatibility.
- Existing Add Component behavior.
- Existing disabled/future tool inertness.
- BenchBeep as the user-facing app/product name.
- TraceBench as the repository/platform/project name.
- BoardFact as the data-fact/subsystem name.

## Design source status

The dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not stage them. Do not edit them. Do not copy them into runtime assets. Do not import or bundle them. Do not depend on `_incoming` at runtime. Do not infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, route behavior, or AI facts from them.

## Explicitly forbidden

- Editing runtime/test files outside the two-file future implementation allowlist.
- Editing `lib/features/home/screens/benchbeep_home_screen.dart`.
- Editing `lib/features/project/screens/home_screen.dart`.
- Editing `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Editing `lib/app/router.dart`.
- Editing Measure Sheet screen, writer/service, schema, validator, materializer, projection, Project ZIP, events, facts, assets, samples, platform files, generated files, or unrelated docs.
- Editing, staging, importing, bundling, or copying `_incoming` HTML/CSS design-source files.
- Adding runtime asset dependencies from `_incoming`, screenshots, mockups, docs/sources, or source indexes.
- Adding logo asset/runtime asset changes.
- Adding Google Fonts or external font dependencies.
- Starting a global dark theme.
- Starting Board Canvas dark EDA visual migration.
- Starting global redesign, command menu, context menu, audio/save beep, or canvas token migration.
- Adding new route/navigation behavior.
- Turning disabled/future tools into functional tools.
- Implementing color-coded nets or board-level legend runtime behavior.
- Treating 5V/220V/GND/Signal prototype labels as confirmed nets.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Board Canvas canonical save/write behavior.
- Canonical measurement writing from Project Overview or Board Canvas.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual traces, From -> To context, prototype route labels, prototype net labels, or prototype legend labels into confirmed connectivity.

## Validation expected for implementation

Future implementation should run and report:

- `dart format lib/features/project/screens/project_overview_screen.dart test/widget/project_overview_screen_test.dart`
- `flutter test test/widget/project_overview_screen_test.dart`
- `flutter test test/widget/benchbeep_home_screen_test.dart`
- `flutter test test/widget/measure_sheet_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Route

- Current route owner during this sync pass: `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md`.
- Current docs-only sync pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Armed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS`.
- Route after this sync pass is accepted/pushed: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS`.
