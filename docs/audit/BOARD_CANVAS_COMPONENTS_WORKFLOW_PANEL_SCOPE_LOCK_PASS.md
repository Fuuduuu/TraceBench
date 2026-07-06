# BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS

## Mode

Docs-only product scope-lock.

## Baseline verification

- Branch: `main`
- Latest commit during gate: `58e16d9` (`docs: close out add edit component legacy flow labeling`)
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- `main` aligned with `origin/main`.
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.

## Read-only findings

- Project Overview / Workbench routes to standalone Add Component, standalone Edit Component, Board Canvas, Measure Sheet, Board Graph, and projection/list views.
- Project Overview labels Add Component as `Loo komponent` and Edit Component as `Muuda komponendi andmeid`.
- Board Canvas is labeled as `Board Canvas · visuaalne paigutus` from Project Overview.
- Board Canvas `Lisa` / `Salvesta` confirms visual placement for an existing selected component through `component_visual_placement_confirmed`.
- Standalone Add Component writes `component_created` for explicit human component identity/existence creation.
- Standalone Edit Component writes `component_updated` for explicit human component metadata update.
- Measure Sheet writes `measurement_recorded` and remains the current canonical measurement writer.
- Board Graph remains reachable as advanced/debug projection inspection and must not create canonical facts.
- Widget tests cover these labels, routes, event-role copy, writer calls, and no-write boundaries.

## Product observation

User expectation: component work should happen on or around the Board Canvas, not as scattered standalone pages.

A future right-side/contextual Board Canvas `Komponendid` workflow may become the primary component work surface.

## Locked product intent

- Board Canvas is the primary technician-facing board/workbench surface.
- Component work should be contextual to selected board/component where practical.
- A future Board Canvas `Komponendid` panel may coordinate identity, metadata, visual placement, and component-related measurement entry.
- Standalone Add Component and Edit Component remain transitional canonical writer flows until a V2 replacement exists.
- No route hiding or screen deletion is authorized by this pass.
- No writer semantics change is authorized by this pass.
- No implementation allowlist is armed in this pass.

## Canonical semantic split to preserve

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

## Proposed future `Komponendid` flow map

Board Canvas right panel: `Komponendid`.

Possible sections/actions:

- `Vali komponent`: select or anchor the current component context.
- `Loo komponent`: identity/existence creation through `component_created`.
- `Muuda andmeid`: metadata update through `component_updated`.
- `Paiguta / kinnita visuaalne paigutus`: visual placement confirmation through `component_visual_placement_confirmed`.
- `Mõõda komponenti`: start component-related measurement through measurement flow and `measurement_recorded`.
- `Vaata seotud mõõtmisi`: projection/read-only summary.

Each action must keep its canonical event boundary clear.

## What stays standalone for now

- Standalone Add Component remains available.
- Standalone Edit Component remains available.
- Measure Sheet remains the current canonical measurement writer.
- Board Graph remains advanced/debug projection inspection.
- Project Overview remains the project navigation bridge.
- No routes are hidden or deleted in this pass.

## What may become transitional/backstage later

- Standalone Add Component may become a backstage/transitional identity writer after a Board Canvas V2 identity-creation replacement exists.
- Standalone Edit Component may become a backstage/transitional metadata writer after a Board Canvas V2 metadata-edit replacement exists.
- Measure Sheet may become linked from Board Canvas for component-related measurement starts, but it remains the canonical measurement writer until a later scope changes that.
- Component list/projection views may remain advanced/debug unless a future Board Canvas inspector covers them.

## Future product decision to record before implementation

A later product decision should choose whether Board Canvas `Komponendid` becomes:

- `A`: a navigation hub to existing Add/Edit/Measure flows.
- `B`: a true integrated right-panel workflow.
- `C`: a phased hybrid: first hub/copy, then integrated writer surfaces.
- `D`: not pursued yet.

## Future implementation surfaces to inspect later

The next active-lock sync must inspect live code and arm exact files. Likely surfaces may include:

- Board Canvas screen.
- Project Overview navigation.
- Add/Edit Component screens or adapters.
- Measure Sheet links.
- Related widget tests.

No implementation files are armed by this pass.

## Hard boundaries

Do not change:

- writer services
- event schema
- validator/materializer/tools
- `events.jsonl` / `known_facts.json` semantics
- Project Open From Directory
- rotation normalization
- projection-stale policy
- canonical bounds guard
- measurement writer behavior
- Add/Edit Component writer behavior
- Board Canvas placement writer behavior

Do not create:

- identity from visual placement
- pins/contacts/pads/nets/traces/electrical facts from visual marker drafts
- AI-authored canonical facts

## Route after this pass

- Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS`
- Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- Docs-only pass.
- No runtime files edited.
- No test files edited.
- No tool/schema/materializer/validator/router files edited.
- No events or `known_facts.json` files edited.
- No `_incoming` files touched.
- No route hiding or screen deletion authorized.
- No implementation allowlist armed.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify route is recorded consistently
- verify no runtime/test files changed
- verify no route hiding/deletion authorized
- verify no implementation allowlist armed
