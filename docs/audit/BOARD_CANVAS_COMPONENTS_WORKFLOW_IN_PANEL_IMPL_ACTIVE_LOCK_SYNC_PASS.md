# BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode
Docs-only active-lock sync.

## Result
Armed `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS` with an exact Board Canvas-only implementation allowlist.

## Baseline verification
Verified before editing:
- `git status --short --branch`: `## main...origin/main`; tracked/cached diff clean, known untracked scratch only.
- `git log --oneline --decorate -8`: latest commit `bf689c9 docs: revise board canvas components workflow toward in-panel scope` on `main`, aligned with `origin/main`.
- `git diff --name-status`: clean.
- `git diff --cached --name-status`: clean.
- `git diff --check`: clean.
- Route docs showed `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS -> BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`.

## Live-code findings
Live-code inspection found:
- The current Komponendid hub is already rendered inside Board Canvas in `lib/features/board_canvas/screens/board_canvas_screen.dart` as `_ComponentWorkflowHubCard` within `_AddComponentTemplateListPanel`.
- Current Board Canvas widget tests already cover the Komponendid hub and placement-panel behavior in `test/widget/board_canvas_screen_test.dart`.
- Existing placement save/prefill/guard behavior is already in Board Canvas and its widget tests.
- No router, Project Overview, standalone Add/Edit Component, Measure Sheet, writer, schema, tool, materializer, validator, events, known_facts, project open, sample/asset, or `_incoming` file is required for the first in-panel shell slice.

## Exact implementation allowlist armed
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS` may edit only:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Product labels locked
Preferred Board Canvas in-panel labels:
- `Uus komponent`
- `Muuda andmeid`
- `Paiguta`
- `Mõõda`

Rejected as primary Komponendid action labels:
- `Ava loomine`
- `Ava muutmine`
- `Ava mõõtmine`

## Implementation-shape decision
The next implementation pass should be an in-panel shell/mode selector, not a navigation gateway.

A partial/informational first slice is acceptable. `Paiguta` may remain the only active real workflow if it can safely reuse existing selected-placement draft/save behavior. `Uus komponent`, `Muuda andmeid`, and `Mõõda` must remain planned/inactive/local-only unless they can be supported within the exact allowlist without forbidden surface changes.

## Forbidden surfaces
The future implementation must not edit:
- router/navigation files
- Project Overview files
- standalone Add Component or Edit Component screens
- Measure Sheet files
- writer services
- schemas
- validator/materializer/tools
- events.jsonl / known_facts.json
- project open files
- samples/assets
- `_incoming`

The future implementation must not create component identity from visual placement, pins/contacts/pads/nets/traces/electrical facts, measurements from the panel shell, AI-authored canonical facts, repair conclusions, or new canonical write paths beyond the existing explicit placement save.

## Test requirements recorded
The implementation should update only Board Canvas widget tests as needed to prove:
- Komponendid panel remains in Board Canvas.
- `Uus komponent`, `Muuda andmeid`, `Paiguta`, and `Mõõda` are visible as in-panel workflow labels.
- Rejected `Ava ...` navigation labels are not primary action copy.
- No route push/navigation is introduced by the panel shell.
- Planned/inactive modes do not write canonical events.
- Existing placement save flow still works through `Salvesta`.
- Existing draft/edit/cancel/discard/navigation no-write boundaries remain intact.

## Route state after sync
Current: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

Next: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Changed files
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Audit status
DRAFTED / PENDING CLAUDE AUDIT

## Boundary confirmation
Docs-only sync. No runtime, tests, router, writer, schema, tool, materializer, validator, events, known_facts, project open, sample/asset, or `_incoming` files changed.
