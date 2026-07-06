# UI_WORKFLOWS.md

## Purpose

Concise UX/workflow policy for BenchBeep. This file does not authorize runtime writes by itself; active implementation scope still comes from `docs/ACTIVE_SCOPE_LOCK.md`.

## Visual First rule

BenchBeep is a local-first Visual First PCB repair workbench.

Technician-facing core:
- `Koht -> Väärtus -> Ühik -> Salvesta`

The technician stays on the board. Board Canvas plus the right-side panel/menu is the primary workflow surface for normal component work.

AI may propose and organize, but the human confirms canonical facts.

## Primary technician workflow

Normal component work should happen in or beside Board Canvas where practical:
- measurement
- component identity creation
- component metadata editing
- visual placement confirmation

The workflow should favor direct visual context over table/form detours.

## Transitional legacy pages

Old standalone Add/Edit/Measure-style pages are transitional migration/removal debt.

They may remain available until scoped replacements exist, but they are not the primary technician workflow and must not be duplicated as a second workflow menu inside Board Canvas.

## Canonical event split

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `measurement_recorded` = measurement write.

Visual placement must not create component identity, pins, contacts, pads, nets, traces, electrical facts, measurements, AI facts, or repair conclusions.

## Data boundaries

- events.jsonl is canonical truth.
- known_facts.json is projection/cache.
- Flutter must not directly mutate known_facts.json.
- Human is the sensor; AI is the graph engine.
- `_incoming` is design/provenance input only and must not become runtime truth.