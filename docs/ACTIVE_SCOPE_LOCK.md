# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active implementation lock is armed.

`V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS` closed the Board Canvas component footprint implementation route and released the `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS` runtime/test lock.

## Closed Board Canvas footprint implementation lock

- Implementation pass: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_PASS`.
- Pushed implementation commit: `02cd557b062e8da7d7dc6ee0685bcc8459b610dd` (`feat(board-canvas): render component footprints`).
- Closeout pass: `V2_BOARD_CANVAS_REAL_COMPONENT_FOOTPRINTS_IMPL_POST_AUDIT_PASS`.
- Manual smoke: `PASS`.
- Audit result: `AUDIT_VERDICT: ACCEPT_WITH_NITS`; `SAFE_FOR_STAGING: YES`.
- Nits recorded: diff was full uncommitted feature size, behavior-neutral cleanup stayed inside the allowlisted Board Canvas file, and no blocking issues were reported.

## Accepted Board Canvas footprint behavior

- Board Canvas renders recognizable component footprint bodies.
- BodyOnly contact visibility model is active.
- Contacts, pads, and legs are not drawn on component image until a future confirmed visual-contact layout is separately scoped.
- Real pin selection remains in the right-side measurement/pin list.
- Right-panel preview uses the same centered body visual model as canvas.
- Stable preview body does not shift based on selected pin or side controls.
- Old standalone `M` / `M3` marker bubble was removed.
- Measurement evidence is integrated/subordinate.
- `rotationDeg` is not applied visually.
- Board Canvas remains read-only: `renderer writes: none`.

## Standing forbidden surfaces

Any future work must open a new explicit scope before touching:

- events.jsonl, known_facts, schema, writer, materializer, validator, projection, Project ZIP, or sample semantics
- canonical placement, coordinate, net, electrical, fact, event, trace, probe, pin, or pad semantics
- Confirm/write/Edit Layout behavior
- AI/OCR/CV fact creation
- Measure Sheet, router, Project Home, assets, pubspec, or `_incoming` runtime dependencies
- Add Component, ghost-placement, or drag-to-place behavior unless separately scoped
