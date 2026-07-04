# PASS_QUEUE

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Queue state
The implementation lock is armed for a small placement writer-boundary normalization fix.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS` | active / docs-only active-lock sync | Arms the exact two-file implementation allowlist. |
| 2 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | next / implementation | Normalize `rotation_deg` before writer payload emit and add focused unit tests. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | candidate | Future closeout after implementation audit/staging/push. |

## Active implementation allowlist
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` may write only:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

## Surfaces explicitly not armed
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- project open/load UI files
- validator/schema/tools files
- events/known_facts files
- materializer/router files
- `_incoming`

## Live-code basis
The writer currently validates finite `request.rotationDeg` and emits it unchanged as `rotation_deg`. The validator already requires `-180 <= rotation_deg < 180`, so the fix belongs at the writer boundary and in writer unit tests.

## Implementation goal
Normalize placement `rotation_deg` at the writer boundary before canonical event payload emit.

Canonical output range:
`-180 <= rotation_deg < 180`

Required example mapping:
- `0 -> 0`
- `90 -> 90`
- `180 -> -180`
- `270 -> -90`
- `360 -> 0`
- `-181 -> 179`
- `-270 -> 90`
- `540 -> -180`

## Required implementation boundaries
The future implementation must preserve:
- writer emits only `component_visual_placement_confirmed`
- explicit human-confirmed V2 envelope
- required `client_operation_id`
- finite-number validation
- unchanged validator/schema canonical rotation range
- no component identity creation
- no pin/contact/pad/net/trace/electrical/measurement/AI/repair facts
- unchanged Project Open From Directory behavior
- unchanged Board Canvas renderer/painter behavior

## Future test requirements
Writer unit tests must prove:
- `270` normalizes to `-90`
- `180` normalizes to `-180`
- `360` normalizes to `0`
- `-181` normalizes to `179`
- `-270` normalizes to `90`
- `540` normalizes to `-180`
- emitted payload always satisfies `-180 <= rotation_deg < 180`
- existing finite validation remains intact
- writer still emits only `component_visual_placement_confirmed`

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS` | Locked writer-boundary rotation normalization intent and boundaries. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS` | Current docs-only active-lock sync arming the exact two-file implementation allowlist. |