# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Current armed implementation pass

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS`

## Type

LANE_B_ADJACENT / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_BOARD_CANVAS_VIEWPORT_CONTROLS

## Baseline

- Expected and verified HEAD/origin before this active-lock sync: `b254d43` (`docs: lock Board Canvas fit reset discoverability`).
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS` at `b254d43`.
- Scope-lock full SHA: `b254d437e8577bf5cbfd649b4a92dc99893f0fb5`.
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_POST_AUDIT_PASS` at `1740e8a` (`docs: record Board Canvas rail label fit`).
- Prior closeout full SHA: `1740e8a541cdb9fb03f3d1c0574fb2322d42810f`.
- Prior accepted/pushed implementation: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS` at `e855d5d` (`feat(board-canvas): polish rail label fit`).
- Prior implementation full SHA: `e855d5d4db8254923cdc1887e6a23b5e29a0c396`.
- Tracked diff before this active-lock sync: none.
- Cached/staged diff before this active-lock sync: none.
- Known untracked scratch files remain untouched.

## Active-lock sync allowlist

This docs-only active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

No runtime or test implementation is authorized in this active-lock sync.

## Future implementation allowlist

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS` may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other runtime, test, docs, asset, schema, tool, sample, platform, generated, or `_incoming` file is authorized for the future implementation pass.

## Implementation goal to arm

The future implementation may only improve discoverability of existing Board Canvas Fit / Reset / viewport recovery affordances.

Allowed future implementation behavior:

- Make existing Fit / Reset / viewport recovery controls easier to notice or understand.
- Preserve compact dark EDA-style Board Canvas UI.
- Preserve existing pan/zoom/fit/reset semantics.
- Use tooltip, semantic, or concise help copy where useful.
- Keep the change local to Board Canvas UI polish.
- Avoid full redesign or new workflow.
- Add or update focused Board Canvas widget tests for UI structure, tooltip/semantic copy, and preserved no-write boundaries.

## Protected boundaries to preserve

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- Existing pan/zoom/fit/reset semantics remain preserved.
- Existing tap-to-select behavior remains preserved.
- Existing selected-pin persistence remains preserved.
- Existing inspector behavior remains preserved.
- Existing measurement marker/summary behavior remains preserved.
- Existing Add Component local/UI-only behavior remains preserved.
- Existing Measure Sheet route/save path remains preserved.
- Existing Project Overview behavior remains preserved.
- Existing rail label fit behavior remains preserved.
- `_incoming` remains design/reference input only and is not runtime truth.
- BenchBeep / TraceBench / BoardFact naming boundaries remain preserved.
- No Board Canvas save/write behavior.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring.
- No `events.jsonl` writes.
- No `known_facts` mutation.
- No canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- No schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, or generated-file changes.

## Explicitly forbidden in this active-lock sync

- Runtime implementation.
- Editing `lib/`.
- Editing `test/`.
- Editing `tools/`.
- Editing `schemas/`.
- Editing `assets/`.
- Editing `_incoming`.
- Editing runtime, writer, materializer, projection, ZIP, event, fact, schema, or sample files.
- Claiming future implementation is complete.
- Claiming Claude audit or Claude acceptance.
- Claiming Board Canvas save/write behavior is accepted.
- Claiming canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Changing Project Overview.
- Changing Measure Sheet route/save path.
- Changing Add Component canonical behavior.
- Altering pan/zoom/fit/reset semantics beyond discoverability copy or local affordance polish in the separately armed implementation pass.
- Turning visual traces, labels, or From -> To context into confirmed connectivity.
- Command menu, context menu, audio/save beep, full redesign, global theme migration, or canvas token migration.
- Broad staging.

## Temporary review context

- Claude Code may be unavailable.
- This active-lock sync does not claim Claude audit.
- If this pass is accepted without Claude, record temporary mode explicitly as `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Audit packet status for this draft: `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`.

## Route

- Current pass: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current armed implementation pass: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS`.
- This active-lock sync does not implement runtime behavior.
