# Pass Queue

## Current route

Current: `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

## Current repair pass

The human selected `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS` from the
non-executable `NEEDS_USER_DECISION` sentinel. It owns an exact seven-file
docs-only change that:

- names the byte representation of the archive attestation and anchors it on
  the Git object id, which is verifiable in any clone
- makes representation naming mandatory for every future published hash or
  byte-length attestation
- replaces the count `13` in operative contract text with a stated counting
  method and the six records that method returns
- records that the four active `PRE-AUDIT SNAPSHOT` rows and the four rows
  previously called unreconciled are one population
- reassigns those four rows from a lock that was never created to the
  non-executable `NEEDS_USER_DECISION` sentinel
- releases the spent seven-file authority inside this pass's route advance
- creates one evidence artifact and exactly one new active-index row

## Evidence and history boundary

The pass begins from pushed baseline
`9644e62ef9e8f81d00a3d38cff3e0606b2b93a73`. It rewrites no completed artifact's
original measurements. Superseded values stay in place as historical evidence
and their divergence is registered in this pass's artifact and row.

An existing artifact is edited only where it hands a future reader a
verification instruction that will fail. Exactly one artifact meets that test:
`docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`, whose recorded
recipe for reproducing the archive hash cannot succeed as written. It is
corrected append-only and gains the ledger row it never had.

## Sequencing

`NEEDS_USER_DECISION` remains the truthful next pointer. It is non-executable,
reserves no successor, and requires another explicit human route decision
before any later pass.

Known unarmed work, recorded here so it stops living only in chat. None of it
is armed, reserved, or scheduled by this pass:

- **line-ending normalization.** Add `.gitattributes` and normalize. Verified
  content no-op for existing text blobs: `git grep -I -l -P '\r' HEAD` returns
  `0` of the `864` tracked text blobs; the other `11` of `875` tracked files
  are binary PNG assets excluded by that scan. Deferred on severity, not
  interference.
- **four `PRE-AUDIT SNAPSHOT` adjudications.** Requires evidence only the human
  holds; cannot be resolved from the repository.
- **routing completeness.** Top-level `docs/*.md` files absent from
  `docs/FILE_MAP.md`, plus the missing `code_maps` and skills layers in
  `docs/MEMORY_REGISTRY.yml`. Three separate counts of the unrouted set have
  been reported. That pass must establish the number with a stated method and
  publish the method with the number; no earlier count may be inherited.
- **code-map coverage.** Unmapped Dart screens that may satisfy automatic
  qualification under `docs/code_maps/CODE_MAP_STANDARD.md`.

This repair pass defines no closeout, route release, pointer reset,
implementation, or protected-surface pass.
