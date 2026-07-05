# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock

None. The `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` active implementation lock is released.

## Write allowlist

No files are currently armed for implementation.

## Last released implementation lock

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

Safe implementation set recorded:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closeout result

- Pushed implementation: `90107a64ec277a8992ff9d509d1b8eee6fae2f19` (`fix: guard invalid placement draft bounds`)
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- Manual smoke: `PASS`

## Behavior recorded

- Invalid `board_normalized` placement drafts are guarded before writer call.
- UI shows clear guard copy instead of raw validator output.
- Writer is not invoked for invalid draft bounds.
- Validator/schema remain strict and unchanged.
- Valid draft still saves and marks projection stale / refresh-needed.
- Rotation normalization remains unchanged.
- Project Open From Directory behavior remains unchanged.
- Placement writer contract remains unchanged.
- `known_facts.json` is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.

## Known carryover nit

- Empty required draft label also disables `Salvesta`; future copy may make that clearer if desired.

## Protected surfaces remain locked unless separately scoped

- schema / validator / materializer / projection semantics
- placement writer contract
- events / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization behavior
- component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- samples/assets and `_incoming`

## Route note

Future work must start from `NEEDS_USER_DECISION` with a fresh scope-lock or active-lock sync before any implementation edits.