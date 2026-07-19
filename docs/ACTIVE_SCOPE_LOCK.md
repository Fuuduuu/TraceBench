# Active Scope Lock

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

The route is the terminal, non-executable human-decision sentinel mandated by
the committed human closeout authority amendment at
`1fc4e0f47395a86a04e34253c96dfb1a5f8b5f65`. It is not a runnable PASS_ID and
not a pass self-loop.

## No active lock

No scope lock is active and no writable allowlist exists. All Batch A
authority is retired and historical:

- the docs-only active-lock sync allowlist, satisfied and spent at
  `5de88b9bb33d3aa8039a4adbfa0ff1bec69f68b8` and reconciled at
  `0a0c2a627ba56a441c1a49ebf9e275968488157f`;
- the five-path implementation allowlist, spent at
  `fb259edb3c73bdc9a2eedd5c10ef702ebd335c17` with its append-only correction
  at `8f600575a9b2a1bedc11e2424a3ec4e9161f049e`;
- the human closeout authority amendment, recorded at
  `1fc4e0f47395a86a04e34253c96dfb1a5f8b5f65`; and
- the five-path closeout allowlist of
  `TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS`, consumed by the
  closeout diff recorded in
  `docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_POST_AUDIT_PASS.md` and
  retired on that closeout's acceptance.

None of these grants any further write authority to any PASS_ID. Superseded
allowlist wording in earlier committed revisions of this file is historical
evidence only and is not standing authority.

## Preserved standing rules

`docs/POHIKIRI.md` remains the charter and conflict-stop authority. The
accepted architecture remains owned by
`docs/spec/TRACEBENCH_REPO_SKILLS_ARCHITECTURE.md`. External tooling remains
default-off under `docs/CODEX_TOOLING_POLICY.md`.

The implementation artifact's committed blank-at-eol evidence exception
remains valid and limited to its byte-preserved verbatim response blocks in
`docs/audit/TRACEBENCH_REPO_SKILLS_BATCH_A_IMPL_PASS.md`. The 48 evidence
spaces must not be normalized.

Known scratch remains outside authority and must stay preserved and unstaged.
Staging, commit, and push remain human-only, after independent Claude audit,
with exact-file staging.

## Terminal non-authorization

Batch B, C, and D, `tracebench-code-map-lifecycle`, recovery scope locks,
active-lock syncs, reconciliation passes, deferred-wording or live-authority
repairs, generic/personal extraction, Markdown compaction, Photo-to-Canvas,
skill edits, `lib/**`, `test/**`, `tools/**`, validators, schemas, packages,
assets, `_incoming`, code maps, runtime, writers, events, facts, projections,
Project ZIP, and protected semantics remain excluded. Arming any future pass
requires a new explicit human route decision and, where governance requires
it, a new scope lock.
