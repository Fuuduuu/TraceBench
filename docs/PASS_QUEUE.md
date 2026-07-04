# PASS_QUEUE

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Queue state
The active route is a docs-only scope-lock for a future placement writer-boundary rotation normalization fix.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS` | active / docs-only scope-lock | Locks writer-boundary normalization intent and boundaries only. |
| 2 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS` | next | Must read live code and arm the exact implementation allowlist. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | candidate | Future protected implementation; likely writer + writer unit tests only, pending active-lock sync. |
| 4 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | candidate | Future closeout after implementation audit/staging/push. |

## Scope gate rules
- Route docs must agree before implementation begins.
- Active implementation allowlist must be armed by an active-lock sync pass, not by this scope-lock.
- Repo docs and verified git state outrank chat handoff text.
- Protected surfaces require explicit scope-lock before edits.
- No runtime/test/tool/schema/event/known_facts changes are authorized by this docs-only pass.

## Locked product intent
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

## Future implementation notes
The future implementation must preserve:
- writer emits only `component_visual_placement_confirmed`
- explicit human-confirmed V2 envelope
- required `client_operation_id`
- no component identity creation
- no pin/contact/pad/net/trace/electrical/measurement/AI/repair facts
- unchanged validator/schema canonical rotation range
- unchanged Project Open From Directory behavior
- unchanged Board Canvas renderer/painter read-only boundary

Likely future files, not armed by this pass:
- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`

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

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PROJECT_OPEN_FROM_DIRECTORY_IMPL_POST_AUDIT_PASS` | Closed open-folder implementation with `PASS_WITH_DOWNSTREAM_BLOCKER`; identified placement rotation normalization as next candidate. |
| `PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS` | Current docs-only scope-lock for the downstream writer-boundary rotation fix. |