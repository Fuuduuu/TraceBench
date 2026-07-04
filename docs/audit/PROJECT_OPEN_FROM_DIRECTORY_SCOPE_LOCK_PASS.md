# PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS

## Mode

Docs-only scope-lock.

## Goal

Lock a future implementation pass for opening an existing TraceBench project from a local folder.

## Baseline

- Current route before this pass: `NEEDS_USER_DECISION`.
- Latest pushed closeout: `f4ce7c6` (`docs: close out placement writer confirm implementation`).
- Source limitation: `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` is closed, but full UI -> writer -> `events.jsonl` append smoke remains blocked because current app flows use sample/assets or ZIP import, which leave `projectDirectory` null.

## Current code findings

- `ProjectLoader.loadFromDirectory` exists in `lib/shared/services/project_loader.dart`.
- `ProjectLoader.loadFromDirectory` validates required local project files and preserves `projectDirectory` by returning `ProjectState.copyWith(projectDirectory: trimmedDirectory, isProjectionStale: false)`.
- `ProjectLoader.loadFromAssets` loads the bundled sample and does not preserve `projectDirectory`.
- `ProjectLoader.loadFromZipBytes` loads ZIP content and does not preserve `projectDirectory`.
- `ProjectZipImportAction.importZip` currently uses `ProjectLoader.loadFromZipBytes`.
- `TraceBenchApp` launcher currently exposes bundled sample loading and ZIP import callbacks.
- `BenchBeepHomeScreen` currently exposes Open existing / Import project / sample entry points, but no local folder-open action.
- `NewProjectWizardScreen` already uses `FilePicker.platform.getDirectoryPath`, providing an existing platform picker pattern to evaluate.

## Locked product intent

Add an `Ava projekt kaustast` / `Open project from folder` path that:

- lets the user pick an existing local project folder;
- loads it through `ProjectLoader.loadFromDirectory`;
- preserves `projectDirectory`;
- makes the loaded project writable when valid;
- allows later placement writer smoke against a real folder-backed `events.jsonl`.

## Scope boundaries

This pass documents and scopes the work only.

No runtime, tests, schema, tools, events, known facts, writer implementation, router behavior, project fixture, sample data, or `_incoming` files are changed by this pass.

Future implementation must preserve:

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No schema changes unless explicitly scope-locked later.
- No writer contract changes.
- No component identity creation.
- No AI-authored canonical facts.
- Local folder path must be user-selected, not guessed.
- Sample/asset project may remain read-only.
- ZIP import behavior must not be silently changed unless explicitly included.

## Future implementation should cover

- visible UI entry point for opening a local folder project;
- folder picker integration using the existing platform approach if present;
- validation/error copy for invalid folder structure;
- successful load sets `projectDirectory`;
- project remains reloadable/usable by Board Canvas;
- placement writer can append to that folder-backed `events.jsonl`;
- no broad rewiring of project model beyond what is required.

## Future implementation candidate surfaces

Candidate surfaces to evaluate in the active-lock sync, not armed by this pass:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/shared/services/project_loader.dart`
- `lib/features/project/screens/new_project_wizard_screen.dart`
- `lib/shared/services/project_creator.dart`
- relevant launcher, project-loader, folder-picker, and smoke-oriented tests

The next active-lock sync must decide the exact implementation allowlist after reading live code.

## Future test and smoke expectations

Future implementation should cover:

- unit/widget coverage for open-folder action if practical;
- invalid folder shows clear error;
- valid folder loads with `projectDirectory` present;
- sample/asset and ZIP flows are not silently converted into folder-backed writable projects.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Expected smoke after implementation:

canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> one `component_visual_placement_confirmed` appended -> `python tools/validate_all.py` passes.

## Route

- Current: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`
- Next: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Validation to run for this pass

- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Claude audit packet

Read-only audit requested for this scope-lock only.

- PASS_ID: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`
- Expected changed files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS.md`
- Verify route:
  - Current: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`
  - Next: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Verify no runtime/test/schema/tool/events/known_facts/_incoming files changed.
- Verify the pass documents candidate surfaces but does not arm implementation allowlist.
- Verify future active-lock sync is required before implementation.
- Verify protected boundaries around events, projection/cache, writer contract, component identity, and AI-authored canonical facts are preserved.
- Do not edit, stage, commit, or push.

Expected verdict format:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET:
BLOCKERS:
NITS:
```
