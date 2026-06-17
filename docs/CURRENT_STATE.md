# Current State

## Current pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`

## Current product state

- Workbench Home status-strip/action polish is implemented and accepted (current UI state is in a docs-only accepted state).
- `Lisa mõõtmine` and overview flow still route through V2 measure-sheet path.
- `/project/measurements/new` remains the compatibility redirect to `/project/measure-sheet`.
- No writer/schema/materializer/validator/projection-model changes were introduced by the accepted tap-to-select implementation.
- `test(board-canvas): verify read-only renderer shell` (`68f7985`) closed out the verification of the read-only Board Canvas renderer and confirmed that the renderer shell already existed from `87eae78 feat(board-canvas): polish read-only visual rendering`.
- `V2_BOARD_CANVAS_READONLY_RENDERER_PASS` is closed out as a no-runtime-change verification pass with zero-event regression coverage.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_PASS` is closed out as docs-only scope-lock.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_SCOPE_LOCK_CLOSEOUT_PASS` is closed out and handed off to `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS`.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_PASS` added read-only pan/zoom/fit view-transform to the existing Board Canvas projection renderer and is now closed out.
- `V2_BOARD_CANVAS_PAN_ZOOM_FIT_CLOSEOUT_PASS` is now closed out.
- `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS` is now closed out and routed to this implementation pass.
- `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS` implementation is accepted, audited, committed, and pushed.
- `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_PASS` is completed (test-only, runtime-untouched regression hardening, accepted/pushed and post-audit `ACCEPT_AS_IS`).
- `V2_BOARD_CANVAS_QA_REGRESSION_POLISH_CLOSEOUT_PASS` is accepted/pushed and moved to stable status.
- `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_SCOPE_LOCK_PASS` completed the narrow docs-only scope lock for the inspector-only count visibility polish.
- `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_IMPL_PASS` is implemented, audited, accepted, committed, and pushed as `67e877f` (`feat(board-canvas): polish selection inspector measurement count`). The accepted inspector-only polish shows selected component related-measurement count and safety context while keeping measurement values/details in the measurement summary card.
- `V2_BOARD_CANVAS_SELECTION_INSPECTOR_POLISH_CLOSEOUT_PASS` is accepted/pushed as `3d66879` (`docs: close out board canvas selection inspector polish`) and returned the route to `NEEDS_USER_DECISION`.
- `V2_BOARD_CANVAS_TAP_TO_SELECT_SCOPE_LOCK_PASS` is accepted/pushed in `bbc51c1` (`docs: lock board canvas tap to select`).
- `V2_BOARD_CANVAS_TAP_TO_SELECT_IMPL_PASS` is implemented, audited, accepted, committed, and pushed as `3e61d48` (`feat(board-canvas): add tap to select`); tapping/clicking an already-rendered board-normalized placement updates only volatile Board Canvas selection state, equivalent to choosing the existing placement selector chip.
- `V2_BOARD_CANVAS_TAP_TO_SELECT_CLOSEOUT_PASS` is accepted/pushed as `5a34980` (`docs: add tap to select closeout audit`) and returned the queue to `NEEDS_USER_DECISION`.
- `V2_BOARD_CANVAS_INTERACTION_SMOKE_PASS` is completed and pushed as `2d18a39` (`docs: record board canvas interaction smoke pass with nits`). The first manual smoke attempt was `PARTIAL / BLOCKED_NO_PLACEMENTS`; rerun with `board_canvas_positive_smoke` is recorded as `PASS_WITH_NITS`. Confirmed observations include one rendered board-normalized `SMP001` placement, selector/inspector visibility, measurement badge/safety copy, measurement `M1001`, read-only visual trace metadata, photo-alignment readiness metadata, and persistent `renderer writes: none`. Remaining limitations: single-placement sample did not validate multi-placement switching; fit/reset was not found or validated; post-fit tap alignment was not validated.
- `V2_BOARD_CANVAS_LAYOUT_DENSITY_SCOPE_LOCK_PASS` is the current docs-only scope lock. It replaces the uncommitted narrower fit/reset draft with a broader layout-density lock using accepted Variant B / persistent slim rails direction: Board Canvas and Project Overview board/workspace surfaces should become dominant, selector/legend/safety/inspector chrome should become compact but usable, and safety/evidence copy must remain accessible by click/tap/keyboard. Future implementation target: `V2_BOARD_CANVAS_LAYOUT_DENSITY_IMPL_PASS`.

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
- `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS` is closed out and routed to `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_PASS`.
- No write/event/model/schema/renderer behavior changes are being introduced outside this pass scope.

## Core boundaries

- `events.jsonl` is canonical truth; `known_facts.json` is projection cache.
- AI is not a source of canonical facts.
- Photo pixels are not facts.
- `sequence` must not be added to V2 events.
- No protected surface changes are made by this pass.
- Audit routing is controlled via route docs and the active scope lock.
- `V2_BOARD_CANVAS_MEASUREMENT_MARKERS_SCOPE_LOCK_PASS` is docs-only and did not permit runtime mutation.
- Component-level measurement badges mean “component has related measurement(s)” only.

## Pointers

- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
