# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS`

## Next recommended pass

`SELECTED_PLACEMENT_EDIT_PREFILL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

The current pass is a docs-only product scope-lock for selected-placement visual draft prefill behavior in Board Canvas.

No implementation allowlist is armed in this pass. The next active-lock sync must read live code and arm exact files if the scope-lock is accepted.

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

## Selected placement edit/prefill scope-lock

`SELECTED_PLACEMENT_EDIT_PREFILL_SCOPE_LOCK_PASS` locks the intended behavior for opening a Board Canvas visual placement draft from a selected existing component/placement.

Product problem:

- A technician can select a component/placement on the Board Canvas and open `Lisa` / Add Component.
- The current flow carries selected component context for save guards, but the panel can still feel like a blank shape/template choice flow.
- User expectation is that selected board/component context should carry meaningful placement context into the right-panel draft/editor.

Current live-code findings:

- `_selectedPlacementKey` is the volatile Board Canvas selection key.
- Selection handlers update both `_selectedPlacementKey` and `_addComponentTemplatePlacementContextKey`.
- Opening the Add Component rail captures the current coerced selected key into `_addComponentTemplatePlacementContextKey`.
- The save context copy renders `Valitud komponent: ...` or `Valitud komponent: puudub`.
- `Salvesta` is guarded by selected component context, required label, canonical bounds, and local project folder.
- Local draft width, height, rotation, center, template, and label state remain in-memory until explicit `Salvesta`.
- Existing tests cover selected context, no-preselect guard, invalid board-normalized guards, writer invocation, and volatile draft behavior.

Locked product behavior:

- Selected component/placement context should prefill or seed visual placement draft state where safe.
- If selected placement data exists, future UI may open directly into an edit-like placement draft rather than a blank template-only flow.
- The user should still be able to choose/change template/shape locally before save.
- This is visual placement editing/confirmation for an existing component, not standalone Add Component identity creation.
- Later copy may prefer `Muuda paigutust` / `Paiguta` wording over generic `Lisa`, but naming is not implemented in this pass.
- All draft edits remain UI-local until explicit `Salvesta`.

Future implementation expectations:

- Preserve selected placement context when opening the panel.
- Prefill template/shape/size/rotation/center from selected placement where safe.
- Show clear copy that this is visual placement editing/confirmation.
- Still allow changing template/shape locally before save.
- Keep draft edits, `Kustuta`, `Tühista`, and navigation no-write.
- Keep `Salvesta` guarded by selected component, label, bounds, and folder-backed project.

Likely future implementation surfaces to inspect later:

- `lib/features/board_canvas/screens/board_canvas_screen.dart`
- `test/widget/board_canvas_screen_test.dart`

Do not assume these are sufficient. The next active-lock sync must inspect live code and arm the exact allowlist.

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
