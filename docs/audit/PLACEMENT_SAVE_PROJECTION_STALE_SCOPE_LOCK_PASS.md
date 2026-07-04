# PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS

## Mode
Docs-only scope-lock.

## Baseline verification
- Latest baseline verified before edits: `eea1353` (`docs: close out placement rotation normalization`).
- Route before this pass: `NEEDS_USER_DECISION`.
- Tracked diff and cached diff were clean before this pass.
- Branch was aligned with `origin/main`.
- `PLACEMENT_ROTATION_NORMALIZATION_IMPL_POST_AUDIT_PASS` was the latest closed pass.

## Current route
- Current: `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS`
- Next: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Source finding
Placement writer/open-folder/rotation foundation is now complete enough that `Salvesta` can reach the canonical writer and succeed. The next correctness issue is post-save projection truthfulness: after a placement event is appended, loaded projection-backed state can remain visually stale unless the UI records that `events.jsonl` is newer than loaded `known_facts.json`.

## Live-code findings
- `ProjectState` owns `isProjectionStale`.
- `ProjectionStaleBanner` renders stale-projection copy when `isProjectionStale` is true.
- Existing Add Component, Edit Component, Measure Sheet, and legacy measurement save patterns update in-memory state after writer success by appending the returned event when missing and setting `isProjectionStale: true`.
- `ProjectLoader.loadFromDirectory` loads `events.jsonl` and `known_facts.json`, preserves `projectDirectory`, and resets `isProjectionStale: false` for freshly loaded folder-backed state.
- Board Canvas placement save calls `V2PlacementWriter.confirmPlacement` and surfaces success/failure copy, but does not yet update `projectStateProvider` with the returned placement event or set `isProjectionStale: true`.
- `V2PlacementService` calls `tools/event_writer_service.py` for `events.jsonl` append and does not call `materialize_known_facts.py` or mutate `known_facts.json`.

## Locked behavior for future implementation
- On successful explicit human placement `Salvesta`, append the returned `component_visual_placement_confirmed` event to in-memory `projectState.events` if it is not already present.
- On successful append or idempotent existing-event result, set `ProjectState.isProjectionStale` to `true`.
- Do not duplicate the event if the returned event is already present in local state.
- Keep guarded save, writer failure, draft edits, preview changes, size changes, rotation changes before save, cancel, reset, `Kustuta`, and navigation as no-state-mutation paths.
- User-facing save/stale copy must remain truthful that projection-backed views may remain stale until materialization/reload/export.
- Do not mutate `known_facts.json` directly from Flutter.
- Do not run the materializer automatically from placement save unless separately scope-locked.

## Future implementation boundaries
- No schema changes.
- No validator changes.
- No materializer/projection semantics changes.
- No placement writer contract changes unless the active-lock sync proves they are required; expected answer is no.
- Event type remains `component_visual_placement_confirmed`.
- No component identity creation.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- No Project Open From Directory behavior change.
- Board Canvas renderer/painter remains read-only.
- No `_incoming` dependency.

## Expected future active-lock sync
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS` must inspect live code and arm exact implementation files. Likely candidate surfaces are the Board Canvas save UI state owner and its widget tests, but no implementation allowlist is armed by this scope-lock.

## Future test expectations
- Successful placement save appends the returned placement event to in-memory `projectState.events`.
- Successful placement save sets `isProjectionStale: true`.
- Idempotent existing-event save does not duplicate local events and still marks stale.
- Writer failure does not mutate local events or stale state.
- Guarded save/no project/no selected component remains no-write/no-state-mutation.
- Draft edits, cancel/reset/delete/navigation write nothing and do not mark stale.
- Tests guard that Flutter does not mutate `known_facts.json` directly from placement save.

## Validation
Completed for this docs-only pass:
- `python tools/validate_all.py`: PASS, 285 tests OK.
- `git diff --check`: PASS.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '\|\|'`: no matches.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '^\| PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS \|'`: one match.
