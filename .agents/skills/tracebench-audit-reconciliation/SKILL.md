---
name: tracebench-audit-reconciliation
description: Use when an independently audited TraceBench pass is pushed but its existing artifact and ledger row still record pending evidence while route and authority remain unchanged.
---

# TraceBench Audit Reconciliation

## Purpose

Reconcile already-returned audit and pushed-commit evidence into its existing
TraceBench records without performing a new audit or advancing lifecycle state.

## Trigger boundary

Use this skill only when the verdict already exists, the audited pass is
pushed, its existing artifact/index still says pending, and route plus authority
must remain unchanged. This is not scope locking, active-lock sync,
implementation, closeout, or staging.

## Canonical route

Read the default five owners in `AGENTS.md`, then
`docs/AUDIT_CONTRACT.md`, `docs/AUDIT_INDEX.md`, the one exact existing audit
artifact, and live Git evidence. Route owners are inspect-only.

## Reconciliation sequence

1. Verify baseline, clean tracked/cached state, pushed commit, subject, parent,
   exact committed set, returned verdict, blockers/nits, and accepted safe set.
2. Retain the same PASS_ID and existing artifact. Preserve original draft-time
   evidence and append a clearly labelled superseding reconciliation; do not
   create a sibling artifact or rewrite history.
3. Update only the existing `AUDIT_INDEX` status cell and preserve its
   descriptive column byte-identically. Keep exactly one PASS_ID row.
4. Change only the exact authorized evidence surfaces. Keep current/next route
   and active authority unchanged.
5. Emit the required read-only Claude diff-audit packet. The reconciliation
   itself remains unstaged; if the independent diff audit accepts it, the
   packet may return only the exact reconciliation allowlist as
   `SAFE_STAGING_SET`.

## Non-authorization

This skill does not perform the audit, invent evidence, create an artifact,
activate or release a route, close a pass, implement, stage, commit, or push.
If commit evidence, safe-set identity, byte preservation, or unchanged route
cannot be proved, stop instead of repairing by inference.
