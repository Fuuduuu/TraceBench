# BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS

## Mode

Docs-only product scope revision.

## Baseline verification

Live baseline before this pass:

- `git status --short --branch`: `## main...origin/main` with only known untracked scratch paths; no tracked or cached diff.
- `git log --oneline --decorate -8`: latest commit `120808a` (`docs: close out aborted board canvas components actions implementation`) on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route before this pass: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`.
- `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ABORT_CLOSEOUT_PASS` was present and recorded the rejected navigation-only implementation revert.

## Rejected direction summary

The rejected `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` direction was a navigation-only Board Canvas Komponendid gateway. It attempted primary actions such as:

- "Ava loomine";
- "Ava muutmine";
- "Ava mõõtmine".

That direction routed technicians from Board Canvas toward old standalone pages as the primary Komponendid workflow and was rejected by product decision.

## Revised in-panel product decision

Board Canvas Komponendid should evolve toward contextual in-panel workflows beside/on the board canvas where practical.

Locked intent:

- Board Canvas is the primary technician-facing board/workbench surface.
- Komponendid work should happen beside/on the board canvas where practical.
- The Komponendid panel should become an in-panel mode selector / contextual workflow shell, not a navigation-only gateway.
- Old standalone Add/Edit/Measure pages may remain transitional/backstage routes for now.
- Future primary UX should not route the technician away from Board Canvas just to perform component work.
- No route hiding, screen deletion, writer merge, or implementation is authorized by this pass.

## Canonical split preserved

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

Visual placement must not create component identity. Component identity, metadata, placement, and measurement remain separate canonical writer domains.

## Proposed phased implementation direction

Future work should be split into small slices.

Possible first implementation slice:

- Convert the current read-only Komponendid hub into an in-panel mode selector / contextual panel shell.
- Do not wire new canonical writers unless separately scoped.
- Make `Paiguta` use the existing Board Canvas local placement draft/prefill/save behavior.
- Keep `Uus komponent`, `Muuda andmeid`, and `Mõõda` clearly marked as planned/future in-panel modes or inactive until safely implemented.
- Avoid routing out to legacy standalone pages as the primary behavior.

Possible later slices:

- In-panel component identity creation through `component_created`.
- In-panel component metadata edit through `component_updated`.
- In-panel measurement entry through `measurement_recorded`.
- Route/backstage handling for old standalone Add/Edit/Measure pages.
- Test migration after replacement workflows exist.

## Questions locked by this revision

1. `Komponendid` should become an in-panel mode selector rather than a navigation gateway.
2. First implementation slice should allow `Paiguta` as the first real action because Board Canvas placement workflow already exists.
3. `Uus komponent`, `Muuda andmeid`, and `Mõõda` should be planned/future in-panel modes first unless a later pass explicitly implements them.
4. Copy must prevent users from thinking visual placement creates component identity.
5. Standalone Add/Edit/Measure remain transitional/backstage until explicitly replaced.

## Hard boundaries

Future implementation must not:

- merge Add/Edit/Measure writers into Board Canvas in one pass;
- create a new generic component writer;
- change writer services;
- change event schema;
- change validator/materializer/tools;
- mutate `known_facts.json` directly from Flutter;
- edit `events.jsonl` or `known_facts.json`;
- hide or delete standalone Add/Edit/Measure routes;
- change Project Open From Directory behavior;
- change rotation normalization;
- change projection-stale policy;
- change canonical bounds guard;
- change required-label guard;
- change selected-placement prefill behavior;
- create identity from visual placement;
- create pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored canonical facts from visual drafts;
- implement startup intro or use `_incoming` design handoffs.

## Future implementation surfaces

This pass does not arm an implementation allowlist.

The next active-lock sync must inspect live code and arm exact files.

Likely future first-slice surfaces:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Possible only after later decisions/scope:

- standalone Add Component screen;
- standalone Edit Component screen;
- Measure Sheet screen;
- Project Overview navigation;
- router.

## Future test expectations

Future implementation tests should prove:

- Komponendid panel exposes in-panel mode/shell behavior, not legacy-page navigation as primary UX.
- `Paiguta` mode uses existing Board Canvas placement draft behavior.
- inactive/planned modes are not misleadingly interactive.
- no canonical write occurs merely by switching Komponendid modes.
- `Salvesta` remains explicit placement write trigger for visual placement.
- Add/Edit/Measure standalone routes remain available.
- no writer/event/schema behavior changes.
- renderer/painter remains read-only.

## Route result

Route set to:

- Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS`
- Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- Docs-only pass.
- No runtime files edited.
- No test files edited.
- No tools/schema/events/known_facts files edited.
- No `_incoming` files touched.
- No route hiding or screen deletion authorized.
- No implementation allowlist armed.
- Do not stage, commit, or push.

## Audit status

DRAFTED / PENDING CLAUDE AUDIT