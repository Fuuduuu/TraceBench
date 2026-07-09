# Active Scope Lock

## Current pass

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Lock state

Docs-only build-lock is active.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

No runtime/test implementation is authorized in this build-lock pass.

## Current docs pass write allowlist

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS` may write only:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS.md`

## Armed implementation pass

`BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`

## Armed implementation write allowlist

The future implementation pass may write only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Existing measurement writer/provider use is import/call only. Do not edit `lib/features/measure_sheet/services/v2_save_measurement_writer.dart` in the future implementation pass unless a later lock explicitly arms it.

## Locked intent

- Board Canvas / right panel becomes the primary measurement entry context.
- Technician selects board / component / pin / point context.
- User enters Koht -> Väärtus -> Ühik -> Salvesta.
- Use the existing human-confirmed measurement writer path where possible.
- Write only `measurement_recorded`.
- Write requires explicit human action: `Salvesta`.
- AI may suggest next checks but writes no canonical facts.
- Photo / visual trace / net inference must not become canonical.

## Stop conditions

Stop with `BLOCKED_ALLOWLIST_MISMATCH` if the future implementation needs any file outside:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Stop if the future implementation needs:

- router/page proliferation
- standalone Measure Sheet deletion or hiding
- direct `known_facts.json` mutation
- schema, validator, materializer, writer, model, tool, event, known_facts, asset, or `_incoming` edits
- AI/photo output as canonical facts
- visual trace as electrical net

## Protected boundaries still in force

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human-confirmed canonical writes remain explicit and scoped by writer contract.
- AI must not create canonical facts.
- Measurement flow writes only `measurement_recorded`.

## Route

Current: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_BUILD_LOCK_PASS`
Next: `BOARD_CANVAS_MEASUREMENT_RIGHT_PANEL_IMPL_PASS`