# Current State

## Current pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed scope-lock verified: `d29c821d63bff56f1a0874a2bebaca4bf2e0878e` (`docs: lock project open from directory scope`).
- Current pass: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next route: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`.

## Active scope summary

Docs-only active-lock sync for the local-folder project open implementation.

This pass arms the exact future implementation allowlist for adding an `Ava projekt kaustast` / `Open project from folder` path. The implementation must let the user pick an existing local TraceBench project folder and load it through `ProjectLoader.loadFromDirectory` so `projectDirectory` is preserved for folder-backed writer smoke.

## Live-code findings

- `ProjectLoader.loadFromDirectory` already exists in `lib/shared/services/project_loader.dart`; it validates required local files and returns project state with `projectDirectory: trimmedDirectory`.
- `ProjectLoader.loadFromAssets` remains the bundled sample flow and does not preserve a folder-backed `projectDirectory`.
- `ProjectLoader.loadFromZipBytes` remains the ZIP import flow and does not preserve a folder-backed `projectDirectory`.
- `ProjectZipImportAction.importZip` in `lib/features/project/screens/home_screen.dart` owns the current ZIP import action and error handling pattern.
- `TraceBenchApp` in `lib/app/app.dart` wires launcher callbacks into project state and routing.
- `BenchBeepHomeScreen` in `lib/features/home/screens/benchbeep_home_screen.dart` owns the visible launcher project actions.
- `NewProjectWizardScreen` already demonstrates the existing `FilePicker.platform.getDirectoryPath` folder picker approach, but the wizard itself is reference-only for the implementation pass.
- Existing loader tests already cover `ProjectLoader.loadFromDirectory`; launcher-facing coverage belongs with the BenchBeep home widget tests.

## Implementation pass armed

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`

Exact implementation allowlist:

- `lib/app/app.dart`
- `lib/features/project/screens/home_screen.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Implementation boundaries

The future implementation must:

- Add a visible open-folder entry point.
- Use the existing platform folder picker approach if available.
- Call `ProjectLoader.loadFromDirectory` for the selected folder.
- Preserve `projectDirectory` on the loaded project state.
- Show clear copy for cancelled, invalid, or failed folder selection/load.
- Leave sample/assets flow read-only unless separately scoped.
- Leave ZIP import behavior unchanged unless separately scoped.
- Avoid schema changes.
- Avoid writer contract changes.
- Avoid component identity creation.
- Avoid AI-authored canonical facts.
- Avoid changing `events.jsonl` / `known_facts.json` semantics.

## Test and smoke expectations

Future implementation should cover:

- valid local folder opens and `projectDirectory` is present;
- cancelled folder picker does not break current state;
- invalid folder shows clear error;
- existing sample and ZIP import behavior do not silently change.

Manual smoke target:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Expected smoke after implementation:

open that folder -> canvas-select `R1`/`C1`/`U1` -> `Lisa` -> `Salvesta` -> exactly one `component_visual_placement_confirmed` event appends -> `python tools/validate_all.py` passes.

## Canonical owners and evidence ledgers

- Active/near-future route queue: `docs/PASS_QUEUE.md`.
- Current scope boundary: `docs/ACTIVE_SCOPE_LOCK.md`.
- Completed pass provenance: `docs/AUDIT_INDEX.md` and `docs/audit/`.
- Stable architecture memory: `docs/PROJECT_MEMORY.md`.
- Core invariants and protected truth: `docs/TRUTH_INDEX.md`.
- Board vector and footprint architecture: `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`.
- Protected boundaries: `docs/PROTECTED_SURFACES.md`.
- Documentation classification/read priority: `docs/FILE_MAP.md`.

## Binding workflow constraints

- Repo docs and verified git state outrank chat handoff text and assistant memory.
- Stage exact files only if explicitly asked; never use `git add .`, `git add -A`, or `git commit -am`.
- Do not stage `_incoming`; do not create runtime dependencies on `_incoming`.
