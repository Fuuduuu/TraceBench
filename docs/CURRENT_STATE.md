# Current State

Current pass: NEEDS_USER_DECISION
Next recommended pass: NEEDS_USER_DECISION

## First-read charter

`docs/POHIKIRI.md` is the tracked canonical product charter / first-read scope anchor.

If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human. AI may propose, guide, and organize; only human-confirmed information becomes canonical truth.

## Status

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS` is closed out.

Implementation commit recorded:

- `a68e924189627a3e780922c976829db440b51d82` — `feat: add board canvas measurement right-panel flow`

Prior build-lock commit recorded:

- `3175ff0` — `docs: lock board canvas measurement right-panel flow`

Claude audit result recorded:

- `AUDIT_VERDICT: ACCEPT_WITH_NITS`
- `SAFE_FOR_STAGING: YES`

Safe implementation set:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closed behavior

- Board Canvas now has a compact right-panel measurement entry flow.
- Flow copy: `Koht -> Väärtus -> Ühik -> Salvesta`.
- Explicit `Salvesta` is required before any measurement write.
- The flow uses the existing V2 measurement writer/provider by import/call only.
- The writer file was not edited.
- The only emitted measurement event type is `measurement_recorded`.
- Successful save appends the returned event locally.
- Successful save marks projection stale.
- `known_facts.json` is not mutated directly.
- `projectState.knownFacts` is not mutated directly.
- No component identity, placement, pins, contacts, pads, nets, traces, electrical facts, AI facts, or repair conclusions are created.
- Standalone Measure Sheet remains available.
- AI/photo/trace context remains non-canonical.

## Validation recorded

- Board Canvas widget tests: 121/121 PASS.
- `dart format`: PASS / 0 changed after format.
- `flutter test test/widget/board_canvas_screen_test.dart`: PASS.
- `flutter test`: 387/387 PASS.
- `python tools/validate_all.py`: 285 tests OK.
- `git diff --check`: PASS.
- `git diff --cached`: empty before staging.

## Known non-blocking nit

- Dead conditional in `_componentIdForTarget`; behavior is safe and may be cleaned later in a separately scoped pass.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`

## Canonical owner pointers

- Product charter / first-read scope anchor: `docs/POHIKIRI.md`
- Route state: `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, `docs/ACTIVE_SCOPE_LOCK.md`
- Audit/provenance ledger: `docs/AUDIT_INDEX.md`
- Stable project memory and facts: `docs/PROJECT_MEMORY.md`, `docs/TRUTH_INDEX.md`
- UI workflow policy: `docs/UI_WORKFLOWS.md`
- Protected surface rules: `docs/PROTECTED_SURFACES.md`
- Prompt/lifecycle/model-routing rules: `docs/PROMPTING_PROTOCOL.md`, `docs/PASS_LIFECYCLE.md`, `docs/MODEL_ROUTING.md`
