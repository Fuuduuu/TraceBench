# BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_PASS

## PASS_ID
`BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_PASS`

## Lane
`FLUTTER_PASS / FIXUP_PASS`

## Mode
Narrow navigation/discoverability fix from live-lite smoke findings.

## Goal
Make existing board-canvas screen reachable from project overview without changing board-canvas rendering/evidence behavior.

## Finding addressed
- Router already contained `/project/board-canvas`.
- `BoardCanvasScreen` already existed.
- Project overview exposed `Board graph` but did not expose `Board Canvas`.

## Implementation
- Added `Board Canvas` action button to project overview:
  - label: `Board Canvas`
  - key: `overview-board-canvas-button`
  - navigation target: `/project/board-canvas`
- Preserved existing `Board graph` action unchanged.

## Test coverage updates
- Updated project overview widget tests to verify:
  - `Board Canvas` action is present,
  - `Board graph` action remains present,
  - tapping `Board Canvas` navigates to board-canvas screen/title,
  - forbidden action labels are not introduced in overview.

## Boundaries preserved
- No board-canvas rendering logic changes.
- No readiness-panel/renderer evidence-boundary changes.
- No schema/tool/materializer/Dart model/ZIP/runtime artifact changes.
- No transform/background/photo-local/geometry/event-writing scope expansion.

## Routing
- Current pass: `BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_PASS`
- Next recommended pass: `BOARD_CANVAS_NAVIGATION_SMOKE_FIXUP_AUDIT_PASS`

## Validation
- `py -3 tools\\validate_all.py`: PASS
- `flutter test --reporter expanded`: PASS
- `git diff --name-only`: expected scoped files only
- `git status --short --branch`: expected scoped modifications + unrelated untracked
