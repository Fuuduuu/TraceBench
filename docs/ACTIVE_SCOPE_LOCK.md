# Active Scope Lock

## Current pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Status

Docs-only active-lock sync is active.

This pass arms the exact runtime/test implementation allowlist for opening an existing local TraceBench project folder. It does not implement the UI, does not edit runtime/tests, and does not change project-loading behavior.

## Verified prior scope-lock

- Pushed commit: `d29c821d63bff56f1a0874a2bebaca4bf2e0878e` (`docs: lock project open from directory scope`).
- Prior route: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS` -> `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Write allowlist for this active-lock sync pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Exact implementation allowlist

The implementation pass may edit only:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Live-code findings behind the allowlist

- `ProjectLoader.loadFromDirectory` already exists in `lib/shared/services/project_loader.dart`; it validates required local project files and preserves `projectDirectory`.
- `ProjectLoader.loadFromAssets` remains the bundled sample flow and does not preserve a folder-backed `projectDirectory`.
- `ProjectLoader.loadFromZipBytes` remains the ZIP import flow and does not preserve a folder-backed `projectDirectory`.
- `ProjectZipImportAction.importZip` in `lib/features/project/screens/home_screen.dart` owns the current ZIP import action and local user-facing error pattern.
- `TraceBenchApp` in `lib/app/app.dart` wires launcher callbacks into `projectStateProvider` and route changes.
- `BenchBeepHomeScreen` in `lib/features/home/screens/benchbeep_home_screen.dart` owns the visible launcher project actions.
- `test/widget/benchbeep_home_screen_test.dart` already exercises `TraceBenchApp`, launcher actions, and `file_picker` behavior.

## Reference-only surfaces not armed

- `lib/shared/services/project_loader.dart`: reuse existing `ProjectLoader.loadFromDirectory`; no loader edit is armed.
- `lib/features/project/screens/new_project_wizard_screen.dart`: reference for `FilePicker.platform.getDirectoryPath`; no wizard edit is armed.
- `lib/shared/services/project_creator.dart`: reference for folder-backed project state after creation; no creator edit is armed.
- Placement writer files: not directly needed for opening a folder-backed project and not armed.
- Schema/tool/materializer/validator/event/known-facts/sample/_incoming files: not armed.

## Future implementation must preserve

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No schema changes.
- No writer contract changes.
- No component identity creation.
- No AI-authored canonical facts.
- Local folder path must be user-selected, not guessed.
- Sample/asset project may remain read-only.
- ZIP import behavior must not be silently changed.
- Existing placement writer contract remains unchanged.
- Board Canvas renderer/painter remains read-only except already scoped explicit writer calls.

## Future implementation should cover

- visible UI entry point for opening a local folder project;
- folder picker integration using the existing platform approach if available;
- call `ProjectLoader.loadFromDirectory` for the selected folder;
- clear copy for cancelled, invalid, or failed folder selection/load;
- successful load sets `projectDirectory`;
- loaded project remains reloadable/usable by Board Canvas;
- placement writer can append to that folder-backed `events.jsonl`;
- no broad project-model rewiring beyond what is required.

## Future tests and smoke expectations

Future implementation should include practical widget coverage where possible:

- valid local folder opens and `projectDirectory` is present;
- cancelled folder picker does not break current state;
- invalid folder shows clear error;
- existing sample and ZIP import behavior do not silently change.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Manual smoke expectation after implementation:

open that folder -> canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> exactly one `component_visual_placement_confirmed` appended -> `python tools/validate_all.py` passes.

## Forbidden in this active-lock sync pass

- No runtime edits.
- No test edits.
- No schema/tool/materializer/validator edits.
- No event or known-facts edits.
- No `_incoming` edits or staging.
- No UI implementation.
- No staging, commit, or push.

## Route

1. `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`
