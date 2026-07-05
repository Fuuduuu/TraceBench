# ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS

## Mode

Docs-only scope-lock.

## Baseline verification

- Branch: `main`
- Latest commit during gate: `b7650cd` (`docs: close out board graph legacy route implementation`)
- Tracked diff before this pass: clean.
- Cached diff before this pass: clean.
- `main` aligned with `origin/main`.
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.

## Source context

- `LEGACY_SURFACE_CLASSIFICATION_DOCS_PASS` classifies standalone Add Component and Edit Component as `KEEP_BUT_RESKIN_LATER` transitional canonical writer flows.
- `BOARD_GRAPH_LEGACY_ROUTE_IMPL_POST_AUDIT_PASS` closed out the prior Board Graph route role implementation and released route to `NEEDS_USER_DECISION`.
- Placement writer closeouts establish that Board Canvas `Lisa` / `Salvesta` confirms visual placement for an already selected existing component.

## Live-code findings

- Project Overview exposes an Add Component action with `overview-add-component-button` routing to `/project/components/add`.
- Project Overview exposes an Edit Component action with `overview-edit-component-button` routing to `/project/components/edit`.
- Standalone Add Component currently uses `Lisa komponent` copy and records `component_created`.
- Standalone Add Component helper copy says it creates `component_created` only after explicit human action.
- Standalone Edit Component currently uses `Muuda komponenti` copy and records `component_updated`.
- Standalone Edit Component helper copy says it records `component_updated` after explicit human action.
- Board Canvas currently uses `Lisa komponent` / `Salvesta` copy for selected-component visual placement confirmation.
- Widget tests exist for Project Overview, Add Component, Edit Component, and Board Canvas label/event-role expectations.

## Locked product intent

- Keep standalone Add Component and Edit Component for now as transitional canonical writer flows.
- Do not delete, hide, merge, or replace them in this pass.
- Standalone Add Component should be described as component identity/existence creation.
- Standalone Edit Component should be described as component metadata editing.
- Board Canvas `Lisa` should be described as visual placement/template confirmation for an existing component.
- Future copy should distinguish identity, metadata, and visual placement.
- Future visual reskin/V2 alignment may happen later, but is not part of this pass.

## Canonical semantic split

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement/documentation confirmation.

## Possible future copy direction

Exact wording is deferred to implementation.

Standalone Add Component examples:

- `Loo komponent`
- `Loo komponendi identiteet`
- `Lisa uus komponent projekti faktidesse.`

Standalone Edit Component examples:

- `Muuda komponendi andmeid`
- `Muuda metadata`
- `Uuenda olemasoleva komponendi nime, tüüpi või paketiinfot.`

Board Canvas `Lisa` examples:

- `Kinnita visuaalne paigutus`
- `Lisa/vali paigutuse kuju`
- `Salvesta olemasoleva komponendi visuaalne paigutus.`

## Future implementation questions

The next active-lock sync must inspect live code and decide:

- where Project Overview action labels are defined
- where standalone Add Component title/helper/safety copy is defined
- where standalone Edit Component title/helper/safety copy is defined
- whether Board Canvas `Lisa` wording should be touched in the same implementation or only referenced
- which widget tests assert the current labels
- whether copy updates can happen without router or writer changes

## Future implementation boundaries

Future implementation may update:

- Project Overview action rail labels
- standalone Add Component title/helper/safety copy
- standalone Edit Component title/helper/safety copy
- Board Canvas `Lisa` wording only if separately armed and needed for comparison clarity
- related widget tests

Future implementation must not:

- change router paths
- change writer services
- change event schema
- change validator/materializer/tools
- change `events.jsonl` semantics
- change `known_facts.json` semantics
- change Board Canvas placement writer behavior
- change measurement writer behavior
- change Project Open From Directory behavior
- merge Add/Edit with Board Canvas
- hide routes
- delete screens
- remove tests

## Future implementation surfaces

Not armed by this pass. The next active-lock sync must read live code and arm exact files.

Likely surfaces to verify:

- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/components/screens/add_component_screen.dart`
- `lib/features/components/screens/edit_component_screen.dart`
- `test/widget/project_overview_screen_test.dart`
- `test/widget/add_component_screen_test.dart`
- `test/widget/edit_component_screen_test.dart`

## Route after this pass

- Current: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS`
- Next: `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- Docs-only pass.
- No runtime files edited.
- No test files edited.
- No tool/schema/materializer/validator/router files edited.
- No events or `known_facts.json` files edited.
- No `_incoming` files touched.
- No route hiding or screen deletion authorized.
- No implementation allowlist armed yet.

## Validation requested

- `python tools/validate_all.py`
- `git diff --check`
- verify no glued rows / no `||` in `docs/AUDIT_INDEX.md`
- verify route is recorded consistently
- verify no runtime/test files changed
