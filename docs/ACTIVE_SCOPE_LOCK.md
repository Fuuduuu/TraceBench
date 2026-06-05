# ACTIVE_SCOPE_LOCK.md

## Current pass

- Current pass: `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SYNC_SCOPE_LOCK`
- Mode: Docs-only scope lock. No runtime implementation.
- Next recommended pass: `REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS`

## Goal

Lock future Reference Values Panel display/provenance rules so measured values, reference/source values, candidate values, and notes are visually and semantically distinct before any UX styling, helper, or implementation work.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS.md`

## Forbidden surfaces

- No implementation code, tests, UI runtime, Reference Values Panel runtime, schemas, validators, tools, materializer, samples, assets, generated artifacts, platform folders, tags, or release objects.
- No Project ZIP logic or contract change.
- No Board Canvas runtime change.
- No Reference Images runtime change.
- No AI/OCR/CV, source search, URL import, web scrape, datasheet parser, public upload, cloud sync, resource-pack, commercial/licensing, or event-writing implementation.
- No `events.jsonl`, `known_facts.json`, `board_graph.json`, or `view_state.json` changes.
- No real Save Measurement / Add Component / Edit Component before `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`.

## Core boundaries

- Human is the sensor. AI is the graph engine.
- AI must not create canonical facts.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- Sourced/reference/research/candidate values are non-canonical, not measurements, not facts, not nets, not diagnoses, not probability claims, and must visually rank below human measurements.
- Damage/suspect/source/research are not proof.

## Reference Values Panel rules locked

- Docs-only scope lock - no runtime implementation; lock allowed files + future implementation pass only.
- The panel displays values and writes nothing.
- Lock distinct visual treatment for measured vs reference/source vs candidate vs note.
- Reference/candidate/note must never look measured.
- Reference/candidate/note must rank below local human measurements.
- Non-canonical: no mutation of events.jsonl, known_facts.json, materializer output, Project ZIP contract, or Board Canvas evidence rendering.
- No AI/OCR/CV, source search, URL import, web scrape, or datasheet parsing.
- No promotion of reference/candidate/note to measured/canonical without a separately scoped human-confirmed measurement/event-writing workflow.
- No real Save Measurement / Add Component / Edit Component.
- Technician-first: the measured-vs-reference distinction must be obvious to a repair tech without schema/event/projection/sidecar knowledge.
- No fault diagnosis, net inference, component-identity confirmation, or probability claims.
- Damage/suspect/source/research are not proof.

## Future pass split

- `REFERENCE_VALUES_PANEL_SCOPE_LOCK_POST_AUDIT_PASS`: required independent post-audit before implementation.
- `REFERENCE_VALUES_PANEL_IMPL_PASS`: future display-only implementation after this lock is accepted and post-audited; must not write events or canonical facts.
- `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`: Claude Design / UX critique after requesting full prototype bundle.
- `GUIDED_MEASUREMENT_FLOW_SCOPE_LOCK_PASS`: safe helper suggestions, missing measurements, and conflicts; no diagnosis or fact creation.
- `V2_EVENT_WRITING_ARCHITECTURE_SCOPE_LOCK_PASS`: required before real Save Measurement / Add Component / Edit Component behavior.