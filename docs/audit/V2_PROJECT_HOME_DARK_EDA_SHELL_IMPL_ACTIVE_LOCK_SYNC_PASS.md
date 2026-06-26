# V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_PROJECT_HOME`.
- Scope: docs-only active-lock sync to arm the future first Project Home dark EDA shell visual implementation slice.

## Temporary audit mode

- Claude Code is temporarily unavailable for this active-lock sync.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT Pro temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected and verified HEAD/origin: `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Accepted/pushed Project Home dark EDA shell scope-lock: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS` at `675412d` (`docs: lock Project Home dark EDA shell scope`).
- Prior accepted/pushed dark EDA design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Prior route decision-state before this sync: current shell scope-lock `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS`, next recommended `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected accepted design-source scope-lock artifact: `docs/audit/V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS.md`.
- Inspected accepted shell scope-lock artifact: `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS.md`.
- Inspected live routing and candidate surfaces: `lib/app/app.dart`, `lib/app/router.dart`, `lib/features/home/screens/benchbeep_home_screen.dart`, `lib/features/project/screens/home_screen.dart`, `lib/features/project/screens/project_overview_screen.dart`, `test/widget/benchbeep_home_screen_test.dart`, and `test/widget/project_overview_screen_test.dart`.
- Inspected repo-local route/audit references for Project Overview / Workbench ownership, including `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md`, `docs/PASS_QUEUE_ARCHIVE.md`, and `docs/AUDIT_INDEX.md`.
- No external plugin, online source, screenshot, mockup, source index, or `_incoming` file was used as runtime truth.

## Target surface decision

Chosen target surface: Project Overview / Workbench Home.

Implementation surface:

- `lib/features/project/screens/project_overview_screen.dart`

Focused test surface:

- `test/widget/project_overview_screen_test.dart`

Rationale:

- The live router maps `/project` to `ProjectOverviewScreen`, making it the existing project/workbench landing surface.
- The screen owns the current workbench shell through `overview-workbench-zone`, `overview-workbench-board-preview`, `overview-actions-panel`, the Project Overview app bar/breadcrumb, and Project Overview navigation actions.
- The focused widget test already exercises Project Overview rendering, layout dominance, action routing, disabled future tools, Measure Sheet compatibility, Board Canvas navigation, and no-event-mutation boundaries.
- Existing audit/docs history maps Workbench Home / Project Overview work to `ProjectOverviewScreen` and keeps that surface split from Board Canvas.
- `BenchBeepHomeScreen` is the global BenchBeep launcher, not the first Project Home dark EDA shell implementation target.
- `HomeScreen` is the router fallback / legacy root route surface, not the first Project Home dark EDA shell implementation target.
- `BoardCanvasScreen` is a separate accepted Board Canvas surface and is not included in this Project Home shell slice.

## Future implementation allowlist

`V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` may edit exactly:

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

No broad directories are authorized.

## Future implementation may only

- Apply local visual shell polish to the selected existing Project Overview / Workbench Home surface.
- Move that surface toward the dark EDA / bench-instrument visual language.
- Use restrained dark surfaces, technical typography direction, compact shell spacing, and read-only/project identity presentation.
- Align visually toward the provided dark EDA HTML/CSS without copying HTML/CSS or assets.
- Preserve existing route and action behavior while changing presentation only.
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
- BenchBeep as user-facing app/product name.
- TraceBench as repo/platform/project name.
- BoardFact as data-fact subsystem name.

## Design source status

The dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

They must not be staged, edited, copied into runtime assets, imported, bundled, or depended on at runtime.

## Forbidden protected behavior

- No runtime/test edits in this active-lock sync.
- No implementation in this active-lock sync.
- No future implementation edits outside the two-file allowlist.
- No edits to BenchBeep Home launcher, legacy root Home screen, Board Canvas screen, router, Measure Sheet screen, writer/service, schema, validator, materializer, projection, Project ZIP, events, facts, assets, samples, platform files, generated files, or unrelated docs unless separately scoped.
- No `_incoming` files staged, edited, copied, imported, bundled, or depended on at runtime.
- No logo asset/runtime asset changes.
- No Google Fonts or external font dependency.
- No global dark theme.
- No Board Canvas dark EDA visual migration.
- No global redesign, command menu, context menu, audio/save beep, or canvas token migration.
- No new route/navigation behavior.
- No disabled/future tool becomes functional.
- No color-coded nets or board-level legend runtime behavior.
- Prototype labels such as 5V, 220V, GND, and Signal do not confirm nets, connectivity, electrical proof, facts, measurements, pins, or components.
- No Board Canvas canonical save/write behavior.
- No canonical measurement writing from Project Overview or Board Canvas.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring.
- No `events.jsonl` write or `known_facts` mutation.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Visual traces, From -> To context, prototype route labels, prototype net labels, and prototype legend labels remain non-authoritative visual/provenance/design input only.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this active-lock sync the current pass, record accepted/pushed shell scope-lock `675412d`, choose the future target surface, and route after acceptance to implementation.
- Updated `docs/PASS_QUEUE.md` to mark the shell scope-lock accepted/pushed and add this active-lock sync as the current pass.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to arm `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` with the exact two-file implementation allowlist.
- Updated `docs/AUDIT_INDEX.md` to mark the shell scope-lock accepted/pushed and add a pointer to this artifact.
- Added this audit artifact.

## Changed files in this active-lock sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Armed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS`.
- Route after accepted/pushed: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS`.

## Validation

- `git status --short --branch`: expected docs-only tracked diff plus known untracked scratch; nothing staged.
- `git diff --name-status`: expected docs-only tracked changes in `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged diff.
- `git diff --check`: passed; Git reported LF-to-CRLF working-copy warnings only.
- `python tools/validate_all.py`: passed; includes known optional missing-photo warnings and `Ran 273 tests ... OK`.

## Safe staging candidate

If ChatGPT Pro temporary secondary review or future Claude review accepts this active-lock sync, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
