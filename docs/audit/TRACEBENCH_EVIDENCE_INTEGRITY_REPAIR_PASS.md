# TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS

Record kind: `EVIDENCE INTEGRITY REPAIR`

PASS_ID: `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`

Lane: `A`

Mode: `DOCS_SYNC`

## Purpose

Repair three defects in the evidence layer itself:

1. an archive attestation published without naming the byte representation it
   measured, whose value matches nothing Git stores;
2. a grandfathered population defined by a count that no committed ledger state
   reproduces;
3. evidence debt assigned to a lock that was never created.

Each defect is the same failure in a different place: a claim that survived
because nothing mechanical could check it.

## TOOL_SKILL_CHECK

- relevant skill/tool/helper found: the three loader-qualified repo-local
  skills inventoried by `docs/CODEX_TOOLING_POLICY.md`, plus direct Git object
  inspection and `tools/validate_all.py`
- capability actually used: `tracebench-prompt-authoring` for the real
  post-change audit handoff; `git rev-parse`, `git cat-file blob`, and
  `git grep` over `HEAD` for every published measurement
- why applicable: this pass ends in a genuine post-change handoff with named
  changed files and observed validation, which is that skill's second trigger.
  `tracebench-scope-lock` does not apply because no executable successor or
  future allowlist is reserved. `tracebench-audit-reconciliation` does not
  apply: its trigger is a pushed pass whose row still records pending evidence
  while route and authority stay unchanged, whereas this pass advances the
  route and releases a spent authority
- external tool required: `NO`

## CODE_MAP_PREFLIGHT

`not applicable`. No Dart production or test file is targeted or materially
depended on. `docs/code_maps/CODE_MAP_INDEX.md`, every code map, all Dart
source, and all Dart tests remain outside the seven-file authority.

## Gate and authority evidence

- HEAD, local `main`, local `origin/main`, and live `refs/heads/main`:
  `9644e62ef9e8f81d00a3d38cff3e0606b2b93a73`
- subject: `docs: add audit evidence recording protocol`
- divergence against `origin/main`: `0` ahead, `0` behind
- cached content diff at entry: empty
- tracked content diff at entry: empty; the five pre-existing porcelain
  modifications carry no content change under `git diff --numstat`
- entry authority: explicit human route decision from the non-executable
  `NEEDS_USER_DECISION` sentinel; no prior allowlist is inherited
- released authority: the seven-file allowlist of
  `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`, whose pushed file set at
  `9644e62ef9e8f81d00a3d38cff3e0606b2b93a73` equals that allowlist exactly

## Exact seven-file boundary

This pass changes exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

## Repair 1: archive attestation

`docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md` published the
archive anchor as SHA-256
`eb16fd47fe8e9bb7c3f7a173467398dfb0a881d4fecec6402529fd14bb621780` at `284984`
bytes, and instructed future verifiers that reading the complete archive file
reproduces it. Its own wording records that the measurement was taken from the
working-tree copy.

Measured values, each with its representation and command named:

| Representation | Command | Byte length | SHA-256 |
|---|---|---|---|
| published | working-tree read at measurement time | `284984` | `eb16fd47fe8e9bb7c3f7a173467398dfb0a881d4fecec6402529fd14bb621780` |
| `blob` | `git cat-file blob HEAD:docs/archive/AUDIT_INDEX_ARCHIVE.md` | `284219` | `94a404163d5b1a9acf718e4f81576e10a9c488bd89fc23642087ef549e3b734c` |
| `worktree` | `sha256sum docs/archive/AUDIT_INDEX_ARCHIVE.md` | `284990` | `a068b4e554d524e88c6939fe9e601105c3b4e3facbdf33b08d824ddb3b6ff419` |

Mechanism: `core.autocrlf=true` with no tracked `.gitattributes`. Staging
strips one `CR` per line. `284984 - 284219 = 765`, exactly the CRLF count the
compaction artifact recorded. Checkout then applied CRLF to the `6` lines that
were bare LF at measurement time, producing today's `284990`. The published
byte sequence exists in no current representation, and only one commit,
`bea022455bd5fb03abf698e39f3cef1b94a75532`, has ever touched the archive, so
no alternative version exists to test.

The compaction's substance was nonetheless correct, and is now provable without
any hashing tool. These three commands all return
`cf8a3ffc7a6589a360889e2b70ba02d9a98d1f6a`:

```text
git rev-parse 73f0b1a9c52181c19a9ff28912279c6f16e70b92:docs/AUDIT_INDEX.md
git rev-parse bea022455bd5fb03abf698e39f3cef1b94a75532:docs/archive/AUDIT_INDEX_ARCHIVE.md
git rev-parse HEAD:docs/archive/AUDIT_INDEX_ARCHIVE.md
```

The archive is the same Git object as the pre-compaction ledger.
`BYTE_IDENTICAL` holds by object identity. What failed was representation
naming, not preservation.

The correction is appended to the compaction artifact; every original
measurement there is preserved verbatim. `docs/AUDIT_CONTRACT.md` gains the
operative rule that prevents recurrence, and resolves the surrounding-space
`NIT` that `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` deferred for hash values
published inside table cells.

## Repair 2: the grandfathered population

Counting method, published so it can be re-run and disputed: split each
pipe-prefixed row on `|`, giving field 2 `PASS_ID`, field 3 `File`, field 4
`Status`; match the literal `PRE-AUDIT SNAPSHOT` only in field 4.

Field scoping is load-bearing, and the difference is measurable. At baseline
`9644e62ef9e8f81d00a3d38cff3e0606b2b93a73` a line-scoped match returns `5`
active rows rather than `4`, because `TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS`
mentions the label inside its `Description` cell without carrying it as a
Status. This pass's own row mentions it as well, so after this diff a
line-scoped match returns `6`. The field-scoped count is `4` in both states,
which is the property that makes it usable as a rule boundary.

The method returns six records at `9644e62ef9e8f81d00a3d38cff3e0606b2b93a73`:
four in `docs/AUDIT_INDEX.md` and two in
`docs/archive/AUDIT_INDEX_ARCHIVE.md`, enumerated by name in
`docs/AUDIT_CONTRACT.md`.

The four active records are the same four rows previously described as
unreconciled. The canonical text treated them as two populations, one
grandfathered and one pending; they are one.

The superseded total `13` appears in six files. No committed ledger state
contains 13 such rows under any tested population, and no derivation was ever
recorded. Operative text is corrected in place. The artifact and ledger row of
`TRACEBENCH_AUDIT_EVIDENCE_PROTOCOL_PASS` are completed audited records and are
not rewritten; the divergence is registered here instead.

## Repair 3: ownership

The four active records were assigned to "the docs-hygiene lock". The only such
lock in the repository, `TRACEBENCH_DOCS_HYGIENE_SCOPE_LOCK_PASS`, was last
recorded at `dbe9271` on 2026-06-19, five weeks before those rows existed, and
appears in no route owner today.

Deciding each row requires knowing whether an independent audit actually ran.
The repository does not hold that evidence, and a commit or push is not
evidence that it did. Ownership therefore moves to the non-executable
`NEEDS_USER_DECISION` sentinel, which is truthful, until an explicit human
route decision assigns a named executable pass.

Two further active rows assert an unresolved audit position without the
`PRE-AUDIT SNAPSHOT` label, so the counting method excludes them while the same
open question applies:
`TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS` and
`BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS`. They are named and share the
same owner. Neither row is edited, because choosing replacement wording would
require inferring whether an audit ran.

## Divergence register

- superseded archive anchor: `worktree` SHA-256 `eb16fd47…` at `284984` bytes;
  replaced by `blob` SHA-256 `94a40416…` at `284219` bytes and object id
  `cf8a3ffc…`
- superseded grandfathered total: `13`; replaced by a published counting method
  returning `6`
- superseded owner of four active records: the docs-hygiene lock; replaced by
  `NEEDS_USER_DECISION`

## Deferred, not armed

Repository line-ending normalization stays unarmed. The earlier claim that it
would churn the files this pass must hash is withdrawn as false: every tracked
text blob in `HEAD` is already `LF`.

Command and population, stated so the scan re-runs to the same numbers:

```text
git grep -I -l -P '\r' HEAD -- .      -> 0 files
git grep -l --text -P '\r' HEAD -- .  -> 11 files
git grep -l --text -P '\x00' HEAD -- . -> 11 files
```

The `-I` flag restricts the scan to text blobs, so `0` is a count over the text
subset, not over everything tracked. Of `875` tracked files, `864` are text and
`11` are binary PNG assets; those `11` are exactly the blobs containing a `NUL`
byte and exactly the `11` the `--text` run returns.

`text=auto` applies only to text blobs, so a future normalization is a content
no-op for them, and every `blob`-representation anchor published here survives
it unchanged. The deferral rests on severity order alone, recorded in
`docs/ACTIVE_SCOPE_LOCK.md`.

## SELF_REFERENCE_AUDIT

- touched artifact, ledger, and route-owner files checked: all seven
- no touched file asserts this pass's own staging or audit-pipeline position;
  the designated verdict block below is the only place a returned result is
  recorded
- generic policy examples distinguished from claims about the current pass: the
  representation rule and counting method in `docs/AUDIT_CONTRACT.md` are
  standing policy; the measured values in this artifact are claims about this
  pass's evidence
- pushed-Git facts cited here are time-invariant: commit hashes, parent, file
  sets, object ids, and blob contents
- one pre-existing violation found and deliberately not corrected: the
  preserved body of `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`
  contains a sentence asserting its own staging and audit position at authoring
  time. Because this pass updates that file, the prospective rule now reaches
  it. Rewriting the sentence would destroy the evidence of the state this
  correction documents, so the appended section labels the body as historical
  instead. Flagged here rather than silently left, and available to the auditor
  as a scope decision

## Validation

- `py -3 tools\validate_all.py`: `PASSED`, exit code `0`, `Ran 302 tests`, `OK`
- non-blocking warnings classified: three `[WARN] missing optional photo file`
  lines for `photos/top_backlight_001.jpg` and `photos/smoke_top_001.jpg`;
  these are expected optional-asset warnings in the sample fixtures and are
  unrelated to this docs-only pass
- validator scratch is written under the system temp directory, not the
  repository
- `git diff --name-only` and `git status --short --branch`: the seven files
  named above, plus the pre-existing untracked scratch inventory and the five
  content-free porcelain entries that were present at entry

## Route

Current: `TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS`
Next: `NEEDS_USER_DECISION`

No executable successor, closeout, route release, or later write authority is
reserved.

<!-- TRACEBENCH_AUDIT_VERDICT_BLOCK_BEGIN -->

Independent repo-local audit, returned result recorded as returned:

`AUDIT_VERDICT: PASS`

`SAFE_FOR_STAGING: YES`

`SAFE_STAGING_SET`:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_EVIDENCE_INTEGRITY_REPAIR_PASS.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

Focus results: measurement reproducibility `PASS`; no movement outside the
three patched passages `PASS`; no fourth unqualified population count `PASS`.
Boundary confirmed at seven files with an empty index.

Two independent audits were run for this pass. The first returned
`NEEDS_PATCH` against one published CR-scan measurement whose numerator counted
text blobs while its denominator counted every tracked file, so the command as
written returned `11` rather than the stated `0`. The correction qualified both
filter and population in all three passages carrying the claim. The second
audit re-ran all three published commands, reproduced `0`, `11`, and `11`,
confirmed the two eleven-file sets identical, and found no new defect.

One non-blocking `NIT`: the published scans use `git grep -P`, which needs a
PCRE-enabled Git build. Where PCRE is absent the command fails immediately
instead of returning a wrong number, so the failure mode is safe; `-e $'\r'` is
the portable form. It is left unchanged, because any content change outside
this block would require a further audit.

One item outside the audit's reach: the `validate_all.py` result was not
independently re-run, since execution writes `.codex/known_facts.json` and the
audit mandate excluded writes. The test count `302` was confirmed by
replicating the `loader.discover()` call at `tools/validate_all.py:115` with
zero load errors. The `PASSED` / exit `0` result recorded above rests on the
authoring runs alone.

<!-- TRACEBENCH_AUDIT_VERDICT_BLOCK_END -->
