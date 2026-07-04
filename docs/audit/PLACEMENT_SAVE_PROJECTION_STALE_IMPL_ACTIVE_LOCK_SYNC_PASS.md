# PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode
Docs-only active-lock sync.

## Baseline verification
- Baseline HEAD verified before edits: `789fae7` (`docs: lock placement save projection stale scope`).
- Branch was aligned with `origin/main`.
- Tracked diff and cached diff were clean before edits.
- Route before this pass:
  - Current: `PLACEMENT_SAVE_PROJECTION_STALE_SCOPE_LOCK_PASS`
  - Next: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route after this pass
- Current: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Implementation pass armed
`PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS`

## Exact implementation allowlist
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings
- `ProjectState` already owns `isProjectionStale`; no model change is required.
- `ProjectionStaleBanner` and existing workbench/report/list surfaces already consume stale projection state.
- Existing Add Component, Edit Component, Measure Sheet, and legacy measurement save flows append the returned event to in-memory `projectState.events` when missing and set `isProjectionStale: true`.
- `ProjectLoader.loadFromDirectory` preserves `projectDirectory` and loads fresh disk state with `isProjectionStale: false`.
- `V2PlacementWriterResult` already returns the written event map and append/existing status.
- `V2PlacementService` calls `tools/event_writer_service.py` for `events.jsonl` append and existing unit tests assert it does not call `materialize_known_facts.py`.
- Board Canvas `_confirmAddComponentTemplatePlacement` currently calls `V2PlacementWriter.confirmPlacement` and surfaces success/failure copy, but does not update `projectStateProvider` with the returned event or mark `isProjectionStale: true`.
- Board Canvas widget tests already provide a fake placement writer and source-boundary assertions, including no direct `known_facts.json` path in Board Canvas source.

## Allowlist rationale
- `lib/features/board_canvas/screens/board_canvas_screen.dart` is the narrow state owner for placement `Salvesta`, success copy, and local `projectStateProvider` update.
- `test/widget/board_canvas_screen_test.dart` is the narrow test owner for placement save, no-write paths, fake writer behavior, and source-boundary guards.
- `lib/shared/models/project_state.dart` is not armed because the stale flag already exists.
- `lib/features/components/services/v2_placement_writer.dart` is not armed because the writer already returns event/status and the event contract must remain unchanged.
- Measurement write tests are not armed because the implementation can preserve existing measurement stale behavior without editing those tests.

## Locked implementation behavior
- On successful explicit human placement `Salvesta`, append the returned `component_visual_placement_confirmed` event to in-memory `projectState.events` if it is not already present.
- On successful append or idempotent existing-event result, set `ProjectState.isProjectionStale` to `true`.
- Do not duplicate returned events already present in local state.
- Success copy must remain truthful that projection-backed views may need refresh/materialization/reload/export before showing updated projection data.
- Guarded save, writer failure, draft edits, preview changes, size changes before save, rotation changes before save, cancel, reset, `Kustuta`, and navigation must not mutate in-memory canonical event state or stale state.
- Do not mutate `known_facts.json` directly from Flutter.
- Do not call the materializer automatically from placement save.

## Forbidden surfaces
- No placement writer service edits.
- No Project Open From Directory edits.
- No schema edits.
- No tools/materializer/validator edits.
- No router edits.
- No events.jsonl or known_facts.json edits.
- No sample/assets edits.
- No `_incoming` edits or staging.
- No component identity creation.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- Board Canvas renderer/painter remains read-only.

## Future implementation test requirements
- Successful placement save appends the returned event to in-memory `projectState.events`.
- Successful placement save sets `isProjectionStale: true`.
- Idempotent existing-event save does not duplicate local events and still marks stale.
- Writer failure leaves local events and stale state unchanged.
- Guarded save/no selected component/no project directory remains no-state-mutation.
- Draft edits, `Kustuta`, `Tühista`, reset, and navigation write nothing and do not mark stale.
- Board Canvas source-boundary tests continue to prove no direct `known_facts.json` mutation from Flutter.
- Existing placement writer unit tests and rotation normalization remain stable.

## Future manual smoke
Use:
`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Smoke:
- Open folder-backed project.
- Select `R1` / `C1` / `U1`.
- Open `Lisa`.
- Press `Salvesta`.
- Confirm one new `component_visual_placement_confirmed` appends.
- Confirm UI shows saved plus stale/reload/projection truth.
- Run `python tools/validate_all.py` and confirm PASS.
- Confirm `known_facts.json` is not directly mutated by Flutter unless a separately accepted materializer/reload path explicitly runs.

## Validation
Completed for this docs-only pass:
- `python tools/validate_all.py`: PASS, 285 tests OK.
- `git diff --check`: PASS.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '\|\|'`: no matches.
- `Select-String -Path docs/AUDIT_INDEX.md -Pattern '^\| PLACEMENT_SAVE_PROJECTION_STALE_IMPL_ACTIVE_LOCK_SYNC_PASS \|'`: one match.
