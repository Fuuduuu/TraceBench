# BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS

## Lane and mode

Lane A / `DOCS_SYNC` build-lock.

Docs-only. No runtime/test/asset edits. No stage/commit/push.

## Charter guard

`docs/POHIKIRI.md` remains the tracked canonical product charter / first-read scope anchor.

The requested startup-page choices match the charter's explicit start flow: create from scratch, continue a project, load from ZIP/folder, and configure a phone. If implementation conflicts with the charter, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Baseline verification

Live repository evidence verified before this build-lock:

- Repository root: `C:/Users/Kasutaja/Desktop/TraceBench`.
- Branch: `main`.
- `HEAD` and `origin/main`: `ce2f3e0a69c73e15249a7fe3344ea7956a229fd7` (`docs: close out board canvas workbench visual alignment`).
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- No active implementation lock was armed.
- Tracked diff was clean.
- Cached diff was clean.
- `git diff --check` was clean.

Known untracked scratch and `_incoming` design inputs remained unscoped and unstaged.

## Design input findings

Read-only design/provenance input:

- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/BenchBeep Startup Intro - Redesign.html`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/markGold.png`
- `_incoming/ui_redesign/Starting page/TraceBench_NEW_startpage/assets/pcb-photo.png`

Classification: `DESIGN_INPUT_ONLY`.

Useful visual/workflow direction:

- retain the established BenchBeep black/gold/cream instrument palette
- preserve the current launcher structure while making the four primary choices explicit
- use Estonian technician-facing copy
- distinguish disabled `Tulekul` choices from enabled actions
- keep green for loaded/ready state and gold for active action
- expose `Seaded` and `Välju` without inventing settings behavior
- use a standard exit-confirmation dialog

Non-binding/deferred input:

- Google Fonts and all linked font resources
- HTML, CSS, and JavaScript implementation
- any route/page for project creation, phone setup, or settings
- any persistence or saved-state claim

The design files must not be copied, imported, staged, or runtime-referenced.

## Asset findings

`markGold.png` and the tracked `assets/brand/benchbeep_mark.png` are both `2075 x 526` and share SHA-256:

- `DCA37A0BFFF66EF2D13599A0B94D9D25BC97004ECACD61AD09C29DBF66BFAFA0`

Therefore `assets/brand/benchbeep_mark.png` needs no implementation edit and is not armed.

`pcb-photo.png` and tracked `assets/brand/pcb_board.png` are both `602 x 862`, but their SHA-256 values differ:

- accepted input: `CC1957609BF21E3998668EE927E3E8D64CA21B6AAE2ABE64E3942C63DAC6471F`
- current runtime asset: `6B66A73E1A6BF565D8EE115636A6E7BE3A1A79365185C7761A96EE55E94C8442`

The accepted PCB image can replace the existing `assets/brand/pcb_board.png` contents without a new asset path.

`pubspec.yaml` already registers the entire `assets/brand/` directory. No `pubspec.yaml` edit is required or authorized.

## Live-code findings

Home ownership:

- `lib/features/home/screens/benchbeep_home_screen.dart` owns the launcher scaffold, established black/gold palette, brand mark, PCB image, wide/narrow layout, launcher actions, and visible copy.
- The current Home still exposes developer-facing English copy such as `Instrument menu`, `Home`, `Workbench`, `Import`, `Start new`, `OPEN EXISTING`, `Board workbench`, and `QUICK START`.
- The current no-project continuation action remains enabled through `onOpenWorkbench`; the redesign must disable continuation until a project exists.
- Current Home has no visible settings affordance and no exit confirmation flow.

Application ownership:

- `lib/app/app.dart` owns `projectStateProvider`, launcher construction, existing bundled-sample load, ZIP import, local-folder open, loaded-project open, and workbench transition callbacks.
- `TraceBenchApp` already watches whether a project is loaded before building Home.
- `window_manager` is already declared in `pubspec.yaml` and initialized in `lib/main.dart` for fullscreen launch.
- A functional exit can be passed from `lib/app/app.dart` to Home using the existing `window_manager` dependency; no `lib/main.dart`, package, `pubspec`, route, or platform-runner edit is needed.

Test ownership:

- `test/widget/benchbeep_home_screen_test.dart` already covers the black/gold launcher, wide layout, hover treatment, bundled sample, loaded-project handoff, local-folder behavior, existing Workbench navigation, and ZIP import behavior.
- The same test file can assert the new four-choice contract, disabled states, Estonian copy, settings state, exit dialog/callback behavior, and preserved project-loading callbacks.

## Implementation pass armed

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/app/app.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/pcb_board.png`

If implementation needs any other file, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Locked implementation intent

Preserve the current Home structure and BenchBeep black/gold identity while applying the accepted startup hierarchy.

Primary choices:

1. `Loo projekt nullist` — visible, disabled, and marked `Tulekul`.
2. `Jätka avatud projektiga` — enabled only when a project is loaded; disabled truthfully when no project is loaded.
3. `Lae projekt` — exposes the existing `Ava ZIP` and `Ava kaust` callbacks without changing import/open semantics.
4. `Seadista telefon` — visible, disabled, and marked `Tulekul`.

Additional actions:

- Keep `Ava näidisprojekt` secondary and preserve the existing bundled-sample callback.
- Show `Seaded` visibly but disabled and marked `Tulekul` until real settings exist.
- Show functional `Välju`.
- `Välju` opens a standard confirmation dialog with `Tühista` and confirmed `Välju` actions.
- Confirmation title may use `Kas väljuda BenchBeepist?`.
- Confirmation body must be neutral, such as `Rakendus suletakse.`; it must not assert that all data is saved or that every open project is folder-backed.
- Confirmed exit invokes the app-owned callback exactly once.

Copy and layout:

- Remove developer-facing English Home copy.
- Keep user-facing product naming as BenchBeep; TraceBench may remain a compact platform/provenance label where already appropriate.
- Keep existing brand asset paths.
- Use the current Flutter/system fonts only.
- Preserve usable wide and narrow layouts without a full app redesign.

## Future test requirements

The implementation tests must:

- assert all four Estonian choices
- assert project creation, phone setup, and settings are disabled / `Tulekul`
- assert `Jätka avatud projektiga` is disabled without a project and enabled with a loaded project
- preserve existing ZIP import, local-folder open, bundled-sample, and loaded-project navigation coverage
- assert `Ava näidisprojekt` remains secondary
- assert `Välju` opens the confirmation dialog
- assert `Tühista` does not call the exit callback
- assert confirmed `Välju` calls an injected exit callback exactly once
- assert exit copy does not claim all data is saved
- assert developer-facing English Home copy is absent
- preserve asset-path assertions and wide/narrow no-overflow coverage
- avoid broad brittle golden tests

## Strict exclusions

- No router or route changes.
- No new pages or screens.
- No project creation implementation.
- No phone setup implementation.
- No settings implementation.
- No persistence or saved-state detection.
- No `pubspec.yaml`, package, font, or `lib/main.dart` changes.
- No new asset paths and no `assets/brand/benchbeep_mark.png` edit.
- No `_incoming`, HTML, CSS, JavaScript, or Google Font runtime use.
- No Board Canvas or Project Overview edits.
- No writer/schema/materializer/validator/tool/model/event/fact/projection/Project ZIP changes.
- No canonical project data mutation from Home.

## Stop conditions

Stop and report instead of implementing if:

- any file outside the four-file allowlist is required
- existing ZIP, folder-open, bundled-sample, or loaded-project behavior cannot be preserved
- functional exit requires a new package, platform-runner change, `lib/main.dart`, or `pubspec` edit
- a route/page is needed to satisfy a disabled future choice
- the design would require importing/copying/runtime-referencing `_incoming` or web resources
- protected project truth semantics would change

## Product and canonical boundaries

- Home remains a launcher, not a canonical writer.
- `events.jsonl` remains canonical truth; `known_facts.json` remains projection/cache.
- AI/helper may not author canonical facts or events.
- No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics changes unless separately scoped.
- No facts/events/coordinates/net/path/trace/probe/pin/pad semantics change unless explicitly scoped.
- Board Canvas and project truth behavior remain unchanged.

## Future implementation validation

- `dart format lib/features/home/screens/benchbeep_home_screen.dart lib/app/app.dart test/widget/benchbeep_home_screen_test.dart`
- `flutter test test/widget/benchbeep_home_screen_test.dart`
- `flutter test`
- `python tools/validate_all.py`
- `git status --short --branch`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Manual smoke is required after implementation and before Claude audit. The implementation audit packet must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.

## Route after this pass

Current: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Safe staging set

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BENCHBEEP_HOME_STARTPAGE_REDESIGN_BUILD_LOCK_PASS.md`

## Review status

DRAFTED / PENDING CLAUDE AUDIT.
