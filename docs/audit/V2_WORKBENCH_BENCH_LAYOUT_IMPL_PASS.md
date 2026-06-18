# V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS

Date: 2026-06-18
Lane: CODEX / FLUTTER_UI_POLISH
Status: implemented locally / pending Claude Code read-only post-audit

## MODEL_ROUTING_CHECK

PASS. This is a repo-local implementation pass for the locked UI-only 3-zone Board Canvas / Workbench layout shell. Runtime edits are limited to `lib/features/board_canvas/screens/board_canvas_screen.dart`; tests are limited to `test/widget/board_canvas_screen_test.dart`; governance edits are limited to active route/audit docs. Staging, commit, and push are out of scope.

## STARTUP_REPO_STATE

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- HEAD at startup: `5d88998` (`docs: lock workbench bench layout scope`)
- `git status --short --branch`: clean tracked tree on `main...origin/main`, with known scratch/untracked artifacts only.
- `git log --oneline --decorate -10`: confirmed `5d88998` at `HEAD`, `origin/main`, and `origin/HEAD`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.

## FILES_READ

- user-provided `V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS` prompt from attached pasted text
- `AGENTS.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_HOME_REDESIGN_DESIGN_GAP_CAPTURE_PASS.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_SCOPE_LOCK_PASS.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/TRUTH_INDEX.md`
- `docs/MEMORY_PROTOCOL.md`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## IMPLEMENTATION_SUMMARY

- Added a wide-layout Workbench shell keyed `board_canvas_workbench_shell`.
- Added a left rail keyed `board_canvas_workbench_rail`.
- Moved the existing `Focus canvas` and inspector show/hide actions into the rail on wide layouts.
- Added clearly disabled/inert future rail tools for trace and repair-map placeholders.
- Kept the existing compact Placement and Safety / Evidence control band in the center zone.
- Added a center zone keyed `board_canvas_workbench_canvas_zone` that remains wider than the right context panel and rail.
- Wrapped existing read-only inspector/context content in a right contextual panel keyed `board_canvas_context_panel`.
- Preserved narrow responsive fallback by keeping focus/inspector controls in the compact control band when the rail is not shown.

## DESIGN_DECISION_SUMMARY

- Adapted the existing Board Canvas screen instead of creating a new route.
- Used local constants and private widgets only inside the existing screen surface.
- Kept the center renderer/canvas as the dominant area by using a fixed narrow rail and fixed right context-panel widths.
- Used icon-only rail affordances to avoid adding visible forbidden/write-flow labels.
- Kept future rail tools disabled/inert rather than connecting them to routes or write behavior.
- Did not copy `_incoming` HTML/CSS/assets or follow mockup dimensions pixel-perfectly.

## TESTS_ADDED_OR_UPDATED

- Added widget test `wide workbench layout exposes rail canvas and read-only context zones`.
  - RED evidence: failed because `board_canvas_workbench_shell` did not exist.
  - GREEN evidence: passed after adding the keyed shell, rail, center zone, context panel, and inert rail placeholders.
- Full Board Canvas widget suite now covers `64/64` tests, including existing read-only renderer, focus mode, tap-to-select, pan/zoom/fit, measurement metadata, visual_trace metadata, photo-alignment metadata, and source-boundary checks.

## FILES_CHANGED

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`

## VALIDATION_RESULTS

- `flutter test test/widget/board_canvas_screen_test.dart --plain-name "wide workbench layout exposes rail canvas and read-only context zones"`: RED before implementation; failed because `board_canvas_workbench_shell` did not exist.
- `flutter test test/widget/board_canvas_screen_test.dart --plain-name "wide workbench layout exposes rail canvas and read-only context zones"`: PASS after implementation.
- `dart format --output=none --set-exit-if-changed lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart`: PASS (`Formatted 2 files (0 changed)`).
- `flutter test test/widget/board_canvas_screen_test.dart`: PASS (`64/64`).
- `py -3 tools/validate_all.py`: PASS (`validate_all.py PASSED`; `Ran 273 tests`; `OK`; existing optional-photo warnings only).
- `git diff --check`: PASS; CRLF normalization warnings only.

## SCOPE_DRIFT_CHECK

- Renderer behavior was not changed.
- Board-normalized placement semantics were not changed.
- Selected placement semantics were not changed.
- Tap-to-select behavior was preserved.
- Pan/zoom/fit behavior was preserved.
- Measurement association/count logic was not changed.
- visual_trace geometry or interpretation was not changed.
- Photo-alignment semantics were not changed.
- No inline measurement entry, Save button, new write path, routing consolidation, or `/project/measure-sheet` deletion was added.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event surfaces were changed.
- No `events.jsonl` or `known_facts.json` write/mutation changes were made.
- No `_incoming` HTML/CSS/assets were copied into runtime.
- `renderer writes: none` remains present.

## STAGING_SET_EXACT

No staging in this pass. Expected explicit staging set after Claude Code read-only implementation post-audit accepts the diff:

`git add lib/features/board_canvas/screens/board_canvas_screen.dart test/widget/board_canvas_screen_test.dart docs/CURRENT_STATE.md docs/PASS_QUEUE.md docs/ACTIVE_SCOPE_LOCK.md docs/AUDIT_INDEX.md docs/audit/V2_WORKBENCH_BENCH_LAYOUT_IMPL_PASS.md`

## NEXT_STEP_FOR_USER

Claude Code read-only implementation post-audit before staging, commit, or push.
