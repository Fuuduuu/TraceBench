# Active Scope Lock

## Current armed implementation pass

None.

## Current docs-only scope-lock pass

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_COPY

## Baseline

- Expected and verified HEAD/origin before this scope-lock: `aa20c78` (`docs: record Board Canvas dark EDA style alignment`).
- Latest accepted/pushed closeout: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS` at `aa20c78`.
- Accepted/pushed implementation baseline: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS` at `725b8b8` (`feat(board-canvas): align dark EDA shell`).
- Accepted Board Canvas visual baseline: dark EDA shell/style alignment after the Project Overview / Workbench Home dark EDA family.
- Current route before this scope-lock: decision state with no implementation pass armed.

## Scope-lock allowlist

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`

No runtime or test files are authorized by this scope-lock.

## Future implementation intent

Future implementation may only polish remaining visible English/mixed Board Canvas shell/control labels toward clearer Estonian user-facing copy where safe.

Candidate future implementation files, subject to a separate active-lock sync:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The future active-lock sync must inspect live repo files and list the smallest exact implementation allowlist. This scope-lock does not arm implementation directly.

## Candidate copy areas

Future implementation may consider visible Board Canvas copy such as:

- `Measure`
- `Add Component`
- `Inspector`
- `Placements`
- `Safety`
- `Ready`
- `Beep`
- `Board Canvas`
- `BenchBeep · TraceBench platform`
- `renderer writes: none`
- `Panels`
- `Show All`
- nearby Board Canvas shell/control labels in the same visible copy cluster, if still present

Diagnostic or platform copy may remain unchanged when translation would reduce precision. Canonical domain terms must remain precise.

## Future implementation may only

- Replace remaining visible English/mixed Board Canvas shell/control labels with clearer Estonian user-facing copy.
- Preserve technical meaning.
- Preserve read-only / no-write meaning.
- Preserve disabled/future tool inertness.
- Preserve existing route/navigation/action behavior.
- Update focused Board Canvas widget tests only after a separate active-lock sync.
- Keep diagnostic copy such as `renderer writes: none` unchanged if it is intentionally technical and safer as-is.

## Must preserve

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- No save/write behavior from Board Canvas.
- Existing pan/zoom/fit/reset behavior.
- Existing tap-to-select behavior.
- Existing selected-pin persistence behavior.
- Existing inspector behavior.
- Existing placement rendering behavior.
- Existing measurement marker/summary behavior.
- Existing visual-trace/provenance behavior.
- Existing Add Component local UI-only behavior.
- Existing Measure Sheet route/save path.
- Existing Project Overview runtime behavior.
- Existing dark EDA visual styling unless a tiny copy-related style adjustment is unavoidable.
- BenchBeep / TraceBench / BoardFact naming boundaries.
- No canonical data rename.
- No project fact changes.
- No board fact changes.
- No schema changes.
- No writer/service changes.
- No materializer/validator/projection changes.
- No Project ZIP changes.
- No `events.jsonl` writes.
- No `known_facts` mutation.
- No canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Explicitly forbidden

- Runtime implementation in this scope-lock.
- Editing `lib/` in this scope-lock.
- Editing `test/` in this scope-lock.
- Editing `_incoming`.
- Importing, copying, bundling, staging, or depending on `_incoming` files at runtime.
- Adding logo/runtime assets.
- Editing `pubspec.yaml`.
- Global theme migration.
- Broad app-wide copy migration.
- Project Overview copy changes.
- Measure Sheet copy changes.
- Route/navigation rewiring.
- Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Schema, writer, materializer, validator, projection, event, fact, sample, platform, generated, or Project ZIP changes.
- Broad staging.

## Design source status

Prior dark EDA HTML/CSS, screenshots, and standalone HTML remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Route

- Current docs-only scope-lock pass: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS`.
- Current armed implementation pass: none.
- Route after accepted/pushed scope-lock: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
