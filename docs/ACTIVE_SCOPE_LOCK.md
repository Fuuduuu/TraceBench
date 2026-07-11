# Active Scope Lock

## Current pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS`

## Next recommended pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Lock state

Docs-only build-lock is active.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

No runtime/test/asset implementation is performed in this build-lock pass.

## Current docs pass write allowlist

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS.md`

## Design input lock

Read-only design/provenance input:

- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/BenchBeep Startup Intro - Redesign.html`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/markGold.png`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/pcb-photo.png`

- Do not edit or stage these files.
- Do not import or runtime-reference the HTML, CSS, JavaScript, Google Fonts, or `_incoming` paths.
- `markGold.png` already matches `assets/brand/benchbeep_mark.png` byte-for-byte; no mark write is armed.
- `pcb-photo.png` may replace only the existing `assets/brand/pcb_board.png` contents.

## Armed implementation pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Armed implementation write allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

If implementation needs any other file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

- Preserve the current Home structure and BenchBeep black/gold identity.
- Present four primary numbered choices:
  1. `Loo projekt nullist` — disabled / `Tulekul`.
  2. `Jätka avatud projektiga` — enabled only when `projectStateProvider` contains a project.
  3. `Lae projekt` — expose the existing `Ava ZIP` and `Ava kaust` actions.
  4. `Seadista telefon` — disabled / `Tulekul`.
- Keep `Ava näidisprojekt` secondary and preserve its existing bundled-sample callback.
- Show `Seaded` visibly but disabled / `Tulekul`.
- Add functional `Välju` with a standard confirmation dialog.
- Use neutral exit copy such as `Rakendus suletakse.`; do not claim that all data is saved or that every project is folder-backed.
- Wire the confirmed exit through an app-owned callback using the already installed and initialized `window_manager` dependency.
- Remove developer-facing English Home copy without changing routes or project-loading semantics.
- Preserve the existing runtime asset paths and replace only `assets/brand/pcb_board.png` contents.

## Future test intent

- Assert the four Estonian choices and their enabled/disabled states.
- Assert `Jätka avatud projektiga` cannot open Workbench without a loaded project and works when a project is loaded.
- Preserve existing ZIP import, local-folder open, bundled-sample, and loaded-project navigation tests.
- Assert `Seaded` is visible and disabled / `Tulekul`.
- Assert `Välju` opens the confirmation dialog, `Tühista` does not exit, and confirmed `Välju` invokes the injected exit callback exactly once.
- Assert exit copy does not claim that all data is saved.
- Assert developer-facing English Home copy is absent.
- Keep wide/narrow layout coverage and avoid brittle golden tests.

## Stop conditions

Stop instead of implementing if the work requires:

- a router, route, page, project-creation, phone-setup, settings, persistence, `pubspec`, package, font, or `lib/main.dart` change
- a new asset path or an edit to `assets/brand/benchbeep_mark.png`
- importing/copying/runtime-referencing `_incoming`, HTML, CSS, JavaScript, or Google Fonts
- writer, schema, validator, materializer, tool, event, fact, projection, Project ZIP, sample, or Board Canvas changes
- weakening existing ZIP, folder-open, sample, or loaded-project behavior
- exit copy that asserts saved-state truth

## Protected boundaries still in force

- `events.jsonl` remains canonical truth; `known_facts.json` remains projection/cache.
- AI/helper may not author canonical facts or events.
- Board Canvas and project truth surfaces remain unchanged.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.

## Future implementation validation

- `dart format lib/features/home/screens/benchbeep_home_screen.dart lib/app/app.dart test/widget/benchbeep_home_screen_test.dart`
- `flutter test test/widget/benchbeep_home_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Manual visual smoke is required before Claude audits the implementation.

## Route

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`
