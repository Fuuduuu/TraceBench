# ACTIVE_SCOPE_LOCK

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Mode
Docs-only active-lock sync.

## Write allowlist for this pass
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Exact implementation allowlist
The implementation pass may write only:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

## Implementation goal
Normalize `request.rotationDeg` before emitting payload `rotation_deg` in `component_visual_placement_confirmed`.

Canonical output range:
`-180 <= rotation_deg < 180`

Required examples:
- `0 -> 0`
- `90 -> 90`
- `180 -> -180`
- `270 -> -90`
- `360 -> 0`
- `-181 -> 179`
- `-270 -> 90`
- `540 -> -180`

## Implementation must preserve
- finite-number validation
- validator/schema unchanged
- event type `component_visual_placement_confirmed`
- V2 human-confirmed envelope unchanged
- `client_operation_id` required
- no component identity creation
- no pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- Project Open From Directory behavior unchanged
- Board Canvas renderer/painter behavior unchanged

## Forbidden implementation surfaces
- No Board Canvas screen edits.
- No project open/load UI edits.
- No validator/schema/tools edits.
- No events/known_facts edits.
- No materializer/router edits.
- No `_incoming` edits or staging.
- No staging, commit, or push.

## Required implementation tests
- `270` normalizes to `-90`
- `180` normalizes to `-180`
- `360` normalizes to `0`
- `-181` normalizes to `179`
- `-270` normalizes to `90`
- `540` normalizes to `-180`
- emitted payload always satisfies `-180 <= rotation_deg < 180`
- existing finite validation remains intact
- writer still emits only `component_visual_placement_confirmed`

## Validation required for this sync pass
- `python tools/validate_all.py`
- `git diff --check`
- verify `docs/AUDIT_INDEX.md` has no glued table rows / no `||`