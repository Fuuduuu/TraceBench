# CURRENT_STATE

## Current pass
`PLACEMENT_ROTATION_NORMALIZATION_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status
Docs-only scope lock is active for the placement rotation normalization bugfix.

## Scope summary
`PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` proved the folder-backed open path can reach the real placement writer/validator. Manual smoke then exposed a downstream writer-boundary issue: UI rotation can produce `270`, while canonical validation requires `-180 <= rotation_deg < 180`.

This pass locks the future fix only. No runtime, tests, tools, schema, events, known_facts, or `_incoming` files are changed here.

## Locked product intent
Normalize `rotation_deg` at the placement writer boundary before emitting `component_visual_placement_confirmed`.

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
Future implementation must keep:
- event type unchanged: `component_visual_placement_confirmed`
- V2 human-confirmed envelope unchanged
- `client_operation_id` requirement unchanged
- finite-number validation intact
- validator/schema canonical constraint unchanged
- no component identity creation
- no pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- no Project Open From Directory behavior change
- Board Canvas renderer/painter read-only boundary unchanged

Likely future surfaces are `lib/features/components/services/v2_placement_writer.dart` and `test/unit/v2_placement_writer_test.dart`, but this scope-lock does not arm the implementation allowlist. The next active-lock sync must read live code and arm exact files.

## Manual smoke target for future implementation
Use `C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`.

Expected future smoke:
open project from folder -> Board Canvas renders R1/C1/U1 -> select R1/C1/U1 -> Lisa -> choose rotation that previously produced `270` -> Salvesta -> one `component_visual_placement_confirmed` appends with `rotation_deg: -90` -> `python tools/validate_all.py` passes.

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