# ACTIVE_SCOPE_LOCK

## Current pass
`NEEDS_USER_DECISION`

## Next recommended pass
`NEEDS_USER_DECISION`

## Mode
No active implementation lock.

## Lock status
Released by `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS`.

## Last closed implementation
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS`

Pushed implementation commit:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

Safe implementation set:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

## Result recorded
- Claude audit: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- Manual smoke: `PASS`
- Writer normalizes canonical `rotation_deg` to `-180 <= rotation_deg < 180` before emitting `component_visual_placement_confirmed`.

## Boundary record
- Validator/schema unchanged.
- Writer contract unchanged.
- Event type remains `component_visual_placement_confirmed`.
- No identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions were added.
- Project Open From Directory behavior unchanged.
- Board Canvas renderer/painter unchanged.

## Standing protected boundaries
Future work must re-arm a new active scope lock before editing runtime, tests, schema, tools, events, known_facts, materializer, validator, router, Project ZIP, samples, or `_incoming`.