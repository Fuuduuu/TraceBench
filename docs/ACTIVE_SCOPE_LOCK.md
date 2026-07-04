# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Status

No active scope lock is armed.

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` has been closed out by `PLACEMENT_WRITER_AND_CONFIRM_IMPL_POST_AUDIT_PASS`.

## Released implementation lock

Closed implementation pass:

`PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS`

Pushed implementation commits recorded:

- `e0af793e1b140eec7c498d9a73e8a65f29020b33` (`feat: confirm component visual placement`)
- `8db8c23669421f4d7c4a71cfce716dc1f9dd06a7` (`fix: align placement confirm flow with canvas selection`)

## Safe implementation set recorded

- `lib/features/components/services/v2_placement_writer.dart`
- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/unit/v2_placement_writer_test.dart`
- `test/widget/board_canvas_screen_test.dart`

## Preserved boundaries

- Placement writer emits only `component_visual_placement_confirmed`.
- Confirm requires explicit human action.
- `client_operation_id` is required.
- No component identity is created or updated by placement confirm.
- No pins, contacts, pads, nets, traces, measurements, electrical facts, AI-authored facts, visual-contact-layout facts, or repair conclusions are created by placement confirm.
- Draft edits, preview changes, size changes before save, rotation changes before save, cancel/reset/discard/navigation, and `Kustuta` write nothing canonical.
- Board Canvas renderer/painter remains read-only.
- `_incoming` remains design/source input only and is not staged or imported into runtime.

## Manual smoke limitation recorded

Manual smoke result is `PASS_WITH_ENVIRONMENT_LIMITATION`.

Full UI → writer → `events.jsonl` append smoke remains unverified because the app currently lacks an open-from-local-folder UI path. Sample/loadFromAssets and ZIP import leave `projectDirectory` null, so `Salvesta` is correctly guarded. A later folder-open pass is required.

## Recommended next candidate

`PROJECT_OPEN_FROM_DIRECTORY_SCOPE_LOCK_PASS`

This candidate is not armed. A future pass must explicitly scope it before any route, runtime, project-loader, home-screen, writer, event, known-facts, schema, tool, materializer, validator, or `_incoming` changes.

## Write allowlist

No files are currently armed for a new pass.

## Route

1. `NEEDS_USER_DECISION`
2. `NEEDS_USER_DECISION`
