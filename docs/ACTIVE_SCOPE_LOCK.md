# Active Scope Lock

## Current pass

`PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`

## Next recommended pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only scope-lock is active.

This pass locks the future product intent and implementation boundaries for opening an existing local TraceBench project folder. It does not implement the UI, does not arm runtime files for editing, and does not change project-loading behavior.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS.md`

## Locked product intent

Add an `Ava projekt kaustast` / `Open project from folder` path that:

- lets the user pick an existing local project folder;
- loads it through `ProjectLoader.loadFromDirectory`;
- preserves `projectDirectory` on `ProjectState`;
- makes a valid loaded project writable through existing scoped writer preconditions;
- allows later placement-writer smoke against a real folder-backed `events.jsonl`.

## Current code facts recorded

- `ProjectLoader.loadFromDirectory` already reads required local project files and preserves `projectDirectory`.
- Bundled sample loading uses `ProjectLoader.loadFromAssets` and remains non-folder-backed.
- ZIP import uses `ProjectLoader.loadFromZipBytes` and remains non-folder-backed.
- The new-project wizard already demonstrates the existing `FilePicker.platform.getDirectoryPath` folder-picker approach.

## Future implementation active-lock sync

The next pass must be docs-only:

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

That sync pass must read live code and decide the exact runtime/test implementation allowlist before any implementation begins.

Candidate surfaces to evaluate, not armed here:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/shared/services/project_loader.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/shared/services/project_creator.dart`
- launcher/home/project-loader/folder-picker tests

## Future implementation must preserve

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No schema changes unless separately scope-locked.
- No writer contract changes.
- No component identity creation.
- No AI-authored canonical facts.
- Local folder path must be user-selected, not guessed.
- Sample/asset project may remain read-only.
- ZIP import behavior must not be silently changed unless explicitly included.
- Existing placement writer contract remains unchanged.
- Board Canvas renderer/painter remains read-only except already scoped explicit writer calls.

## Future implementation should cover

- visible UI entry point for opening a local folder project;
- folder picker integration using existing platform approach if present;
- clear error copy for invalid folder structure or failed load;
- successful load sets `projectDirectory`;
- loaded project remains reloadable/usable by Board Canvas;
- placement writer can append to that folder-backed `events.jsonl`;
- no broad project-model rewiring beyond what is required.

## Future tests and smoke expectations

Future implementation should include practical unit/widget coverage where possible:

- open-folder action invokes a folder picker;
- invalid folder shows clear error;
- valid folder loads with `projectDirectory` present;
- sample/asset and ZIP paths are not silently converted into writable folder-backed projects.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Manual smoke expectation after implementation:

canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> exactly one `component_visual_placement_confirmed` appended -> `python tools/validate_all.py` passes.

## Forbidden in this scope-lock pass

- No runtime edits.
- No test edits.
- No schema/tool/materializer/validator edits.
- No event or known-facts edits.
- No `_incoming` edits or staging.
- No UI implementation.
- No implementation allowlist arming beyond the future active-lock sync route.
- No staging, commit, or push.

## Route

1. `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`
2. `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
