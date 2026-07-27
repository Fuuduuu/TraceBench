# Current State

Current pass: `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

This Lane A docs sync makes independent audit evidence durable in the pass that
earned it. The canonical sequence is:

`independent audit -> record returned verdict -> exact staging`

## Authority basis

The explicit human route decision selected this pass from the non-executable
`NEEDS_USER_DECISION` sentinel; no earlier allowlist is inherited. Baseline
`fd21a107e6918f355df185beaf2159d366ea0bdb` is the pushed
`docs: reconcile audit and push evidence` commit.

## Current work

- add the verdict-recording gate and the no-self-referential-lifecycle check to
  `docs/AUDIT_CONTRACT.md`
- update the compact prompt skeleton, required artifact output, and exact
  staging rule in `docs/PROMPTING_PROTOCOL.md`
- create one protocol artifact with one delimited verdict block
- record exactly one active evidence-anchor row
- keep the route at this pass -> `NEEDS_USER_DECISION`

## Boundaries

The exact authority is the seven documentation files named in
`docs/ACTIVE_SCOPE_LOCK.md`. No Dart, test, schema, tool, asset, ZIP, runtime,
`_incoming`, skill, product, or protected-surface behavior is changed. No
executable successor, closeout, or later write authority is reserved.

`docs/PASS_LIFECYCLE.md` remains unchanged: its compact audit-to-human-commit
orientation is compatible with the more precise verdict-recording gate owned
by the audit and prompting protocols.

## Historical evidence boundary

The new rules apply prospectively to artifacts and ledger rows created or
updated by this pass or later. The 13 existing `PRE-AUDIT SNAPSHOT` records and
their artifacts remain historical evidence. Four unreconciled rows stay owned
by the docs-hygiene lock, which must determine audit execution row by row
without inferring it from commit or push evidence.
