# Active Scope Lock

## Current docs-only scope-lock pass

`V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_PROJECT_HOME_COPY

## Baseline

- Accepted/pushed standalone HTML design-source intake: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS` at `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Accepted/pushed Project Home dark EDA shell closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Accepted/pushed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Full implementation SHA: `5691e8de78b46cb45859337e089b84f206c2831b`.
- Current route before this lock: `NEEDS_USER_DECISION` with no implementation armed.
- Claude Code is temporarily unavailable for this scope-lock.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.

## Allowed files for this scope-lock

This scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS.md`

No runtime, test, asset, schema, writer, materializer, validator, projection, event, fact, sample, platform, generated, `_incoming`, or scratch file is authorized by this scope-lock.

## Future implementation scope to lock

Future implementation may only copy-polish visible Project Overview / Workbench Home dark EDA shell labels.

Future implementation may consider:

- replacing remaining mixed English/Estonian shell labels with clearer Estonian user-facing copy;
- keeping technical meaning precise;
- preserving read-only / non-writing status;
- preserving disabled/future tool inertness;
- preserving BenchBeep / TraceBench / BoardFact naming boundaries;
- updating focused widget tests only after a separate active-lock sync.

Candidate copy areas:

- `Board workspace (read-only)`
- `Known facts`
- `Not populated`
- `Future tools`
- nearby Project Overview / Workbench Home shell labels that are part of the same visible copy cluster.

## Future implementation must preserve

- No canonical data rename.
- No project fact change.
- No board fact change.
- No route behavior change.
- No navigation behavior change.
- No Board Canvas behavior change.
- No Measure Sheet save behavior change.
- No logo/runtime assets.
- No HTML/CSS/JS reuse from `_incoming`.
- No inference of canonical nets, pins, measurements, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts from copy.

## Design source status

The standalone dark HTML and prior dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Explicitly forbidden

- Editing `lib/` or `test/`.
- Editing `_incoming`.
- Editing assets or `pubspec.yaml`.
- Arming implementation directly.
- Starting runtime implementation in this pass.
- Starting global dark theme.
- Starting Board Canvas dark EDA migration.
- Adding route/navigation behavior.
- Adding runtime dependencies.
- Adding logo/font/runtime assets.
- Changing Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Editing schema, writer, materializer, validator, projection, Project ZIP, events, facts, samples, platform files, or generated files.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Expected next route

After this scope-lock is accepted/pushed, route to:

`V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`

That active-lock sync must inspect live repo files and arm the exact future implementation allowlist. This scope-lock does not arm implementation directly.
