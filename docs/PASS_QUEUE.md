# Pass Queue

## Current route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

## Current docs-only scope lock

The current pass records only the verified need for two maintained code maps.
It changes no code map, index row, Dart source, test, runtime behavior, or
Wizard V2 product contract.

The production target qualifies automatically through five or more
independently testable behaviors. Its focused widget test qualifies at
`SCORE 6/12`. Their deterministic maps and index rows are absent at baseline
`d8d983f104bb66bec39e182ffcba1dd552005348`.

## Conditional next pass

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` may activate only after this
scope-lock diff receives independent `scope-lock-post-audit` acceptance and
the exact accepted files are pushed.

That future pass is limited to the exact four-file allowlist in
`docs/ACTIVE_SCOPE_LOCK.md`. It begins both maps and index rows as
`REVIEW_REQUIRED`, requires independent map-to-code audit before
`MAINTAINED`, and requires a final Claude diff audit before staging.

No Wizard implementation pass, product behavior, or runtime authority is
queued or reserved.

## Scope-lock amendment (queue unchanged)

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` amended the
lock at baseline `363d86bf81266a6205fff2f0f07d9a302077065c` and is itself
awaiting independent audit and push.

The exact four-file allowlist referenced above is superseded history. The live
future allowlist is the exact eight-file list owned by
`docs/ACTIVE_SCOPE_LOCK.md`, which adds `docs/CURRENT_STATE.md`,
`docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`, and `docs/AUDIT_INDEX.md` so
the successor can record its own route state and ledger row in-pass.

`Current` and `Next` are deliberately unchanged, because this amendment is an
in-place fixup of the current lock rather than a second active pass. The
amendment queues no new
pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` remains the same reserved
successor, still conditional on this amendment being independently accepted and
pushed. No closeout, route-release, or pointer-reset pass is queued or
permitted for this route.
