# ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS

## Mode

Docs-only scope-lock.

## Baseline verification

- Live HEAD during drafting: `c8f4538` (`docs: sync placement chain truth docs`).
- Branch: `main...origin/main`.
- Tracked diff before edits: clean.
- Cached diff before edits: clean.
- Route before edits: `NEEDS_USER_DECISION` -> `NEEDS_USER_DECISION` in `docs/CURRENT_STATE.md`, `docs/PASS_QUEUE.md`, and `docs/ACTIVE_SCOPE_LOCK.md`.

## Goal

Scope-lock a future Add Component / `Lisa komponent` UX copy fix so the required draft label/name save blocker is visible and understandable.

## Problem recorded

Manual smoke showed that `Salvesta` becomes inactive when the required draft label/name is empty, but the UI does not make that reason clear enough. The user had to discover that adding a name makes `Salvesta` active.

## Live-code findings

Targeted inspection found the current Add Component panel already has draft label state and a label input in `lib/features/board_canvas/screens/board_canvas_screen.dart`:

- `_addComponentTemplateDraftLabel` stores the local draft label.
- `draftLabel` is passed into `_AddComponentTemplateListPanel`.
- `onDraftLabelChanged` updates local state only.
- The `Salvesta` button receives nullable `onConfirmPlacement`, so it can be disabled by guard state.
- Existing visible save-blocker copies cover selected component, local project folder, and invalid `board_normalized` bounds:
  - `Vali olemasolev komponent enne salvestamist.`
  - `Salvestamiseks ava projekt kohalikust kaustast.`
  - `Suurus või asukoht ei mahu plaadi piiridesse.`
- No dedicated persistent missing-label/name disabled reason was identified in the current source/test scan.

Targeted widget-test inspection found coverage for no selected component, invalid bounds, local-folder precondition, writer/no-write paths, and explicit save, but not a clear persistent missing-label explanation.

## Locked product intent

If a required draft label/name is missing:

- `Salvesta` may remain disabled.
- UI must show clear persistent copy explaining why.
- The reason must not depend on hover, tooltip, or clicking a disabled button.
- The copy must be concise and user-facing.
- Writer must not be invoked.
- `events.jsonl` must not grow.

Suggested future copy intent:

- `Lisa nimi enne salvestamist.`
- `Komponendi nimi on salvestamiseks vajalik.`
- `Sisesta nimi, et paigutus salvestada.`

Exact final copy may be refined during implementation, but it must be explicit.

## Future implementation boundaries

Future implementation may add or adjust Add Component panel copy, status, or validation text.

Future implementation must not:

- change placement writer contract
- change canonical event schema
- change validator/tools/materializer
- change Project Open From Directory behavior
- change rotation normalization
- change projection-stale behavior
- change canonical bounds guard
- mutate `known_facts.json` directly from Flutter
- create component identity
- create pins/contacts/pads/nets/traces/electrical facts
- create measurements
- create AI-authored facts
- redesign Board Canvas
- implement selected-placement prefill/edit flow
- change `Muuda` / `Tühista` behavior unless separately scoped

## Future implementation questions

The next active-lock sync must inspect live code and decide:

1. Where the required draft label/name validation currently lives.
2. Whether `Salvesta` is disabled because label is missing, or because multiple guards collapse into one state.
3. Where the best persistent helper/error copy belongs.
4. How to order messages when multiple guards are active: no selected component, missing required label/name, invalid bounds, and no local project folder.
5. Which widget tests need to assert the disabled reason.

## Future implementation surfaces

No implementation allowlist is armed in this pass.

The next active-lock sync must read live code and arm exact files. Likely candidate surfaces, not armed here:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Future test expectations

Future implementation tests should prove:

- empty required label/name disables `Salvesta`
- visible copy explains the missing label/name without hover/click
- writer is not invoked while label/name is missing
- entering a valid label/name can enable `Salvesta` when other guards are satisfied
- existing guards still work: no selected component, invalid `board_normalized` bounds, and missing local project folder
- valid save still appends and shows projection-refresh truth copy
- draft edits / `Kustuta` / `Tühista` / navigation write nothing

## Future manual smoke

Using `C:\Users\Kasutaja\Desktop\TraceBench_SMOKE_PROJECTS\placement_writer_confirm_smoke`:

- open folder-backed project
- select R1/C1/U1
- open `Lisa`
- leave label/name empty
- confirm `Salvesta` is disabled
- confirm visible copy explains missing label/name
- enter label/name
- confirm `Salvesta` can become active when other guards are satisfied
- save valid draft
- confirm one `component_visual_placement_confirmed` appends
- run `python tools/validate_all.py` and confirm pass

## Route after this pass

- Current: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`
- Next: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

This pass is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Audit status

DRAFTED / PENDING CLAUDE AUDIT.