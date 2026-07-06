# Current State

## Current pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

## Route status
Docs-only active-lock sync is arming the first implementation slice for the Board Canvas in-panel Komponendid workflow.

Baseline verified from live git/docs:
- Latest pushed scope-revision commit: `bf689c9 docs: revise board canvas components workflow toward in-panel scope`
- Prior route before this sync: `BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_SCOPE_REVISION_PASS -> BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Main is aligned with `origin/main`.
- Tracked diff and cached diff were clean before this sync.

This sync does not implement runtime UI. It records the exact future implementation allowlist and route.

## Implementation pass armed
`BOARD_CANVAS_COMPONENTS_WORKFLOW_IN_PANEL_IMPL_PASS`

Exact allowlist for that implementation pass:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Live-code inspection found the current Komponendid hub is already rendered inside Board Canvas (`_ComponentWorkflowHubCard` within `_AddComponentTemplateListPanel`) and covered by Board Canvas widget tests. The first in-panel implementation slice therefore stays in Board Canvas only.

## Product decision for armed implementation
Board Canvas should evolve the existing read-only Komponendid hub into an in-panel workflow shell/mode selector, not a navigation gateway to old standalone pages.

Preferred Board Canvas in-panel labels:
- `Uus komponent`
- `Muuda andmeid`
- `Paiguta`
- `Mõõda`

Rejected as primary Komponendid UX:
- `Ava loomine`
- `Ava muutmine`
- `Ava mõõtmine`

Implementation shape:
- in-panel shell/mode selector
- partial/informational first slice is acceptable
- `Paiguta` may remain the only active real workflow if it can safely reuse the existing placement draft/save behavior
- `Uus komponent`, `Muuda andmeid`, and `Mõõda` must stay planned/inactive/local-only unless supportable inside the allowlist without forbidden surface changes

## Boundaries
The future implementation must not:
- route users out to standalone Add/Edit/Measure pages as the primary Komponendid action
- edit router, Project Overview, standalone Add/Edit Component screens, Measure Sheet, writer services, schemas, tools, materializer, validator, events, known_facts, project open files, samples/assets, or `_incoming`
- create component identity from visual placement
- create pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions from this panel
- add new canonical write paths beyond the existing explicit `Salvesta` placement confirmation path

## Current known stable behavior
- Board Canvas is the primary technician-facing board/workbench surface.
- Existing placement prefill/save behavior remains separately accepted.
- `Salvesta` remains the only canonical placement write trigger in the Board Canvas placement panel.
- Writer/schema/event semantics remain unchanged in this sync.
- No runtime or test files are changed by this sync.
