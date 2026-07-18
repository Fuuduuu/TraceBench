---
name: tracebench-scope-lock
description: Use when the immediate executable phase is a docs-only TraceBench reservation of a future exact route, allowlist, boundaries, and stops.
---

# TraceBench Scope Lock

## Purpose

Reserve one future TraceBench pass without implementing it or changing current
authority by implication. A scope lock is a lifecycle phase, not a PASS_ID
substring.

## Trigger boundary

Use this skill when the requested work is semantically a docs-only reservation
of a future route and exact scope. Do not use it for audit reconciliation,
active-lock sync, implementation, or closeout merely because a name contains
`SCOPE_LOCK_PASS`. In a mixed request, identify the immediate executable phase
first; a later reserved scope lock does not trigger this skill during an
immediate reconciliation, sync, implementation, or closeout. If the requested
work combines those phases, decompose it. During an immediate reconciliation,
select only the audit-reconciliation lifecycle skill and report this skill as
not applicable; naming a later scope-lock phase does not make it applicable.

## Canonical route

Read the default five owners in `AGENTS.md`, then the task-specific audit,
protected-surface, prompt/model, lifecycle, and implementation owners required
by those files. Verified Git state and the live route owners outrank the brief.

## Scope-lock sequence

1. Verify the baseline, tracked/cached state, and current/next tuple in all
   operational route owners.
2. State current write authority separately from every reserved future
   allowlist. Match it to the live `Current` PASS_ID and satisfied transition
   evidence, not to the nearest retained transition-history heading. If those
   signals disagree, stop instead of calling a stale list current. A
   reservation is not executable authority.
3. Identify lifecycle phases and responsibility zones. Reconciliation, sync,
   implementation, and closeout stay separate; independent zones require
   decomposition or a new human decision.
4. Reserve one exact future PASS_ID, allowlist, inspect-only surfaces,
   exclusions, scratch treatment, stops, validation, and acceptance contract.
5. Reserve active-lock sync only when the selected sequence actually requires
   it; active-lock sync is not a universal skill rule.
6. Record the scope-lock artifact and ledger evidence only inside the current
   docs allowlist, then emit the required read-only Claude audit packet.

## Non-authorization

This skill cannot reconcile an audit, activate reserved writes, implement,
stage, commit, push, or resolve a conflict by broadening an allowlist. If live
authority is inconsistent or the required reservation crosses independent
zones, stop with the governing outcome instead of merging phases.
