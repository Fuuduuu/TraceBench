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

The committed New Project Wizard creation cycle opens from the launcher at
`/new-project` and has seven steps. Steps 1–5 own the complete retained,
UI-local draft. Required Steps 1, 3, and 5 must all satisfy their current
gates when creation starts; a prior visit or progress label does not substitute
for current validity.

- Step 1 `Projekti andmed` owns project name, device name, parent directory,
  additional information, and the optional `Täpsemalt` values device type,
  manufacturer, model, and revision. Future-AI copy is informational only.
- Step 2 retains the optional background-photo path and UI-local alignment
  transform. Desktop supports the committed picker; mobile reports that the
  action is unavailable and does not invoke the picker.
- Step 3 retains the closed non-degenerate board-contour draft and owns its
  live creation gate.
- Step 4 retains human-created visual candidates and their presentation
  geometry. They are noncanonical proposals, not component identity,
  placement, measurement, diagnosis, or electrical facts.
- Step 5 retains all five raw human problem-description values and owns the
  nonblank-description creation gate.
- Step 6 `Kontroll ja kinnitus` presents the complete draft, provides
  functional `Muuda` actions for Steps 1–5, and exposes `Loo projekt`.
- One activation invokes creation once. While creation is pending, duplicate
  activation is blocked. Success is latched; a later activation cannot create
  or hand off the project again.
- A creation failure remains on Step 6, preserves the complete editable draft,
  and shows only fixed safe copy or a result's `sanitizedMessage`. Raw process
  output, `rawDetail`, exception text, and stack data are not read for visible
  Wizard copy.
- `ProjectCreator` owns generated-project storage: technical ID/destination
  validation, skeleton and compatible manifest, always-written
  `notes/wizard_intake.json`, optional supported photo copy, zero-byte
  `events.jsonl` initialization, Python materializer invocation, loader-based
  hydration, and generated-child-only cleanup.
- Successful creation hands the hydrated `ProjectState` to the app-owned
  provider exactly once before terminal navigation becomes available.
- Step 7 `Projekt loodud` remains visible and shows project name, technical
  project ID, and location. It does not redirect automatically.
- `Ava projekt` is the only Step 7 transition and explicitly opens the
  existing `/project` route.

Desktop supports the committed parent-directory and photo pickers. Mobile
keeps the seven-step presentation responsive but reports unavailable
folder/photo creation actions honestly and does not invoke those pickers.

The human-facing `project_name` remains separate from the random technical
directory/project identifier `prj_XXXXXXXX`. Wizard intake is noncanonical
human presentation input. Creation writes no canonical event, fact, component,
placement, measurement, evidence, diagnosis, board-side, net, or electrical
assertion. `events.jsonl` starts exactly empty and `known_facts.json` remains
materializer-owned.

## Five event meanings

- `component_created` = component identity/existence creation.
- `component_updated` = component metadata update.
- `component_visual_placement_confirmed` = visual placement confirmation.
- `board_outline_confirmed` = project-level Visual/Layout board-outline confirmation.
- `measurement_recorded` = measurement write.

The board-outline event foundation currently has no armed wizard or Board Canvas authoring workflow. UI activation, candidate persistence, and confirmation affordances remain deferred to a separate scoped pass.

Canonical data and AI boundaries: `docs/TRUTH_INDEX.md`.
