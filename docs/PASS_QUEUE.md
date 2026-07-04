# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Route status

Docs-only active-lock sync is active. The implementation allowlist for the next pass is now armed.

## Active sequence

| Order | PASS_ID | Purpose |
|---|---|---|
| 1 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` | Pushed scope-lock for guarding invalid placement draft canonical bounds before writer call. |
| 2 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS` | Current docs-only sync arming the exact implementation allowlist. |
| 3 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Future implementation to add pre-save invalid-bounds UI guard and tests. |

## Exact implementation allowlist armed

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Why this allowlist is exact

Live-code inspection shows the invalid canonical payload is assembled in the Board Canvas Add Component / placement save path before calling the placement writer. Existing widget tests already fake and inspect the placement writer call. Therefore the future implementation can add the pre-writer UI guard and coverage in the Board Canvas screen and widget test only.

Writer and unit-test files are not armed because the future change is a pre-call UI guard; the placement writer contract, event-writer validation path, and rotation normalization remain unchanged.

## Future implementation requirements

- Block or guard `Salvesta` before writer call when `board_normalized` payload fields are invalid.
- Show clear user-facing Estonian guard copy.
- Avoid raw Python validator dump for expected UI validation cases.
- Keep validator/schema strict and unchanged.
- Keep writer/event contract unchanged.
- Preserve rotation normalization.
- Preserve projection-stale behavior.
- Preserve Project Open From Directory behavior.
- Preserve Board Canvas renderer/painter read-only boundary.
- Ensure invalid draft edits remain UI-local and write nothing.
- Ensure `Kustuta`, `Tühista`, and navigation still write nothing.
- Ensure valid draft still saves and marks projection stale.
- Do not directly mutate `known_facts.json` from Flutter.
- Do not create component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored facts.

## Canonical bounds to record

For `coordinate_space: board_normalized`:

- `center_x` must be within `0..1`.
- `center_y` must be within `0..1`.
- `width` must be valid and `<= 1`.
- `height` must be valid and `<= 1`.
- `rotation_deg` must remain normalized to `-180 <= rotation_deg < 180`.

## Future implementation questions to answer

1. Where `center_x` / `center_y` / `width` / `height` payload fields are assembled before writer call.
2. Whether invalid bounds disable `Salvesta` or keep it clickable with guard copy.
3. Whether local preview/draft editing may visually exceed bounds as long as canonical save is guarded.
4. Whether extents should be checked only by payload fields or also by board-edge overhang.
5. What exact Estonian copy replaces raw validator failures.
6. How tests prove writer is not invoked for invalid bounds.

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active implementation lock.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.