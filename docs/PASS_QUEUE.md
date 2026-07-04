# PASS_QUEUE

## Current pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Queue state
Active docs-only sync arming the placement-save projection stale/truthfulness implementation pass.

| Order | Pass ID | Status | Notes |
| --- | --- | --- | --- |
| 1 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS` | current / docs-only active-lock sync | Arms exact implementation allowlist for the small Board Canvas post-save state/truthfulness fix. |
| 2 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | next / implementation | Updates Board Canvas placement save state and tests so successful placement confirmation appends returned event to in-memory state and marks projection stale. |

## Baseline
`PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS` was pushed as:
`789fae7` (`docs: lock placement save projection stale scope`)

Previous implementation closeout:
`eea1353` (`docs: close out placement rotation normalization`)

It recorded implementation:
`ca8d152a1b5105a576a2cb0d215628afb7dc9855` (`fix: normalize placement rotation before write`)

## Implementation allowlist armed
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Rationale:
- Board Canvas screen owns the placement `Salvesta` callback, success/status copy, and project-state update point.
- Board Canvas widget tests own placement save fake-writer coverage, no-write paths, stale-state assertions, and source-boundary checks.
- `ProjectState` already has `isProjectionStale`, and `V2PlacementWriterResult` already returns the written event; neither file needs arming for this fix.

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
- Placement writer service, project open files, tools, materializer, validator, schema, router, events, known_facts, samples/assets, and `_incoming` are not armed.

## Current-state maintenance trigger
Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together whenever the current or next pass changes.

## Routing provenance
| Pass ID | Provenance |
| --- | --- |
| `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS` | Current docs-only active-lock sync after pushed scope-lock `789fae7`; arms exact two-file implementation allowlist for Board Canvas state/test fix. |
| `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS` | Pushed docs-only scope-lock after placement writer/open-folder/rotation foundation passes; records live-code stale-projection gap and routes to active-lock sync. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Pushed implementation `ca8d152a1b5105a576a2cb0d215628afb7dc9855`; normalized placement writer rotation before canonical emit. |
| `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` | Closeout returned route to `NEEDS_USER_DECISION`. |
