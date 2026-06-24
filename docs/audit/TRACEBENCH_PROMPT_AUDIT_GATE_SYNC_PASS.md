# TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS

## Status

Current docs-only prompting/audit-gate protocol sync candidate.

## Baseline

- Latest accepted/pushed pass: `TRACEBENCH_STALE_SECONDARY_POINTER_SYNC_PASS`.
- Latest accepted/pushed commit: `ebda2dc` (`docs: sync stale secondary pointers`).
- Current route before and after this pass: `NEEDS_USER_DECISION`.

## Scope

This pass updates only prompting/audit/lifecycle protocol docs and the audit index.

Allowed files:

- `docs/PROMPTING_PROTOCOL.md`
- `docs/AUDIT_CONTRACT.md`
- `docs/PASS_LIFECYCLE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS.md`

## Recorded rules

- Every TraceBench Codex PASS_ID response must end with a clearly separated `CLAUDE_AUDIT_PACKET`.
- The packet must be paste-ready for Claude Code.
- The packet must include expected diff, do-not-edit/stage/commit/push instructions, focused audit checklist, validation commands/results, verdict format, and exact safe staging set if accepted.
- Visual/product-surface work requires manual smoke before Claude audit.
- Visual/manual-smoke packets must be marked `USE ONLY AFTER MANUAL SMOKE PASS`.
- Claude audit must not be used to approve a known-wrong visual draft.
- `Accepted` shorthand is valid only for clean `ACCEPT_AS_IS`, `SAFE_FOR_STAGING: YES`, no blockers, and exact expected staging set.
- Any `ACCEPT_WITH_NITS`, blocker, unsafe staging, route/hash mismatch, unexpected file, protected-surface concern, staging-set mismatch, or unclear/conditional acceptance requires the relevant Claude audit details.
- Protected implementation may begin only when `docs/ACTIVE_SCOPE_LOCK.md` names the implementation pass and lists the exact runtime/test write allowlist.
- If the active lock still names the docs-only scope-lock or lacks the runtime/test allowlist, route first to `<IMPLEMENTATION_PASS>_ACTIVE_LOCK_SYNC_PASS`.
- Active-lock sync passes are docs-only and must not implement runtime behavior.
- Staging remains exact-file only; `git add .`, `git add -A`, and broad staging remain forbidden.

## Preserved boundaries

- BenchBeep remains the user-facing app/product name.
- TraceBench remains the repo/platform/project name.
- BoardFact remains the data-fact/subsystem name.
- Runtime/product scope is unchanged.
- No runtime or test files changed.
- No product behavior changed.
- No protected data/write surfaces changed.
- No source/design runtime dependency was introduced.
- Historical audit artifacts were not deleted or rewritten.
- The separate missing `33d2f17` AUDIT_INDEX pointer sync was not addressed in this pass.
- Memory/handoff refresh and product identity cleanup remain separate.

## Route

- Current pass: `TRACEBENCH_PROMPT_AUDIT_GATE_SYNC_PASS`.
- Route after accepted/pushed: `NEEDS_USER_DECISION`.

## Validation

Requested validation commands:

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

## Staging

- STAGED: NO
- COMMITTED: NO
- PUSHED: NO

