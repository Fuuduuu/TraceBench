# Pass Queue

## Current route

Current: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Queue status

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS` is a docs-only build-lock.

It arms the next narrow implementation pass:

- `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## First-read charter

Read `docs/POHIKIRI.md` before route, implementation, or audit decisions. If a task conflicts with `docs/POHIKIRI.md`, stop and ask the human.

## Prerequisite closeouts recorded

- `BOARD_CANVAS_RIGHT_PANEL_CREATION_FLOW_IMPL_POST_AUDIT_PASS` is recorded in the live repo history as the right-panel component identity creation closeout.
- `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_POST_AUDIT_PASS` is recorded in the live repo history as the right-panel component metadata edit closeout.

## Next implementation intent

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS` should add the first narrow Board Canvas right-panel measurement entry flow:

- technician works in the Board Canvas right panel
- context is board / component / pin / point as available in the current UI state
- user enters Koht -> Väärtus -> Ühik -> Salvesta
- write requires explicit human action
- event type remains `measurement_recorded`
- existing V2 measurement writer/provider may be imported and called, but the writer file itself is not armed for edits

## Exact implementation allowlist

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS` may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Scope gate rules

- Do not edit runtime or tests in this build-lock pass.
- Do not edit writer, schema, validator, materializer, router, standalone screens, events, known_facts, assets, or `_incoming` in the next implementation unless a later lock explicitly authorizes it.
- If writer/schema/validator/materializer edits are needed, stop with `BLOCKED_ALLOWLIST_MISMATCH`.
- If implementation needs router/page proliferation or standalone Measure Sheet deletion/hiding, stop.
- Do not let AI/photo/visual-trace output become canonical.
- Do not treat visual trace as electrical net.
- Do not stage, commit, or push from this pass.