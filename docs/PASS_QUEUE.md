# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS`

## Next recommended pass

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Route status

The current pass is a docs-only product scope-lock for a future Board Canvas `Komponendid` workflow panel direction.

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

## Board Canvas `Komponendid` workflow direction

`BOARD_CANVAS_COMPONENTS_WORKFLOW_PANEL_SCOPE_LOCK_PASS` locks product direction only.

Current flow map:

- Project Overview / Workbench routes users to standalone Add Component, standalone Edit Component, Board Canvas, Measure Sheet, Board Graph, and projection/list surfaces.
- Standalone Add Component writes `component_created` for explicit human component identity/existence creation.
- Standalone Edit Component writes `component_updated` for explicit human component metadata updates.
- Board Canvas `Lisa` / `Salvesta` writes `component_visual_placement_confirmed` for visual placement confirmation of an existing selected component.
- Measure Sheet writes `measurement_recorded` and remains the current canonical measurement writer.
- Board Graph remains advanced/debug projection inspection and must not create canonical facts.

Proposed future `Komponendid` flow map:

- `Vali komponent` selects or anchors component context on Board Canvas.
- `Loo komponent` leads to identity/existence creation through `component_created`.
- `Muuda andmeid` leads to metadata update through `component_updated`.
- `Paiguta / kinnita visuaalne paigutus` confirms placement through `component_visual_placement_confirmed`.
- `Mõõda komponenti` starts component-related measurement through the measurement flow and `measurement_recorded`.
- `Vaata seotud mõõtmisi` shows projection/read-only measurement summary.

Product decision still needed before implementation:

- `A` navigation hub to existing Add/Edit/Measure flows.
- `B` true integrated right-panel workflow.
- `C` phased hybrid: first hub/copy, then integrated writer surfaces.
- `D` do not pursue yet.

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
