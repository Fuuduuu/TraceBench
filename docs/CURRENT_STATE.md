# Current State

## Current pass

`V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`

## Next recommended pass

`NEEDS_USER_DECISION`

## Current product state

- Workbench Home status-strip/action polish is implemented and accepted (current UI state is in a docs-only accepted state).
- `Lisa mõõtmine` and overview flow still route through V2 measure-sheet path.
- `/project/measurements/new` remains the compatibility redirect to `/project/measure-sheet`.
- No runtime/event/model/validator/materializer/writer/schema changes are introduced in this compaction pass.
- `test(board-canvas): verify read-only renderer shell` (`68f7985`) closed out the verification of the read-only Board Canvas renderer and confirmed that the renderer shell already existed from `87eae78 feat(board-canvas): polish read-only visual rendering`.
- `V2_BOARD_CANVAS_READONLY_RENDERER_PASS` is closed out as a no-runtime-change verification pass with zero-event regression coverage.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS` is closed out as docs-only scope-lock.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS` is closed out and handed off to `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS` added read-only pan/zoom/fit view-transform to the existing Board Canvas projection renderer and is now closed out.

## Accepted recent governance state

- `V2_WORKBENCH_HOME_STATUS_STRIP_AND_BUTTON_POLISH_PASS`, `_CLOSEOUT_PASS`, and `V2_SAVE_MEASUREMENT_EXPLICIT_TARGET_SELECTION_*` are accepted/pushed; non-sequence boundaries remain.
- `V2_LEGACY_MEASUREMENT_WRITE_PATH_RETIREMENT_*` smoke and closeout are accepted (manual smoke was `PASS_WITH_ENVIRONMENT_LIMITATION`).
- `V2_PROJECT_OVERVIEW_PCB_FIRST_SHELL_PASS` and Workbench Home shell/visual tracks are accepted and compacted into read-only references.
- Governance-ledger hygiene is accepted and closed out in commit `20e80d3` (`docs: clean governance ledger statuses`).
- Legacy per-route route narrative no longer lives in live-state narrative.

## Deferred work

- `V2_BOARD_CANVAS_READONLY_RENDERER_SCOPE_LOCK_CLOSEOUT_PASS` is closed out.
- `V2_BOARD_CANVAS_READONLY_RENDERER_CLOSEOUT_PASS` is now closed out.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS` is now closed out, and route moved to `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS`.
- No write/event/model/schema/renderer behavior changes have been started outside this pass scope.

## Core boundaries

- `events.jsonl` is canonical truth; `known_facts.json` is projection cache.
- AI is not a source of canonical facts.
- Photo pixels are not facts.
- `sequence` must not be added to V2 events.
- No protected surface changes are made by this pass.
- Audit routing is controlled via route docs and the active scope lock.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS` is docs-only and does not permit runtime mutation.

## Pointers

- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
