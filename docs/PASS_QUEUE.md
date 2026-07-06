# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS

## Next recommended pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS

## Route status

Scope-lock the next Board Canvas `Komponendid` hub step as a safe navigation/action gateway.

This pass is docs-only. It does not implement runtime behavior, does not arm an implementation allowlist, does not hide or delete routes, and does not merge writer semantics.

## Scope gate rules

- One narrow pass at a time.
- Repo docs and verified git state outrank prompt handoff text.
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` must agree before implementation.
- Protected surfaces require a dedicated scope-lock before implementation.
- Do not stage, commit, or push unless the user explicitly asks.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Board Canvas Komponendid workflow actions scope-lock

Current state:

- Board Canvas already contains a read-only `Komponendid` hub in the `Lisa` / Add Component panel.
- The hub explains four domains: identity creation, metadata edit, visual placement confirmation, and measurement recording.
- Existing standalone Add/Edit Component routes remain the canonical component identity/metadata writer flows.
- Existing Board Canvas `Lisa` / `Salvesta` remains the visual placement confirmation flow.
- Existing Measure Sheet remains the measurement writer flow.

Locked product decision:

- The next implementation should be navigation/action-gateway first, not an integrated in-panel writer replacement.
- `Loo komponent` should route to the existing standalone Add Component identity flow if implemented.
- `Muuda andmeid` should route to the existing standalone Edit Component metadata flow if implemented.
- `Paiguta` should activate or focus the existing Board Canvas placement panel behavior rather than create a new writer path.
- `Mõõda komponenti` may route to Measure Sheet only if active-lock sync confirms that direct navigation is safe without context propagation; otherwise it remains informational/future.

Boundaries for the future implementation:

- No writer contract changes.
- No schema/tool/materializer/validator changes.
- No events.jsonl / known_facts.json semantic changes.
- No component identity creation from visual placement.
- No pins/contacts/pads/nets/electrical facts from visual marker drafts.
- No AI-authored canonical facts.
- No route hiding/deletion in the scope-lock.

## Planned follow-up sequence

1. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS` - current docs-only product scope-lock.
2. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS` - read live code and arm an exact implementation allowlist.
3. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_PASS` - if approved, implement the smallest safe action-gateway behavior.
4. `BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_POST_AUDIT_PASS` - close out after audit and push.

## Recent accepted context

| Pass | Status | Notes |
|---|---|---|
| `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_POST_AUDIT_PASS` | closed | Selected placement context/prefill closed out and route released. |
| `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_POST_AUDIT_PASS` | closed | Read-only `Komponendid` hub added and recorded. |
| `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_POST_AUDIT_PASS` | closed | Standalone Add/Edit flow labels clarified as identity/metadata flows. |
| `BOARD_GRAPH_LEGACY_ROUTE_IMPL_POST_AUDIT_PASS` | closed | Board Graph labeled as advanced/debug projection inspection. |

## Current-state maintenance trigger

Update `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` together when the route changes.

Update `docs/AUDIT_INDEX.md` and create a focused `docs/audit/*.md` artifact for each route-changing pass.