# V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_SCOPE_LOCK / PROTECTED_UI_HOME_STYLE`.
- Scope: docs-only scope-lock for a future BenchBeep Home / esileht dark-theme parity implementation.

## Temporary review mode

- Claude Code may be unavailable.
- This artifact does not claim Claude audit.
- Review status for this docs-only scope-lock: `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`.

## Baseline

- Expected and verified HEAD/origin: `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS` at `846e7da` (`docs: record Board Canvas fit reset discoverability`).
- Latest accepted/pushed implementation: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS` at `6762bdc` (`feat(board-canvas): improve fit reset discoverability`).
- Route before this scope-lock: `NEEDS_USER_DECISION`.
- Current armed implementation pass before this scope-lock: `none`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files were left untouched.

## Tool and evidence check

- Used the local `androbuss-pass-runner` skill for pass discipline and report structure.
- Inspected live route docs: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md`.
- Inspected product/protected-boundary docs: `docs/PROJECT_MEMORY.md` and `docs/PROTECTED_SURFACES.md`.
- Inspected the Fit / Reset closeout artifact: `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS.md`.
- Used repo-local memory only for TraceBench route-governance expectations; repo docs and verified git state remained authoritative.
- No external plugin, online source, `_incoming`, screenshot, mockup, or source index was used as runtime truth.

## Scope locked

This pass locks a future implementation direction only:

- BenchBeep Home / esileht may be brought into visual parity with the accepted compact dark BenchBeep/workbench style.
- The future change is visual-only: background, cards/surfaces, text contrast and hierarchy, dividers/borders, and buttons if needed for dark-theme parity.
- Home remains a launcher, not a marketing landing page.
- Home launcher behavior must remain preserved: `Open existing`, `Import project`, existing navigation, and back/home behavior.

## Required next route

After this scope-lock is accepted/pushed, route to:

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

The next active-lock sync must inspect the exact live Home screen/widget owners before arming files for:

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`

The sync must list the smallest exact runtime/test allowlist and must not invent files or allow broad directories.

## Future implementation boundaries

Future implementation may only:

- improve BenchBeep Home / esileht dark-theme visual parity;
- preserve compact dark BenchBeep/workbench visual language;
- update focused tests after an active-lock sync arms exact files;
- preserve launcher, open existing, import project, route, and navigation behavior.

Future implementation must not:

- change Board Canvas;
- change Measure Sheet;
- change Project Overview behavior;
- add save/write/canonical behavior;
- import, call, route to, or wire `v2_save_measurement_writer.dart`;
- write `events.jsonl`;
- mutate `known_facts`;
- create or imply canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts;
- change schema, writer, materializer, validator, projection, Project ZIP, samples, or `_incoming`;
- treat `_incoming`, screenshots, mockups, or design-source files as runtime truth;
- start a full redesign, new navigation, command menu, context menu, audio/save beep, global theme migration, or canvas token migration.

## Work performed

- Updated `docs/CURRENT_STATE.md` to make this scope-lock the current pass and route next to the active-lock sync.
- Updated `docs/PASS_QUEUE.md` to add this current scope-lock and the next active-lock sync row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md` to authorize only this docs-only scope-lock and keep runtime implementation unarmed.
- Updated `docs/AUDIT_INDEX.md` to point to this audit artifact and to record the pushed Fit / Reset closeout at `846e7da`.
- Added this audit artifact.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS.md`

## Validation

Validation is recorded from Codex local execution during this scope-lock.

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
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS.md`

Do not stage `_incoming`, screenshots, mockups, design-source files, runtime files, test files, assets, `pubspec.yaml`, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
