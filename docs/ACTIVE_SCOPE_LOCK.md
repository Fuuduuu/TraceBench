# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority.

## Current write authority

No implementation or docs pass is active. No file write authority is armed.
A future pass requires a new explicit human decision and exact allowlist.

## Accepted repo-skills decision

The repo-skills architecture decision is accepted and pushed at
`9d6ec175ee9a4327b1683ca101ddb36b0acb48ec`
(`docs: define repo skills architecture`). Its durable owner is
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`.

The accepted decision establishes:

- core: `tracebench-prompt-authoring`;
- lifecycle: `tracebench-scope-lock`, `tracebench-code-map-lifecycle`,
  `tracebench-audit-reconciliation`, and `tracebench-docs-closeout`;
- specialized: `tracebench-flutter-widget-pass` and
  `tracebench-v2-event-boundary`;
- mechanical guard: `tracebench-safe-staging`;
- all five existing skills: `formalize/rewrite`;
- three missing roles remain unimplemented;
- canonical docs remain truth and authority owners;
- skills remain reusable judgment/workflow only and non-authorizing;
- validators/tools remain mechanical-invariant owners;
- code maps remain descriptive and non-authorizing;
- each exact prompt owns its PASS_ID, baseline, allowlist, exclusions, stops,
  pass-specific delta, and validation within live canonical authority; it may
  narrow but never widen that authority;
- every new/material skill rewrite requires RED/GREEN evidence;
- portability/extraction labels are non-authorizing; and
- future Markdown deletion requires an audited replacement, updated pointers,
  preserved authority/history, no dangling references, and exact
  docs-compaction authority.

The A-D batch labels, `Extraction candidate: YES` classifications, and
Markdown dispositions are non-authorizing architecture decisions only.

## Released authority

All pass-specific write authority from the repo-skills architecture scope-lock
and decision passes is released. The accepted architecture spec remains the
durable decision owner. This closeout does not arm:

- Batch A, B, C, or D;
- generic or personal skill extraction;
- Markdown compaction or deletion;
- Photo-to-Canvas work;
- automatic loading, linting, hooks, CI, tooling, or validators;
- active-lock sync; or
- runtime, test, schema, package, asset, `_incoming`, or protected-surface
  work.

The architecture spec, tooling policy, decision artifact, all existing skills,
and all protected owners remain unchanged by this closeout.
