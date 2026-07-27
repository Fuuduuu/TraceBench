# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
Next recommended pass: `NEEDS_USER_DECISION`

This Lane A docs-only code-map pass is in Phase 2 of 2. The independent Claude
map-to-code audit returned `MAP_VERDICT: ACCEPT_WITH_NITS` and
`SAFE_FOR_SNIPER_USE: YES`; both maps and both index rows are now
`MAINTAINED`. Final independent diff audit remains required before staging.
The pass defines no Wizard V2 product behavior and carries no implementation
authority.

## Qualification evidence

At baseline `d8d983f104bb66bec39e182ffcba1dd552005348`,
`lib/features/project/screens/new_project_wizard_screen.dart` qualifies
automatically because it owns at least five independently testable behaviors.
`test/widget/new_project_wizard_screen_test.dart` qualifies at `SCORE 6/12`.

At that original qualification baseline, both deterministic maps and both
`docs/code_maps/CODE_MAP_INDEX.md` rows were absent. That scope lock changed no
source responsibility zone; both target Dart files remain inspect-only.

## Satisfied conditional reservation

The reservation condition for
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` was satisfied when the amended
scope lock was accepted and pushed as
`480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`. The pass is now active under the
exact amended eight-file allowlist owned by `docs/ACTIVE_SCOPE_LOCK.md`.

Phase 1 created only two descriptive maps, two index rows, its own audit
artifact, and the required route/ledger evidence. Wizard V2 implementation
remains inactive and unreserved.

## Scope-lock amendment and active route

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` amended the
lock at baseline `363d86bf81266a6205fff2f0f07d9a302077065c`. The four-file
future allowlist quoted above is superseded history; the live active authority
is the exact eight-file list in `docs/ACTIVE_SCOPE_LOCK.md`, which adds the
three route owners and `docs/AUDIT_INDEX.md`.

The amendment was required because the four-file list left
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` unable to record its own route
state or the ledger row `docs/AUDIT_CONTRACT.md` requires for every new audit
artifact. That allowlist is insufficient, not absent.

At amendment time, `Current pass` and `Next recommended pass` were deliberately
unchanged because the amendment was an in-place fixup of the lock then named
by `Current pass`, rather than a second active pass. Both map files and both
index rows began as `REVIEW_REQUIRED`. The independent map-to-code audit is
now recorded, and Phase 2 promoted both maps and both index rows to
`MAINTAINED`; final diff audit remains open before any staging.

Phase 1 advanced `Current pass` to
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` and proposed
`NEEDS_USER_DECISION` as `Next recommended pass`. This non-executable sentinel
does not reserve a successor. Phase 2 leaves both pointers unchanged and stops
for final independent diff audit inside the same PASS_ID. No closeout or
route-release pass may be created for this route.
