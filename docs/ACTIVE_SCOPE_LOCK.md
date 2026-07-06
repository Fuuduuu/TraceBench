# ACTIVE_SCOPE_LOCK.md

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Mode

Docs-only active-lock sync.

## Active lock status

This pass arms the implementation allowlist for selected-placement visual draft prefill in Board Canvas.

No runtime or test implementation is performed in this pass.

## Write allowlist for this sync pass

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation pass armed

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Exact implementation allowlist

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings behind allowlist

- Board Canvas owns `_selectedPlacementKey`, `_addComponentTemplatePlacementContextKey`, the Add Component / `Lisa` panel, local draft label/size/rotation/center/template fields, guard copy, and the placement save call site.
- Board Canvas widget tests own existing selection, guard, save, local-only draft, and no-write assertions.
- The placement writer service is not armed because the writer contract and payload emission rules are unchanged.
- Standalone Add/Edit Component screens are not armed because this pass is visual placement prefill for an existing selected component only.
- Project Overview, Project Open From Directory, router, schema, validator, materializer, tools, events, `known_facts.json`, samples/assets, and `_incoming` are not armed.

## Implementation goal

Seed or prefill the Board Canvas visual placement draft from the currently selected existing placement where safe, while keeping all draft state UI-local until explicit `Salvesta`.

## Required behavior

- Canvas/list selection remains the binding path for the existing component/placement context.
- Opening Add Component / `Lisa` after selection must not lose selected placement context.
- Existing placement data may seed local draft center, width, height, rotation, template/shape, and label where safe.
- The user may still change template/shape/size/rotation locally before save.
- Draft seeding and draft edits write nothing.
- `Salvesta` remains the only canonical `component_visual_placement_confirmed` write trigger.
- Existing guards for no selected component, missing label, invalid canonical bounds, and missing local folder remain intact.
- Existing projection-stale success behavior remains intact.
- Board Canvas renderer/painter remains read-only.

## Critical stale placement requirement

The implementation must not prefill from stale older placement data.

The implementation pass must verify and test that the selected entry used for prefill reflects the current/latest placement intended by the app projection, including the V1/V2 stream-order latest-wins hazard previously fixed in placement projection ordering.

## Required implementation tests

- selected placement context carries into Add Component / `Lisa`
- selected placement values seed UI-local draft fields where available
- prefilled draft writes nothing before `Salvesta`
- local draft changes write nothing before `Salvesta`
- valid `Salvesta` still emits exactly one `component_visual_placement_confirmed`
- no selected component remains guarded
- missing label guard remains visible and blocks writer invocation
- invalid canonical bounds guard remains visible and blocks writer invocation
- missing local project folder guard remains visible and blocks writer invocation
- stale V1/V2 placement history does not prefill from an older placement when a newer placement is intended

## Forbidden surfaces

- No placement writer service edits.
- No standalone Add Component screen edits.
- No standalone Edit Component screen edits.
- No Project Overview edits.
- No Project Open From Directory edits.
- No router edits.
- No schema edits.
- No validator/materializer/tool edits.
- No `events.jsonl` or `known_facts.json` edits or semantic changes.
- No sample/asset edits.
- No `_incoming` edits or staging.
- No identity creation from visual placement.
- No pins, contacts, pads, nets, traces, electrical facts, measurements, or AI-authored facts from visual placement drafts.

## Staging

Do not stage, commit, or push.