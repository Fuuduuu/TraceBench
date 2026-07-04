# ACTIVE_SCOPE_LOCK

## Current pass
`PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode
Docs-only scope-lock.

## Lock status
Active docs-only route/scope lock. No runtime or test implementation is armed in this pass.

## Write allowlist for this pass
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS.md`

## Implementation pass to prepare later
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

The next pass, `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`, must inspect live code and arm the exact implementation allowlist.

Likely candidate surfaces, not yet armed:
- Board Canvas placement save UI state owner.
- Board Canvas widget tests for placement save state/stale behavior.

Do not assume these paths until the active-lock sync verifies them from live code.

## Locked behavior
- After successful explicit human placement `Salvesta`, the loaded in-memory project state should include the returned `component_visual_placement_confirmed` event if missing.
- After successful placement save/idempotent confirmation, `ProjectState.isProjectionStale` should become `true`.
- Guarded save, writer failure, draft edits, cancel/reset/delete/navigation must not mutate in-memory canonical event state or stale state.
- The UI should remain truthful that `known_facts.json` projection-backed views may be stale until materialization/reload/export.
- `known_facts.json` must not be mutated directly by Flutter UI.
- No automatic materializer run is authorized by this lock.

## Boundary record
- `events.jsonl` remains canonical.
- `known_facts.json` remains projection/cache.
- Writer contract unchanged.
- Event type remains `component_visual_placement_confirmed`.
- No identity, pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- No Project Open From Directory behavior changes.
- No placement writer service changes unless the next active-lock sync proves they are required; expected answer is no.
- Board Canvas renderer/painter remains read-only.

## Standing protected boundaries
Future work must re-arm a new active scope lock before editing runtime, tests, schema, tools, events, known_facts, materializer, validator, router, Project ZIP, samples, or `_incoming`.
