# Pass Queue

## Current route

Current: `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`
Next: `NEEDS_USER_DECISION`

## Current protocol pass

The human selected `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` from the
non-executable `NEEDS_USER_DECISION` sentinel. It owns an exact seven-file
docs-only change that:

- makes `independent audit -> record returned verdict -> exact staging` the
  canonical order
- confines post-audit recording to one delimited artifact block and one
  mechanical ledger Status-cell mirror
- requires `SELF_REFERENCE_AUDIT` whenever a pass produces an artifact
- prohibits an artifact or ledger row from asserting its own audit or staging
  pipeline position
- creates one evidence artifact and exactly one active-index row

## Evidence and history boundary

The pass begins from pushed baseline
`fd21a107e6918f355df185beaf2159d366ea0bdb`. Its rules apply to artifacts and
ledger rows created or updated by this pass or later. The 13 existing
`PRE-AUDIT SNAPSHOT` records and their artifacts are grandfathered as history
and remain unchanged. Four unreconciled rows remain assigned to the
docs-hygiene lock for evidence-by-evidence adjudication.

## Sequencing

`NEEDS_USER_DECISION` remains the truthful next pointer. It is non-executable,
reserves no successor, and requires another explicit human route decision
before any later pass.

This protocol pass defines no closeout, route release, pointer reset,
implementation, or protected-surface pass.
