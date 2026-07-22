# Current State

Current pass: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS`

The current pass is a docs-only scope lock for one later audit-index archive
and compaction pass. It starts from accepted pushed baseline
`fc2ec5d1a1601de8098c317ed0d587aa57071c3b` (`docs: close out board outline
v2 event foundation`) and changes only the three route owners, the audit index,
and its new scope-lock evidence artifact.

## Current authority

Only `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS` is active.
Its exact write allowlist is:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS.md`

The new audit record and ledger row are a `PRE-AUDIT SNAPSHOT`. They claim no
independent verdict and no staging-safety decision.

## Reserved next pass

`TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS` is reserved, not active. It
may begin only after this exact scope-lock diff is independently accepted,
committed and pushed by the human, followed by a no-drift recheck. Its purpose
is to preserve the complete pre-compaction ledger in the archive, reduce the
active index to its authority/lookup contract and four named evidence anchors,
and add a truthful evidence-based disposition register without rewriting any
existing audit artifact.

Source-package cleanup, repo-skill hardening, and code-map expansion remain
deferred and unarmed.
