# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

The pushed `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` is closed out and the active implementation lock is released.

No implementation pass is armed. The next pass requires an explicit user decision and a fresh scope-lock or active-lock sync.

## Last closed implementation

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

Pushed implementation commit recorded from live git log:

- `90107a64ec277a8992ff9d509d1b8eee6fae2f19`
- `fix: guard invalid placement draft bounds`

## Closeout record

- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- Manual smoke: `PASS`
- Safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

Manual smoke evidence recorded:

- Empty required label keeps `Salvesta` disabled.
- Valid selected component + label enables `Salvesta` and saves.
- Width/height above canonical bounds disables `Salvesta`.
- Invalid draft does not append `events.jsonl`.
- Valid draft appends `component_visual_placement_confirmed`.
- `python tools/validate_all.py` passes.

## Behavior now recorded

- Invalid `board_normalized` placement drafts are guarded before writer call.
- UI shows clear guard copy instead of raw validator output.
- Writer is not invoked for invalid draft bounds.
- Validator/schema remain strict and unchanged.
- Valid draft still saves and marks projection stale / refresh-needed.
- Rotation normalization is unchanged.
- Project Open From Directory behavior is unchanged.
- Placement writer contract is unchanged.
- `known_facts.json` is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.

## Known carryover nit

- Empty required draft label also disables `Salvesta`; future copy may make that clearer if desired.

## Boundary confirmation

This closeout is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.