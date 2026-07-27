# Active Scope Lock

## Route

Current: `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

## Authority transition

The completed `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` has no standing write
authority. Its seven-file docs diff completed and was pushed at
`9644e62ef9e8f81d00a3d38cff3e0606b2b93a73`; the pushed file set equals that
pass's allowlist exactly, with no eighth file.

The former seven-file allowlist is spent and retained only in Git and its
existing audit evidence. It grants no writes to this or any later pass. The
explicit human route decision selected this pass from the non-executable
`NEEDS_USER_DECISION` sentinel; no prior allowlist is inherited.

That release is recorded here, inside this pass's normal route advance. No
separate route-release, closeout, or pointer-reset `PASS_ID` is created for it:
a spent or deficient lock is amended in place rather than routed through a
sync-pass ceremony.

## Exact current write allowlist

`TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS` may write exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

No other file is authorized.

## Required outcomes

- correct the archive attestation by naming the byte representation it
  measured, and publish the Git object id as the durable anchor
- keep the original compaction measurements verbatim; the correction is
  append-only and does not rewrite the historical claim
- give `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md` a ledger
  row so the correction is reachable from `docs/AUDIT_INDEX.md`
- add the operative byte-representation rule for every future published hash or
  byte-length attestation, and resolve the deferred surrounding-space `NIT` for
  hash values published inside table cells
- replace the unverifiable count `13` in operative contract text with a stated
  counting method and the enumeration that method returns
- record that the four active `PRE-AUDIT SNAPSHOT` rows and the four rows
  previously called unreconciled are one population, not two
- reassign those four rows from the never-created docs-hygiene lock to the
  non-executable `NEEDS_USER_DECISION` sentinel
- name the two further active rows that assert an unresolved audit position,
  and place them under the same owner, without editing either row
- release the spent seven-file authority in this pass's route advance
- keep `Next` at the non-executable `NEEDS_USER_DECISION` sentinel
- add exactly one new audit artifact and its ledger row

## Frozen historical evidence

`docs/audit/TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS.md` and its ledger row are
completed, independently audited records. This pass does not rewrite them. The
superseded count they contain is registered as a divergence in this pass's
artifact and row instead, which is the disposition-register mechanism
`docs/AUDIT_INDEX.md` already requires.

The same rule applies to every other artifact that cites the superseded archive
hash as historical evidence. An existing artifact is edited by this pass only
where it hands a future reader a verification instruction that will fail.

## Forbidden surfaces

No Dart, test, schema, tool, asset, ZIP, runtime, `_incoming`, or
`.agents/skills/**` file may change. `AGENTS.md`, `CLAUDE.md`,
`docs/POHIKIRI.md`, `docs/PROJECT_MINI_MAP.md`, `docs/FILE_MAP.md`,
`docs/MEMORY_REGISTRY.yml`, `docs/MEMORY_PROTOCOL.md`,
`docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`,
`docs/archive/AUDIT_INDEX_ARCHIVE.md`, every code map, and every audit artifact
outside the two named above remain outside this pass.

No `.gitattributes` is added and no file is renormalized by this pass.

This pass defines no product behavior, implementation authority, protected
surface, or executable successor.

## Deferred: line-ending normalization

Repository line-ending normalization is deferred to a later pass that requires
its own explicit human route decision. The deferral reason is severity order,
not interference:

- every tracked text blob in `HEAD` is already `LF`: `git grep -I -l -P '\r'
  HEAD` returns `0` files. `-I` scans text blobs only, which is `864` of the
  `875` tracked files; the excluded `11` are binary PNG assets, and the same
  scan with `--text` returns exactly those `11`
- a future `text=auto` normalization is therefore a content no-op for existing
  blobs, and `git add --renormalize` would produce no blob change
- every anchor published by this pass is a `blob`-representation value, so all
  of them survive that later pass unchanged

Normalization removes a defect generator and cosmetic `git status` noise. This
pass removes canonical text that is currently false about Git. The false text
compounds, because later passes cite it; the generator does not, because it
cannot corrupt already-`LF` blobs. That ordering is a severity judgment and is
recorded as one.

## Verdict-recording and staging authority

1. Complete and validate the exact seven-file Phase 1 docs diff.
2. Independent audit covers the complete diff except the named empty verdict
   block. The auditor must not be the session that wrote the diff.
3. The returned verdict is copied into that block and mechanically mirrored in
   this pass's existing ledger Status cell.
4. A freeze proof must show that no other content or changed file moved.
5. Only an accepted exact staging set may be staged by the human.

No agent has authority to stage, commit, or push in this pass.

## Stops

Stop if any eighth file is required, if the correction cannot be written
without rewriting a completed audit artifact's original measurements, if
resolving a ledger row would require inferring whether an audit ran from commit
or push evidence, if validation exposes a scope-relevant failure, or if any
product, implementation, or protected-surface decision is required.
