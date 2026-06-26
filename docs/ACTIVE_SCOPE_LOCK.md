# Active Scope Lock

## Current pass

`V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_PROJECT_HOME

## Goal

Lock the first narrow implementation slice for Project Home dark EDA shell visual presentation, based on the accepted dark EDA design-source intake.

This pass is docs-only. It locks future implementation boundaries only and does not implement runtime behavior, edit tests, arm Board Canvas save/write behavior, or arm implementation directly.

## Temporary audit mode

- Claude Code is temporarily unavailable for this pass.
- This pass must not claim Claude audit or output a Claude `AUDIT_VERDICT`.
- Scope-lock review status is `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT Pro temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Codex output must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline

- Latest pushed HEAD verified before this scope-lock: `487c691` (`docs: lock Project Home dark EDA design source`), aligned with `origin/main`.
- Accepted/pushed dark EDA design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS` at `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Prior accepted decision-state: current design-source scope-lock `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS`, next recommended `NEEDS_USER_DECISION`.
- Accepted Board Canvas baseline remains read-only with `renderer writes: none`.

## Allowed files for this scope-lock

This scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS.md`

If any runtime, test, design-source, route, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event/fact, platform, asset, sample, generated, unlisted docs, or untracked scratch file appears necessary for this scope-lock, stop and report the exact required file and rationale before editing it.

## Design inputs inspected

Prompt-listed paths were checked first and were not present:

- `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\BenchBeep Project Home (dark).html`
- `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\home-dark.css`

Matching repo scratch design files were inspected as design input only:

- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark).html`
- `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\home-dark.css`

These files are not runtime truth and must not be staged, edited, imported, bundled, copied into runtime assets, or depended on at runtime.

## Design source status

The inspected dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

Do not infer canonical board facts, nets, pins, measurements, components, coordinates, electrical proof, route behavior, or AI facts from these files.

## Live surface ownership hints for next sync

This scope-lock does not arm implementation files. The next active-lock sync must inspect live repo files and choose the smallest exact future implementation allowlist.

Read-only live inspection found these existing surfaces to verify in the next sync:

- BenchBeep Home launcher: `lib/features/home/screens/benchbeep_home_screen.dart` with focused tests in `test/widget/benchbeep_home_screen_test.dart`.
- Legacy/project Home screen route surface: `lib/features/project/screens/home_screen.dart`.
- Project Overview / Workbench Home surface: `lib/features/project/screens/project_overview_screen.dart` with focused tests in `test/widget/project_overview_screen_test.dart`; existing docs identify `ProjectOverviewScreen`, `overview-workbench-zone`, and `overview-workbench-board-preview` as Workbench Home handles.
- Board Canvas is an accepted separate surface in `lib/features/board_canvas/screens/board_canvas_screen.dart` and must not be pulled into this first Project Home shell slice unless a later scope explicitly changes that route.

These are inspection notes only, not an implementation allowlist.

## Future implementation slice to lock

Future implementation may allow only:

- local visual shell polish for the existing Project Home / project landing surface, after the active-lock sync confirms the exact target surface;
- dark EDA / bench-instrument visual language for that surface only;
- restrained dark surfaces, technical typography direction, compact shell spacing, and read-only/project identity presentation;
- non-functional visual alignment toward the provided dark EDA HTML/CSS;
- tests for existing route/surface rendering and preservation of current navigation behavior.

## Future implementation must preserve

- Existing Home launcher behavior.
- `Open existing` behavior.
- `Import project` behavior.
- Back/Home behavior.
- Menu System behavior.
- Board Canvas behavior.
- Project Overview behavior unless explicitly identified as the exact target surface in active-lock sync.
- Existing Measure Sheet save behavior.
- BenchBeep as user-facing app/product name.
- TraceBench as repo/platform/project name.
- BoardFact as data-fact subsystem name.

## Explicitly forbidden

- Runtime/test edits in this scope-lock.
- A new implementation pass armed directly by this scope-lock.
- Runtime asset dependencies from `_incoming`, screenshots, mockups, docs/sources, or source indexes.
- Editing, staging, importing, bundling, or copying the dark EDA HTML/CSS design-source files.
- Dark Project Home implementation in this pass.
- Global dark theme.
- Board Canvas dark EDA visual migration.
- Color-coded nets or board-level legend runtime behavior.
- Treating 5V/220V/GND/Signal prototype labels as confirmed nets.
- Logo asset/runtime asset changes.
- Google Fonts or external font dependency.
- New route/navigation behavior.
- Board Canvas canonical save/write behavior.
- Claiming Board Canvas save/write or canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- `events.jsonl` writes, `known_facts` mutation, or canonical measurement/fact creation.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Turning visual traces, From -> To context, prototype route labels, prototype net labels, or prototype legend labels into confirmed connectivity.
- Edits to router, Home, Project Overview, Measure Sheet screen, writer/service, schema, writer, validator, materializer, projection, Project ZIP, event, fact, platform, generated, sample, asset, or unlisted docs files in this scope-lock.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, or canvas token migration.

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- The next active-lock sync must be docs-only and must arm the smallest exact future implementation allowlist before any runtime/test work.
