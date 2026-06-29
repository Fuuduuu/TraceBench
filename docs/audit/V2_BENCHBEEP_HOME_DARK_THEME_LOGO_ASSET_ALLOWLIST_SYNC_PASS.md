# V2_BENCHBEEP_HOME_DARK_THEME_LOGO_ASSET_ALLOWLIST_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`
- Type: `DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_HOME_STYLE`
- Scope: docs-only allowlist sync for the BenchBeep Home logo parity asset path.

## Baseline

- Git baseline at pass start: `4094a61` (`docs: sync BenchBeep Home logo target route`), aligned with `origin/main`.
- Current pass in `docs/CURRENT_STATE.md` and `docs/PASS_QUEUE.md` already set to `V2_BENCHBEEP_HOME_DARK_THEME_LOGO_ASSET_ALLOWLIST_SYNC_PASS`.
- Current armed implementation remains `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS` with the allowlist documented in `docs/ACTIVE_SCOPE_LOCK.md`.
- This pass is an asset-allowlist sync (not a route-sync pass): it records the exact future asset boundary and does not implement runtime behavior.
- Latest accepted/pushed active-lock sync: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS` at `70bd37e` (`docs: arm BenchBeep Home dark theme parity`).
- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS` at `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Known untracked scratch files remain untouched.

## Work performed

- Recorded docs-only blocker status that exact logo parity requires one generated/captured asset and must not be completed with a CustomPainter approximation.
- Kept docs-only target implementation route as `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Kept implementation allowlist in `docs/ACTIVE_SCOPE_LOCK.md` explicit and bounded to:
  - `lib/features/home/screens/benchbeep_home_screen.dart`
  - `test/widget/benchbeep_home_screen_test.dart`
  - `assets/brand/benchbeep_logo_primary_dark.png`
  - `pubspec.yaml` (asset registration only)
- Kept design source as `DESIGN_INPUT_ONLY`: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html` and the first `PRIMARY · dark / combined lockup` target.
- Did not edit runtime files, tests, assets, or `pubspec.yaml` in this pass.

## Forbidden surface reconciliation

- `assets/` edits are forbidden in this docs-only sync.
- The sole allowed future runtime asset carve-out is `assets/brand/benchbeep_logo_primary_dark.png`, paired with `pubspec.yaml` registration only when runtime implementation advances.

## Pubspec and asset registration check

- `pubspec.yaml` currently does not yet register:
  - `assets/brand/benchbeep_logo_primary_dark.png`
- This is expected for this pass because it is docs-only.
- Future implementation may edit `pubspec.yaml` only for asset registration when this pass advances into runtime implementation.

## Boundaries

- Docs-only: only `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and this audit artifact may be edited.
- No runtime/test changes.
- No schema/writer/materializer/projection/Project ZIP/sample changes.
- No save/write/canonical behavior claim.
- No `v2_save_measurement_writer.dart` usage.
- No `events.jsonl` writes, no `known_facts` mutations.
- No `_incoming` runtime dependency.

## Route

- Current pass: `V2_BENCHBEEP_HOME_DARK_THEME_LOGO_ASSET_ALLOWLIST_SYNC_PASS`.
- Route after this pass remains: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Review mode for this pass remains: `RETRO_CLAUDE_READY / DO_NOT_CLAUDE_REVIEW` (no Claude audit claim).

## Validation

- `git status --short --branch`: tracked and cached diffs were clean before this pass; route-docs were current-edit only during this sync.
- `git diff --name-status`: modified expected docs files only.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed.
- `python tools/validate_all.py`: expected to pass for docs-only ledger changes.
