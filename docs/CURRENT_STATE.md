# Current State

Current pass: `NEEDS_USER_DECISION`
Next recommended pass: `NEEDS_USER_DECISION`

## Charter and accepted baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop
authority.

The repo-skills architecture decision is accepted and pushed at
`9d6ec175ee9a4327b1683ca101ddb36b0acb48ec`
(`docs: define repo skills architecture`). Claude returned
`AUDIT_VERDICT: ACCEPT_AS_IS` and `SAFE_FOR_STAGING: YES`; blockers none;
nits none.

## Accepted repo-skills architecture

`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md` now owns the Variant C
repo-skill system decision:

- exact eight-role catalogue across core, lifecycle, specialized, and
  mechanical-guard layers;
- canonical docs own truth, routes, authority, semantics, and protected
  boundaries;
- skills own reusable judgment and workflow technique only;
- validators/tools may own proven deterministic mechanical invariants;
- code maps remain descriptive and non-authorizing;
- each prompt owns its exact PASS_ID, baseline, allowlist, exclusions, stops,
  pass-specific delta, and validation;
- all five existing skills are `formalize/rewrite`;
- YAML `name` / `Use when...` trigger discovery and ordered conditional
  composition are locked;
- every new or material rewrite requires RED/GREEN pressure evidence;
- batches A-D and portability classifications are architecture decomposition
  only and grant no implementation or extraction authority; and
- future Markdown dispositions are `KEEP_CANONICAL`,
  `COMPACT_AND_REPOINT`, and `RETIRE_AND_DELETE`; no current file is
  classified, compacted, or retired.

The implemented inventory remains five repo-local skills. The three missing
roles are `tracebench-prompt-authoring`, `tracebench-code-map-lifecycle`, and
`tracebench-audit-reconciliation`.

## Active authority

All pass-specific write authority from the repo-skills architecture scope-lock
and decision passes is released. The accepted architecture spec remains the
decision owner. No repo-skills implementation batch, generic extraction,
Markdown compaction, Photo-to-Canvas work, tool/validator work, active-lock
sync, runtime change, or test change is armed. A future pass requires a new
human decision and exact scope.

Closeout evidence:
`docs/audit/TRACEBENCH_REPO_SKILLS_ARCHITECTURE_DECISION_POST_AUDIT_PASS.md`.
