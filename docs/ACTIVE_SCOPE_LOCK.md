# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Current armed implementation pass

None. This route is a docs-only active-lock sync target; runtime/test implementation is not armed by this route-sync pass.

## Type

CODEX / DOCS_ACTIVE_LOCK_SYNC / Board Canvas visual rendering

## Status

Docs-only route pointer sync has advanced the active route to the active-lock sync pass. The active-lock sync pass must arm the exact implementation allowlist before runtime/test work starts.

## Active docs write allowlist for the next sync pass

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS.md

## Future implementation target

- Future implementation pass: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`.
- Future implementation surface: Board Canvas visual rendering only.
- Replace marker-only placement visuals with real-looking component footprint shapes rendered from existing placement/projection data.
- Preserve existing selection, inspector, measurement summary, pan/zoom, fit/reset, and read-only Board Canvas behavior.
- Keep display language explicit: visual-only, no confirmed connectivity, no write, candidate/unconfirmed where relevant.
- Expected future runtime/test allowlist to be armed by `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`:
  - lib/features/board_canvas/screens/board_canvas_screen.dart
  - test/widget/board_canvas_screen_test.dart

## Design source handling

- Design source: `C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html`.
- Use as `DESIGN_INPUT_ONLY`.
- Do not stage `_incoming`.
- Do not copy HTML/CSS into runtime.
- Do not create runtime dependency on `_incoming`.
- Do not add new assets or dependencies.

## Confirmed logic guard

- Confirmed status is not created by this route sync or by the future visual rendering implementation.
- Confirmed means human-confirmed canonical event/projection.
- AI, candidate, visual, or inferred hints remain unconfirmed until explicit human confirmation.
- The renderer must not imply confirmed component identity, connectivity, coordinates, nets, traces, probes, pins, pads, or electrical semantics.
- No Confirm/write/Edit Layout behavior is authorized.

## Boundaries

- Docs only in this route sync.
- No runtime edits.
- No test edits.
- No asset edits.
- No pubspec edits.
- No `_incoming` staging or runtime dependency.
- No Board Canvas implementation in this pass.
- No Measure Sheet changes.
- No schema/writer/materializer/projection/Project ZIP/sample changes.
- No Confirm/write/Edit Layout behavior.
- No AI/OCR/CV fact creation.

## Route handling

- Pushed scope-lock recorded: `8fad35d4398942a64d355f31c8065d384fdbb6e8` (`8fad35d docs: lock Board Canvas real component footprints`).
- Previous route was `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_SCOPE_LOCK_PASS` -> `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Current route is `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`.
- Next recommended route is `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`.
