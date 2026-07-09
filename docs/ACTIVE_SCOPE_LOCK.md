# Active Scope Lock

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Lock state

No active implementation lock is armed.

The active lock cannot override `docs/POHIKIRI.md`; conflicts stop for human decision.

No runtime, test, docs, schema, writer, materializer, validator, tool, event, known_facts, asset, router, standalone-screen, or `_incoming` files are authorized for implementation from this state.

## Last released lock

`BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_PASS` is closed out by `BOARD_CANVAS_METADATA_EDIT_FLOW_IMPL_POST_AUDIT_PASS`.

Implementation commit recorded from live git:

- `1492075f13e24494cbb728eab28de93981d9d240` (`feat: add board canvas metadata edit flow`)

Safe implementation set recorded:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Audit record:

- Claude audit: `ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`

## Released behavior

- Board Canvas right-panel metadata edit is implemented for selected existing `ComponentPlacementSelection.componentId` only.
- The write action is explicit human action: `Salvesta muudatused`.
- The flow writes only `component_updated` through existing `V2EditComponentWriter`.
- Draft / unsaved placement metadata edit remains blocked.
- No direct `known_facts.json` or `projectState.knownFacts` mutation occurs.
- No writer, schema, router, tool, model, or `_incoming` edits were part of the implementation.
- `docs/POHIKIRI.md` is now the tracked canonical product charter / first-read scope anchor.

## Protected boundaries still in force

- Events.jsonl remains canonical truth.
- `known_facts.json` remains projection/cache.
- Flutter must not directly mutate `known_facts.json`.
- Human-confirmed canonical writes remain explicit and scoped by writer contract.
- AI must not create canonical facts.

## Route

Current: `NEEDS_USER_DECISION`
Next: `NEEDS_USER_DECISION`
