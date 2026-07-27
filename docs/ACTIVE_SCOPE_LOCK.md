# Active Scope Lock

## Route

Current: `TRACEBENCH_AGENT_ORIENTATION_PASS`
Next: `NEEDS_USER_DECISION`

## Authority transition

The completed `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` has no standing
write authority. Its map audit, `MAINTAINED` promotion, final diff audit, and
exact staging/commit/push gates all completed at
`3e5edad0956c852584543bc643ca7306caee9e8e`. The superseding evidence was
reconciled and pushed at
`3e7ba9e97b5b45af158b8d7922915065d7677273`.

The former eight-file allowlist is spent and retained only in Git and its
existing audit evidence. It grants no writes to this or any later pass. The
explicit human route decision selected this pass from `NEEDS_USER_DECISION`;
no prior allowlist is inherited.

## Exact current write allowlist

`TRACEBENCH_AGENT_ORIENTATION_PASS` may write exactly:

- `CLAUDE.md`
- `docs/PROJECT_MINI_MAP.md`
- `AGENTS.md`
- `docs/FILE_MAP.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/TRACEBENCH_AGENT_ORIENTATION_PASS.md`

No other file is authorized.

## Required outcomes

- keep `CLAUDE.md` pointer-only and at or below 30 physical lines
- keep `docs/PROJECT_MINI_MAP.md` pasteable and between 40 and 60 lines
- preserve the exact five-file default read set and canonical conflict order
- add inbound pointers for both orientation files
- name `.agents/skills/**` and `docs/CODEX_TOOLING_POLICY.md` for capability discovery
- keep `Next` at the non-executable `NEEDS_USER_DECISION` sentinel
- add exactly one ledger row and one audit artifact for this pass

## Forbidden surfaces

No Dart, test, schema, tool, asset, ZIP, runtime, `_incoming`, or
`.agents/skills/**` file may change. No other documentation or audit artifact
may change. Known routing and docs-hygiene findings remain outside this pass.

This pass defines no product behavior, implementation authority, protected
surface, or executable successor.

## Audit and staging gates

1. Complete the exact nine-file docs diff.
2. Run required validation and boundary checks.
3. Obtain independent Claude audit of the complete diff.
4. Only an accepted exact staging set may be staged by the human.

Nothing is staged, committed, or pushed by this pass.

## Stops

Stop if any tenth file is required, either line limit cannot be met, the
five-file model or conflict order cannot be preserved, validation exposes a
scope-relevant failure, or any product, implementation, or protected-surface
decision is required.
