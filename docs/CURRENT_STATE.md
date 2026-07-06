# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_SCOPE_LOCK_PASS

## Next recommended pass

BOARD_CANVAS_COMPONENTS_WORKFLOW_ACTIONS_IMPL_ACTIVE_LOCK_SYNC_PASS

## Route status

Docs-only product scope-lock is active for the next Board Canvas `Komponendid` hub step.

This pass does not implement runtime behavior, does not arm an implementation allowlist, and does not hide or delete any routes/screens. It records the product decision for turning the existing read-only `Komponendid` hub into a safe action gateway later.

## Latest accepted baseline

Latest closed route before this pass: `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_POST_AUDIT_PASS`.

Live pushed baseline verified before this scope-lock:

- `e385c37 docs: close out selected placement edit prefill`
- Route before this pass: `NEEDS_USER_DECISION -> NEEDS_USER_DECISION`
- Active implementation allowlist before this pass: none

## Current scope summary

Board Canvas is the primary technician-facing board/workbench surface.

The current Board Canvas `Komponendid` hub is display-only and explains four write domains:

- `component_created` = component identity/existence creation
- `component_updated` = component metadata update
- `component_visual_placement_confirmed` = visual placement confirmation
- `measurement_recorded` = measurement write

Locked direction for the next implementation track:

- Use the hub as a navigation/action gateway first, not as an integrated writer panel.
- `Loo komponent` may link to the existing standalone Add Component identity route.
- `Muuda andmeid` may link to the existing standalone Edit Component metadata route.
- `Paiguta` should stay anchored in the existing Board Canvas `Lisa` / `Salvesta` visual placement workflow.
- `Mõõda komponenti` may link to the existing Measure Sheet route only if the active-lock sync confirms that no context propagation or measurement-writer merge is needed; otherwise it should remain informational/future.

No writer semantics change is authorized by this scope-lock.

## Binding workflow safety

Never use broad staging:

- Do not run `git add .`
- Do not run `git add -A`
- Do not run `git commit -am`
- Stage exact files only when the user explicitly requests staging.

## Canonical owners / evidence ledgers

Current route owners:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`

Canonical evidence and invariant ledgers:

- `docs/AUDIT_INDEX.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/PROTECTED_SURFACES.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/MODEL_ROUTING.md`
- `docs/PASS_LIFECYCLE.md`

## Protected boundary reminder

No writer/schema/materializer/validator/projection/Project ZIP/fact/event semantics change is authorized by this docs-only pass.

No runtime, test, schema, tool, events, known_facts, samples, assets, router, or `_incoming` edits are authorized.