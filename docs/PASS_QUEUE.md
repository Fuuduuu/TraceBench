# Pass Queue

## Current route

Current: `BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS`

## Queue policy

Keep this file to the next 3-5 candidate passes and sequencing rules. Closed history belongs in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`.

Do not route to another docs-only planning pass unless a concrete audit finding or route mismatch requires it.

## Latest closed work

- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_PASS` closed by `962a525 docs: close out board canvas right-panel creation flow`.
- Implementation commit: `4390255c51609396977a16f60b14c2b6bee50d8c feat: add board canvas right-panel component creation`.
- Review status: `NON_CLAUDE_REVIEW: ACCEPTED_RISK`; Claude audit was not supplied for that pass.
- Safe implementation set: `lib/features/board_canvas/screens/board_canvas_screen.dart`, `test/widget/board_canvas_screen_test.dart`.

## Active build-lock

`BOARD_CANVAS_METADATA_EDIT_FLOW_BUILD_LOCK_PASS` arms `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS` directly.

Implementation allowlist armed:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Implementation must keep this as the first Visual First metadata-edit slice:
- Edit metadata for an existing selected component from the Board Canvas right panel.
- Operate on the currently selected `ComponentPlacementSelection.componentId`.
- Use the existing `V2EditComponentWriter` / `v2EditComponentWriterProvider`.
- Write only `component_updated` after explicit human action such as `Salvesta muudatused`.
- Update local `projectState.events` and mark projection stale, matching the existing standalone writer pattern.
- Stay in the Board Canvas right panel; do not route to standalone Edit Component as the primary edit flow.
- Do not create component identity, visual placement, placement edits, pins, contacts, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- Do not directly mutate `known_facts.json` or `projectState.knownFacts`.

Preferred first-slice fields:
- display label / name
- component kind using writer-safe canonical values: `unknown`, `passive`, `ic`, `connector`, `regulator`

Optional if simple and already safely represented:
- reference designator
- package hint

If the implementation needs any file outside the two-file allowlist, stop with `BLOCKED_ALLOWLIST_MISMATCH`.

## Candidate passes

Candidates only; not armed by this build-lock:

1. Fullscreen Exit/Välju affordance.
2. Home lockup refresh.
3. Later right-panel route migration/removal only after replacements and dependency audit.

## Visual First sequencing rule

Normal component work should stay on Board Canvas plus the right-side panel/menu.

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt. Do not duplicate those pages inside Board Canvas and do not route technicians out of Board Canvas as the primary workflow unless a future scoped pass explicitly changes that product rule.

Do not resurrect navigation-only gateway behavior, four-card mode selectors, table/form page transplants, or old workflow menus inside Board Canvas.

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