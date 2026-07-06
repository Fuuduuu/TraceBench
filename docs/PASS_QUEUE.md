# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

Docs-only product scope revision is active.

This pass supersedes the rejected navigation-only Komponendid gateway direction from `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS` / `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS`.

## Rejected direction recorded

The rejected implementation direction sent the technician from the Board Canvas Komponendid hub to old standalone pages through actions such as:

- "Ava loomine"
- "Ava muutmine"
- "Ava mõõtmine"

The implementation was reverted before staging and closed out in `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS`.

## Revised product decision

Board Canvas Komponendid should become an in-panel mode selector / contextual workflow shell, not a primary navigation gateway to legacy standalone pages.

Preserve the canonical writer split:

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Proposed phased implementation direction

Future implementation should be split into small slices.

Likely first slice:

- Convert the current read-only Komponendid hub into an in-panel mode selector / contextual panel shell.
- Keep `Paiguta` connected to the existing Board Canvas local placement draft/prefill/save behavior.
- Keep `Uus komponent`, `Muuda andmeid`, and `Mõõda` visibly planned/future in-panel modes unless separately and safely implemented.
- Do not wire new canonical writers in the first slice unless separately scoped.
- Do not route users out to legacy standalone pages as the primary Komponendid UX.

Possible later slices:

- In-panel component identity creation.
- In-panel component metadata edit.
- In-panel component-related measurement entry.
- Backstage/transitional handling for old standalone Add/Edit/Measure routes.
- Test migration once replacement workflows exist.

## Hard boundaries

Future implementation must not:

- merge Add/Edit/Measure writers into Board Canvas in one pass;
- create a generic component writer;
- change writer services, event schema, validator/materializer/tools, `events.jsonl`, or `known_facts.json` semantics;
- mutate `known_facts.json` directly from Flutter;
- hide or delete standalone Add/Edit/Measure routes;
- change Project Open From Directory, rotation normalization, projection-stale policy, canonical-bounds guard, required-label guard, or selected-placement prefill behavior;
- create identity from visual placement;
- create pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored canonical facts from visual drafts;
- implement startup intro or use `_incoming` design handoffs.

## Active-lock sync expectation

The next pass must be docs-only active-lock sync. It must inspect live code and arm exact implementation files. Likely first-slice surfaces are only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not arm implementation files in this scope revision pass.

## Scope gate rules

- One pass at a time.
- Repo docs and verified git state outrank chat handoff text.
- Runtime/test/schema/tool/event/fact changes require an active lock that names the exact files.
- Protected surfaces require a dedicated protected-surface scope-lock before implementation.
- Do not stage, commit, or push unless explicitly requested.

## Current-state maintenance trigger

Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, `docs/AUDIT_INDEX.md`, and the relevant `docs/audit/*.md` artifact together when a pass changes route state or audit state.

## Recent routing provenance

| Pass | Result | Notes |
|---|---|---|
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS` | pushed closeout | Rejected navigation-only implementation was reverted and route returned to `NEEDS_USER_DECISION`. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS` | current scope revision | Supersedes navigation-only gateway direction with in-panel Board Canvas workflow direction. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS` | next recommended | Must inspect live code and arm exact files before implementation. |