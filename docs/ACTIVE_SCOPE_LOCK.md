# Active Scope Lock

## Current pass

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current armed implementation pass

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`

## Type

LANE_B_ADJACENT / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_HOME_STYLE

## Baseline

- Expected and verified HEAD/origin before this active-lock sync: `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS` at `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS` at `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files remain untouched.

## Active-lock sync write allowlist

This docs-only active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

No runtime, test, schema, tool, asset, sample, platform, generated, or `_incoming` file is authorized in this sync pass.

## Discovered Home owners

- Runtime Home visual-shell owner: `lib/features/home/screens/benchbeep_home_screen.dart`.
- Focused Home widget-test owner: `test/widget/benchbeep_home_screen_test.dart`.
- Context-only file inspected but not armed: `lib/app/app.dart`; it instantiates `BenchBeepHomeScreen` and wires existing callbacks, but visual-only Home parity does not require route/app wiring changes.
- Existing import/open-project flow file inspected but not armed: `lib/features/project/screens/home_screen.dart`; it owns `ProjectZipImportAction` and legacy project-home/import flow, not the BenchBeep Home visual shell.

## Future implementation allowlist

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS` may edit only:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

No other runtime or test file is armed.

## Future logo design input

- User-provided design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`.
- Status: `DESIGN_INPUT_ONLY`.
- Intended Home visual target: the bottom-most logo variant in that HTML.
- Future implementation must explicitly map: HTML logo variant -> Flutter widget/method -> focused widget-test assertion.
- The HTML/CSS must not be copied into runtime.
- `_incoming` and design-source files must not be staged.
- Runtime must not depend on `_incoming`, the HTML file, or any design-source file.
- No asset file is authorized by this active lock.
- If the design source is unavailable during future implementation, stop and report the missing source rather than inventing a logo or expanding the allowlist.

## Armed implementation scope

Future implementation may only improve BenchBeep Home / esileht dark-theme parity with the existing dark BenchBeep/workbench visual family.

Future implementation may allow visual-only polish such as:

- background treatment;
- card/surface treatment;
- text contrast and hierarchy;
- dividers and borders;
- button styling where needed for dark-theme parity;
- compact BenchBeep/workbench-style visual language;
- applying the bottom-most BenchBeep logo design-source variant as Flutter-rendered Home UI inside the armed Home screen owner only;
- focused widget-test updates proving visible Home structure, launcher actions, inert/deferred affordances, and no forbidden-surface drift.

Future implementation must preserve:

- BenchBeep Home as the launcher, not a marketing landing page;
- `Open existing` behavior;
- `Import project` behavior through the existing allowed import/open-project flow;
- existing Home, workbench, and back/home navigation behavior;
- BenchBeep as the user-facing app/product name;
- TraceBench as the repo/platform/project name;
- BoardFact as the data-fact/subsystem name;
- existing Project Overview, Board Canvas, Measure Sheet, and Add Component behavior.

## Explicitly forbidden

- Editing runtime/test files in this active-lock sync.
- Editing any implementation file outside the future two-file allowlist.
- Editing `lib/app/app.dart`.
- Editing `lib/app/router.dart`.
- Editing `lib/features/project/screens/home_screen.dart`.
- Editing Project Overview.
- Editing Board Canvas.
- Editing Measure Sheet.
- Editing `tools/`.
- Editing `schemas/`.
- Editing `assets/`.
- Editing `_incoming`.
- Copying HTML/CSS from the logo design source into runtime.
- Adding or editing logo/image/font/runtime assets.
- Depending on `_incoming`, `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`, or any design-source file at runtime.
- Changing Home launcher behavior, open/import behavior, route behavior, or navigation behavior.
- Adding save/write/canonical behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Writing `events.jsonl`.
- Mutating `known_facts`.
- Creating or implying canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Changing schema, writer, materializer, validator, projection, Project ZIP, samples, or `_incoming`.
- Treating `_incoming`, screenshots, mockups, or design-source files as runtime truth.
- Starting a full redesign, new navigation, command menu, context menu, audio/save beep, global theme migration, or canvas token migration.
- Broad staging.

## Route

- Current pass: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current armed implementation pass: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Route after accepted/pushed: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- This pass does not implement runtime behavior.
