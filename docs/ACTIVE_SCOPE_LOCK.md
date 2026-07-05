# ACTIVE_SCOPE_LOCK.md

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

## Active lock

Docs-only active-lock sync for future implementation pass `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`.

## Write allowlist for this active-lock sync

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS.md`

## Implementation allowlist armed for next pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

No other implementation files are armed.

## Why this allowlist is exact

- `_addComponentTemplateDraftLabel`, `draftLabel`, `onDraftLabelChanged`, `_addComponentTemplateSaveBlockReason`, `canConfirmAddComponentPlacement`, and the `Salvesta` action wiring are all in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- Existing widget coverage for Add Component `Salvesta`, guard copy, label input, invalid bounds, local-folder precondition, no-write behavior, and source-boundary assertions lives in `test/widget/board_canvas_screen_test.dart`.
- No placement writer file is needed because the writer contract is unchanged and the future implementation must only block before writer call when label/name is missing.
- No project-open, rotation-normalization, projection-stale, schema, validator, materializer, router, events, `known_facts.json`, sample, asset, or `_incoming` file is needed.

## Future implementation must

- make the missing required draft label/name reason visible without hover/click
- keep `Salvesta` disabled while required label/name is missing
- keep writer uninvoked while label/name is missing
- allow `Salvesta` to become enabled after label/name is entered if all other guards are satisfied
- preserve existing guard ordering or document expected priority:
  1. no selected component
  2. missing required label/name
  3. invalid board-normalized bounds
  4. missing local project folder
- keep existing bounds guard behavior
- keep projection-stale success copy
- keep rotation normalization
- keep Project Open From Directory behavior
- keep placement writer contract unchanged
- keep Board Canvas renderer/painter read-only
- keep `known_facts.json` projection/cache only; no direct Flutter mutation
- keep draft edits / `Kustuta` / `Tühista` / navigation as no-write paths

## Future tests must prove

- empty required label/name disables `Salvesta`
- visible copy explains missing label/name without hover/click
- writer is not invoked while label/name is missing
- entering valid label/name can enable `Salvesta` when other guards pass
- existing guards still work: no selected component, invalid board-normalized bounds, and missing local project folder
- valid save still appends and shows projection-refresh truth copy
- draft edits / `Kustuta` / `Tühista` / navigation write nothing

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

## Route note

After this active-lock sync is accepted and pushed, route should proceed to `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`.