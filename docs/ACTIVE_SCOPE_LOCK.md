# Active Scope Lock

## Route

Current: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS`

## Active authority

Only `TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS` is active.
This docs-only pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_SCOPE_LOCK_PASS.md`

It must not create the archive, compact the ledger, classify historical rows,
rewrite an existing audit artifact, or activate any implementation or cleanup
work. Its ledger row and artifact are `PRE-AUDIT SNAPSHOT` evidence only.

## Reserved future authority

`TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS` is reserved but not active.
After independent acceptance of this amendment, an exact human commit/push,
and a no-drift recheck, that pass may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/archive/AUDIT_INDEX_ARCHIVE.md`
- `docs/FILE_MAP.md`
- `docs/audit/TRACEBENCH_AUDIT_INDEX_ARCHIVE_COMPACTION_PASS.md`

The future pass must:

1. Preserve the complete starting `docs/AUDIT_INDEX.md` ledger before any row
   is removed or compacted, retaining every historical row and convention.
2. Leave every existing `docs/audit/*.md` artifact byte-identical.
3. Add a disposition register whose classifications are supported by exact
   artifact and Git evidence, never by a status label or descriptive claim
   alone.
4. Keep pushed-but-unaudited work as historical evidence debt, keep
   pre-audit records explicitly without a verdict, and use
   `RETIRED / NOT_EXECUTED` only for work proved genuinely unexecuted.
5. Reduce the active audit index to its purpose and authority rules, an archive
   pointer, lookup instructions, and exactly these four evidence anchors:
   - `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS`
   - `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS`
   - `BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS`
   - `BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS`
6. Update `docs/FILE_MAP.md` only to register the resulting active-index and
   archive roles; make no broader documentation-lifecycle change.
7. Record both the complete pipe-prefixed-line count and the true PASS_ID
   data-row count, excluding the markdown table header and separator from the
   latter. Recompute both values from the live future baseline and do not reuse
   the historical header-inclusive `753 -> 754` figures as true data-row
   counts.
8. Reconcile `BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS` from the
   supplied exact evidence: `AUDIT_VERDICT: PASS`, `SAFE_FOR_STAGING: YES`, and
   pushed closeout commit
   `fc2ec5d1a1601de8098c317ed0d587aa57071c3b`. Record it as
   accepted/pushed/audited evidence, not pushed-but-unaudited evidence debt.
9. Leave every other existing audit artifact byte-identical.
10. After successful completion, update `docs/CURRENT_STATE.md`,
    `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md` to
    `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`. State that the matching
    values are a non-executable sentinel, not a self-loop, and create no
    recursive closeout or audit-of-audit pass.

If complete preservation cannot be proved before compaction, evidence is
ambiguous, a required existing artifact would need modification, or the exact
seven-file future allowlist is insufficient, the future pass must stop.

## Exclusions

Source-package cleanup, repo-skill hardening, code-map expansion, skills,
policy, source/design inputs, runtime, schemas, tools, tests, Dart, Flutter,
packages, assets, Project ZIP, and all protected semantics remain outside this
lock and unarmed.
