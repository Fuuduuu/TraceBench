# Current State

Current pass: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

The Board Canvas test-code-map closeout is accepted, pushed, and audited at
`061ec7a0ce195e4d0560832631a25e55e3a0c1c2`
(`docs: close out board canvas test code map`). Claude returned
`AUDIT_VERDICT: ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; blockers none;
nits none. The separate production and test Board Canvas maps remain
`MAINTAINED`.

## Active docs-only architecture decision lock

The human-confirmed Variant C repo-skills architecture is locked for one later
decision pass. Canonical repo docs keep truth and authority; skills may own
reusable judgment and workflow technique only; validators/tools own mechanical
invariants; code maps remain descriptive; and each prompt owns its exact
PASS_ID, baseline, allowlist, exclusions, and pass-specific delta.

This scope lock changes only the four operational/audit owners and its new
audit artifact. It creates or edits no skill, architecture spec, tool,
validator, runtime, test, schema, package, asset, or `_incoming` file.

## Armed decision pass

After independent audit and push of this scope lock,
`TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS` may write exactly:

- `docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_PASS.md`

The decision must define the exact eight-skill Variant C catalogue, existing
skill dispositions, ownership and non-authorization, frontmatter/trigger and
composition contracts, RED/GREEN pressure evidence, validator boundaries,
narrow implementation batches, and lifecycle/drift rules. No active-lock sync
is required for that Lane A docs-only decision.

Scope-lock evidence:
`docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_SCOPE_LOCK_PASS.md`.
