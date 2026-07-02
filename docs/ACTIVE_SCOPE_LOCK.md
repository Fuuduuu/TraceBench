# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock is armed.

`PLACEMENT_EDITOR_SHELL_IMPL_PASS` is closed out as accepted/pushed/audited.

## Closed implementation baseline

- Implementation commit: `d779b0c294b5b0f28557d3e8d921fb4cd7970c91` (`feat: add placement editor draft shell`)
- Active-lock commit: `657a269f7ea0a949bde80f35007477576e3b38a6` (`docs: arm placement editor shell implementation`)
- Implementation audit: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Manual smoke: `PASS`

## Closed implementation files

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Closed implementation summary

- Board Canvas now has a first UI-local placement editor draft shell in the right panel.
- Draft is seeded read-only from selected placement projection.
- Draft state is `setState` / in-memory / session-only.
- Draft exposes local controls for side, rotation, width, and height.
- Draft has Cancel local draft, Reset local draft, and Discard local draft actions.
- Draft copy says unsaved/session-only and confirms canonical projection remains unchanged.
- No canonical write is wired.
- No placement writer was created.
- No Confirm/Save/Edit placement action was added.
- Renderer/painter remains read-only.
- Add Component marker-builder copy was clarified as UI-local/not confirmed contacts.

## Boundary record

- No writer.
- No canonical placement Confirm.
- No `events.jsonl` write.
- No `known_facts.json` write.
- No schema/tool/materializer/validator/router changes.
- No visual contact layout.
- No AI marker conversion.
- No `_incoming` dependency.

## Future candidate, not armed

`PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`
