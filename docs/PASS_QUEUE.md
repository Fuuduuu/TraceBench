# Pass Queue

## Current route

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
Next: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## Current pass

Bounded docs-only compaction: make the default read set exactly the five operational files, move every other owner to task-specific loading, compact duplicated/stale active memory, and correct only verified audit-index drift.

Exact current and next-pass allowlists live in `docs/ACTIVE_SCOPE_LOCK.md`.

## Next pass

`BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` retains the seven-file Home/test/asset allowlist and the hidden-decoy plus visible-launcher integration-test correction.

Do not route through `NEEDS_USER_DECISION`. Do not stage, commit, or push from this pass.
