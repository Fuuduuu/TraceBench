# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock.

`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` is closed by `PROJECT_OPEN_FROM_DIRECTORY_IMPL_POST_AUDIT_PASS`.

## Closed implementation

- Pushed implementation: `21c8c6551a5b340173b994354874f606c17d6f21` (`feat: open project from local folder`).
- Claude audit: `ACCEPT_WITH_NITS` / `SAFE_FOR_STAGING: YES`.
- Manual smoke: `PASS_WITH_DOWNSTREAM_BLOCKER`.

Safe implementation set:

- `lib/app/app.dart`
- `lib/features/home/screens/benchbeep_home_screen.dart`
- `lib/features/project/screens/home_screen.dart`
- `test/widget/benchbeep_home_screen_test.dart`

## Closed implementation summary

- `Ava projekt kaustast` / open local folder path works.
- Folder-backed project loads through `ProjectLoader.loadFromDirectory`.
- `projectDirectory` is preserved enough to reach the real writer/validator path.
- Board Canvas opens from the external smoke project.
- `Salvesta` reaches the real placement writer/validator.
- Invalid rotation `270°` was rejected by validation.
- `events.jsonl` remained unchanged; no invalid event was appended.

## Downstream blocker recorded

- Placement writer passes UI rotation through unnormalized.
- Validator requires `-180 <= rotation_deg < 180`.
- `270°` must normalize to `-90` before canonical emit.
- This is out of scope for the open-folder implementation.

## Recommended next candidate

`PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`

This candidate is not armed. A future scope-lock pass must define its route, allowlist, tests, and protected boundaries.

## Boundary confirmation

No active write allowlist is armed.

Future runtime, test, schema, writer, materializer, validator, router, events, known-facts, sample, project fixture, ZIP, or `_incoming` edits require a new explicit scope lock.