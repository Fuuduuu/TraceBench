# V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_HOME_STYLE`.
- Scope: docs-only active-lock sync for the future BenchBeep Home / esileht dark-theme parity implementation.

## Temporary review mode

- Claude Code may be unavailable.
- This artifact does not claim Claude audit.
- Review status for this docs-only active-lock sync: `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`.

## Baseline

- Expected and verified HEAD/origin: `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS` at `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS` at `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Route before this sync: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS` as the next recommended route from the accepted scope-lock.
- Tracked diff before this sync: none.
- Cached/staged diff before this sync: none.
- Known untracked scratch files were left untouched.

## Tool and evidence check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected accepted scope-lock artifact: `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS.md`.
- Searched repo-local runtime/tests for Home/esileht owners.
- Inspected `lib/features/home/screens/benchbeep_home_screen.dart`.
- Inspected `test/widget/benchbeep_home_screen_test.dart`.
- Inspected context-only `lib/app/app.dart`.
- Inspected existing import/open-project flow owner `lib/features/project/screens/home_screen.dart`.
- Recorded user-provided logo design source path: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`.
- Local `Test-Path` for the corrected repo-local logo design-source path returned true during this docs-only repair; this confirms the design input exists but does not make it runtime truth or a runtime dependency.
- No external plugin, online source, `_incoming`, screenshot, mockup, or source index was used as runtime truth.

## Discovered Home owners

- Runtime Home visual-shell owner: `lib/features/home/screens/benchbeep_home_screen.dart`.
  - Contains `BenchBeepHomeScreen`.
  - Owns the Home launcher visual shell, local color constants, menu bar, rail/card surfaces, action buttons, and custom Home glyph painters.
- Focused Home widget-test owner: `test/widget/benchbeep_home_screen_test.dart`.
  - Covers the BenchBeep Home launcher, open existing/workbench handoff, menu workbench affordance, import project flow, deferred/inert affordances, and forbidden future tool copy.
- Context-only file inspected but not armed: `lib/app/app.dart`.
  - Instantiates `BenchBeepHomeScreen` and wires callbacks, but visual-only Home parity does not require route/app wiring changes.
- Existing import/open-project flow file inspected but not armed: `lib/features/project/screens/home_screen.dart`.
  - Owns `ProjectZipImportAction` and legacy project-home/import flow, not the BenchBeep Home visual shell.

## Future implementation allowlist

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS` may edit only:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

No other runtime or test file is armed.

## Logo design-source requirement

- User-provided design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`.
- Status: `DESIGN_INPUT_ONLY`.
- Intended BenchBeep Home / esileht visual target: the bottom-most logo variant in that HTML.
- Future implementation must map: HTML logo variant -> Flutter widget/method -> focused widget-test assertion.
- `_incoming` and design-source files must not be staged.
- HTML/CSS must not be copied into runtime.
- Runtime must not depend on `_incoming`, the HTML file, or any design-source file.
- No asset file is authorized by this active lock.
- If the design source is unavailable during the future implementation pass, stop and report the missing source rather than inventing a logo or expanding the allowlist.

## Armed implementation scope

Future implementation may only:

- improve BenchBeep Home / esileht dark-theme visual parity;
- preserve compact dark BenchBeep/workbench visual language;
- use the bottom-most logo design-source variant as the intended Home logo target, implemented as local Flutter UI inside the armed Home screen owner only;
- update focused Home widget tests for visible Home structure, launcher actions, inert/deferred affordances, and no forbidden-surface drift;
- preserve launcher, open existing, import project, route, and navigation behavior.

Future implementation must not:

- change Board Canvas;
- change Measure Sheet;
- change Project Overview behavior;
- change `lib/app/app.dart`;
- change `lib/app/router.dart`;
- change `lib/features/project/screens/home_screen.dart`;
- add or edit logo/image/font/runtime assets;
- copy HTML/CSS from the logo design source into runtime;
- depend on `_incoming`, the logo HTML file, or any design-source file at runtime;
- add save/write/canonical behavior;
- import, call, route to, or wire `v2_save_measurement_writer.dart`;
- write `events.jsonl`;
- mutate `known_facts`;
- create or imply canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts;
- change schema, writer, materializer, validator, projection, Project ZIP, samples, or `_incoming`;
- treat `_incoming`, screenshots, mockups, or design-source files as runtime truth;
- start a full redesign, new navigation, command menu, context menu, audio/save beep, global theme migration, or canvas token migration.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this active-lock sync the current pass and route next to the implementation pass.
- Updated `docs/PASS_QUEUE.md` to mark the accepted scope-lock at `1af1e51`, make this active-lock sync current, and add the implementation pass row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to arm `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS` with the exact two-file future implementation allowlist.
- Repaired this active-lock sync to record the provided BenchBeep logo HTML path as `DESIGN_INPUT_ONLY`, the bottom-most logo variant as the intended Home visual target, and the future implementation mapping requirement from HTML variant to Flutter widget/method to test assertion.
- Updated `docs/AUDIT_INDEX.md` to point to this audit artifact and record the scope-lock accepted/pushed commit.
- Added this audit artifact.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Validation

Validation is recorded from Codex local execution during this active-lock sync.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported CRLF working-copy warnings only.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings only.

## Safe staging candidate

If accepted, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, assets, `pubspec.yaml`, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
