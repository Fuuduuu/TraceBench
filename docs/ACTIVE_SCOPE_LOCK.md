# ACTIVE_SCOPE_LOCK.md

## Current pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Active lock

Docs-only active-lock sync arming the exact implementation allowlist for `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`.

## Write allowlist for this docs-only sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Files not armed

- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`
- project open files
- router files
- schema files
- validator/tool/materializer files
- events / `known_facts.json`
- samples/assets
- `_incoming`

## Live-code basis for allowlist

- Board Canvas assembles `center_x`, `center_y`, `width`, `height`, rotation, template, and selected placement context into `V2PlacementWriterRequest` immediately before calling the placement writer.
- Current save guard covers selected component and local project-directory prerequisites but not canonical `board_normalized` center/size bounds.
- Existing widget tests provide fake placement writer request capture, so the future implementation can assert invalid drafts do not invoke the writer.
- Writer, unit-test, schema, validator, and tool files are not required for a pre-writer UI guard and remain outside the implementation allowlist.

## Future implementation must

- Block or guard `Salvesta` before writer call when `board_normalized` payload is invalid.
- Show clear user-facing Estonian guard copy.
- Avoid raw Python validator dump for expected UI validation cases.
- Keep validator/schema strict and unchanged.
- Keep writer/event contract unchanged.
- Preserve rotation normalization.
- Preserve projection-stale behavior.
- Preserve Project Open From Directory behavior.
- Preserve Board Canvas renderer/painter read-only boundary.
- Ensure invalid draft edits remain UI-local and write nothing.
- Ensure `Kustuta`, `Tühista`, and navigation still write nothing.
- Ensure valid draft still saves and marks projection stale.
- Not directly mutate `known_facts.json` from Flutter.
- Not create component identity.
- Not create pins, contacts, pads, nets, traces, or electrical facts.
- Not create measurements.
- Not create AI-authored facts.

## Canonical bounds

For `coordinate_space: board_normalized`:

- `center_x` must be within `0..1`.
- `center_y` must be within `0..1`.
- `width` must be valid and `<= 1`.
- `height` must be valid and `<= 1`.
- `rotation_deg` must remain normalized to `-180 <= rotation_deg < 180`.

## Future tests expected

- `width > 1` blocks `Salvesta` before writer call.
- `height > 1` blocks `Salvesta` before writer call.
- `center_x < 0` or `center_x > 1` blocks `Salvesta` before writer call.
- `center_y < 0` or `center_y > 1` blocks `Salvesta` before writer call.
- Clear guard copy appears.
- Writer is not invoked for invalid draft.
- Valid draft still saves.
- Valid draft still marks projection stale / refresh-needed.
- Rotation normalization still works.
- Project Open From Directory still works.
- Draft edits / `Kustuta` / `Tühista` / navigation write nothing.
- Validator/schema remains unchanged.

## Future manual smoke

Use:

`C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`

Smoke:

- open folder-backed project
- select R1/C1/U1
- `Lisa`
- make draft too wide or outside canonical bounds
- confirm `Salvesta` is disabled or shows clear guard
- confirm no event appends
- reduce draft into valid bounds
- `Salvesta` appends one `component_visual_placement_confirmed`
- UI shows projection-refresh truth copy
- `python tools/validate_all.py` passes

## This sync pass must not

- implement runtime behavior
- edit tests
- edit writer files
- edit schema, tools, validator, materializer, router, events, `known_facts.json`, samples, assets, or `_incoming`
- stage, commit, or push