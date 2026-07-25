# AUDIT_INDEX.md

## Purpose and authority

This compact file is the active lookup surface for selected current evidence
anchors. It is audit/provenance lookup, not the active route pointer.

- `docs/CURRENT_STATE.md` owns the operational route handoff.
- `docs/PASS_QUEUE.md` owns sequencing and next-pass planning.
- `docs/ACTIVE_SCOPE_LOCK.md` owns active write authority.
- `docs/archive/AUDIT_INDEX_ARCHIVE.md` preserves the complete historical
  ledger and the archive/compaction evidence.
- Historical rows and their original ordering must be looked up in the
  archive; exact pass detail remains in the referenced `docs/audit/*.md`
  artifact.
- A compact anchor status may record later exact audit/Git evidence while its
  immutable historical artifact remains a temporal pre-audit snapshot; such
  divergence must be documented in the disposition register for the pass that
  performed the reconciliation.

## Active evidence anchors

| PASS_ID | File | Status | Description |
|---|---|---|---|
| TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS | docs/audit/TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_SCOPE_LOCK_PASS.md | `PRE-AUDIT SNAPSHOT`; independent audit not yet run; no audit verdict or staging-safety decision is claimed | Lane A docs-only scope lock at baseline `d01e49930937f2311194059172ad1d326d2a197f`; reserves `TRACEBENCH_FILE_MAP_DISPOSITION_OWNER_REPAIR_PASS` with an exact six-file future allowlist to correct only the inaccurate FILE_MAP archive disposition-owner wording plus minimum truthful route/audit/index records; preserves the archive as the immutable historical ledger snapshot, keeps per-pass disposition registers in their corresponding audit artifacts, leaves the Board Canvas code-map NIT deferred and unarmed, and does not edit FILE_MAP or any prior artifact. |
| BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS | docs/audit/BOARD_OUTLINE_V2_EVENT_FOUNDATION_IMPL_POST_AUDIT_PASS.md | accepted/pushed/independently audited as `fc2ec5d1a1601de8098c317ed0d587aa57071c3b` (`docs: close out board outline v2 event foundation`); human-supplied audit `PASS` / `SAFE_FOR_STAGING: YES` | Lane A exceptional docs-only route/authority and durable-risk closeout at baseline `ca93f2b029f127df3c2baff7a6f9f4bcd0830d15`; adds only the missing canonical `component_visual_placement_confirmed` table row, records the accepted implementation evidence, supersedes old scope-artifact gating wording as live authority without rewriting history, releases all route and write authority to the non-executable `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` sentinel, arms no future pass, and limits the closeout to the exact six-file allowlist. |
| TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS | docs/audit/TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_ABORT_CLOSEOUT_PASS.md | committed/pushed as `76580e0b9a40ae226b85ed5a740855296919dc34` (`docs: close out aborted repo skills catalogue parent`); independent audit not recorded | Lane A docs-only recovery closeout at baseline `c1fe3bc1768fe699f4dc435df309009d3c4a1985`; records the explicit human abort and retirement of `TRACEBENCH_REPO_SKILLS_CATALOGUE_PARENT_LOCK` without marking it completed; records Batch B, C, D, and `TRACEBENCH_REPO_SKILLS_CATALOGUE_CLOSEOUT_PASS` as `NOT_EXECUTED / NOT_AUDITED / RETIRED_UNSTARTED`; preserves completed Batch A at `fdf9b1998c1cf998210d7ea28529c64672f57169` and both `DEFERRED / UNPROVED / NON-BLOCKING` evidence items; returns all three route owners to `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION`, empties the queue, retires every parent and child allowlist, arms nothing, records the external V3.x branch as `ABANDONED / NEVER_MATERIALIZED_IN_REPO`, and carries the existing Batch A closeout pending-audit ledger/artifact mismatch as unresolved evidence debt without modifying prior history. |
| BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS | docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_POST_AUDIT_PASS.md | DRAFTED / PENDING CLAUDE AUDIT | Docs-only closeout for accepted/pushed production map `3ca031395425caa30de741b67309f22dec01f308` (`docs: add board canvas screen code map`); records the scope and reconciliation chain, exact three-file committed and final safe staging sets, Claude `MAP_VERDICT: ACCEPT_AS_IS`, `SAFE_FOR_SNIPER_USE: YES`, `AUDIT_VERDICT: ACCEPT_AS_IS`, and `SAFE_FOR_STAGING: YES`, maintained map/index state, unchanged source/tests, no test map, lock release, and route reset to `NEEDS_USER_DECISION`. |
| BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS | docs/audit/BOARD_CANVAS_SCREEN_TEST_CODE_MAP_POST_AUDIT_PASS.md | accepted/pushed/audited as `061ec7a0ce195e4d0560832631a25e55e3a0c1c2` (`docs: close out board canvas test code map`); Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`; blockers none; nits none | Docs-only lifecycle closeout for accepted/pushed test-map commit `041d3a710ac3f35092532d831ffc04eb57e38ebc` (`docs: add board canvas test code map`); records the accepted scope/reconciliation/map chain, Claude map and final-diff audits, exact committed set, maintained map/index state, unchanged source and production map, safe SNIPER use, lock release, and route reset to `NEEDS_USER_DECISION`. |
