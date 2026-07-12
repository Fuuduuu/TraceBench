# Pass Queue

## Current route

Current: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS`
After compaction: `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS`

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. Conflicts stop for human decision.

## Current pass

This docs-only scope lock records that the direct compaction attempt stopped before edits because it was not named or authorized in the live route/scope docs. It now arms one bounded memory-routing and docs-compaction pass without performing that compaction.

The current four-file Home implementation diff remains frozen by file set and binary hash. No runtime, test, asset, staging, commit, or push action is authorized.

## Next pass

`TRACEBENCH_MEMORY_ROUTING_AND_DOCS_COMPACTION_PASS` may write only the exact documentation allowlist in `docs/ACTIVE_SCOPE_LOCK.md`. It must establish the five-file default read path, move all other owners to task-specific loading, compact duplicated/stale active memory, and correct only verified audit-index drift.

## Preserved downstream route

After compaction, return immediately to `BENCHBEEP_HOME_STARTPAGE_REDESIGN_IMPL_PASS` with its exact seven-file allowlist and hidden-decoy/integration-test correction unchanged.

Do not stage, commit, or push from this pass.
