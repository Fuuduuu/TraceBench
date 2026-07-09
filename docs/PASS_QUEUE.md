# Pass Queue

## Current route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Queue status

No active implementation lock is armed.

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS` is closed out after accepted implementation audit.

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human.

## Recent closeout

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_POST_AUDIT_PASS` records:

- implementation commit `a68e924189627a3e780922c976829db440b51d82` (`feat: add board canvas measurement right-panel flow`)
- Claude audit `ACCEPT_WITH_NITS / SAFE_FOR_STAGING: YES`
- safe implementation set:
  - `lib/features/board_canvas/screens/board_canvas_screen.dart`
  - `test/widget/board_canvas_screen_test.dart`
- validation evidence:
  - Board Canvas widget tests 121/121 PASS
  - `flutter test` 387/387 PASS
  - `python tools/validate_all.py` 285 tests OK
  - `git diff --check` PASS

## Closed implementation behavior

- Board Canvas/right panel now includes the first compact measurement entry flow.
- Technician-facing flow copy is `Koht -> Väärtus -> Ühik -> Salvesta`.
- Measurement write requires explicit human action: `Salvesta`.
- Existing V2 measurement writer/provider is used by import/call only.
- The writer service file was not edited.
- The only measurement event type emitted by this flow is `measurement_recorded`.
- Successful save appends the returned event locally and marks projection stale.
- AI/photo/trace context remains non-canonical.
- Standalone Measure Sheet remains available.

## Boundaries preserved

- No writer/schema/router/tool/materializer/validator/model changes.
- No events or known_facts files changed.
- No direct `known_facts.json` mutation.
- No direct `projectState.knownFacts` mutation.
- No component identity, placement, pins, contacts, pads, nets, traces, electrical facts, AI facts, or repair conclusions created by the measurement panel.
- No route hiding/deletion.
- No `_incoming` use.

## Known non-blocking nit

- Dead conditional in `_componentIdForTarget`; behavior is safe and can be cleaned later if separately scoped.

## Scope gate rules

- Do not stage, commit, or push unless explicitly requested.
- Do not arm a new pass without a separate route/scope decision.
- Keep `docs/POHIKIRI.md` as the first-read product charter and scope anchor.
