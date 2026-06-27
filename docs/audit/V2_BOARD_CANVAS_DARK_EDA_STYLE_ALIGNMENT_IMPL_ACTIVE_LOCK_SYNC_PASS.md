# V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_BOARD_CANVAS_STYLE`.
- Scope: docs-only active-lock sync for a future Board Canvas dark EDA style-alignment implementation.

## Temporary review mode

- Claude Code is temporarily unavailable for this active-lock sync.
- This artifact does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- Codex output for this pass must use `NO_CLAUDE_REVIEW_PACKET`.
- Do not record `AUDIT_VERDICT` or `SAFE_FOR_STAGING` for this sync pass unless a later Claude or approved temporary secondary review supplies that evidence.

## Baseline

- Expected and verified HEAD/origin before editing: `df38722` (`docs: lock Board Canvas dark EDA style alignment`).
- Full scope-lock SHA: `df38722b774f2d8db9a0d0f64715f4c2cff95c65`.
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS` at `df38722` (`docs: lock Board Canvas dark EDA style alignment`).
- `git show --name-status --oneline df38722` confirmed the scope-lock commit changed:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS.md`
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files were left untouched.

## Context inspected

- Read governance docs required by the prompt, including `AGENTS.md`, `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/TRUTH_INDEX.md`, `docs/PROJECT_MEMORY.md`, `docs/PROTECTED_SURFACES.md`, `docs/PROMPTING_PROTOCOL.md`, `docs/AUDIT_CONTRACT.md`, `docs/MODEL_ROUTING.md`, and `docs/PASS_LIFECYCLE.md`.
- Read the pushed Board Canvas dark EDA style-alignment scope-lock artifact.
- Read relevant Project Home dark EDA closeout artifacts:
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS.md`
- Read directly relevant Board Canvas artifacts present in the repo:
  - `docs/audit/V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_POST_AUDIT_PASS.md`
  - `docs/audit/V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS.md`
- The requested artifact names `docs/audit/V2_BOARD_CANVAS_RENDERER_V2_IMPL_POST_AUDIT_PASS.md`, `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS.md`, and `docs/audit/V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_POST_AUDIT_PASS.md` were not present under those names.
- Inspected context-only runtime/test surfaces without editing:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
  - `lib/features/project/screens/project_overview_screen.dart`
  - `test/widget/project_overview_screen_test.dart`

## Target surface decision

Board Canvas visual shell/style is the target surface. The accepted Project Overview / Workbench Home dark EDA shell is reference surface only.

Live repo inspection shows the Board Canvas screen owns the app bar, page chrome, left rail, contextual panels, footer/status strip, canvas status/copy, toolbar chrome, canvas/grid color treatment, read-only badge/copy, integrated Measure panel presentation, Add Component panel presentation, and Board Canvas renderer presentation.

Live repo inspection also shows the focused Board Canvas widget test file already covers Board Canvas read-only chrome, integrated Measure panel behavior, Add Component local state, renderer no-write source assertions, pan/zoom/fit/reset behavior, tap-to-select behavior, measurement badges, and protected no-writer boundaries.

Project Overview / Workbench Home is not part of the future implementation allowlist because it is reference surface only and the requested target is Board Canvas shell/style.

## Future implementation allowlist

`V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS` may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No broad directories are authorized. If implementation requires any additional file, the implementation must stop and route a new active-lock sync with the exact file and rationale.

## Future implementation may only

- Align Board Canvas shell with the accepted Project Overview / Workbench Home dark EDA shell.
- Darken Board Canvas app bar, page chrome, left rail, panels, footer, and status strip.
- Align card/panel borders, backgrounds, radius, spacing, and restrained glow/shadow.
- Align toolbar button chrome.
- Align grid/canvas colors toward the Project Overview green EDA canvas family while preserving contrast and board/canvas dominance.
- Replace the orange read-only badge treatment with BenchBeep dark EDA read-only treatment.
- Preserve clear read-only/no-write status.
- Polish scoped Board Canvas shell copy toward Estonian where safe, while preserving meaning.
- Leave `renderer writes: none` as diagnostic copy unless separately scoped later.
- Update focused Board Canvas widget tests for visual/copy assertions only.

## Protected behavior boundaries

The future implementation must preserve:

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- No save/write behavior from Board Canvas.
- Existing pan/zoom/fit/reset behavior.
- Existing tap-to-select behavior.
- Existing inspector behavior.
- Existing placement rendering behavior.
- Existing measurement marker/summary behavior.
- Existing visual-trace/provenance behavior.
- Existing route/navigation behavior.
- Existing Measure Sheet save behavior.
- Existing Add Component and Measure Sheet action routing where present.
- Existing Project Overview runtime behavior.
- Existing BenchBeep Home behavior.
- Existing tests unless updated only for visual/copy assertions.
- No canonical data rename, project fact change, board fact change, schema change, writer/service change, materializer/validator/projection change, Project ZIP change, `events.jsonl` write, `known_facts` mutation, canonical measurement, canonical fact, net, pin mapping, coordinate, package identity, electrical proof, fault evidence, or AI/OCR/CV fact.

## Forbidden behavior

- No runtime/test edits in this active-lock sync.
- No future implementation edits outside the exact two-file allowlist.
- No Project Overview runtime/test edits unless separately locked.
- No router, BenchBeep Home, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, event, fact, asset, sample, platform, generated, or unrelated docs edits.
- No `_incoming`, screenshot, mockup, docs/source, or source-index edits.
- No importing, copying, bundling, staging, or runtime dependency on `_incoming` files.
- No logo/runtime asset, `pubspec.yaml`, global dark theme, global theme migration, full redesign, command menu, context menu, audio/save beep, canvas token migration, route/navigation behavior, Measure Sheet UI, Measure Sheet save/write, Board Canvas save/write, Confirm/write, Edit Layout, canonical event/fact writes, or canonical measurement writing.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring.
- No canonical board facts, coordinates, placement semantics, nets, pin mappings, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Design source status

Prior dark EDA HTML/CSS, screenshots, and standalone HTML remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

They must not be edited, staged, copied, imported, bundled, or used as runtime dependencies.

## Work performed

- Updated `docs/CURRENT_STATE.md` to record accepted/pushed scope-lock `df38722`, make this active-lock sync current, route next to the implementation pass, and record the exact future two-file implementation allowlist.
- Updated `docs/PASS_QUEUE.md` to mark the scope-lock accepted/pushed, make this active-lock sync current, and add the future implementation pass as the next recommended route.
- Replaced `docs/ACTIVE_SCOPE_LOCK.md` with an implementation active lock naming `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS` and the exact future Board Canvas screen/test allowlist.
- Updated `docs/AUDIT_INDEX.md` to mark the scope-lock accepted/pushed and point to this active-lock sync artifact.
- Added this audit artifact.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Route

- Current pass: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS`.

## Validation

Validation is recorded from Codex local execution during this active-lock sync.

- `git status --short --branch`: branch `main...origin/main`; modified route docs are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging; known untracked scratch remains untouched.
- `git diff --name-status`: modified tracked files are `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, `docs/CURRENT_STATE.md`, and `docs/PASS_QUEUE.md`; this new audit artifact is untracked until exact staging.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed with no whitespace errors; Git reported existing LF-to-CRLF working-copy warnings for edited Markdown files.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings.

## Staging candidate

If temporary secondary review accepts this active-lock sync, stage exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

Do not stage runtime files, test files, `_incoming`, screenshots, mockups, assets, samples, generated files, platform files, or scratch files.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
