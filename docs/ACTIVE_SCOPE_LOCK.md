# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`

## Lane

`CODEX / FLUTTER_PASS`

## Mode

Scoped implementation only. Implement the first technician-first Measure Sheet read-only/display shell slice. Do not implement event-writing, real Save Measurement, Add Component, Edit Component, canonical mutation, schema changes, materializer changes, Project ZIP changes, Board Canvas write/edit behavior, AI/OCR/CV, source search, URL import, datasheet parser, or localStorage behavior.

## Goal

Add the smallest implementation-safe read-only Measure Sheet shell that demonstrates the technician-first flow `Koht -> Väärtus -> Ühik -> Salvesta` without writing or mutating project facts.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_POST_AUDIT_PASS`

Claude Code / Opus must audit this implementation before closeout or any follow-up scope.

## Write allowlist

- `lib/app/router.dart`
- `lib/features/project/screens/project_overview_screen.dart`
- `lib/features/measure_sheet/screens/measure_sheet_screen.dart`
- `test/widget/measure_sheet_screen_test.dart`
- `test/widget/project_overview_screen_test.dart`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS.md`

## Implemented slice

- New read-only `MeasureSheetScreen` route at `/project/measure-sheet`.
- Project overview action labeled `Measure Sheet`.
- Technician-first flow labels: `Koht -> Väärtus -> Ühik -> Salvesta`.
- Disabled/non-functional save-looking affordance that clearly says it does not write.
- Neutral recorded-reading status copy.
- Display hierarchy for `Mõõdetud`, `Viide / Allikas`, `Kandidaat`, and `Märkus`.
- Narrow-width fallback that keeps selected `Koht` context visible.
- Focused widget/navigation/source-boundary tests.

## Forbidden surfaces

- Real Save Measurement runtime
- Add Component runtime
- Edit Component runtime
- Event-writing
- Canonical fact creation
- Schema changes
- `known_facts.json` mutation
- Materializer changes
- Project ZIP behavior changes
- Board Canvas write/edit behavior
- Reference Images runtime changes
- AI/OCR/CV
- Source search
- URL import
- Datasheet parser
- localStorage behavior
- Copied prototype HTML/CSS/JS implementation patterns
- Generated artifacts
- Assets or samples
- Platform folders
- Tags or release objects

## Core hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference/source/candidate/note values remain non-canonical and cannot look measured.
- Board Canvas remains read-only.
- Real Measure Sheet Save/Add/Edit/event-writing behavior must wait for separately accepted V2 event-writing architecture.