# V2_BENCHBEEP_HOME_DARK_THEME_DROPIN_ALLOWLIST_SYNC_PASS

## Type

LANE_B_ADJACENT / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_HOME_STYLE

## Status

Drafted / pending independent audit.

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Verified HEAD/origin aligned before edits: `29b5e22` (`docs: sync BenchBeep Home logo asset route`).
- Tracked diff before this pass: clean.
- Cached/staged diff before this pass: clean.
- Current route verified before edits: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Known untracked scratch remained untouched, including `_incoming/`.

## Drop-in source handling

- Drop-in source root: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/Starting page/TraceBench_final/tracebench_dropin`.
- Drop-in source asset folder: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/Starting page/TraceBench_final/tracebench_dropin/assets/brand`.
- `_incoming` is `DROPIN_SOURCE_ONLY / DESIGN_INPUT_ONLY`.
- `_incoming` must not be staged.
- Runtime must not depend on `_incoming`.
- HTML/CSS must not be copied directly into runtime.

## Discovered runtime-relevant drop-in files

- `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/Starting page/TraceBench_final/tracebench_dropin/lib/features/home/screens/benchbeep_home_screen.dart`
- `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/Starting page/TraceBench_final/tracebench_dropin/assets/brand/benchbeep_mark.png`
- `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/Starting page/TraceBench_final/tracebench_dropin/assets/brand/pcb_board.png`

## Package facts recorded

- The drop-in replaces `lib/features/home/screens/benchbeep_home_screen.dart`.
- Public API / constructor remains compatible for `BenchBeepHomeScreen`.
- `router.dart` and `home_screen.dart` should not need edits.
- Destination assets are `assets/brand/benchbeep_mark.png` and `assets/brand/pcb_board.png`.
- `pubspec.yaml` is needed only for Flutter asset registration.

## Future implementation allowlist

`V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS` may edit only:

- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`
- `assets/brand/benchbeep_mark.png`
- `assets/brand/pcb_board.png`
- `pubspec.yaml`

`pubspec.yaml` is limited to Flutter asset registration only. No dependency additions are authorized.

## Superseded target

- Previous manual Home/logo/color attempts are superseded by the prepared TraceBench_final drop-in package.
- The earlier single-logo destination `assets/brand/benchbeep_logo_primary_dark.png` is deprecated for this implementation route.

## Boundaries

- No runtime or test edits in this docs pass.
- No asset creation or copying in this docs pass.
- No `pubspec.yaml` edit in this docs pass.
- No `_incoming` staging.
- No runtime dependency on `_incoming`.
- No dependency additions.
- No Board Canvas edits.
- No Measure Sheet edits.
- No route/navigation behavior changes.
- No save/write/canonical behavior changes.
- No schema/writer/materializer/projection/Project ZIP/sample changes.

## Route state

- Current route remains: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- This pass only syncs future drop-in implementation allowlist and source facts.
- Future runtime implementation may replace the Home screen from the drop-in package, copy only the two destination assets, update Home widget tests, and register Flutter assets in `pubspec.yaml`.

## Validation requested

- `git status --short --branch`
- `git log --oneline --decorate -5`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Audit focus

- Confirm changed files are limited to docs allowlist.
- Confirm current route remains `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Confirm future implementation allowlist exactly matches the drop-in destination set.
- Confirm `assets/brand/benchbeep_logo_primary_dark.png` is no longer the active future target.
- Confirm `_incoming` is source/design input only and not a runtime dependency.
- Confirm no runtime/test/asset/pubspec implementation happened in this pass.
