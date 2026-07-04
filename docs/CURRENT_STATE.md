# CURRENT_STATE

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

## Route status
Docs-only active-lock sync is active. The implementation lock is armed for the placement writer-boundary rotation normalization fix.

## Baseline evidence
Latest pushed scope-lock commit observed in live git log:
`2937deb docs: lock placement rotation normalization scope`

The route before this sync was:
Current: `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`
Next: `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Live-code findings
`lib/features/components/services/v2_placement_writer.dart` currently validates `request.rotationDeg` as finite, then emits it directly as payload `rotation_deg`.

`tools/validate_events_jsonl.py` already enforces the canonical range:
`-180 <= rotation_deg < 180`

`test/unit/v2_placement_writer_test.dart` already covers writer envelope, client operation ID, finite validation, unknown component, project directory guards, writer status mapping, and forbidden side-effect fields. It does not yet cover rotation normalization.

## Implementation pass armed
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

Exact implementation allowlist:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

No other implementation files are armed.

## Required implementation behavior
Future implementation must:
- normalize `request.rotationDeg` before payload emit
- keep finite-number validation
- keep validator/schema unchanged
- keep event type `component_visual_placement_confirmed`
- keep V2 human-confirmed envelope unchanged
- keep `client_operation_id` required
- not create component identity
- not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- not change Project Open From Directory behavior
- not change Board Canvas renderer/painter behavior

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

## Forbidden surfaces for implementation
- No Board Canvas screen edits.
- No project open files.
- No validator/schema/tools edits.
- No events/known_facts edits.
- No materializer/router edits.
- No `_incoming` edits or staging.

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