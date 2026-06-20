# Active Scope Lock

## Current pass

`V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS`

## Type

`CODEX / DOCS_SYNC`

## Lane

Docs-only implementation post-audit closeout for the accepted Workbench / Board Canvas read-only measurement overlay.

## Current goal

Record the accepted/pushed `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS`, capture Claude Code audit acceptance and validation evidence, preserve implementation boundaries, and route to a focused manual visual smoke/checkpoint.

## Baseline

- `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_PASS` is accepted/pushed as `e1f78ed` (`feat(board-canvas): add read-only measurement value overlay`).
- `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_SCOPE_LOCK_PASS` is accepted/pushed as `f832ee4` (`docs: activate workbench measurement overlay implementation lock`).
- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_POST_AUDIT_PASS` is accepted/pushed as `f1226d4` (`docs: record workbench measurement overlay scope-lock post-audit`).
- `V2_WORKBENCH_MEASUREMENT_OVERLAY_SCOPE_LOCK_PASS` is accepted/pushed as `8544a4b` (`docs: lock workbench measurement overlay scope`).
- Claude Code implementation audit verdict: `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`.

## Allowed governance scope

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS.md`

## Current route lock

Current pass: `V2_WORKBENCH_MEASUREMENT_OVERLAY_IMPL_POST_AUDIT_PASS`
Next: `V2_WORKBENCH_MEASUREMENT_OVERLAY_MANUAL_SMOKE_PASS`

## Current scope summary

- This pass is docs-only and intentionally does not change runtime code, tests, tools, schemas, samples, generated artifacts, platform files, dependencies, app routing, or `_incoming` assets.
- Record the accepted/pushed read-only measurement value overlay implementation.
- Preserve the accepted Workbench / Board Canvas read-only runtime baseline.
- Preserve `docs/AUDIT_INDEX.md` as audit provenance.
- No runtime, protected-surface, model-routing, prompt, or canonical invariant semantic changes.

## Accepted implementation summary

- Read-only measurement value overlay on Workbench / Board Canvas.
- Existing projected `MeasurementFact` value + unit only.
- Existing explicit component association only.
- Existing `board_normalized` component visual anchors only.
- Selected-component toggle.
- Global Show All / Hide All.
- Deterministic stacked badges for multiple eligible measurements.
- Defensive stale/suspect/invalid UI treatment.
- Volatile UI-only visibility state.
- No persistence and no canonical visibility events.

## Required validation

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `py -3 tools/validate_all.py`

## Scope carry-forward

- Board Canvas remains read-only.
- `renderer writes: none` remains present in accepted behavior context.
- Measure Sheet remains unchanged.
- Add Component remains deferred.
- No inline Workbench value/unit/Save or write-flow integration is accepted by this pass.
- No `events.jsonl`, `known_facts.json`, schema, materializer, validator, writer service, projection contract, or Project ZIP changes are accepted by this pass.
- No `_incoming/` assets are treated as accepted runtime behavior.
- Codex writes scoped docs inside the active lock, Claude Code is the final repo-local audit gate before staging/commit/push unless repo convention explicitly says otherwise, and the user manually stages/commits/pushes with exact staging sets.
- No broad staging (`git add .` / `git add -A`) is allowed.
