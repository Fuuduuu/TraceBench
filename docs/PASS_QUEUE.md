# PASS_QUEUE.md

Routing owner for TraceBench / BenchBeep / BoardFact passes.

## Current pass

`NEEDS_USER_DECISION`

## Next recommended pass

`NEEDS_USER_DECISION`

## Route status

No active pass is armed. The canonical placement chain is closed out, and route control remains with the user.

## Current accepted placement chain

| Order | PASS_ID | Accepted result |
|---|---|---|
| 1 | `PLACEMENT_WRITER_AND_CONFIRM_IMPL_PASS` | Added the dedicated placement writer and explicit selected-component Board Canvas `Salvesta` path. |
| 2 | `PROJECT_OPEN_FROM_DIRECTORY_IMPL_PASS` | Added local-folder project open path so `projectDirectory` is preserved for writer-backed projects. |
| 3 | `PLACEMENT_ROTATION_NORMALIZATION_IMPL_PASS` | Normalized writer payload `rotation_deg` into `-180 <= rotation_deg < 180`. |
| 4 | `PLACEMENT_SAVE_PROJECTION_STALE_IMPL_PASS` | Made successful placement save truthfully mark/show projection stale or refresh-needed. |
| 5 | `BOARD_CANVAS_EXPLICIT_WRITE_STATUS_COPY_IMPL_PASS` | Clarified Board Canvas copy: renderer/painter are read-only, but explicit panel save may write canonical placement events. |
| 6 | `PLACEMENT_DRAFT_CANONICAL_BOUNDS_GUARD_IMPL_PASS` | Blocked invalid `board_normalized` placement drafts before writer call with clear UI copy. |

## Current behavior summary

- Explicit human-confirmed `Salvesta` can append `component_visual_placement_confirmed` only through the accepted writer path.
- Board Canvas renderer/painter remains read-only.
- `known_facts.json` remains projection/cache and is not directly mutated by Flutter.
- Draft edits / `Kustuta` / `Tühista` / navigation remain no-write paths.
- Visual placement save does not create identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.

## Candidate only

Likely next candidate, not armed: `ADD_COMPONENT_DRAFT_LABEL_REQUIRED_COPY_SCOPE_LOCK_PASS`.

## Scope gate rules

- One narrow pass at a time.
- Do not implement without an active implementation lock.
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