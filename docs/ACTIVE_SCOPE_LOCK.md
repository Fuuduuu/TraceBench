# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS`

## Current armed implementation pass

`none`

## Type

LANE_B_ADJACENT / DOCS_POST_AUDIT_CLOSEOUT / PROTECTED_UI_BOARD_CANVAS_VIEWPORT_CONTROLS

## Baseline

- Expected and verified HEAD/origin before this closeout: `6762bdc` (`feat(board-canvas): improve fit reset discoverability`).
- Accepted/pushed implementation: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_PASS` at `6762bdc` (`feat(board-canvas): improve fit reset discoverability`).
- Implementation full SHA: `6762bdcb35287b9d7c393d5b2ec9e21e911df2f3`.
- Implementation changed exactly:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- Manual smoke: PASS.
- Review status: `NO_CLAUDE_REVIEW / GPT_PRO_SECONDARY_REVIEW / RETRO_CLAUDE_PENDING`.
- This closeout does not claim Claude audit or Claude acceptance.
- Accepted/pushed route sync: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ROUTE_SYNC_PASS` at `8f45065` (`docs: sync Board Canvas fit reset route`).
- Accepted/pushed active-lock sync: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_ACTIVE_LOCK_SYNC_PASS` at `b2d0a61` (`docs: arm Board Canvas fit reset discoverability`).
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_SCOPE_LOCK_PASS` at `b254d43` (`docs: lock Board Canvas fit reset discoverability`).
- Tracked diff before this closeout: none.
- Cached/staged diff before this closeout: none.
- Known untracked scratch files remain untouched.

## Closeout write allowlist

This docs-only closeout may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS.md`

No runtime, test, schema, tool, asset, sample, platform, generated, or `_incoming` file is authorized in this closeout.

## Released implementation allowlist

The prior implementation allowlist is released:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No new implementation pass is armed.

## Accepted implementation behavior recorded by this closeout

- Board Canvas uses a compact `Sobita` viewport recovery control.
- Fit / Reset discoverability is improved with tooltip `Sobita / taasta vaade`.
- Semantic label/hint for fit/reset recovery is present.
- Existing fit/reset behavior is preserved.
- Existing pan/zoom/fit/reset semantics remain preserved.
- Board Canvas remains read-only.
- `renderer writes: none` remains true.

## Protected boundaries preserved

- No runtime/test edits in this closeout.
- No new implementation pass armed.
- No Claude audit or Claude acceptance claimed.
- No Board Canvas save/write behavior accepted.
- No canonical measurement writing accepted.
- No `v2_save_measurement_writer.dart` import, call, route, or wiring accepted.
- No `events.jsonl` write or `known_facts` mutation accepted.
- No schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, generated, or `_incoming` changes accepted.
- No canonical facts, measurements, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts accepted.
- Project Overview unchanged.
- Measure Sheet route/save path unchanged.
- Add Component local/UI-only behavior preserved.
- Existing tap-to-select, selected-pin persistence, inspector, measurement marker/summary, and rail-label-fit behavior preserved.
- Visual traces and From -> To context remain display/provenance-only and do not become confirmed connectivity.
- `_incoming` HTML/design files are not runtime dependencies and are not canonical repo truth.
- Command menu, context menu, audio/save beep, full redesign, global theme migration, and canvas token migration remain deferred.

## Explicitly forbidden in this closeout

- Editing `lib/`.
- Editing `test/`.
- Editing `tools/`.
- Editing `schemas/`.
- Editing `assets/`.
- Editing `_incoming`.
- Editing runtime, writer, materializer, projection, ZIP, event, fact, schema, sample, platform, or generated files.
- Claiming Claude audit or Claude acceptance.
- Claiming Board Canvas save/write behavior is accepted.
- Claiming canonical measurement writing is accepted.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Broad staging.

## Route

- Current pass: `V2_BOARD_CANVAS_FIT_RESET_DISCOVERABILITY_IMPL_POST_AUDIT_PASS`.
- Current armed implementation pass: `none`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.
- This closeout does not implement runtime behavior.
