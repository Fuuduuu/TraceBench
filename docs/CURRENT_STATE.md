# Current State

Current pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
Next recommended pass: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

This Lane A docs-only scope lock reserves one future code-map pass for the
qualifying New Project Wizard production screen and focused widget test. It
defines no Wizard V2 product behavior and reserves no implementation authority.

## Qualification evidence

At baseline `d8d983f104bb66bec39e182ffcba1dd552005348`,
`lib/features/project/screens/new_project_wizard_screen.dart` qualifies
automatically because it owns at least five independently testable behaviors.
`test/widget/new_project_wizard_screen_test.dart` qualifies at `SCORE 6/12`.

Both deterministic maps and both `docs/code_maps/CODE_MAP_INDEX.md` rows are
absent. This scope lock changes no source responsibility zone; both target Dart
files remain inspect-only.

## Conditional future reservation

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` is reserved only after this exact
scope-lock diff is independently accepted and pushed. Its exact four-file
future allowlist is owned by `docs/ACTIVE_SCOPE_LOCK.md`.

The future pass creates only two descriptive maps, two index rows, and its own
audit artifact. Wizard V2 implementation remains inactive and unreserved.

## Scope-lock amendment (route unchanged)

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_AMENDMENT_PASS` amended the
lock at baseline `363d86bf81266a6205fff2f0f07d9a302077065c`. The four-file
future allowlist quoted above is superseded history; the live future authority
is the exact eight-file list in `docs/ACTIVE_SCOPE_LOCK.md`, which adds the
three route owners and `docs/AUDIT_INDEX.md`.

The amendment was required because the four-file list left
`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` unable to record its own route
state or the ledger row `docs/AUDIT_CONTRACT.md` requires for every new audit
artifact. That allowlist is insufficient, not absent.

`Current pass` and `Next recommended pass` are deliberately unchanged by this
amendment, which is an in-place fixup of the lock `Current pass` already names
rather than a second active pass. Both map files and both index rows must begin
as `REVIEW_REQUIRED`;
the independent map-to-code audit, the promotion to `MAINTAINED`, and the final
diff audit all occur inside the successor pass before any staging. No closeout
or route-release pass may be created for this route.
