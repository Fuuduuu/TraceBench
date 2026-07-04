# PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Goal

Arm the exact implementation allowlist for `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`.

## Baseline verification

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed scope-lock commit verified from live git log: `d29c821d63bff56f1a0874a2bebaca4bf2e0878e` (`docs: lock project open from directory scope`).
- Route before this pass:
  - Current: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`
  - Next: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- Main alignment: `main...origin/main`.

## Live-code findings

- `lib/shared/services/project_loader.dart` already provides `ProjectLoader.loadFromDirectory`.
- `ProjectLoader.loadFromDirectory` validates a selected local project folder and returns state with `projectDirectory` preserved.
- `ProjectLoader.loadFromAssets` is the bundled sample flow and does not preserve a folder-backed `projectDirectory`.
- `ProjectLoader.loadFromZipBytes` is the ZIP import flow and does not preserve a folder-backed `projectDirectory`.
- `lib/features/project/screens/home_screen.dart` owns `ProjectZipImportAction.importZip`, the existing import action/error-copy pattern, and already imports `file_picker`.
- `lib/app/app.dart` owns `TraceBenchApp` launcher callback wiring into `projectStateProvider` and navigation.
- `lib/features/home/screens/benchbeep_home_screen.dart` owns the visible BenchBeep launcher project actions.
- `lib/features/project/screens/new_project_wizard_screen.dart` already uses `FilePicker.platform.getDirectoryPath`, but is reference-only for this implementation.
- `lib/shared/services/project_creator.dart` is reference-only for folder-backed project creation and is not needed for opening an existing folder.
- `test/widget/benchbeep_home_screen_test.dart` already exercises `TraceBenchApp`, launcher actions, and `file_picker` behavior.
- `test/unit/project_loader_zip_test.dart` already covers `loadFromDirectory`; loader implementation edits are not required for this route.

## Implementation pass armed

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Exact implementation allowlist

The implementation pass may edit only:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Implementation goal

Add an `Ava projekt kaustast` / `Open project from folder` UI path that lets the user choose an existing local TraceBench project folder and loads it through `ProjectLoader.loadFromDirectory` so `projectDirectory` is preserved.

## Implementation must preserve

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No schema changes.
- No writer contract changes.
- No component identity creation.
- No AI-authored canonical facts.
- Local folder path must be user-selected, not guessed.
- Sample/assets flow remains separate and read-only unless separately scoped.
- ZIP import behavior remains unchanged unless separately scoped.
- Placement writer files remain unchanged.

## Future implementation should cover

- visible open-folder entry point;
- folder picker integration using the existing platform approach if available;
- `ProjectLoader.loadFromDirectory` call for selected folder;
- successful load writes loaded state with `projectDirectory` present;
- cancelled picker does not break current state;
- invalid folder shows clear user-facing error;
- existing sample and ZIP import behavior do not silently change.

## Test and smoke expectations

Implementation tests should cover:

- valid local folder opens and `projectDirectory` is present;
- cancelled folder picker does not break current state;
- invalid folder shows clear error;
- existing sample and ZIP import behavior do not silently change.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Manual smoke expectation after implementation:

open that folder -> canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> exactly one `component_visual_placement_confirmed` event appends -> `python tools/validate_all.py` passes.

## Forbidden surfaces

- No schema edits.
- No tools/materializer/validator edits.
- No writer contract edits.
- No placement writer edits.
- No router rewrite beyond existing app callback/navigation wiring needed for this feature.
- No component identity creation.
- No AI-authored canonical facts.
- No `events.jsonl` / `known_facts.json` semantic changes.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No implementation in this active-lock sync pass.

## Route

- Current: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Validation to run for this pass

- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Claude audit packet

Read-only audit requested for this active-lock sync only.

- PASS_ID: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Expected changed files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`
- Verify route:
  - Current: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
  - Next: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`
- Verify exact implementation allowlist:
  - `lib/app/app.dart`
  - `lib/features/project/screens/home_screen.dart`
  - `lib/features/home/screens/benchbeep_home_screen.dart`
  - `test/widget/benchbeep_home_screen_test.dart`
- Verify `ProjectLoader.loadFromDirectory` is reused but `lib/shared/services/project_loader.dart` is not armed.
- Verify placement writer files are not armed.
- Verify no runtime/test/schema/tool/events/known_facts/_incoming files changed by this sync.
- Verify sample/assets and ZIP behavior are documented as preserved unless separately scoped.
- Verify future tests/smoke expectations are recorded.
- Do not edit, stage, commit, or push.

Expected verdict format:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET:
BLOCKERS:
NITS:
```
