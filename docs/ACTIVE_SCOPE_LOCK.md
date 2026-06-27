# Active Scope Lock

## Armed implementation pass

`V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS`

## Type

LANE_B_ADJACENT / FLUTTER_UI_PROTECTED_IMPLEMENTATION / PROJECT_HOME_COPY_POLISH

## Active-lock sync source

- Current docs-only active-lock sync: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Accepted/pushed copy-polish scope-lock: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_SCOPE_LOCK_PASS` at `10c4561` (`docs: lock Project Home dark EDA copy polish`).
- Accepted/pushed standalone HTML design-source intake: `V2_PROJECT_HOME_DARK_EDA_STANDALONE_HTML_DESIGN_SOURCE_INTAKE_PASS` at `0e59ce9` (`docs: intake standalone dark EDA design source`).
- Accepted/pushed Project Home dark EDA shell closeout: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_POST_AUDIT_PASS` at `aa4b907` (`docs: record Project Home dark EDA shell`).
- Accepted/pushed implementation pass: `V2_PROJECT_HOME_DARK_EDA_SHELL_IMPL_PASS` at `5691e8d` (`feat(project-overview): polish dark EDA shell`).
- Claude Code is temporarily unavailable for this active-lock sync.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.

## Exact future implementation allowlist

Future implementation may edit only:

- `lib/features/project/screens/project_overview_screen.dart`
- `test/widget/project_overview_screen_test.dart`

No broad directories are authorized.

## Target surface decision

The inspected target surface for the future implementation is Project Overview / Workbench Home.

Rationale:

- The candidate visible labels are rendered in `lib/features/project/screens/project_overview_screen.dart`.
- Existing focused coverage for this surface lives in `test/widget/project_overview_screen_test.dart`.
- No Board Canvas, router, BenchBeep Home, legacy Home, Measure Sheet, asset, `pubspec.yaml`, schema, writer, materializer, validator, projection, event, fact, sample, platform, or generated file is required for the scoped copy-polish implementation.

## Future implementation may only

- Replace remaining mixed English/Estonian Project Overview / Workbench Home shell labels with clearer Estonian user-facing copy.
- Keep technical meaning precise.
- Preserve read-only / non-writing status.
- Preserve disabled/future tool inertness.
- Preserve BenchBeep / TraceBench / BoardFact naming boundaries.
- Update focused widget tests for changed labels.

Candidate visible labels:

- `Board workspace (read-only)`
- `Known facts`
- `Not populated`
- `Future tools`
- nearby Project Overview / Workbench Home shell labels in the same visible copy cluster.

## Future implementation must preserve

- No canonical data rename.
- No project fact changes.
- No board fact changes.
- No route behavior changes.
- No navigation behavior changes.
- No Board Canvas behavior changes.
- No Measure Sheet save behavior changes.
- No logo/runtime assets.
- No HTML/CSS/JS reuse from `_incoming`.
- No canonical nets, pins, measurements, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts inferred from copy.

## Design source status

The standalone dark HTML and prior dark EDA HTML/CSS remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Explicitly forbidden

- Editing files outside the exact future implementation allowlist.
- Editing `_incoming`.
- Editing assets or `pubspec.yaml`.
- Editing router, Board Canvas, BenchBeep Home, legacy Home, Measure Sheet, writer/service, schema, validator, materializer, projection, ZIP, events, facts, samples, platform files, generated files, or unrelated docs.
- Broadening copy-polish into route/navigation behavior.
- Starting global dark theme.
- Starting Board Canvas dark EDA migration.
- Adding runtime dependencies.
- Adding logo/font/runtime assets.
- Arming Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Writing `events.jsonl`.
- Mutating `known_facts`.
- Creating or implying canonical measurements, facts, nets, pin mappings, placement semantics, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Route

- Current docs-only sync pass: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Armed next implementation pass: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS`.
