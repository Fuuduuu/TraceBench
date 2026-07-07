# Pass Queue

## Current route

Current: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS`

## Queue policy

Keep this file to the next 3-5 candidate passes and sequencing rules. Closed history belongs in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.

Do not route to another docs-only planning pass unless a concrete audit finding or route mismatch requires it.

## Latest closed work

- `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS` closed by `93ddff1 docs: close out benchbeep fullscreen launch`.
- Implementation commit: `324829e586b40eddd266a2f1d834c02a39ef4aa1` (`feat: launch benchbeep fullscreen`).
- Review status: `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; Claude audit skipped/unavailable.

## Active build-lock

`BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_BUILD_LOCK_PASS` arms `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` directly.

Implementation allowlist armed:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Implementation must keep this as the first Visual First identity-creation slice:
- Add compact right-panel component identity creation.
- Use the existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- Write only `component_created` after explicit human action.
- Update local `projectState.events` and mark projection stale, matching the existing standalone writer pattern.
- Do not route to the standalone Add Component page as the primary creation flow.
- Do not create visual placement or any pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.

If the implementation needs any file outside the two-file allowlist, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Candidate passes

Candidates only; not armed by this build-lock:

1. Fullscreen Exit/Välju affordance.
2. Board Canvas metadata edit flow.
3. Home lockup refresh.

## Visual First sequencing rule

Normal component work should stay on Board Canvas plus the right-side panel/menu.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

## Canonical split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Safety reminders

- User stages, commits, and pushes manually.
- Never broad-stage.
- `_incoming` is design/provenance input only, never runtime truth.
- Protected surfaces require their own scope lock.
