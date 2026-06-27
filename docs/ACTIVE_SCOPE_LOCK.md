# Active Scope Lock

## Current docs-only pass

`V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS`

## Type

LANE_B_ADJACENT / DOCS_SCOPE_LOCK / PROTECTED_UI_BOARD_CANVAS_STYLE

## Temporary review mode

- Claude Code is temporarily unavailable for this scope-lock.
- This pass does not claim Claude audit.
- Review status: `NO_CLAUDE_REVIEW / RETRO_CLAUDE_PENDING`.
- Codex output for this pass must use `NO_CLAUDE_REVIEW_PACKET`.

## Baseline source

- Expected and verified HEAD/origin before this scope-lock: `7f11471` (`docs: record Project Home dark EDA copy polish`).
- Latest accepted/pushed closeout: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_POST_AUDIT_PASS` at `7f11471` (`docs: record Project Home dark EDA copy polish`).
- Latest accepted/pushed Project Home copy-polish implementation: `V2_PROJECT_HOME_DARK_EDA_COPY_POLISH_IMPL_PASS` at `3674a69` (`feat(project-overview): polish dark EDA copy`).
- Current route before this scope-lock was the accepted closeout state routing next to `NEEDS_USER_DECISION`.
- No runtime/test implementation pass is currently armed.

## Exact scope-lock allowlist

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS.md`

No broad directories are authorized.

## Target surface

Future work is limited to Board Canvas visual shell/style alignment.

Reference surface:

- Accepted Project Overview / Workbench Home BenchBeep dark EDA style, including compact dark shell, restrained EDA panel/chrome treatment, read-only status presentation, and technician-facing copy direction.

Protected target surface:

- Board Canvas read-only renderer/shell and its existing Board Canvas tests.

## Future implementation route

- This scope-lock does not arm runtime/test writes directly.
- Route after this scope-lock is accepted/pushed: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- The active-lock sync must inspect live repo files and list the smallest exact future runtime/test allowlist before implementation.
- Primary future candidate files, if still sufficient after inspection:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Future implementation may consider

- Aligning Board Canvas shell with the accepted Project Overview / Workbench Home dark EDA shell.
- Darkening Board Canvas app bar, page chrome, left rail, panels, footer, and status strip.
- Aligning card/panel borders, backgrounds, radius, spacing, and restrained glow/shadow.
- Aligning toolbar button chrome.
- Aligning grid/canvas colors toward the Project Overview green EDA canvas family while preserving board/canvas dominance and contrast.
- Replacing the orange read-only badge with the BenchBeep dark EDA read-only treatment.
- Preserving clear read-only/no-write status.
- Polishing scoped Board Canvas shell copy toward Estonian where safe, such as:
  - `Read-only · no writes` -> `Ainult vaatamine · kirjutusi pole` or equivalent.
  - `Board projection canvas` -> `Plaadi projektsioonivaade` or equivalent.
  - `Existing board-normalized placements only` -> clear Estonian preserving the same meaning.
  - `Future tools` -> `Tulevased tööriistad`.
  - `renderer writes: none` may remain as diagnostic copy unless separately scoped later.
- Adding/updating focused widget tests only when authorized by the future active-lock sync.

## Must preserve

- Board Canvas remains read-only.
- `renderer writes: none` remains true.
- Existing pan, zoom, fit, reset, tap-to-select, inspector, placement rendering, measurement markers/summaries, and visual trace/provenance behavior remain preserved.
- Existing Add Component behavior remains local/UI-only.
- Existing integrated Measure panel and standalone Measure Sheet behavior remain preserved.
- Existing Project Overview, BenchBeep Home, router, Measure Sheet save, Menu System, and navigation behavior remain preserved.
- Visual traces remain visual-only and never become confirmed nets, connectivity, pin mapping, or electrical proof.
- Board Canvas does not write `events.jsonl` or mutate `known_facts`.
- Board Canvas does not import, call, route to, or wire `v2_save_measurement_writer.dart`.
- No canonical facts, measurements, nets, pin mappings, package identity, electrical proof, fault evidence, AI/OCR/CV facts, or write behavior are accepted by this lock.

## Explicitly forbidden

- Editing `lib/` or `test/` in this docs-only scope-lock.
- Arming runtime implementation directly without the next active-lock sync.
- Editing `_incoming`, screenshots, mockups, docs/sources, or source indexes.
- Copying/importing/depending on `_incoming` files at runtime.
- Editing assets, `pubspec.yaml`, platform files, generated files, samples, schemas, tools, writer/service, validator, materializer, projection, Project ZIP, events, facts, or unrelated docs.
- Editing Project Overview runtime or combining Project Overview and Board Canvas implementation in one future pass.
- Starting global dark theme, global theme migration, full redesign, logo/runtime assets, command menu, context menu, audio/save beep, or canvas token migration.
- Changing route/navigation behavior.
- Changing Measure Sheet UI or save/write behavior.
- Adding Board Canvas save/write, Confirm/write, Edit Layout, canonical event/fact writes, or canonical measurement writing.
- Creating or implying canonical board facts, coordinates, placement semantics, nets, pin mappings, package identity, electrical proof, fault evidence, or AI/OCR/CV facts.

## Design source status preserved

`_incoming` dark EDA HTML/CSS/design references remain `DESIGN_INPUT_ONLY`.

- `RUNTIME_AUTHORITY: NONE`
- `CANONICAL_SEMANTICS: NONE`
- `IMPLEMENTATION_AUTHORIZATION: NONE`
- `ASSET_AUTHORIZATION: NONE`

Do not edit, stage, copy, import, bundle, or runtime-depend on `_incoming` files.

## Route

- Current docs-only scope-lock pass: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_SCOPE_LOCK_PASS`.
- Route after accepted/pushed: `V2_BOARD_CANVAS_DARK_EDA_STYLE_ALIGNMENT_IMPL_ACTIVE_LOCK_SYNC_PASS`.
