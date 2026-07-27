# Active Scope Lock

## Route

Current: `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`
Next: `NEEDS_USER_DECISION`

## Authority transition

The explicit human route decision selected this pass from the non-executable
`NEEDS_USER_DECISION` sentinel at pushed baseline
`fd21a107e6918f355df185beaf2159d366ea0bdb`. No prior allowlist is inherited.

## Exact current write allowlist

`TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` may write exactly:

- `docs/AUDIT_CONTRACT.md`
- `docs/PROMPTING_PROTOCOL.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS.md`

No other file is authorized.

## Required outcomes

- define the ordered gate
  `independent audit -> record returned verdict -> exact staging`
- require one clearly delimited artifact verdict block and one mechanical
  ledger Status-cell mirror in the same exact staged set
- require a bounded Phase 1-to-Phase 2 freeze proof
- add the no-self-referential-lifecycle common audit check
- require `SELF_REFERENCE_AUDIT` for any pass producing an artifact
- grandfather the 13 existing `PRE-AUDIT SNAPSHOT` records and their artifacts
  without rewriting them
- leave the four unreconciled rows to their docs-hygiene owner for individual
  evidence decisions
- keep `Next` at the non-executable `NEEDS_USER_DECISION` sentinel
- add exactly one ledger row and one new audit artifact

## Forbidden surfaces

No Dart, test, schema, tool, asset, ZIP, runtime, `_incoming`, or
`.agents/skills/**` file may change. `AGENTS.md`, `CLAUDE.md`,
`docs/PROJECT_MINI_MAP.md`, `docs/FILE_MAP.md`,
`docs/MEMORY_REGISTRY.yml`, `docs/MEMORY_PROTOCOL.md`,
`docs/PASS_LIFECYCLE.md`, every code map, every existing audit artifact, and
all other documentation remain outside this pass.

This pass defines no product behavior, implementation authority, protected
surface, or executable successor.

## Verdict-recording and staging authority

1. Complete and validate the exact seven-file Phase 1 docs diff.
2. Independent Claude audit covers the complete diff except the named empty
   verdict block.
3. The returned verdict is copied into that block and mechanically mirrored in
   this pass's existing ledger Status cell.
4. A freeze proof must show that no other content or changed file moved.
5. Only an accepted exact staging set may be staged by the human.

Codex has no authority to stage, commit, or push.

## Stops

Stop if any eighth file is required, the rules require an edit to `AGENTS.md`
or `docs/PASS_LIFECYCLE.md`, the bounded verdict-recording exception cannot be
defined truthfully, validation exposes a scope-relevant failure, or any
product, implementation, or protected-surface decision is required.
