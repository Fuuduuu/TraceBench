# Current State

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Repository handoff

- Repository: `C:\Users\Kasutaja\Desktop\TraceBench`
- Branch: `main`
- Latest pushed implementation verified: `21c8c6551a5b340173b994354874f606c17d6f21` (`feat: open project from local folder`).
- Closed pass: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS`.
- Closeout pass: `PROJECT_OPEN_FROM_DIRECTORY_IMPL_POST_AUDIT_PASS`.
- Current route: `NEEDS_USER_DECISION`.
- Next route: `NEEDS_USER_DECISION`.

## Closeout summary

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` is closed after Claude audit `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`.

Safe implementation set:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

Implementation result recorded:

- `Ava projekt kaustast` / open local folder path works.
- Folder-backed project loads through `ProjectLoader.loadFromDirectory`.
- `projectDirectory` is preserved enough to reach the real writer/validator path.
- Board Canvas opens from the external smoke project.
- `Salvesta` reaches the real placement writer/validator.
- Sample/assets and ZIP import behavior remain unchanged by the closeout.

## Manual smoke record

`PASS_WITH_DOWNSTREAM_BLOCKER`

Smoke result:

- Invalid rotation `270°` was rejected by validation.
- `events.jsonl` remained unchanged; no invalid event was appended.

Downstream blocker:

- The placement writer passes UI rotation through unnormalized.
- Validator requires the half-open range `-180 <= rotation_deg < 180`.
- `270°` must normalize to `-90` before canonical emit.
- This is out of scope for the open-folder implementation.

Recommended next candidate, not armed:

`PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`

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