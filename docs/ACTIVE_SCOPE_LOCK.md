# ACTIVE_SCOPE_LOCK

## Current pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Mode
Docs-only active-lock sync.

## Lock status
Active implementation lock is armed for the next pass. No runtime or test implementation is performed in this sync pass.

## Write allowlist for this pass
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Exact implementation allowlist
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Allowlist rationale
- Board Canvas screen owns `_confirmAddComponentTemplatePlacement`, save status copy, and the only placement-save UI state update point.
- Board Canvas widget tests own the fake `V2PlacementWriter`, placement `Salvesta` coverage, no-write path coverage, and source-boundary assertions.
- `ProjectState.isProjectionStale` already exists; no model change is required.
- `V2PlacementWriterResult.event` already returns the written event; no writer-service change is required.
- Existing measurement/Add/Edit flows already demonstrate the local-state update pattern.

## Locked behavior
- After successful explicit human placement `Salvesta`, the loaded in-memory project state should include the returned `component_visual_placement_confirmed` event if missing.
- After successful placement save/idempotent confirmation, `ProjectState.isProjectionStale` should become `true`.
- Success copy must be truthful that projection-backed views may need refresh/materialization/reload/export before showing the new projection.
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
- No placement writer service changes.
- No schema/tool/materializer/validator/projection/router/events/known_facts/sample/assets/_incoming changes.
- Board Canvas renderer/painter remains read-only.

## Future implementation test requirements
- Successful placement save appends the returned placement event to in-memory `projectState.events`.
- Successful placement save sets `isProjectionStale: true`.
- Idempotent existing-event save does not duplicate local events and still marks stale.
- Writer failure leaves local events and stale state unchanged.
- Guarded save/no selected component/no project directory remains no-state-mutation.
- Draft edits, `Kustuta`, `Tühista`, reset, and navigation write nothing and do not mark stale.
- Board Canvas source-boundary tests continue to prove no direct `known_facts.json` mutation from Flutter.
- Existing placement writer unit tests and rotation normalization remain stable.

## Standing protected boundaries
Future work must re-arm a new active scope lock before editing runtime, tests, schema, tools, events, known_facts, materializer, validator, router, Project ZIP, samples, or `_incoming`.
