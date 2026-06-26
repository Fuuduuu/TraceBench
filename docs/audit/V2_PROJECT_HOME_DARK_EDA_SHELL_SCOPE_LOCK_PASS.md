# V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_PROJECT_HOME`.
- Scope: docs-only scope-lock for a future first narrow Project Home dark EDA shell visual presentation slice.

## Temporary audit mode

- Claude Code is temporarily unavailable for this scope-lock.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- ChatGPT Pro temporary secondary review may be used before any staging decision, but it is not Claude audit.
- Do not use this artifact as a Claude acceptance record.

## Baseline

- Expected HEAD/origin: `487c691` (`docs: lock Project Home dark EDA design source`).
- Accepted/pushed dark EDA design-source scope-lock: `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS` at `487c691` (`docs: lock Project Home dark EDA design source`).
- Prior accepted/pushed closeout: `V2_MEASURE_PANEL_PIN_LEG_SELECTOR_DEDUP_IMPL_POST_AUDIT_PASS` at `2b17f68` (`docs: record Measure panel pin leg selector dedup`).
- Prior route decision-state before this scope-lock: current design-source scope-lock `V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS`, next recommended `NEEDS_USER_DECISION`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Tool / skill check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected protected-boundary and prompt/audit docs listed by the prompt, including `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Inspected accepted dark EDA design-source scope-lock artifact: `docs/audit/V2_PROJECT_HOME_DARK_EDA_DESIGN_SOURCE_SCOPE_LOCK_PASS.md`.
- Checked the prompt-listed design paths under `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\`; those exact paths were not present.
- Inspected matching repo scratch design files under `_incoming/ui_redesign/` as design input only:
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\BenchBeep Project Home (dark).html`
  - `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\home-dark.css`
- Performed read-only live surface inspection using file listings and targeted `rg` queries. Existing surfaces found for the next active-lock sync to verify include `BenchBeepHomeScreen`, `HomeScreen`, `ProjectOverviewScreen`, `BoardCanvasScreen`, and their focused widget tests.
- Inspected existing docs/audit references that identify the Project Overview / Workbench Home surface, including `docs/audit/V2_PROJECT_OVERVIEW_LAYOUT_DENSITY_SCOPE_LOCK_PASS.md` and route/archive references to `overview-workbench-zone`.
- No external plugin, online source, screenshot, mockup, source index, or `_incoming` file was used as runtime truth.

## Design source status

The inspected dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`

They must not be staged, edited, copied into runtime assets, imported, bundled, or depended on at runtime.

## Future shell visual slice locked

Future implementation may allow only:

- local visual shell polish for the existing Project Home / project landing surface, after active-lock sync confirms the exact target surface;
- dark EDA / bench-instrument visual language for that surface only;
- restrained dark surfaces, technical typography direction, compact shell spacing, and read-only/project identity presentation;
- non-functional visual alignment toward the provided dark EDA HTML/CSS;
- tests for existing route/surface rendering and preservation of current navigation behavior.

This scope-lock does not identify or authorize exact runtime/test implementation files. The next active-lock sync must inspect live repo files and arm the smallest exact future implementation allowlist.

## Live surface ownership notes for next active-lock sync

- BenchBeep Home launcher exists at `lib/features/home/screens/benchbeep_home_screen.dart`; focused tests exist at `test/widget/benchbeep_home_screen_test.dart`.
- Legacy/project Home screen route surface exists at `lib/features/project/screens/home_screen.dart`.
- Project Overview / Workbench Home exists at `lib/features/project/screens/project_overview_screen.dart`; focused tests exist at `test/widget/project_overview_screen_test.dart`.
- Existing docs identify `ProjectOverviewScreen`, `overview-workbench-zone`, and `overview-workbench-board-preview` as Workbench Home / Project Overview handles.
- Board Canvas exists at `lib/features/board_canvas/screens/board_canvas_screen.dart` but remains a separate accepted surface and is not included in this first Project Home shell slice.

These are inspection notes only and not a future implementation allowlist.

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

## Protected boundaries preserved

- No runtime/test edits in this scope-lock.
- No implementation pass armed directly.
- No runtime asset dependencies added.
- No `_incoming` files staged, edited, copied, imported, or bundled.
- No dark Project Home implementation accepted in this pass.
- No global dark theme accepted.
- No Board Canvas dark EDA visual migration accepted.
- No color-coded nets or board-level legend runtime behavior accepted.
- Prototype labels such as 5V, 220V, GND, and Signal do not confirm nets, connectivity, electrical proof, facts, measurements, pins, or components.
- No logo asset/runtime asset changes accepted.
- No Google Fonts or external font dependency accepted.
- No new route/navigation behavior accepted.
- No Board Canvas canonical save/write behavior accepted.
- No canonical measurement writing accepted.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring accepted.
- No `events.jsonl` write or `known_facts` mutation accepted.
- No canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts accepted.
- Visual traces, From -> To context, prototype route labels, prototype net labels, and prototype legend labels remain non-authoritative visual/provenance/design input only.
- Router, Home, Project Overview, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, events, facts, assets, samples, platform files, generated files, and unrelated docs remain untouched in this scope-lock.
- Command menu, context menu, audio/save beep, global redesign, global theme migration, and canvas token migration remain deferred.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this Project Home dark EDA shell scope-lock the current pass, record accepted/pushed design-source scope-lock `487c691`, and route after acceptance to active-lock sync.
- Updated `docs/PASS_QUEUE.md` to mark the design-source scope-lock accepted/pushed and add this scope-lock as the current pass.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to replace the completed design-source scope-lock with this docs-only Project Home shell scope-lock.
- Updated `docs/AUDIT_INDEX.md` to mark the design-source scope-lock accepted/pushed and add a pointer to this artifact.
- Added this audit artifact.

## Changed files in this scope-lock

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS.md`

## Route

- Current pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- No implementation active lock is armed by this pass.

## Validation

- `git status --short --branch`: expected docs-only tracked diff plus known untracked scratch; nothing staged.
- `git diff --name-status`: expected docs-only tracked changes in `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged diff.
- `git diff --check`: passed.
- `python tools/validate_all.py`: passed; includes known optional missing-photo warnings and `Ran 273 tests ... OK`.

## Safe staging candidate

If ChatGPT Pro temporary secondary review or future Claude review accepts this scope-lock, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_SCOPE_LOCK_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
