# BOARD_CANVAS_READONLY_RENDERER_QA_PASS

Lane: `FLUTTER_PASS / QA_PASS`  
Mode: narrow QA/polish implementation only  
Status: completed

## Goal

Harden accepted read-only board-canvas renderer behavior without expanding scope.

## Scope outcome

Completed narrow QA/polish improvements on existing board-canvas rendering and tests only.

## Implemented surfaces

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_READONLY_RENDERER_QA_PASS.md`

## QA hardening summary

1. `_templateAspectRatio` / sizing map-serialization cleanup
- Board-canvas sizing path remains typed and direct (`template.body.width`, `template.body.height`).
- Source guard asserts `template.toMap(...)` is absent from board-canvas screen.

2. `CustomPainter.shouldRepaint` hardening
- Repaint decision no longer depends on list identity.
- Repaint now uses deterministic logical comparison of render inputs:
  - placement coordinate/rotation/sizing/template/status fields,
  - displayed designator text,
  - template geometry identity fields,
  - selected key and color scheme.
- New list instance with identical logical entries no longer forces repaint.

3. Evidence deferral and read-only boundaries
- No event-writer imports/usages.
- No canonical fact mutation paths introduced.
- No file-writing paths introduced.
- No `board_graph.json` / `view_state.json` behavior introduced.
- No board-canvas reads introduced for deferred evidence sources:
  - `knownFacts.visualTraces`
  - `knownFacts.measurements`
  - `knownFacts.damageRegions`
  - `knownFacts.suspectRegions`
  - `knownFacts.nets`

## Test summary

Strengthened widget/source-guard coverage for:

- scale-mode placement rendering path
- width+height-mode placement rendering path
- missing sizing fallback path
- missing template-id fallback rendering path
- unknown template-id fallback rendering path
- unknown fallback template family rendering safety
- preserved `photo_local` non-rendering behavior
- preserved `renderer writes: none` chrome visibility
- preserved read-only/no-write/no-raw-JSON boundaries
- explicit deferred-evidence read guards in board-canvas source

## Validation

- `py -3 tools\validate_all.py` -> PASS
- `C:\Users\Kasutaja\Desktop\flutter\flutter\bin\flutter.bat test --reporter expanded` -> PASS

## Boundary confirmation

- No visual_trace rendering added.
- No measurement overlay rendering added.
- No damage/suspect overlay rendering added.
- No photo-local board rendering added.
- No background photo helper added.
- No AI proposal UI/persistence added.
- No editing/confirm/save/export/event-writing UI added.
