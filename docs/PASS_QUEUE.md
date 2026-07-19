# Pass Queue

## Current route

Current: `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_LOCK`
Next: `TRACEBENCH_REPO_SKILLS_BATCH_B_IMPL_PASS`

The route is a human-selected Lane A parent lock against baseline
`fdf9b1998c1cf998210d7ea28529c64672f57169`. No parent or child authority
becomes executable until the independent audit returns
`SAFE_FOR_STAGING: YES` with no blocker, the exact three-file route decision is
exactly committed and pushed, and `HEAD == origin/main ==` remote `main`.

## Exact child queue

1. `TRACEBENCH_REPO_SKILLS_BATCH_B_IMPL_PASS`
2. `TRACEBENCH_REPO_SKILLS_BATCH_C_IMPL_PASS`
3. `TRACEBENCH_REPO_SKILLS_BATCH_D_IMPL_PASS`
4. `TRACEBENCH_REPO_SKILLS_CATALOGUE_CLOSEOUT_PASS`

The parent lock owns this queue until the final closeout is accepted and
pushed. The three implementation children move Codex -> independent Claude
audit -> exact human staging/commit/push without intermediate route-ledger
churn. A child activates only after the immediately preceding child is
independently accepted, exactly committed, pushed, and verified with no scope
or protected-surface drift.

The route header's `Next` names the bundle entry child only. After Child 1,
the executable child is the first incomplete child whose sequential gate is
satisfied. The unchanged entry header is not a second authorization
requirement and is never permission to rerun Child 1.

Batch B finishes closure and staging safety. Batch C creates the missing
code-map lifecycle role. Batch D finishes the two specialized execution
roles. The final closeout records all accepted outcomes, retires every child
allowlist, and returns the route to `NEEDS_USER_DECISION` ->
`NEEDS_USER_DECISION`.

## Nothing else is queued

No Batch A repair, deferred wording repair, live-authority repair,
documentation compaction, extraction, runtime, test, tool, validator, schema,
asset, code-map content, plugin, MCP, or protected work is armed. Any child
blocker, allowlist mismatch, failed evidence gate, or independent-audit
rejection immediately suspends every child and grants no new authority. The
parent remains recorded but non-executable until a separately audited,
exactly committed, and pushed human route amendment replaces or retires it.
No blocked child may be skipped.
