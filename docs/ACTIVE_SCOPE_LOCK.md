# Active Scope Lock

## Route

Current: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_SCOPE_LOCK_PASS`
Next: `TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS`

## Exact future allowlist

`TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS` is conditionally reserved. It
may activate only after this exact scope-lock diff is independently accepted
and pushed. Its complete future write allowlist is:

- `docs/code_maps/lib/features/project/screens/new_project_wizard_screen.dart.md`
- `docs/code_maps/test/widget/new_project_wizard_screen_test.dart.md`
- `docs/code_maps/CODE_MAP_INDEX.md`
- `docs/audit/TRACEBENCH_NEW_PROJECT_WIZARD_CODE_MAP_PASS.md`

No other file is authorized.

## Future map-pass contract

The future pass must describe accepted committed source only, follow
`docs/code_maps/CODE_MAP_STANDARD.md`, use stable symbol anchors rather than
maintained line numbers, create exactly two map files and two index rows, and
keep both maps descriptive and non-authorizing.

Both map files and index rows must begin as `REVIEW_REQUIRED`. Independent
Claude map-to-code audit is required before changing them to `MAINTAINED`, and
a final Claude diff audit is required before staging.

The mapped production and test files are inspect-only. The future pass must not
edit Dart, tests, schemas, tools, runtime, UI, assets, ZIP files, Project
Sources, handoffs, or design inputs.

## Excluded authority and stops

No Wizard V2 behavior, implementation pass, project-name, directory,
collision, persistence, event, outline, component, placement, router, writer,
or protected-surface authority is active or reserved.

Stop if either target no longer qualifies, either map requires a fifth file,
source or test changes are needed, or any product/implementation decision is
required.
