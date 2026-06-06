# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS`

## Lane

`CODEX / DOCS_SYNC_PREP`

## Mode

Docs/source-prep only. Do not implement runtime code. Do not modify Flutter runtime, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Goal

Prepare the safe docs-only source location for the BoardFact Measure Sheet prototype bundle and record handoff rules before `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`

This pass is blocked/gated until the user provides HTML, CSS, JS, screenshots or screen recording if available, and a behavior-vs-visual note. If the bundle is still missing, the next action is user bundle collection, not design or implementation.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS.md`
- `docs/sources/ideelabor/boardfact_measure_sheet/README.md`
- `docs/sources/ideelabor/boardfact_measure_sheet/.gitkeep`
- `docs/sources/ideelabor/boardfact_measure_sheet/screenshots/.gitkeep`
- `docs/sources/ideelabor/boardfact_measure_sheet/recordings/.gitkeep`

## Forbidden surfaces

- Runtime code
- Flutter runtime
- Tests
- Schemas or validators
- Tools or materializer
- Project ZIP logic or contract
- Board Canvas runtime
- Reference Images runtime
- AI/OCR/CV
- URL import
- Event-writing
- Generated artifacts
- Assets or samples
- Platform folders
- Tags or release objects

## Prototype source boundary

- `docs/sources/ideelabor/boardfact_measure_sheet/` is design/prototype source material only.
- It is not production Flutter source.
- It must not be treated as implementation input without `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` and a separate implementation scope.
- Do not copy HTML/CSS/JS directly into Flutter.
- Do not copy localStorage persistence behavior into the evidence workflow.
- Do not treat prototype Save behavior as event-writing permission.
- Do not infer schema changes from the prototype.
- Do not add files to assets or samples.
- Do not include this source bundle in Project ZIP behavior.

## Evidence boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference/source/candidate/note values are non-canonical and must not look measured.
- Board Canvas remains read-only.
