# V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_SYNC_PASS

## Lane and type

- Lane: `LANE_B_ADJACENT`.
- Type: `DOCS_TARGET_SYNC / PROTECTED_UI_HOME_STYLE`.
- Scope: tiny docs-only clarification of the BenchBeep Home dark-theme logo target.

## Baseline

- Git HEAD at pass start: `afe5fd1` (`docs: sync BenchBeep Home dark theme route`), aligned with `origin/main`.
- Latest accepted/pushed active-lock sync: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_ACTIVE_LOCK_SYNC_PASS` at `70bd37e` (`docs: arm BenchBeep Home dark theme parity`).
- Latest accepted/pushed scope-lock: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_SCOPE_LOCK_PASS` at `1af1e51` (`docs: lock BenchBeep Home dark theme parity`).
- Armed implementation pass (unchanged by this sync): `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.
- Pre-existing uncommitted working-tree changes (NOT part of this docs-only target sync and NOT touched here): `lib/features/home/screens/benchbeep_home_screen.dart` and `test/widget/benchbeep_home_screen_test.dart` from the in-progress Home dark-theme/logo implementation.
- Known untracked scratch files/directories remain untouched.

## Goal

Re-point the BenchBeep Home dark-theme logo target from the previously recorded bottom-most horizontal lockup to the first `PRIMARY · dark / combined lockup` variant, per manual visual review and user selection.

## Target change

- Old target: bottom-most / horizontal dark lockup.
- New target: first `PRIMARY · dark / combined lockup` variant in `BenchBeep Logo.html`.
  - `markPine` dark mark.
  - `benchbeep` wordmark.
  - orange beep arcs.
  - subtitle: `Measurement Data Visualization`.
  - any pulse / live-signal motion in the source is design reference only and is not required runtime behavior.
- Reason: manual visual review found the bottom-most horizontal lockup did not fit the Home hero target well.

## Design source handling

- Design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/logo/BenchBeep Logo.html`.
- Status: `DESIGN_INPUT_ONLY` (`RUNTIME_AUTHORITY: NONE`, `CANONICAL_SEMANTICS: NONE`, `IMPLEMENTATION_AUTHORIZATION: NONE`, `ASSET_AUTHORIZATION: NONE`).
- No `_incoming` runtime dependency is created or authorized.
- No HTML/CSS is copied into runtime.
- The design source is not staged.
- Exact logo parity may require one generated/captured logo asset introduced through a later, separate asset-scope sync. This target sync adds no asset and authorizes none.

## Boundaries preserved

- Docs-only; no `lib/` edits, no `test/` edits, no asset files, no `_incoming` staging.
- No navigation/route/save/write/canonical changes.
- The armed Home implementation allowlist is unchanged: `lib/features/home/screens/benchbeep_home_screen.dart` and `test/widget/benchbeep_home_screen_test.dart`.
- Route toward Home dark-theme implementation is preserved.

## Work performed

- Updated `docs/CURRENT_STATE.md`: set this target sync current, route next to `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`, replaced the bottom-most logo-target wording with the `PRIMARY · dark / combined lockup` target, and recorded the asset-scope note.
- Updated `docs/PASS_QUEUE.md`: set current/next pointers and added the target-sync ledger row.
- Updated `docs/ACTIVE_SCOPE_LOCK.md`: set current pass to this target sync, updated the logo design-input target wording, kept the armed implementation allowlist and forbidden surfaces, and recorded the asset-scope note.
- Updated `docs/AUDIT_INDEX.md`: added this target-sync provenance row.
- Added this audit artifact.

## Route

- Current pass: `V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_SYNC_PASS`.
- Route after accepted/pushed: `V2_BENCHBEEP_HOME_DARK_THEME_PARITY_IMPL_PASS`.

## Changed files in this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BENCHBEEP_HOME_DARK_THEME_LOGO_TARGET_SYNC_PASS.md`

## Validation

- `git diff --name-status`: the four route/ledger docs above are modified; this audit artifact is untracked until exact staging. The pre-existing uncommitted Home `lib/`+`test/` changes remain present and were not touched by this pass.
- `git diff --cached --name-status`: no staged files.
- `git diff --check`: passed; only existing LF-to-CRLF checkout warnings.
- `python tools/validate_all.py`: passed (`Ran 273 tests`, `OK`) with existing optional missing-photo warnings only.

## Review state

- `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`. Claude Code performed this docs-only target sync; it does not self-approve staging.

## Staging state

- Staged: no.
- Committed: no.
- Pushed: no.
