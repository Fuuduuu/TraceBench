# Active Scope Lock

## Current armed implementation pass

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS`

## Current docs-only active-lock sync pass

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Type

LANE_B_ADJACENT / DOCS_ACTIVE_LOCK_SYNC / PROTECTED_UI_BOARD_CANVAS_COPY

## Baseline

- Expected and verified HEAD/origin before this active-lock sync: `375b8da` (`docs: lock Board Canvas remaining copy polish`).
- Full scope-lock SHA: `375b8da706b21d0e4cfd1f7a6ed056f43a92ef47`.
- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS` at `375b8da` (`docs: lock Board Canvas remaining copy polish`).
- `git show --name-status --oneline 375b8da` confirmed the scope-lock commit changed:
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_SCOPE_LOCK_PASS.md`
- Prior accepted/pushed closeout: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_POST_AUDIT_PASS` at `aa20c78` (`docs: record Board Canvas dark EDA style alignment`).
- Accepted Board Canvas visual baseline: dark EDA shell/style alignment after the Project Overview / Workbench Home dark EDA family.

## Active-lock sync allowlist

This docs-only active-lock sync may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

No runtime or test files are authorized by this sync pass.

## Future implementation allowlist

`V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS` may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No broad directories are authorized. If implementation requires any additional file, the implementation must stop and route a new active-lock sync with the exact file and rationale.

## Target surface decision

- Target surface: Board Canvas visible shell/control copy only.
- Runtime owner selected by live inspection: `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Focused test owner selected by live inspection: `test/widget/board_canvas_screen_test.dart`.
- Project Overview / Workbench Home remains reference context only and is not authorized for implementation by this active lock.
- Measure Sheet remains out of scope.

## Candidate copy areas

Future implementation may consider visible Board Canvas labels/buttons such as:

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

## Translation guidance

- Use concise, technician-friendly Estonian only where safe.
- Possible directions include `Measure` -> `Mõõtmine`, `Add Component` -> `Lisa komponent`, `Placements` -> `Paigutused`, `Safety` -> `Ohutus`, and `Ready` -> `Valmis`.
- `Inspector` may become `Inspektor` only if context supports it.
- `Beep`, `Board Canvas`, `BenchBeep · TraceBench platform`, and `renderer writes: none` may remain unchanged when identity, instrument wording, or diagnostic precision is safer.
- Keep BenchBeep / TraceBench / BoardFact naming boundaries intact.

## Future implementation may only

- Replace remaining visible English/mixed Board Canvas shell/control labels with clearer Estonian user-facing copy.
- Preserve technical meaning.
- Preserve read-only / no-write meaning.
- Preserve disabled/future tool inertness.
- Preserve existing route/navigation/action behavior.
- Preserve accepted dark EDA visual styling.
- Update focused Board Canvas widget tests for changed copy assertions only.
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

- Runtime implementation in this active-lock sync.
- Editing `lib/` in this active-lock sync.
- Editing `test/` in this active-lock sync.
- Editing files outside the future implementation allowlist in the later implementation.
- Editing Project Overview runtime or tests.
- Editing Measure Sheet runtime or tests.
- Broad app-wide copy migration.
- Route/navigation rewiring.
- Board Canvas save/write behavior.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Editing `_incoming`.
- Importing, copying, bundling, staging, or depending on `_incoming` files at runtime.
- Adding logo/runtime assets.
- Editing `pubspec.yaml`.
- Schema, writer, materializer, validator, projection, event, fact, sample, platform, generated, or Project ZIP changes.
- Creating or implying canonical measurements, facts, nets, pin mappings, coordinates, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.
- Broad staging.

## Design source status

Prior dark EDA HTML/CSS, screenshots, and standalone HTML remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Route

- Current docs-only active-lock sync pass: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current armed implementation pass: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS`.
- Route after accepted/pushed active-lock sync: `V2_BOARD_CANVAS_REMAINING_COPY_POLISH_IMPL_PASS`.
