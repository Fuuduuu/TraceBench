# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS`

## Current armed implementation pass

None. This is a docs-only scope-lock and does not arm runtime implementation directly.

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_VIEWPORT_CONTROLS

## Baseline

- Expected and verified HEAD/origin before this scope-lock: `1740e8a` (`docs: record Board Canvas rail label fit`).
- Accepted/pushed closeout: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_POST_AUDIT_PASS` at `1740e8a`.
- Closeout full SHA: `1740e8a541cdb9fb03f3d1c0574fb2322d42810f`.
- Accepted/pushed implementation: `V2_BOARD_CANVAS_RAIL_LABEL_FIT_IMPL_PASS` at `e855d5d` (`feat(board-canvas): polish rail label fit`).
- Implementation full SHA: `e855d5d4db8254923cdc1887e6a23b5e29a0c396`.
- Tracked diff before this scope-lock: none.
- Cached/staged diff before this scope-lock: none.
- Known untracked scratch files remain untouched.

## Scope-lock allowlist

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS.md`

No runtime or test implementation is authorized in this scope-lock.

## Future implementation route

- Route after this scope-lock is accepted/pushed: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- That active-lock sync must inspect live repo files before arming any implementation.
- Do not implement runtime behavior directly from this scope-lock.

## Future implementation allowlist to propose

If still sufficient after active-lock sync inspection, future implementation should be limited to:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not allow broad runtime, test, asset, schema, tool, sample, platform, generated, or `_incoming` paths.

## Scope to lock

Future implementation may only improve discoverability of existing Board Canvas Fit / Reset / viewport recovery affordances.

Allowed future behavior direction:

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

## Explicitly forbidden in this scope-lock

- Runtime implementation.
- Editing `lib/`.
- Editing `test/`.
- Editing `tools/`.
- Editing `schemas/`.
- Editing `assets/`.
- Editing `_incoming`.
- Editing runtime, writer, materializer, projection, ZIP, event, fact, schema, or sample files.
- Arming runtime implementation directly.
- Claiming Claude audit or Claude acceptance.
- Claiming Board Canvas save/write behavior is accepted.
- Claiming canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Changing Project Overview.
- Changing Measure Sheet route/save path.
- Changing Add Component canonical behavior.
- Altering pan/zoom/fit/reset semantics beyond discoverability copy or local affordance polish in a later separately armed implementation pass.
- Turning visual traces, labels, or From -> To context into confirmed connectivity.
- Command menu, context menu, audio/save beep, full redesign, global theme migration, or canvas token migration.
- Broad staging.

## Temporary review context

- Claude Code may be unavailable.
- This scope-lock does not claim Claude audit.
- If this pass is accepted without Claude, record temporary mode explicitly as `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- Audit packet status for this draft: `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`.

## Route

- Current pass: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- No runtime implementation is armed by this scope-lock.
