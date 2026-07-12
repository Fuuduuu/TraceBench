# Current State

Current pass: `BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS`
Next recommended pass: `BOARD_CANVAS_SCREEN_CODE_MAP_PASS`

## Charter and pushed baseline

`docs/POHIKIRI.md` remains the canonical product charter and conflict-stop authority.

Verified pushed baseline: `5b5c346a6030b40b4071fb6ebc1e4593d2e2fd1b`
(`docs: close out code map standard bootstrap`).

## Active objective

This docs-only pass locks the first production code map for
`lib/features/board_canvas/screens/board_canvas_screen.dart`. The committed
11,816-line source automatically qualifies under the code-map standard:
`AUTO — >5000 lines + 3+ responsibilities`.

The next pass may create only the deterministic production map, add its single
index row, and record map-pass audit evidence. The test file remains inspect-only
evidence and receives no map in this sequence.

## Lifecycle and boundaries

The map and index begin as `REVIEW_REQUIRED`. They may become `MAINTAINED` only
after a read-only Claude map-to-code audit returns an accepted map verdict and
`SAFE_FOR_SNIPER_USE: YES`; a short final Claude diff audit is then required
before staging.

No Dart, test, standard, tooling, runtime, route-behavior, schema, writer,
projection, `_incoming`, refactor, or extraction change is open.

Detailed scope evidence:
`docs/audit/BOARD_CANVAS_SCREEN_CODE_MAP_SCOPE_LOCK_PASS.md`.
