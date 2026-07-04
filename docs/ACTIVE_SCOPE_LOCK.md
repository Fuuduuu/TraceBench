# ACTIVE_SCOPE_LOCK.md

## Current pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Mode

Docs-only active-lock sync.

This pass arms the exact implementation allowlist for the future Board Canvas explicit-write status/action copy implementation. It does not implement runtime or tests.

## Write allowlist for this sync pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Allowlist rationale

Live-code inspection shows the required implementation is localized to Board Canvas UI copy/action wiring and its widget/source-boundary tests:

- top badge copy: `Ainult vaatamine · kirjutusi pole`
- footer/status copy key `renderer_writes_none`: `renderer writes: none`
- placement save success/stale copy
- Add Component action bar labels and callbacks: `Salvesta`, `Muuda`, `Kustuta`, `Tühista`
- save guard copy for missing component and missing local project folder
- tests asserting current badge/footer/action text, no-write paths, and explicit save behavior

## Implementation goal for next pass

After placement writer support, Board Canvas UI must truthfully communicate that:

- renderer/painter remain read-only
- explicit panel `Salvesta` can write a human-confirmed placement event when all guards pass
- projection-derived views may require refresh/materialization/reload after a successful save
- draft edits and local discard/cancel actions do not write canonical data

## Required behavior for next pass

- `Salvesta` remains the only canonical write trigger.
- `Salvesta` remains disabled/guarded unless an existing component, folder-backed project, and valid draft fields are present.
- Successful save continues to append only `component_visual_placement_confirmed` through the existing writer.
- Success copy remains truthful that projection needs refresh.
- `Muuda` must not be presented as a working canonical edit action if it remains local/inert.
- `Kustuta` must remain local draft discard/reset only, not canonical delete.
- `Tühista` must be copy/behavior-aligned with cancellation/reset behavior.
- Board Canvas renderer/painter code remains read-only.

## Test requirements for next pass

- updated visible copy is asserted
- no stale misleading global no-write copy remains where explicit save is available
- renderer/painter read-only boundary remains asserted
- `Salvesta` explicit user action still invokes the writer only when guards pass
- draft edits write nothing
- `Kustuta`, `Tühista`, navigation, and preview/size/rotation draft changes write nothing
- projection-stale success copy remains visible after successful save
- existing Board Canvas selection/measurement/preview behavior remains stable

## Forbidden surfaces

The next implementation must not edit:

- `lib/features/components/services/v2_placement_writer.dart`
- project open/from-directory files
- rotation-normalization files beyond existing behavior
- schema files
- tools/materializer/validator files
- router files
- `events.jsonl`
- `known_facts.json`
- sample/project fixtures
- `_incoming`
- docs, unless a separate docs pass is opened

The next implementation must not create or change:

- component identity
- pins/contacts/pads/nets/traces/electrical facts
- measurements
- visual-contact layout facts
- AI-authored canonical facts
- repair conclusions
- canonical delete/invalidation behavior

## Stop conditions

Stop and report `BLOCKED_ALLOWLIST_MISMATCH` if the implementation requires any file outside the exact implementation allowlist.

Stop and report the mismatch if live route docs do not show:

- Current: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS`
