# Pass Queue

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Queue policy

Keep this file to the next 3-5 candidate passes and sequencing rules. Closed history belongs in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.

Do not route to another docs-only planning pass unless a concrete audit finding or route mismatch requires it.

## Latest closed work

- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` closed by `4390255c51609396977a16f60b14c2b6bee50d8c feat: add board canvas right-panel component creation`.
- Closeout pass: `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_POST_AUDIT_PASS`.
- Review status: `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; Claude audit was not supplied for this pass.
- Reviewer path: GPT/Pro review plus local validation plus manual smoke plus user-approved push.
- GPT/Pro verdict before staging: `ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`.
- Safe implementation set: `lib/features/board_canvas/screens/board_canvas_screen.dart`, `test/widget/board_canvas_screen_test.dart`.

Implementation behavior recorded:
- Board Canvas right-panel now has compact component identity creation.
- Creation uses existing `V2AddComponentWriter` / `v2AddComponentWriterProvider`.
- Creation writes only `component_created` after explicit human action via `Loo komponent`.
- Successful create appends returned event to local `projectState.events` if not already present and marks projection stale.
- Flow stays in Board Canvas right panel and does not route to the standalone Add Component page.
- Flow does not create visual placement, place a component on canvas, or create pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Visible rich labels map only to canonical writer-safe `componentKind` values: `unknown`, `passive`, `ic`, `connector`, `regulator`.
- Duplicate component ID validation failures show friendly Estonian copy instead of raw validator/Python details.

## Candidate passes

Candidates only; not armed:

1. Board Canvas metadata edit flow.
2. Fullscreen Exit/Välju affordance.
3. Home lockup refresh.
4. Later right-panel route migration/removal only after replacements and dependency audit.

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