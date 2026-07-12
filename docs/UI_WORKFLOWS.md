# UI_WORKFLOWS.md

## Purpose

On-demand BenchBeep UX/workflow policy. It does not authorize implementation or canonical writes; active authority comes from `docs/ACTIVE_SCOPE_LOCK.md`.

UI work must preserve `docs/POHIKIRI.md` and stop for human decision on conflict.

## Visual First

BenchBeep is a local-first Visual First PCB repair workbench.

Technician-facing core: `Koht -> Väärtus -> Ühik -> Salvesta`.

The technician stays on the board. Board Canvas plus its contextual right-side panel/menu is the primary surface for normal component work.

## Primary workflow

Where practical, normal work happens in or beside Board Canvas:

- measurement
- component identity creation
- component metadata editing
- visual placement confirmation

Direct visual context should outrank table/form detours.

## Transitional standalone pages

Standalone Add/Edit/Measure-style pages may remain until scoped replacements exist, but they are transitional and must not be duplicated as a second primary workflow inside Board Canvas.

## Four event meanings

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

Canonical data and AI boundaries: `docs/TRUTH_INDEX.md`.
