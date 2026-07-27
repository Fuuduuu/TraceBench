# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`
Next: `NEEDS_USER_DECISION`

## Current docs-only code-map Phase 2

Phase 1 verified two descriptive code-map bodies against committed source,
recorded both maps and both index rows as `REVIEW_REQUIRED`, rebased the audit
artifact to the amended lock, and advanced the route. Phase 2 records the
independent map audit and promotes both maps and both index rows to
`MAINTAINED`. It changes no Dart source, test, runtime behavior, or Wizard V2
product contract.

The production target qualifies automatically through five or more
independently testable behaviors. Its focused widget test qualifies at
`SCORE 6/12`. Their deterministic maps and index rows were absent at the
original qualification baseline
`d8d983f104bb66bec39e182ffcba1dd552005348`.

## Satisfied activation condition

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` activated after the amended scope
lock was accepted and pushed as
`480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`.

The active pass is limited to the exact amended eight-file allowlist in
`docs/ACTIVE_SCOPE_LOCK.md`. Phase 1 stopped with both maps and both index rows
at `REVIEW_REQUIRED`. The supplied independent audit returned
`MAP_VERDICT: ACCEPT_WITH_NITS` and `SAFE_FOR_SNIPER_USE: YES`; Phase 2
therefore promotes them to `MAINTAINED`. Final Claude diff audit remains
required before staging.

`NEEDS_USER_DECISION` is the proposed non-executable next pointer because no
new successor is authorized or needed for Phase 2. No Wizard implementation
pass, product behavior, or runtime authority is queued or reserved.

## Scope-lock amendment (accepted and pushed)

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` amended the
lock at baseline `363d86bf81266a6205fff2f0f07d9a302077065c` and was accepted
and pushed as `480d79d9a21ea8bb67dffbabd5e275d51a93b6d7`.

The exact four-file allowlist referenced above is superseded history. The live
active allowlist is the exact eight-file list owned by
`docs/ACTIVE_SCOPE_LOCK.md`, which adds `docs/CURRENT_STATE.md`,
`docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md` so
the active pass can record its own route state and ledger row in-pass.

At amendment time, `Current` and `Next` were deliberately unchanged because
the amendment was an in-place fixup of the current lock rather than a second
active pass. The amendment queued no new pass:
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` remained the same reserved
successor.

That condition is now satisfied. The code-map pass is `Current`, and
`NEEDS_USER_DECISION` is `Next` without reserving a new executable successor.
No closeout, route-release, or pointer-reset pass is queued or permitted for
this route.
