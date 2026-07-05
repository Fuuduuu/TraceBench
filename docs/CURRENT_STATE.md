# CURRENT_STATE.md

Operational handoff for TraceBench / BenchBeep / BoardFact.

## Current pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

## Route status

Docs-only active-lock sync is active. It arms the future implementation pass for the Add Component / `Lisa komponent` required draft label/name save blocker copy.

This pass documents and arms the implementation allowlist only. It does not implement runtime, edit tests, change schema/tools/events/`known_facts.json`, touch `_incoming`, stage, commit, or push.

## Implementation pass armed

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

## Live-code findings behind allowlist

- Board Canvas owns the Add Component panel local draft label state through `_addComponentTemplateDraftLabel`.
- Board Canvas passes `draftLabel` and `onDraftLabelChanged` into `_AddComponentTemplateListPanel`.
- The visible label input is in Board Canvas with key `board_canvas_add_component_template_draft_label_input`.
- Save blocking copy is produced in Board Canvas through `_addComponentTemplateSaveBlockReason` and currently covers no selected component, no local project folder, and invalid `board_normalized` bounds.
- The current `canConfirmAddComponentPlacement` gate checks selected template, save-block reason, and in-flight state; the missing label is not currently represented as a dedicated save-block reason in that gate.
- Board Canvas widget tests already cover explicit `Salvesta` writer path, no-preselect guard, invalid bounds guard, local-folder guard, writer failure surfacing, label input visibility, and no-write/source boundary assertions.
- No placement writer, project-open, rotation-normalization, projection-stale, schema/tool/event, router, or `_incoming` file is required for this implementation.

## Required future behavior

- Make the missing required draft label/name reason visible without hover/click.
- Keep `Salvesta` disabled while required label/name is missing.
- Keep writer uninvoked while label/name is missing.
- Allow `Salvesta` to become enabled after label/name is entered if all other guards are satisfied.
- Preserve or explicitly document guard priority:
  1. no selected component
  2. missing required label/name
  3. invalid board-normalized bounds
  4. missing local project folder
- Keep existing bounds guard behavior.
- Keep projection-stale success copy.
- Keep rotation normalization, Project Open From Directory behavior, placement writer contract, Board Canvas renderer/painter read-only boundary, and `known_facts.json` projection/cache boundary unchanged.
- Keep draft edits / `Kustuta` / `Tühista` / navigation as no-write paths.

## Boundary confirmation

This active-lock sync is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Route safety reminders

- Do not use `git add .`.
- Do not use `git add -A`.
- Do not use `git commit -am`.
- Stage only exact files when staging is explicitly requested.
- Repo docs and verified git state outrank handoff text.