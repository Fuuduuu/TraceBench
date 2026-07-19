# Current State

Current pass: `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_LOCK`
Next recommended pass: `TRACEBENCH_REPO_SKILLS_BATCH_B_IMPL_PASS`

This route records the explicit human decision made against baseline
`fdf9b1998c1cf998210d7ea28529c64672f57169` to finish the accepted eight-role
repo-skill catalogue architecture. No parent or child authority becomes
executable until the independent audit returns `SAFE_FOR_STAGING: YES` with no
blocker, the exact three-file route decision is exactly committed and pushed,
and `HEAD == origin/main ==` remote `main`.

The parent remains the current route owner while its four exact child passes
run. Child passes do not churn the operational route owners. The route
header's `Next` names the bundle entry child only. After Child 1, the
executable child is the first incomplete child whose sequential gate in
`docs/ACTIVE_SCOPE_LOCK.md` is satisfied. The unchanged entry header is not a
second authorization requirement and is never permission to rerun Child 1.

## Locked child sequence

1. `TRACEBENCH_REPO_SKILLS_BATCH_B_IMPL_PASS`
   - formalize/rewrite `tracebench-docs-closeout`;
   - formalize/rewrite `tracebench-safe-staging`.
2. `TRACEBENCH_REPO_SKILLS_BATCH_C_IMPL_PASS`
   - create `tracebench-code-map-lifecycle`.
3. `TRACEBENCH_REPO_SKILLS_BATCH_D_IMPL_PASS`
   - formalize/rewrite `tracebench-flutter-widget-pass`;
   - formalize/rewrite `tracebench-v2-event-boundary`.
4. `TRACEBENCH_REPO_SKILLS_CATALOGUE_CLOSEOUT_PASS`
   - reconcile the three accepted implementation children;
   - retire this parent lock;
   - return all route owners to `NEEDS_USER_DECISION`.

Each implementation child requires its own exact diff, individual RED/GREEN
evidence for every new or materially rewritten skill, independent Claude
audit, exact-file human staging, commit, and push. A later child is not
executable until the preceding child satisfies every gate in the active lock.

## Accepted baseline

Batch A remains completed and closed at
`fdf9b1998c1cf998210d7ea28529c64672f57169`. Its three formalized skills and
historical evidence are outside the new implementation allowlists and must
remain byte-unchanged. The two Batch A items recorded as DEFERRED / UNPROVED /
NON-BLOCKING remain unscheduled and are not silently claimed as proved by this
bundle.

## Boundary

This is a Lane A, repo-skill-documentation bundle. It authorizes only the
exact child paths listed in `docs/ACTIVE_SCOPE_LOCK.md`. It does not authorize
runtime, tests, tools, validators, schemas, packages, assets, code maps,
protected semantics, generic or personal skill extraction, plugin or MCP
installation, documentation compaction, scratch changes, or staging in the
TraceBench repository or any real worktree. Agents may never commit or push.
The sole synthetic-fixture exception for proving `tracebench-safe-staging`
behavior is defined narrowly in the active lock and grants no live-repository
authority.
