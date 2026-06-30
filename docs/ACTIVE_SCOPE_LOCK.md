# Active Scope Lock

## Current pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Next recommended pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS`

## Current armed implementation pass

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`

## Type

CODEX / FLUTTER_PASS / Board Canvas visual rendering

## Status

Implementation active lock armed by docs-only pass `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS`. Runtime/test work is authorized only inside the exact two-file implementation allowlist below.

## Active docs write allowlist for the next sync pass

- docs/CURRENT_STATE.md
- docs/PASS_QUEUE.md
- docs/ACTIVE_SCOPE_LOCK.md
- docs/AUDIT_INDEX.md
- docs/audit/V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS.md

## Future implementation target


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

- Pushed scope-lock recorded: 8fad35d4398942a64d355f31c8065d384fdbb6e8 (8fad35d docs: lock Board Canvas real component footprints).
- Pushed route-sync recorded: 32e89f5a1771b67474899d0c77433a98678df043 (32e89f5 docs: sync Board Canvas footprint route).
- Active-lock-sync pass recorded: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS.
- Current route is V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS.
- Next recommended route is V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS.
## Board Canvas real component footprints implementation lock

- Current armed pass: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS.
- Armed by docs-only active-lock sync: V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_ACTIVE_LOCK_SYNC_PASS.
- Pushed route-sync prerequisite: 32e89f5a1771b67474899d0c77433a98678df043 (32e89f5 docs: sync Board Canvas footprint route).
- Implementation type: Board Canvas visual rendering only.
- Implementation goal: replace marker-only Board Canvas placement visuals with real-looking component footprint shapes.
- Runtime/test write allowlist is exactly:
  - lib/features/board_canvas/screens/board_canvas_screen.dart
  - test/widget/board_canvas_screen_test.dart
- If implementation inspection proves additional files are needed, stop and report instead of guessing.
- Design source: C:/Users/Kasutaja/Desktop/TraceBench/_incoming/ui_redesign/BenchBeep Project Home (dark, standalone).html is DESIGN_INPUT_ONLY; do not stage _incoming, copy HTML/CSS into runtime, or create a runtime dependency on _incoming.
- Data source: existing placement/projection data only.
- Preserve: selection, inspector, measurement summary, pan/zoom/fit/reset, and read-only/no-write status language.
- Truth boundary: confirmed status is not created here; confirmed means human-confirmed canonical event/projection. AI/candidate/visual hints remain unconfirmed until explicit human confirmation.
- Board Canvas remains visual/read-only until a later explicit writer scope.
- Forbidden surfaces: no events.jsonl, known_facts, schema/writer/materializer/validator/projection, canonical placement/coordinate/net/electrical semantics, Confirm/write/Edit Layout, AI/OCR/CV fact creation, Measure Sheet, router, Project Home, new assets, or dependency changes.
