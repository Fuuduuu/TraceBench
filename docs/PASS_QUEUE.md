# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`

## Route status

The current pass is a docs-only active-lock sync for selected-placement visual draft prefill behavior in Board Canvas.

It arms the exact implementation allowlist for `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`; no runtime or test implementation is performed in this sync.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |
| 7 | `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_IMPL_PASS` | Made the missing required Add Component draft label/name reason visible while keeping `Salvesta` disabled and writer uninvoked until the label is entered. |
| 8 | `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` | Clarified Project Overview, standalone Add Component, standalone Edit Component, and Board Canvas copy so identity creation, metadata edit, and visual placement confirmation are not confused. |
| 9 | `BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_PASS` | Added a read-only Board Canvas `Komponendid` hub card that explains component identity, metadata, placement, and measurement write domains without adding writer calls or route changes. |

## Selected placement edit/prefill active-lock sync

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS` arms `SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_PASS`.

Scope-lock source:

- `3596e1a` (`docs: lock selected placement edit prefill scope`)
- `docs/audit/SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS.md`

Exact implementation allowlist:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Live-code findings:

- Board Canvas owns selected placement state, Add Component / `Lisa` panel state, local visual draft fields, guard copy, and the placement save call site.
- `_selectedPlacementKey` is the volatile canvas/list selection key.
- `_addComponentTemplatePlacementContextKey` carries selected existing placement context into the panel.
- Opening the Add Component rail captures the current coerced selected key into `_addComponentTemplatePlacementContextKey`.
- The panel already shows `Valitud komponent: ...` / `Valitud komponent: puudub` and guards `Salvesta` by selected component, required label, canonical bounds, and folder-backed project.
- Board Canvas widget tests already cover the relevant selection, guard, save, local-only draft, and no-write paths.
- No placement writer, standalone Add/Edit Component, Project Overview, Project Open From Directory, router, schema, validator, materializer, event, `known_facts.json`, sample, asset, or `_incoming` file is required for this implementation.

Implementation goal:

- When a technician selects an existing placement/component and opens the Board Canvas visual placement draft panel, seed or prefill the UI-local draft from the selected placement where safe.
- Preserve selected component context and make the panel feel edit-like for the selected placement rather than blank template-only.
- Continue allowing local template/shape/size/rotation changes before explicit save.

Critical V1/V2 stale placement hazard:

- Prefill must use the current/latest placement value represented by the app projection, not a stale older placement for the same component.
- The implementation pass must verify selected entry/source selection against the latest-wins placement projection semantics established by the placement projection ordering work.
- Tests must include a case proving a selected component with older V1 and newer V2 placement history pre-fills from the intended current/latest placement, not from an older stale value.

Required tests for implementation:

- canvas/list select component or placement -> open Add Component / `Lisa` panel keeps selected context
- selected placement seeds draft center/size/rotation/template where available
- prefilled draft writes nothing before `Salvesta`
- changing template/size/rotation remains UI-local until save
- `Salvesta` still emits exactly one `component_visual_placement_confirmed` when valid
- no selected component remains guarded
- missing label, invalid bounds, and missing folder guards still work
- V1/V2 stale placement hazard is covered by a focused fixture/test
- standalone Add/Edit identity/metadata behavior is not changed

Forbidden surfaces for implementation:

- no placement writer contract changes
- no event schema changes
- no validator/materializer/tool changes
- no `events.jsonl` or `known_facts.json` semantic changes
- no Project Open From Directory changes
- no rotation normalization changes
- no projection-stale policy changes
- no canonical-bounds guard weakening
- no required-label guard weakening
- no Add/Edit Component identity/metadata writer changes
- no measurement writer changes
- no identity creation from visual placement
- no pins/contacts/pads/nets/traces/electrical facts from visual marker drafts
- no AI-authored canonical facts

## Scope gate rules

- One narrow pass at a time.
- Do not implement outside the active implementation allowlist.
- Do not broaden runtime, schema, tool, event, projection, or writer surfaces unless the active lock explicitly authorizes them.
- Do not stage, commit, or push unless explicitly asked.
- Never use `git add .`, `git add -A`, or `git commit -am`.

## Current-state maintenance trigger

When a pass is staged/pushed/audited or a route changes, keep these route owners synchronized:

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/AUDIT_INDEX.md`

## Routing provenance

Provenance and audit details live in `docs/AUDIT_INDEX.md` and `docs/audit/*.md`. `PASS_QUEUE.md` remains a routing ledger, not architecture documentation.