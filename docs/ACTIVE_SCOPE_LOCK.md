# ACTIVE_SCOPE_LOCK

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode
Docs-only scope-lock.

## Write allowlist for this pass
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS.md`

## Forbidden in this pass
- No runtime edits.
- No test edits.
- No tools, schema, validator, materializer, projection, events, known_facts, sample, ZIP, or `_incoming` edits.
- No Project Open From Directory behavior changes.
- No placement writer implementation.
- No Board Canvas renderer/painter changes.
- No staging, commit, or push.

## Locked future goal
Future implementation will normalize `rotation_deg` at the placement writer boundary before emitting the canonical `component_visual_placement_confirmed` payload.

Canonical output range:
`-180 <= rotation_deg < 180`

Locked examples:
- `0 -> 0`
- `90 -> 90`
- `180 -> -180`
- `270 -> -90`
- `360 -> 0`
- `-181 -> 179`
- `-270 -> 90`
- `540 -> -180`

## Future implementation boundaries
Future implementation must:
- normalize `rotation_deg` before writing `component_visual_placement_confirmed`
- keep finite-number validation
- keep validator/schema canonical constraint unchanged
- keep event type unchanged
- keep V2 human-confirmed envelope unchanged
- keep `client_operation_id` requirement unchanged
- not create component identity
- not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- not change Project Open From Directory behavior
- not change Board Canvas renderer/painter read-only boundary

## Candidate implementation surfaces, not armed here
Likely surfaces observed from live code:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

The next active-lock sync must read live code and arm the exact implementation allowlist.

## Validation required for this pass
- `python tools/validate_all.py`
- `git diff --check`
- verify `docs/AUDIT_INDEX.md` has no glued table rows / no `||`