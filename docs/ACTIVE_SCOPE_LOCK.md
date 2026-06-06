# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`

## Lane

`CODEX / DOCS_SYNC_DESIGN_RECORD`

## Mode

Docs-only design review recording. Do not implement runtime code. Do not modify Flutter runtime, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Goal

Record the completed Claude Design / UX review of the BoardFact Measure Sheet prototype and route the next safe pass without starting implementation.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS`

The next pass must be docs-only scope lock, not implementation. It should encode neutral status-dot language, human-as-sensor copy, measured/reference/candidate/note hierarchy, accessibility minimums, narrow-window expectations, and no Save/Add/Edit/event-writing.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/SOURCES_INDEX_CURRENT.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS.md`
- `docs/sources/ideelabor/boardfact_measure_sheet/README.md`

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
- Prototype HTML/CSS/JS source files

## Accepted design review result

- Claude Design / UX review returned `ACCEPT_WITH_NITS`.
- Technician-first flow, hierarchy, and evidence posture are directionally right.
- The prototype supports the bench workflow better than spreadsheet-style UI.
- The prototype is visual + workflow direction only.
- Interactions may be reviewed as UX intent, but behavior must not be preserved as production logic.
- Do not copy localStorage, Save behavior, event-writing, schema assumptions, or runtime implementation patterns.

## Key design nits to carry forward

- Green `paigutatud` status dot can read as verified/good; future scope must neutralize it.
- Evidence-dot meaning must be locked to `a reading was recorded here`, never `this pin is good`.
- `automaatne` near Koht implies AI/app detection; future copy must avoid inference-tinted language.
- `Mõõdan...` relocates the sensor from technician to app; future copy must keep human as sensor.
- Pin chips around 34px are below 44px touch target minimum.
- Faint small labels risk readability/AA failure.
- Board drops entirely on narrow windows; future scope needs fallback.
- Reference Values Panel ladder is design direction only: measured dominant amber, reference/source calm steel-blue, candidate tentative/dashed violet, note faint italic.

## Evidence boundaries preserved

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Board Canvas remains read-only.
- Reference/source/candidate/note values remain non-canonical unless separately human-confirmed.
- Reference/candidate/note must never look measured.
- Photo pixels are not facts.
- Damage/suspect/source/research are not proof.
- No AI diagnosis, net inference, component identity confirmation, or probability-style claims.

## Must wait for V2 event-writing architecture

- Real Save Measurement runtime
- Add Component runtime
- Edit Component runtime
- Event-writing
- Canonical fact creation
- `known_facts.json` mutation
- Schema changes driven by the prototype
- Promotion of prototype Save behavior into actual evidence workflow
