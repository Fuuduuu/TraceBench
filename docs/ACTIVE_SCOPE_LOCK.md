# Active Scope Lock

## Route

Current: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS`
Next: `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS`

`docs/POHIKIRI.md` remains the charter and conflict-stop authority. The
accepted architecture remains owned by
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`. This active lock
incorporates the accepted Batch A contract; detailed evidence is recorded in
`docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_SCOPE_LOCK_PASS.md`.

## Transition gate and current sync authority

The route above is the post-sync state. Until this exact sync is independently
audited, accepted, exactly committed, and pushed, implementation may not begin.
The current docs-only sync may write exactly:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

This transition authority creates or edits no skill, policy, implementation
artifact, pressure evidence, stage, commit, or push.

## Implementation authority after accepted and pushed sync

After that transition gate is satisfied,
`TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS` may write exactly:

- `.agents/skills/tracebench-prompt-authoring/SKILL.md`
- `.agents/skills/tracebench-scope-lock/SKILL.md`
- `.agents/skills/tracebench-audit-reconciliation/SKILL.md`
- `docs/CODEX_TOOLING_POLICY.md`
- `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS.md`

No sixth path, wildcard, optional file, fixture, harness, helper, or supporting
file is authorized.

## Locked Batch A contract

Batch A contains only new `tracebench-prompt-authoring`,
`tracebench-scope-lock` as `formalize/rewrite`, and new
`tracebench-audit-reconciliation`. Each skill uses matching lowercase-hyphen
directory/name, YAML `name` and trigger-only third-person `description`, and a
concise pointer-based non-authorizing body.

Implementation processes the skills serially. A genuine RED precedes creation
of each new skill; the scope-lock rewrite RED uses its committed baseline
skill. Each paired GREEN uses the identical task, model, reasoning level, and
repo fixture with only ordinary candidate-skill availability changed. Ordinary
discovery must be proven; evaluator prompts may not inject the workflow.
Evaluators remain fresh-context, read-only, and response-only. No permanent
harness or supporting file is allowed.

Stop with `BLOCKED_PRESSURE_TEST_CAPABILITY` when genuine evaluation is
unavailable and `BLOCKED_PRESSURE_TEST_CONTRACT_GAP` when the paired contract
cannot be preserved. Generic/personal extraction stays excluded and external
tooling remains default-off.

## Inspect-only and excluded surfaces

The charter, route owners, audit/index owners, prompting/audit/model/lifecycle
governance, protected-surface owner, architecture spec, accepted scope-lock and
sync evidence, and all non-allowlisted skills are inspect-only during
implementation. The post-audit PASS_ID is sequencing only and authorizes no
file.

Batch B, C, and D, `tracebench-code-map-lifecycle`, generic/personal
extraction, Markdown compaction, Photo-to-Canvas, other skills or docs,
`lib/**`, `test/**`, `tools/**`, validators, schemas, packages, assets,
`_incoming`, code maps, runtime, writers, events, facts, projections, Project
ZIP, and protected semantics remain excluded.

## Staging, scratch, validation, and stops

Known scratch remains outside authority and must stay preserved and unstaged.
Neither this sync nor implementation has staging, commit, or push authority;
independent Claude acceptance and explicit human exact-file authority remain
mandatory.

Run the exact validation and preservation checks in the governing pass. Stop
on baseline, dirty-state, allowlist, governance, skill-inventory, pressure-test
contract, or independent-zone conflict.
