# BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS

## Mode

Docs-only build-lock.

No runtime/test edits. No stage/commit/push.

## Charter guard

`docs/POHIKIRI.md` is tracked and remains the first-read product charter / scope anchor.

If the task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Gate result

Gate passed from live repo evidence:

- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- No active implementation lock was armed.
- Tracked diff was clean before this docs pass.
- Cached diff was clean before this docs pass.
- `docs/POHIKIRI.md` was tracked and identified as the canonical first-read charter.
- Board Canvas right-panel component identity creation closeout was present in live repo history.
- Board Canvas right-panel metadata edit closeout was present in live repo history.

Known untracked scratch remained unscoped and was not staged.

## Live-code findings

Read-only inspection found:

- `MeasureSheetScreen` remains the current canonical measurement writer UI surface.
- Existing V2 measurement writer ownership is `lib/features/measure_sheet/services/v2_save_measurement_writer.dart`.
- Existing V2 writer tests cover `measurement_recorded` behavior.
- Board Canvas currently owns the right-panel work surface where the first measurement-entry slice can be added.
- Existing Board Canvas tests include boundaries around measurement writer imports; the future implementation may update those tests because this lock explicitly scopes Board Canvas measurement entry.
- Legacy `lib/shared/event_write/measurement_event_writer.dart` exists but is not the preferred future Board Canvas V2 writer path.

## Scope lock summary

This pass locks the first narrow Board Canvas right-panel measurement entry flow.

The next implementation pass should:

- keep the technician in Board Canvas / right panel
- let the technician work from selected board / component / pin / point context where available
- collect Koht -> Väärtus -> Ühik -> Salvesta
- save only through explicit human action: `Salvesta`
- use the existing human-confirmed measurement writer/provider path where possible
- emit only `measurement_recorded`
- mark any UI state truthfully without directly mutating projection/cache files

## Armed implementation pass

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Exact implementation allowlist

The future implementation may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Existing measurement writer/provider use is import/call only. The measurement writer service file is not armed for edits.

## Boundaries

The future implementation must not:

- edit writer services unless a later lock explicitly arms them
- edit schema, validator, materializer, tools, router, model, standalone screens, events, known_facts, assets, or `_incoming`
- delete or hide standalone Measure Sheet
- directly mutate `known_facts.json`
- directly mutate projection/cache as canonical truth
- create component identity, placement, pins, contacts, pads, nets, traces, electrical facts, measurements outside the `measurement_recorded` writer path, AI facts, or repair conclusions
- make AI/photo/visual-trace output canonical
- treat visual trace as electrical net

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if implementation needs files outside the armed allowlist.

## Route after this pass

Current: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Safe staging set

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS.md`

## Review status

DRAFTED / PENDING REVIEW.