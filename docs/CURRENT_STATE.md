# Current State

## Current pass

`PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`

## Next recommended pass

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed closeout verified: `f4ce7c6` (`docs: close out placement writer confirm implementation`).
- Current pass: `PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`.
- Next route: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Active scope summary

Docs-only scope lock for a future local-folder project open path.

This pass exists because `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` is closed, but full UI -> writer -> `events.jsonl` append smoke remains blocked until the app can open an existing folder-backed TraceBench project and preserve `projectDirectory`.

Locked product intent:

- Add an `Ava projekt kaustast` / `Open project from folder` path.
- Let the user pick an existing local project folder.
- Load the folder through `ProjectLoader.loadFromDirectory`.
- Preserve `projectDirectory` so scoped writers can append to the selected folder-backed `events.jsonl`.
- Keep sample/assets and ZIP import behavior separate unless a later active lock explicitly includes them.

## Current code findings

- `ProjectLoader.loadFromDirectory` already validates required project files and returns `ProjectState.copyWith(projectDirectory: trimmedDirectory, isProjectionStale: false)`.
- Current launcher import uses ZIP bytes/path through `ProjectLoader.loadFromZipBytes`, which does not preserve a local project directory.
- Bundled sample loading uses `ProjectLoader.loadFromAssets`, which does not preserve a local project directory.
- The new-project wizard already uses `FilePicker.platform.getDirectoryPath` for folder picking, so there is an existing platform approach to evaluate in the implementation active-lock sync.

## Scope boundaries

This pass is documentation only.

Future implementation must preserve:

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- No schema changes unless separately scope-locked.
- No writer contract changes.
- No component identity creation.
- No AI-authored canonical facts.
- Local folder path must be user-selected, not guessed.
- Sample/asset projects may remain read-only.
- ZIP import behavior must not be silently changed unless explicitly included by the future active lock.

## Recommended future implementation route

Next pass should be docs-only:

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_ACTIVE_LOCK_SYNC_PASS`

That active-lock sync must read live code and decide the exact implementation allowlist. Candidate surfaces to evaluate include launcher/home integration, project loading, existing folder-picker pattern/tests, and project-open error handling. These candidate surfaces are not armed by this scope-lock pass.

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
