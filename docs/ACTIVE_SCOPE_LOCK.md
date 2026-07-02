# Active Scope Lock

## Current pass

`PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS`

## Next recommended pass

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Status

Docs-only protected-surface scope-lock is active.

No runtime implementation lock is armed yet. The future implementation allowlist must be armed by `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS` before any writer/UI code changes.

## Write allowlist for this pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md`

## Scope summary

Lock the future placement writer and explicit Confirm/Salvesta contract before any canonical placement write path is implemented.

The full writer/Confirm contract lives in `docs/audit/PLACEMENT_WRITER_AND_CONFIRM_SCOPE_LOCK_PASS.md` and `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` section 2.7.

## Locked implementation direction

- Future writer file: `lib/features/components/services/v2_placement_writer.dart`.
- Future writer emits exactly one canonical event type: `component_visual_placement_confirmed`.
- Future writer uses V2/human explicit confirmation envelope and existing append/event writer precedent.
- Future writer does not directly edit `known_facts.json` or projection state.
- Confirm/Salvesta is explicit-user-action-only.
- Draft interactions, cancel, reset, discard, and navigation write nothing canonical.
- Placement confirmation remains separate from component identity creation.

## Forbidden surfaces

- No runtime implementation in this pass.
- No tests in this pass.
- No writer file in this pass.
- No schema/tool/materializer/validator/router edits.
- No `events.jsonl` or `known_facts.json` edits.
- No visual contact layout writes.
- No confirmed contacts, pins, pads, nets, traces, measurements, electrical facts, AI facts, or repair conclusions.
- No Add Component writer edits.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No broad docs cleanup.

## Future implementation sequence

1. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_ACTIVE_LOCK_SYNC_PASS`
2. `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

Likely future allowlist, not yet armed:

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`
- Optional writer service test path only if matching precedent requires it.
