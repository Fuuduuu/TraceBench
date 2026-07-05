# ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Baseline verification

Gate commands run before edits:

- `git status --short --branch`
- `git log --oneline --decorate -8`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`

Gate result:

- Branch: `main...origin/main`
- HEAD: `5d34186` (`docs: lock add component draft label required copy scope`)
- Tracked diff before edits: clean
- Cached diff before edits: clean
- Route before edits: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS` -> `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Known untracked scratch remained untouched.

## Goal

Arm the exact implementation allowlist for `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`.

The future implementation will make the missing required draft label/name reason visible when `Salvesta` is disabled.

## Live-code findings

Live-code inspection found:

- `_addComponentTemplateDraftLabel` stores the local Add Component draft label in `lib/features/board_canvas/screens/board_canvas_screen.dart`.
- `draftLabel` and `onDraftLabelChanged` are passed into `_AddComponentTemplateListPanel` from Board Canvas.
- The draft label input uses key `board_canvas_add_component_template_draft_label_input` in Board Canvas.
- `_addComponentTemplateSaveBlockReason` currently returns save-block copy for:
  - no selected component: `Vali olemasolev komponent enne salvestamist.`
  - no local project folder: `Salvestamiseks ava projekt kohalikust kaustast.`
  - invalid `board_normalized` bounds: `Suurus või asukoht ei mahu plaadi piiridesse.`
- `canConfirmAddComponentPlacement` currently gates on selected template, save-block reason, and in-flight save state.
- The missing required label/name condition is not currently represented as a dedicated save-block reason in that gate.
- The `Salvesta` callback wiring and boundary copy are in Board Canvas.
- Widget coverage for explicit save, no-preselect guard, invalid bounds guard, local-folder guard, writer-failure surfacing, label input visibility, and no-write/source-boundary assertions lives in `test/widget/board_canvas_screen_test.dart`.

No evidence showed a need to arm placement writer, project-open files, rotation-normalization files, projection-stale files beyond Board Canvas, tools/materializer/validator/schema, events/known_facts, router, or `_incoming`.

## Exact implementation allowlist armed

`ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` may edit exactly:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

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

## Future copy intent

Use concise Estonian copy, for example:

- `Lisa nimi enne salvestamist.`
- `Komponendi nimi on salvestamiseks vajalik.`
- `Sisesta nimi, et paigutus salvestada.`

Exact final wording may be chosen in implementation, but it must be clear and persistent.

## Future tests must prove

- empty required label/name disables `Salvesta`
- visible copy explains missing label/name without hover/click
- writer is not invoked while label/name is missing
- entering valid label/name can enable `Salvesta` when other guards pass
- existing guards still work: no selected component, invalid board-normalized bounds, and missing local project folder
- valid save still appends and shows projection-refresh truth copy
- draft edits / `Kustuta` / `Tühista` / navigation write nothing

## Forbidden surfaces

Not armed:

- placement writer
- project open files
- rotation normalization files
- projection-stale files beyond Board Canvas
- tools/materializer/validator/schema
- events / `known_facts.json`
- router
- samples/assets
- `_incoming`

## Route after this pass

- Current: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS`

## Boundary confirmation

This active-lock sync is docs-only. It does not edit runtime, tests, schema, tools, events, `known_facts.json`, samples, assets, or `_incoming`.

## Audit status

DRAFTED / PENDING CLAUDE AUDIT.