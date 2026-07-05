# ACTIVE_SCOPE_LOCK.md

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Active lock

No active implementation lock is currently armed.

## Latest released lock

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` is closed out by `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_POST_AUDIT_PASS`.

The implementation changed only:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Closeout recorded:

- implementation commit `c773c413f6d8588e1043de5822e6c30cadf918f2` (`fix: explain missing add component draft label`)
- Claude audit `ACCEPT_AS_IS` / `SAFE_FOR_STAGING: YES`
- manual smoke `PASS`

## Boundary confirmation

The released implementation preserved:

- placement writer contract
- schema/tools/validator/materializer behavior
- Project Open From Directory behavior
- rotation normalization
- projection-stale behavior
- Board Canvas renderer/painter read-only boundary
- `events.jsonl` as canonical truth
- `known_facts.json` as projection/cache only
- no direct Flutter mutation of `known_facts.json`
- no component identity creation
- no pins/contacts/pads/nets/traces/electrical facts
- no measurements
- no AI-authored facts

## Protected surfaces remain locked unless separately scoped

- placement writer contract
- canonical event schema
- validator / tools / materializer / projection semantics
- events / `known_facts.json` semantics
- Project Open From Directory behavior
- rotation normalization behavior
- projection-stale behavior
- canonical-bounds guard behavior
- component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI-authored facts, or repair conclusions
- selected-placement prefill/edit flow
- `Muuda` / `Tühista` behavior
- samples/assets and `_incoming`
