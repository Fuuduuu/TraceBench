# Active Scope Lock

## Route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
Next: `NEEDS_USER_DECISION`

## Exact future allowlist

> SUPERSEDED by `## Amended exact future allowlist` below, per
> `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS`. This
> section is retained verbatim as historical record and is no longer the live
> write authority.

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` is conditionally reserved. It
may activate only after this exact scope-lock diff is independently accepted
and pushed. Its complete future write allowlist is:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

No other file is authorized.

## Amended exact future allowlist

Amended by `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` at
baseline `363d86bf81266a6205fff2f0f07d9a302077065c`. This section is the live
write authority for the reserved successor and supersedes the four-file list
above.

Reason for amendment: the superseded four-file list gave
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` no write authority over the three
route owners or `docs/AUDIT_INDEX.md`. That pass could therefore not record its
own route state or the ledger row `docs/AUDIT_CONTRACT.md` requires for every
new audit artifact. That allowlist is insufficient, not absent: this lock names
both its PASS_ID and an allowlist, and is deficient only by narrowness.
`docs/PASS_LIFECYCLE.md:47-48` is supporting analogy only; it governs protected
implementation locks and is not triggered literally here.

The activation condition for
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` is satisfied: the amendment was
accepted and pushed as
`480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`. The pass is now active, and its
complete write allowlist is exactly:

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

No other file is authorized. The amendment itself did not advance `Current` or
`Next`, armed no implementation authority, and granted no Wizard V2 product,
runtime, Dart, test, schema, tool, asset, or protected-surface authority.

At amendment time, `Current` and `Next` were deliberately unchanged because
the amendment was an in-place fixup of the current lock, not a second active
pass. It opened no parallel PASS_ID beside
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`, whose PASS_ID is
already complete, committed, and pushed.

## Amended status and audit gates

Both map files and both `docs/code_maps/CODE_MAP_INDEX.md` rows must begin as
`REVIEW_REQUIRED`. An uncommitted worktree copy that already reads `MAINTAINED`
carries no authority and must be reverted to `REVIEW_REQUIRED` inside the
active pass before its diff is offered for audit.

Both required audits occur inside `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
itself, before any staging, in this order:

1. Independent Claude map-to-code audit, run while both maps and both index
   rows still read `REVIEW_REQUIRED`.
2. Promotion to `MAINTAINED` only after that audit returns clean, recorded in
   the same pass with `Audit evidence:` citing
   `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`.
3. Final independent Claude diff audit of the complete eight-file diff.
4. Exact human `git add <file>` staging, then commit and push.

Phase 1 advances `Current` to
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` and `Next` to the non-executable
`NEEDS_USER_DECISION` sentinel. Phase 2 remains inside the same PASS_ID after a
clean map-to-code audit; the sentinel reserves no executable successor. No
closeout, route-release, ceremony, or pointer-reset pass may be created for
this route.

## Future map-pass contract

This section governs the active pass as amended:
`## Amended exact future allowlist`
and `## Amended status and audit gates` above add the route and ledger
obligations and the audit sequencing, and win on any conflict.

The active pass must describe accepted committed source only, follow
`docs/code_maps/CODE_MAP_STANDARD.md`, use stable symbol anchors rather than
maintained line numbers, create exactly two map files and two index rows, and
keep both maps descriptive and non-authorizing.

Both map files and index rows must begin as `REVIEW_REQUIRED`. Independent
Claude map-to-code audit is required before changing them to `MAINTAINED`, and
a final Claude diff audit is required before staging.

The mapped production and test files are inspect-only. The active pass must not
edit Dart, tests, schemas, tools, runtime, UI, assets, ZIP files, Project
Sources, handoffs, or design inputs.

## Excluded authority and stops

No Wizard V2 behavior, implementation pass, project-name, directory,
collision, persistence, event, outline, component, placement, router, writer,
or protected-surface authority is active or reserved.

Stop if either target no longer qualifies, any file outside the exact amended
eight-file active-pass allowlist is required, source or test changes are needed,
or any product/implementation decision is required.
