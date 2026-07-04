# PASS_QUEUE

## Current pass
`PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS`

## Next recommended pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Queue state
Active docs-only scope-lock for placement-save projection stale/truthfulness behavior.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS` | current / docs-only scope-lock | Locks future behavior for updating in-memory event state and stale-projection truth after successful Board Canvas placement save; no implementation allowlist armed yet. |
| 2 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS` | next / docs-only active-lock sync | Must inspect live code and arm exact implementation allowlist for the small UI state/test fix. |

## Latest closed baseline
`PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` was pushed as:
`eea1353` (`docs: close out placement rotation normalization`)

It recorded implementation:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

## Locked product intent
After explicit human placement `Salvesta` succeeds, the app must be truthful that `events.jsonl` is newer than the loaded `known_facts.json` projection.

Future implementation should match existing Add/Edit Component and measurement save patterns:
- append the returned placement event to in-memory `projectState.events` if it is not already present;
- set `isProjectionStale: true` after successful append/idempotent confirmation;
- keep draft edits, cancel/reset/delete/navigation, save guard failures, and writer failures as no-state-mutation paths;
- keep user copy clear that the visible projection may remain stale until materialization/reload/export.

## Boundary record
- `events.jsonl` remains canonical.
- `known_facts.json` remains projection/cache.
- Flutter must not mutate `known_facts.json` directly.
- No schema/tool/materializer/validator/projection semantics changes are authorized by this scope-lock.
- Event type remains `component_visual_placement_confirmed`.
- No component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions may be created.
- Board Canvas renderer/painter remains read-only.
- The next active-lock sync owns exact implementation allowlist selection after live-code inspection.

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS` | Current docs-only scope-lock after placement writer/open-folder/rotation foundation passes; records live-code stale-projection gap and routes to active-lock sync. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Pushed implementation `ca8d152a1b5105a576a2cb0d215628afb7dc9855`; normalized placement writer rotation before canonical emit. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | Closeout returned route to `NEEDS_USER_DECISION`. |
