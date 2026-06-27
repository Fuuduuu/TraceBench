# Active Scope Lock

## Current armed implementation pass

`V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS`

## Type

LANE_B_ADJACENT / FLUTTER_UI_PROTECTED_IMPLEMENTATION / PROTECTED_UI_BOARD_CANVAS_STYLE

## Armed by docs-only sync

- Sync pass: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Sync mode: docs-only active-lock sync.
- Temporary review mode: Claude Code is temporarily unavailable for the sync pass.
- Sync review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- The sync pass does not claim Claude audit and must output `NO_CLAUDE_REVIEW_PACKET`.
- The future implementation is product/UI surface work and requires manual smoke plus non-Codex review before staging.

## Baseline source

- Accepted/pushed scope-lock: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS` at `df38722` (`docs: lock Board Canvas dark EDA style alignment`).
- Full scope-lock SHA: `df38722b774f2d8db9a0d0f64715f4c2cff95c65`.
- Reference surface: accepted Project Overview / Workbench Home BenchBeep dark EDA style.
- Target surface: Board Canvas visual shell/style only.
- Design-source status remains `DESIGN_INPUT_ONLY`; `_incoming` HTML/CSS/design files have no runtime authority, canonical semantics, implementation authorization, or asset authorization.

## Exact future implementation allowlist

The future implementation may edit only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No broad directories are authorized.

If implementation requires any additional file, stop before editing and route a new active-lock sync with the exact required file and rationale.

## Target surface decision

Board Canvas shell/style ownership is concentrated in `lib/features/board_canvas/screens/board_canvas_screen.dart`, including current app bar, page chrome, left rail, contextual panels, footer/status strip, canvas colors, read-only badge/copy, toolbar chrome, and Board Canvas-local panel visuals.

Focused coverage for this surface already lives in `test/widget/board_canvas_screen_test.dart`, including Board Canvas read-only chrome, integrated Measure panel behavior, Add Component local state, renderer no-write source checks, pan/zoom/fit/reset behavior, tap-to-select behavior, measurement badges, and protected no-writer assertions.

Project Overview / Workbench Home is reference surface only for this pass. Its runtime and tests are not authorized for the future implementation.

## Future implementation may only

- Align Board Canvas shell with the accepted Project Overview / Workbench Home dark EDA shell.
- Darken Board Canvas app bar, page chrome, left rail, panels, footer, and status strip.
- Align card/panel borders, backgrounds, radius, spacing, and restrained glow/shadow.
- Align toolbar button chrome.
- Align grid/canvas colors toward the Project Overview green EDA canvas family while preserving contrast and board/canvas dominance.
- Replace the orange read-only badge treatment with BenchBeep dark EDA read-only treatment.
- Preserve clear read-only/no-write status.
- Polish scoped Board Canvas shell copy toward Estonian where safe, such as:
  - `Read-only · no writes` -> `Ainult vaatamine · kirjutusi pole` or equivalent.
  - `Board projection canvas` -> `Plaadi projektsioonivaade` or equivalent.
  - `Existing board-normalized placements only` -> clear Estonian preserving the same meaning.
  - `Future tools` -> `Tulevased tööriistad`.
  - `renderer writes: none` may remain as diagnostic copy unless separately scoped later.
- Update focused Board Canvas widget tests for visual/copy assertions only.

## Must preserve

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- No save/write behavior from Board Canvas.
- Existing pan/zoom/fit/reset behavior.
- Existing tap-to-select behavior.
- Existing inspector behavior.
- Existing placement rendering behavior.
- Existing measurement marker/summary behavior.
- Existing visual-trace/provenance behavior.
- Existing route/navigation behavior.
- Existing Measure Sheet save behavior.
- Existing Add Component and Measure Sheet action routing where present.
- Existing Project Overview runtime behavior.
- Existing BenchBeep Home behavior.
- Existing tests unless updated only for visual/copy assertions.
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

- Runtime implementation in the active-lock sync.
- Editing files outside the two-file future implementation allowlist.
- Editing Project Overview runtime or tests unless separately locked.
- Editing router, BenchBeep Home, Measure Sheet, writer/service, schema, validator, materializer, projection, Project ZIP, events, facts, assets, samples, platform files, generated files, or unrelated docs.
- Editing `_incoming`, screenshots, mockups, docs/sources, or source indexes.
- Importing, copying, bundling, or depending on `_incoming` files at runtime.
- Adding logo/runtime assets or editing `pubspec.yaml`.
- Starting global dark theme, global theme migration, full redesign, command menu, context menu, audio/save beep, or canvas token migration.
- Changing route/navigation behavior.
- Changing Measure Sheet UI or save/write behavior.
- Adding Board Canvas save/write, Confirm/write, Edit Layout, canonical event/fact writes, or canonical measurement writing.
- Importing, calling, routing to, or wiring `v2_save_measurement_writer.dart`.
- Creating or implying canonical board facts, coordinates, placement semantics, nets, pin mappings, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Design source status preserved

`_incoming` dark EDA HTML/CSS/design references remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Route

- Current docs-only sync pass: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current armed implementation pass: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS`.
- Route after accepted/pushed active-lock sync: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_PASS`.
