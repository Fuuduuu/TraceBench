# Active Scope Lock

## Current pass

`TRACEBENCH_ACCEPTED_SHORTHAND_DOCS_SYNC_PASS`

## Type

CODEX / DOCS_SYNC

## Goal

Record the Lane A docs-only shorthand and compact audit packet policy for this pass stream:
- user-facing `Accepted` shorthand conditions;
- compact `CLAUDE_AUDIT_PACKET` requirements;
- no runtime/test/protected-surface edits for this governance pass.

## Baseline

 - Current route before this pass: `TRACEBENCH_TWO_LANE_GOVERNANCE_PRO_REVIEW_AMEND_PASS`.
 - Latest accepted feature baseline remains `V2_WORKBENCH_ADD_COMPONENT_VISUAL_LAYOUT_BUILDER_ACTIVE_PANEL_POLISH_PASS`.
 - `_incoming` remains design/reference only and is not accepted runtime source.

## Status labels to record

- `ROUTE_EFFECT: DOCS_SYNC`
- `ROUTE_EFFECT_NEXT: NEEDS_USER_DECISION`
- `LANE_A`

## Allowed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/MODEL_ROUTING.md`
- `docs/audit/TRACEBENCH_ACCEPTED_SHORTHAND_DOCS_SYNC_PASS.md`

## Preserve boundary

This governance sync pass is docs-only:

- No runtime/test implementation files are modified.
- No schema/writer/materializer/validator/projection/event/fact changes.
- No `Project ZIP` or route-ambiguity changes.
- No `*_incoming` runtime source usage.

## Route

- Current pass: `TRACEBENCH_ACCEPTED_SHORTHAND_DOCS_SYNC_PASS`.
- Route now requires `ACCEPT_AS_IS` + `SAFE_FOR_STAGING: YES` before any shorthand `Accepted` handoff.
- `V2_WORKBENCH_ADD_COMPONENT_LOCAL_GHOST_SCOPE_LOCK_PASS` remains parked as a separate docs-only scope in adjacent ledgers while this shorthand policy pass records provenance correction.
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

- Stop if this pass claims runtime edits, runtime artifacts, or accepted push hashes for an uncommitted pass.
- Stop and report if this pass needs runtime/schema/writer/materializer/validator/projection/Project ZIP/event/fact edits, `/_incoming` runtime usage, or accepted-architecture changes outside this allowlist.
