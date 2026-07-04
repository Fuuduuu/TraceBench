# PASS_QUEUE

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Queue state
No active route. Placement rotation normalization implementation is closed out.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | completed / docs-only closeout | Records pushed implementation, Claude audit `ACCEPT_AS_IS`, manual smoke `PASS`, boundary record, and route reset. |

## Closed implementation
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` was pushed as:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

Safe implementation set:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

## Recorded result
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- Manual smoke: `PASS`
- Prior blocker fixed: writer now normalizes canonical `rotation_deg` into `-180 <= rotation_deg < 180` before emitting `component_visual_placement_confirmed`.
- Add Component / Salvesta now shows successful save.

## Normalization contract
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

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Pushed implementation `ca8d152a1b5105a576a2cb0d215628afb7dc9855`; normalized placement writer rotation before canonical emit. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | Closeout returned route to `NEEDS_USER_DECISION`. |