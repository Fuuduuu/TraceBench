# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Lock state

No active implementation lock is armed.

The prior active implementation lock for `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS` is released by `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_POST_AUDIT_PASS`.

`docs/POHIKIRI.md` remains the first-read product charter / scope anchor. If a task conflicts with it, stop and ask the human.

## Released implementation pass

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Released implementation write allowlist

The released implementation pass wrote only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Recorded result

- Implementation commit: `a68e924189627a3e780922c976829db440b51d82` (`feat: add board canvas measurement right-panel flow`)
- Claude audit: `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES`
- Safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`

## Boundaries preserved

- Board Canvas/right panel measurement entry writes only through explicit human `Salvesta`.
- The flow uses the existing V2 measurement writer/provider by import/call only.
- The writer file was not edited.
- The measurement event type remains `measurement_recorded`.
- Successful save appends the returned event locally and marks projection stale.
- Standalone Measure Sheet remains available.
- AI/photo/trace context remains non-canonical.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter does not directly mutate `known_facts.json`.
- `projectState.knownFacts` is not mutated directly.
- No component identity, placement, pins, contacts, pads, nets, traces, electrical facts, AI facts, or repair conclusions are created.
- No writer, schema, validator, materializer, tool, router, model, asset, `_incoming`, events, or known_facts files were edited.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`
