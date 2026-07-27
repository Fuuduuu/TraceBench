# Current State

Current pass: `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

This Lane A docs sync repairs three defects in the evidence layer itself: an
attestation that named no byte representation, a grandfathered set defined by
an unreproducible count, and evidence debt assigned to an owner that was never
created.

## Authority basis

The explicit human route decision selected this pass from the non-executable
`NEEDS_USER_DECISION` sentinel. Baseline
`9644e62ef9e8f81d00a3d38cff3e0606b2b93a73` is the pushed
`docs: add audit evidence recording protocol` commit. The seven-file authority
of `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` is spent; its release is recorded
in `docs/ACTIVE_SCOPE_LOCK.md` as part of this route advance rather than in a
separate release pass.

## Current work

- publish the corrected archive attestation with its byte representation named,
  anchored on the Git object id
- add the operative rule that every published hash or byte-length attestation
  names its representation
- replace the count `13` in operative contract text with a stated counting
  method and its enumeration
- reassign the four active `PRE-AUDIT SNAPSHOT` rows to `NEEDS_USER_DECISION`
- name two further active rows that assert an unresolved audit position and
  place them under the same owner, without editing either row
- keep the route at this pass -> `NEEDS_USER_DECISION`

## Boundaries

The exact authority is the seven documentation files named in
`docs/ACTIVE_SCOPE_LOCK.md`. No Dart, test, schema, tool, asset, ZIP, runtime,
`_incoming`, skill, product, or protected-surface behavior is changed. No
`.gitattributes` is added and nothing is renormalized. No executable successor,
closeout, or later write authority is reserved.

## Corrected historical evidence boundary

The verdict-recording and no-self-referential-lifecycle rules still apply
prospectively, unchanged, from `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`
onward.

What changes is the description of the grandfathered set. It is now defined by
a stated counting method owned by `docs/AUDIT_CONTRACT.md` rather than by the
count `13`, which no committed ledger state reproduces. The method returns six
records: four in the active ledger and two in the archive.

Those four active records are the same four rows earlier described separately
as unreconciled. They were never two populations. They are owned by the
non-executable `NEEDS_USER_DECISION` sentinel until an explicit human route
decision assigns them to a named executable pass. Whether an independent audit
actually ran for each remains undetermined in the repository, and a commit or
push is still not evidence that it did.

The only docs-hygiene lock in the repository,
`TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS`, was last recorded at `dbe9271` on
2026-06-19, five weeks before these rows existed, and appears in no route owner
today. It was never re-created for this work. No pass is assigned work here
that does not exist.
