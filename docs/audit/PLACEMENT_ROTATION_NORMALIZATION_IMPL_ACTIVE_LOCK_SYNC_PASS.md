# PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode
Docs-only active-lock sync.

## Route
Current: `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
Next: `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Baseline verification
Live git log showed the pushed scope-lock commit:
`2937deb docs: lock placement rotation normalization scope`

Route docs before this sync showed:
Current: `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`
Next: `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

Tracked and cached diffs were clean before this pass, except known untracked scratch listed by `git status --short --branch`.

## Live-code findings
`lib/features/components/services/v2_placement_writer.dart`:
- validates `request.rotationDeg` with finite-number validation
- builds payload `rotation_deg` directly from `request.rotationDeg`
- emits only `component_visual_placement_confirmed`
- preserves V2 human-confirmed envelope and `client_operation_id`

test/unit/v2_placement_writer_test.dart:
- covers writer envelope and payload
- covers `client_operation_id` requirement
- covers unknown component guard
- covers project directory guards
- covers writer status/failure mapping
- covers forbidden side-effect fields
- does not yet cover rotation normalization

tools/validate_events_jsonl.py:
- already enforces `-180 <= rotation_deg < 180`

## Implementation pass armed
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Exact implementation allowlist
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

## Implementation goal
Normalize `request.rotationDeg` before emitting canonical payload `rotation_deg`.

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

## Forbidden surfaces
- No Board Canvas screen edits.
- No project open/load UI edits.
- No validator/schema/tools edits.
- No events/known_facts edits.
- No materializer/router edits.
- No `_incoming` edits or staging.

## Required implementation boundaries
Future implementation must:
- keep finite-number validation
- keep validator/schema unchanged
- keep event type `component_visual_placement_confirmed`
- keep V2 human-confirmed envelope unchanged
- keep `client_operation_id` required
- not create component identity
- not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- not change Project Open From Directory behavior
- not change Board Canvas renderer/painter behavior

## Future test requirements
Unit tests must prove:
- `270` normalizes to `-90`
- `180` normalizes to `-180`
- `360` normalizes to `0`
- `-181` normalizes to `179`
- `-270` normalizes to `90`
- `540` normalizes to `-180`
- emitted payload always satisfies `-180 <= rotation_deg < 180`
- existing finite validation remains intact
- writer still emits only `component_visual_placement_confirmed`

## Audit status
DRAFTED / PENDING CLAUDE AUDIT.

## Safe staging set
Pending audit.

## Validation record
Pending local validation for this docs-only sync:
- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Markers
RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW