# Active Scope Lock

## Current pass

`TRACEBENCH_TWO_LANE_GOVERNANCE_PRO_REVIEW_AMEND_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Amend two-lane governance policy docs using GPT Pro semantic-risk review: classify lanes by risk, define Lane A parent-lock bundles, enforce Lane A audit evidence handoff, and clarify compact closeout/index policy; no runtime or protected-surface changes.

## Baseline

- Current route before this pass: `TRACEBENCH_TWO_LANE_GOVERNANCE_DOCS_SYNC_PASS`.
- This pass is Lane A docs-only policy amendment; no runtime/test/protected-surface behavior changes.
- `_incoming` remains reference-only and is not accepted runtime source.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SYNC`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/PROMPTING_PROTOCOL.md`
- `docs/MODEL_ROUTING.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_TWO_LANE_GOVERNANCE_DOCS_SYNC_PASS.md`
- `docs/audit/TRACEBENCH_TWO_LANE_GOVERNANCE_PRO_REVIEW_AMEND_PASS.md`

## Preserve boundary

- This recovery pass is docs-only.
- No runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact/protected write-flow edits.
- `renderer writes: none` remains preserved by the accepted implementation baseline.
- Route-tracking docs are updated in this amendment candidate.

## Route

- Current pass: `TRACEBENCH_TWO_LANE_GOVERNANCE_PRO_REVIEW_AMEND_PASS`.
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
