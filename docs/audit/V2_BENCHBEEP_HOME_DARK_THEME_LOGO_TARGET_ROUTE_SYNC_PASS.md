# V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_ROUTE_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`
- Type: `DOCS_ROUTE_SYNC / PROTECTED_UI_HOME_STYLE`
- Scope: tiny route pointer repair after pushed logo target sync.

## Baseline

- Git HEAD at pass start: `fb04be1` (`docs: sync BenchBeep Home logo target`), aligned with `origin/main`.
- Latest accepted/pushed active-lock sync: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS` at `70bd37e` (`docs: arm BenchBeep Home dark theme parity`).
- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS` at `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Armed implementation pass (unchanged by this sync): `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Note: exact home logo parity may still require one generated/captured asset in a later separate asset-scope sync.
- Known untracked scratch files remain untouched.
- No staged files before this docs pass.

## Work performed

- Recorded the pushed logo-target sync (`fb04be1`) in the live route docs.
- Synced `docs/ACTIVE_SCOPE_LOCK.md` current pass to `V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_ROUTE_SYNC_PASS`.
- Kept route target at `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Preserved logo target handling:
  - `PRIMARY · dark / combined lockup` in `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`
  - `DESIGN_INPUT_ONLY`
  - exact parity may still require one generated/captured asset in a later separate asset-scope sync
  - no asset or runtime dependency changes
- Preserved exact armed implementation allowlist:
  - `lib/features/home/screens/benchbeep_home_screen.dart`
  - `test/widget/benchbeep_home_screen_test.dart`
- Added this new route-sync audit record.

## Boundaries

- Docs-only; no `lib/`, `test/`, asset, schema, writer, materializer, projection, ZIP, sample, runtime, or `_incoming` edits.
- No runtime implementation claimed.
- No writer/canonical behavior claimed.
- Did not stage artifacts or files.

## Route

- Current pass: `V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_ROUTE_SYNC_PASS`
- Route after accepted/pushed: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Review mode: `RETRO_CLAUDE_READY / DO_NOT_CLAUDE_REVIEW` (no Claude audit claim).

## Validation

- `git diff --name-status`: updated docs pointers only.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed.
- `python tools/validate_all.py`: passed (existing test evidence preserved).
