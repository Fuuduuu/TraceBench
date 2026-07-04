# PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

Gate commands run before edits:

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Gate result:

- Branch: `main...origin/main`
- HEAD: `cd3ad89` (`docs: lock placement draft canonical bounds guard scope`)
- Tracked diff before this pass: clean
- Cached diff before this pass: clean
- Route before this pass: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_SCOPE_LOCK_PASS` -> `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Known untracked scratch remained untouched.

## Goal

Arm the exact implementation allowlist for `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`.

The future implementation must prevent invalid `board_normalized` placement payloads from reaching the writer/save path.

## Live-code findings

- Board Canvas assembles `V2PlacementWriterRequest` immediately before calling the placement writer in the Add Component / placement save path.
- The assembled request uses selected placement context, optional local ghost draft anchor for `center_x` / `center_y`, local draft `width` / `height`, local draft rotation, template id, and project state.
- The current save guard covers selected component and local folder-backed project prerequisites.
- There is no focused pre-save guard for canonical `board_normalized` center/size bounds.
- The local draft dimension clamp allows values above normalized canonical limits, so the UI can create `width > 1` or `height > 1` candidate payload fields.
- Existing widget tests already provide a fake placement writer and captured `V2PlacementWriterRequest` list, which is the correct surface for proving invalid draft states do not invoke the writer.
- The placement writer contract remains unchanged: explicit human-confirmed `component_visual_placement_confirmed`, existing project-directory/component checks, event-writer validation path, and rotation normalization.
- `tools/validate_events_jsonl.py` remains the strict canonical validator for `board_normalized` center, size, and rotation bounds.

## Exact implementation allowlist armed

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Files intentionally not armed

- `lib/features/components/services/v2_placement_writer.dart`
- `test/unit/v2_placement_writer_test.dart`
- project open files
- router files
- schema files
- validator/tool/materializer files
- events / `known_facts.json`
- samples/assets
- `_incoming`

Rationale: the future implementation is a pre-writer UI guard. Live code shows the invalid payload is assembled in Board Canvas before writer call, and widget tests can prove the writer is not invoked for invalid drafts. No writer or validator changes are required to implement that locked behavior.

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

## Canonical bounds recorded

For `coordinate_space: board_normalized`:

- `center_x` must be within `0..1`.
- `center_y` must be within `0..1`.
- `width` must be valid and `<= 1`.
- `height` must be valid and `<= 1`.
- `rotation_deg` must remain normalized to `-180 <= rotation_deg < 180`.

## Future implementation questions recorded

The implementation pass must answer from live code:

1. Where `center_x` / `center_y` / `width` / `height` payload fields are assembled before writer call.
2. Whether invalid bounds should disable `Salvesta` or keep it clickable with guard copy.
3. Whether local preview/draft editing may visually exceed bounds as long as canonical save is guarded.
4. Whether extents should be checked only by payload fields or also by board-edge overhang.
5. What exact Estonian copy replaces raw validator failures.
6. How tests prove writer is not invoked for invalid bounds.

## Future test expectations recorded

Implementation tests should prove:

- `width > 1` blocks `Salvesta` before writer call
- `height > 1` blocks `Salvesta` before writer call
- `center_x < 0` or `center_x > 1` blocks `Salvesta` before writer call
- `center_y < 0` or `center_y > 1` blocks `Salvesta` before writer call
- clear guard copy appears
- writer is not invoked for invalid draft
- valid draft still saves
- valid draft still marks projection stale / refresh-needed
- rotation normalization still works
- Project Open From Directory still works
- draft edits / `Kustuta` / `Tühista` / navigation write nothing
- validator/schema remains unchanged

## Future manual smoke recorded

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

## Route

- Current: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`

## Boundary confirmation

This pass is docs-only. It does not edit runtime, tests, writer files, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- no glued rows / no `||` in `docs/AUDIT_INDEX.md`

## Claude audit packet

Read-only audit requested for this active-lock sync only.

- PASS_ID: `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Expected changed files:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS.md`
- Exact implementation allowlist armed:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Verify route set to `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_ACTIVE_LOCK_SYNC_PASS` -> `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS`.
- Verify docs-only sync; no runtime/test/schema/tool/events/known_facts/_incoming edits.
- Verify validator/schema remains strict and unchanged.
- Verify future implementation guards invalid drafts before writer call.
- Verify no writer/unit-test files are armed without need.
- Do not edit, stage, commit, or push.

Expected verdict format:

```text
AUDIT_VERDICT: ACCEPT_AS_IS / ACCEPT_WITH_NITS / BLOCKED
SAFE_FOR_STAGING: YES / NO
SAFE_STAGING_SET:
BLOCKERS:
NITS:
```