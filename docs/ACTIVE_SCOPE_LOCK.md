# ACTIVE_SCOPE_LOCK

## Current pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS`

## Next recommended pass
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Mode
Docs-only scope-lock.

## Lock status
Active docs-only scope lock. No runtime or test implementation is performed in this pass.

## Write allowlist for this pass
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_SCOPE_LOCK_PASS.md`

## Implementation pass not armed
This scope-lock does not arm implementation files.

The next pass must inspect live code and arm exact files for:
`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

Likely candidate surfaces, not armed here:
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Locked product intent
- Board Canvas renderer/painter remains read-only.
- Explicit human-confirmed panel actions may write canonical events only when separately scoped and valid.
- UI copy must distinguish:
  - renderer/painter writes none;
  - explicit panel confirmation can write;
  - draft/edit/preview controls remain UI-local until confirmation.
- `Salvesta` success/stale copy from `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` must remain truthful.
- `Muuda` must not appear clickable while doing nothing.
- `Tühista` must either cancel/exit the local draft flow or be clearly non-actionable/non-misleading.
- `Kustuta` remains local draft discard/reset only.
- No new canonical write path is introduced.

## Live-code findings recorded
- Top Board Canvas badge currently renders "Ainult vaatamine · kirjutusi pole".
- Footer/status copy currently renders `renderer writes: none` with key `renderer_writes_none`.
- Add Component draft action bar renders `Salvesta`, `Muuda`, `Kustuta`, and `Tühista`.
- `Salvesta` is gated through `onConfirmPlacement` and calls the existing placement confirmation flow only when valid.
- `Muuda` is currently wired to an empty callback.
- `Kustuta` calls the local reset/default callback.
- `Tühista` currently calls the same local reset/default callback as `Kustuta`.
- Tests currently assert the old top badge, `renderer writes: none`, action labels, no-write paths, explicit save path, and projection-stale success copy.

## Future implementation test requirements
- Top/status copy no longer falsely says there are no writes anywhere.
- Renderer/painter read-only boundary remains visible or documented in UI copy.
- Explicit panel `Salvesta` remains the only canonical write action.
- `Muuda` is not clickable-no-op.
- `Tühista` is not misleadingly equivalent to `Kustuta`/reset unless copy says so.
- `Kustuta` remains local draft discard only.
- Draft edits write nothing.
- Existing placement save/stale tests still pass.

## Forbidden surfaces
- No placement writer contract changes.
- No rotation normalization changes.
- No Project Open From Directory changes.
- No projection-stale policy changes.
- No direct `known_facts.json` mutation from Flutter.
- No schema/tools/materializer/validator/events/known_facts edits.
- No component identity creation.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, visual-contact layout, AI-authored facts, or repair conclusions.
- No Board Canvas redesign.
- No sample/assets or ZIP behavior changes.
- No `_incoming` edits, staging, copy, import, or runtime dependency.

## Standing protected boundaries
Future work must re-arm a new active scope lock before editing runtime, tests, schema, tools, events, known_facts, materializer, validator, router, Project ZIP, samples, or `_incoming`.
