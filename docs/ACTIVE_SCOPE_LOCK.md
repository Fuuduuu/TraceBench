# Active Scope Lock

## Current pass

`TRACEBENCH_TWO_LANE_GOVERNANCE_DOCS_SYNC_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Record and align the two-lane governance docs-policy recovery after compact-polish docs + route-advance commit `6440f0c` (`docs: record add component builder compact polish`), then return to `NEEDS_USER_DECISION`.

## Baseline

- Current route before this pass: `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_COMPACT_POLISH_IMPL_POST_AUDIT_PASS`.
- This pass is docs-only recovery and policy-sync; no runtime/test/protected-surface behavior changes.
- `_incoming` remains reference-only and is not accepted runtime source.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SYNC`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/MODEL_ROUTING.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/audit/TRACEBENCH_TWO_LANE_GOVERNANCE_DOCS_SYNC_PASS.md`

## Preserve boundary

- This recovery pass is docs-only.
- No runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact/protected write-flow edits.
- `renderer writes: none` remains preserved by the accepted implementation baseline.
- `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/AUDIT_INDEX.md` are not changed in this candidate.

## Route

- Current pass: `TRACEBENCH_TWO_LANE_GOVERNANCE_DOCS_SYNC_PASS`.
- Next route: `NEEDS_USER_DECISION`.

## Required validation

```powershell
git status --short --branch
git log --oneline --decorate -10
git diff --name-status
git diff --cached --name-status
git diff --check
```

## Stop conditions

- Stop and report if this pass needs runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact edits, `/_incoming` runtime usage, or accepted-architecture changes outside this docs-only recovery.
