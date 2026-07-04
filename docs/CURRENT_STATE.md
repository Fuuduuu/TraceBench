# CURRENT_STATE

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Route status
No active implementation lock. Placement rotation normalization implementation is closed out.

## Latest closeout
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS`

Pushed implementation recorded:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

Claude audit recorded:
`ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`

Manual smoke recorded:
`PASS`

## Closeout summary
The prior manual-smoke blocker is fixed: UI rotation `270` previously failed validator because the placement writer emitted canonical `rotation_deg: 270`. The writer now normalizes emitted canonical `rotation_deg` into `-180 <= rotation_deg < 180` before writing `component_visual_placement_confirmed`.

Normalization contract recorded:
- `0 -> 0`
- `90 -> 90`
- `180 -> -180`
- `270 -> -90`
- `360 -> 0`
- `-181 -> 179`
- `-270 -> 90`
- `540 -> -180`

## Boundary record
- Validator/schema unchanged.
- Writer contract unchanged.
- Event type remains `component_visual_placement_confirmed`.
- No identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions were added.
- Project Open From Directory behavior unchanged.
- Board Canvas renderer/painter unchanged.

## Binding workflow safety
- Never use `git add .`.
- Never use `git add -A`.
- Never use `git commit -am`.
- Stage exact files only when explicitly requested by the user.

## Canonical owners / evidence ledgers
- Current route: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Stable invariants: `docs/TRUTH_INDEX.md`
- Protected surfaces: `docs/PROTECTED_SURFACES.md`
- Audit provenance: `docs/AUDIT_INDEX.md` and `docs/audit/*.md`