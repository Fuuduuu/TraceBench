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

## New Project Wizard creation workflow

This locked completion workflow is future implementation authority, not a
claim that current runtime already creates a project. The New Project Wizard
creation cycle has seven steps. Steps 1–5 own the complete retained draft.
Required Steps 1, 3, and 5 must all satisfy their current gates when creation
starts; a prior visit or progress label does not substitute for current
validity.

- Step 1 `Projekti andmed` owns project name, device name, parent directory,
  additional information, and the optional `Täpsemalt` values device type,
  manufacturer, model, and revision. Future-AI copy is informational only.
- Steps 2–5 retain the accepted photo, contour, visual-candidate, and raw
  five-field human problem drafts.
- Step 6 is `Kontroll ja kinnitus`. It presents the complete draft summary,
  provides edit links back to Steps 1–5, and exposes `Loo projekt`.
- A creation failure remains on Step 6 and preserves the complete draft for
  correction or retry. Duplicate activation must not start concurrent or
  repeated creation calls, and only sanitized creation-result messages may be
  shown.
- Step 7 is `Projekt loodud`. It shows project name, technical project ID, and
  location. Creation success assigns the returned project state exactly once
  but does not navigate automatically.
- `Ava projekt` is the only Step 7 transition to the existing `/project`
  route. The provider assignment precedes that transition.

The human-facing `project_name` remains separate from the random technical
directory/project identifier `prj_XXXXXXXX`. Creation writes the noncanonical
Wizard presentation draft to `notes/wizard_intake.json`; it does not create a
component, placement, measurement, event, fact, diagnosis, or other canonical
assertion. `events.jsonl` starts empty and `known_facts.json` remains
materializer-owned.

## Five event meanings

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `board_outline_confirmed` = project-level Visual/Layout board-outline confirmation.
- `measurement_recorded` = measurement write.

The board-outline event foundation currently has no armed wizard or Board Canvas authoring workflow. UI activation, candidate persistence, and confirmation affordances remain deferred to a separate scoped pass.

Canonical data and AI boundaries: `docs/TRUTH_INDEX.md`.
