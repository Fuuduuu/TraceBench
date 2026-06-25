# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS`

## Type

CODEX / DOCS_SCOPE_LOCK / PROTECTED_UI_POLISH

## Scope

Docs-only scope-lock for a future narrow Board Canvas/app visual-language polish slice.

This pass locks design intent and protected boundaries only. It does not implement runtime behavior, does not edit tests, does not arm implementation directly, and does not claim any Board Canvas save/write behavior is accepted.

After this scope-lock is accepted/pushed, route to `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS` before any runtime/test implementation. That sync pass must inspect the live repo structure and name the exact runtime/test allowlist.

## Baseline being carried forward

- Latest accepted/pushed closeout: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_POST_AUDIT_PASS` at `a80fb7d` (`docs: record measurement panel visual density`).
- Latest accepted/pushed implementation: `V2_INTEGRATED_MEASUREMENT_PANEL_VISUAL_DENSITY_IMPL_PASS` at `8b140d6` (`feat(board-canvas): polish measurement panel density`).
- Current accepted Board Canvas Measure panel remains non-writing.
- Board Canvas renderer remains read-only with `renderer writes: none`.
- Existing Measure Sheet route, Measure Sheet save behavior, Add Component local UI behavior, BenchBeep Home/menu behavior, and Project Overview behavior remain preserved.

## Design input status

- Prompt-provided design path `C:\Users\Kasutaja\Desktop\TraceBench_incoming\ui_redesign\App visual\Board Canvas (standalone).html` was not present during preflight.
- Repo-local scratch design file inspected for this pass: `C:\Users\Kasutaja\Desktop\TraceBench\_incoming\ui_redesign\App visual\Board Canvas (standalone).html`.
- The inspected file title identifies BenchBeep and Board Canvas; visible cues include Board Canvas, read-only/no-write status, Add Component, Inspector, Placements, Safety, board projection canvas, existing board-normalized placements, renderer writes, and BenchBeep / TraceBench platform labeling.
- Design input classification:
  - `RUNTIME_AUTHORITY: NONE`
  - `CANONICAL_SEMANTICS: NONE`
  - `IMPLEMENTATION_AUTHORIZATION: NONE`
- `_incoming` HTML/design files remain scratch/reference-only and must not be staged, copied into runtime, imported, bundled, or treated as canonical repo truth.

## Allowed files for this scope-lock

This docs-only scope-lock may edit only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS.md`

If any runtime, test, schema, writer, materializer, validator, projection, Project ZIP, event, fact, asset, sample, platform, generated, or untracked scratch file appears necessary in this pass, stop and request a new scope decision before editing it.

## Future implementation intent to lock

Future `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_PASS`, if later armed by active-lock sync, may only polish existing Board Canvas/app visual language and local UI presentation.

Future implementation may allow:

- Board Canvas/app visual density, spacing, and hierarchy polish.
- Technician-facing copy and label hierarchy improvements.
- Existing Board Canvas chrome, rails, right panel, footer/status, controls, and canvas-surface polish.
- Existing local UI-only empty/selection/active/focus state polish.
- Existing non-writing right-panel Measure/Add Component visual alignment where already present in Board Canvas.
- Compact control/readability improvements that prevent awkward wrapping or overflow.
- Widget-test updates for UI structure, local-only state, and no-write boundary preservation.

Future implementation must preserve:

1. Board Canvas remains visible and read-only.
2. Existing accepted integrated Measure panel hierarchy and non-writing boundary.
3. Existing Add Component local/UI-only behavior.
4. Existing Measure Sheet route and functional save path.
5. Existing BenchBeep Home/menu/navigation behavior.
6. `BenchBeep` as user-facing app/product name, `TraceBench` as repo/platform/project name, and `BoardFact` as data-fact/subsystem name.

## Future implementation allowlist expectation

This scope-lock does not arm runtime/test writes.

The next active-lock sync should inspect live repo files and use the smallest plausible implementation allowlist. Expected likely files, if still sufficient, are:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

The active-lock sync must not invent files or authorize broad directories.

## Forbidden surfaces preserved

- No runtime/test edits in this scope-lock.
- No implementation pass is armed directly.
- No Board Canvas canonical save/write behavior is accepted.
- No canonical measurement writing is accepted.
- No import, call, route to, or other wiring of `v2_save_measurement_writer.dart` from Board Canvas is accepted.
- No canonical event/fact writes from Board Canvas.
- No `events.jsonl` writes, `known_facts` mutation, canonical fact creation, or canonical measurement creation from Board Canvas.
- No AI/OCR/CV fact creation.
- No placement, coordinate, net, electrical, package, pin-mapping, identity, fault-evidence, or electrical-proof semantics changes.
- No Confirm/write/Edit Layout behavior.
- No Add Component Confirm/write behavior.
- No command menu, context menu, audio/save beep, full redesign, dark theme, global theme/token migration, canvas token migration, menu system, Home launcher, router, Project Overview, Measure Sheet, schema, writer, materializer, validator, projection, Project ZIP, asset, or sample changes.
- From -> To context remains display/provenance-only and must not imply confirmed connectivity.
- Visual traces remain visual-only and never measured nets.
- `_incoming`, screenshots, docs/sources, mockups, and source indexes remain non-runtime reference input only.

## Route

- Current pass: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_SCOPE_LOCK_PASS`
- Route after accepted/pushed: `V2_BOARD_CANVAS_APP_VISUAL_POLISH_IMPL_ACTIVE_LOCK_SYNC_PASS`
