# Pass Queue

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Queue policy

Keep this file to the next 3-5 candidate passes and sequencing rules. Closed history belongs in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.

Do not route to another docs-only planning pass unless a concrete audit finding or route mismatch requires it.

## Latest closed work

- `BENCHBEEP_FULLSCREEN_WINDOW_MANAGER_IMPL_PASS` closed by `93ddff1 docs: close out benchbeep fullscreen launch`.
- Implementation commit: `324829e586b40eddd266a2f1d834c02a39ef4aa1` (`feat: launch benchbeep fullscreen`).
- Review status: `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; Claude audit skipped/unavailable.

## Candidate passes

Candidates only; none is armed as active route.

1. Fullscreen Exit/Välju affordance.
   - Add an explicit exit/leave-fullscreen path so Windows manual smoke does not rely on Alt+F4.
2. Board Canvas right-panel component creation flow.
   - Move component identity creation toward the Visual First right-panel workflow.
3. Board Canvas metadata edit flow.
   - Move component metadata editing toward the Visual First right-panel workflow.
4. Home lockup refresh.
   - Polish launcher/wordmark presentation without touching canonical data behavior.

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