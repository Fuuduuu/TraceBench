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
