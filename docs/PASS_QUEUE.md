# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. The Add/Edit Component legacy-flow labeling implementation is closed out.

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

## Add/Edit/Board Canvas labeling sequence

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_SCOPE_LOCK_PASS` locked the product taxonomy:

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement/documentation confirmation.

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_ACTIVE_LOCK_SYNC_PASS` armed `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` with the exact implementation allowlist.

`ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_PASS` was pushed as `129a1a87cf8c015f65b6bd5024fc160dcfd900e7` (`fix: clarify add edit and placement flow labels`) and is closed out by `ADD_EDIT_COMPONENT_LEGACY_FLOW_LABELING_IMPL_POST_AUDIT_PASS`.

Accepted result:

- Project Overview distinguishes component identity creation, component metadata edit, and Board Canvas visual placement confirmation.
- Standalone Add Component copy clearly means component identity/existence creation.
- Standalone Edit Component copy clearly means component metadata update.
- Board Canvas `Lisa` / `Salvesta` remains visual placement confirmation for an existing component.
- Routes remain working.
- No routes/screens were hidden, deleted, or merged.
- Writer/event semantics remain unchanged for `component_created`, `component_updated`, and `component_visual_placement_confirmed`.

Known future product direction:

- A Board Canvas `Komponendid` workflow panel may be considered later.
- That direction is out of scope for this closeout and is not armed here.

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
