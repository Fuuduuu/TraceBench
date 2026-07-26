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
