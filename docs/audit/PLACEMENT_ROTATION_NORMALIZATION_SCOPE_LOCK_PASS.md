# PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS

## Mode
Docs-only scope-lock.

## Route
Current: `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`
Next: `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Source evidence
`PROJECT_OPEN_FROM_DIRECTORY_IMPL_POST_AUDIT_PASS` recorded manual smoke as `PASS_WITH_DOWNSTREAM_BLOCKER`:
- folder-backed project open path works
- Board Canvas reaches the real placement writer/validator
- invalid `rotation_deg: 270` was rejected by validation
- `events.jsonl` remained unchanged

Live code inspection confirmed:
- `lib/features/components/services/v2_placement_writer.dart` validates finite rotation but passes `request.rotationDeg` through to payload as `rotation_deg`
- `tools/validate_events_jsonl.py` enforces `component_visual_placement_confirmed.rotation_deg must be >= -180 and < 180`

## Locked product intent
Normalize placement rotation at the writer boundary before canonical event payload emit.

Canonical output range:
`-180 <= rotation_deg < 180`

Required mapping:
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
- keep event type unchanged: `component_visual_placement_confirmed`
- keep V2 human-confirmed envelope unchanged
- keep `client_operation_id` requirement unchanged
- not create component identity
- not create pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- not change Project Open From Directory behavior
- not change Board Canvas renderer/painter read-only boundary

## Candidate future surfaces
Likely future implementation files, pending active-lock sync:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

This scope-lock does not arm the implementation allowlist.

## Future test expectations
Writer unit tests should prove:
- `270` normalizes to `-90`
- `180` normalizes to `-180`
- `360` normalizes to `0`
- `-181` normalizes to `179`
- `-270` normalizes to `90`
- finite validation still rejects NaN / infinity if currently covered
- emitted payload always satisfies `-180 <= rotation_deg < 180`
- writer still emits only `component_visual_placement_confirmed`
- forbidden facts and identity events are not emitted

## Future manual smoke expectation
Using `C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`:
- open project from folder
- Board Canvas renders R1/C1/U1
- select R1/C1/U1
- Lisa
- choose rotation that previously produced `270`
- Salvesta
- verify one new `component_visual_placement_confirmed` appends
- verify appended `rotation_deg` is `-90`, not `270`
- run `python tools/validate_all.py` and confirm PASS

## Audit status
DRAFTED / PENDING CLAUDE AUDIT.

## Safe staging set
Pending audit.

## Validation record
Pending local validation for this docs-only pass:
- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Markers
RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW