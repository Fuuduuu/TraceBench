# ACTIVE_SCOPE_LOCK.md

## Current pass

`TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_CLOSEOUT_PASS`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only closeout. Do not modify runtime code, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Goal

Close out the accepted and pushed `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS` after Claude Code / Opus post-audit and the resolved small docs patch.

## Accepted closeout input

- `TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_PASS` is accepted/pushed as a docs-only scope lock.
- Claude Code / Opus post-audit returned `NEEDS_SMALL_PATCH`; the scope-lock substance was accepted.
- The only patch was removal of a literal trailing text artifact from two Measure Sheet deferral lines in `docs/DEFERRED_FEATURES.md`.
- Validation passed after the patch.
- No implementation, runtime, source, asset, sample, schema, tool, validator, materializer, generated artifact, tag, or release-object change is part of this closeout.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS`

Implementation may proceed only within the locked read-only/display-only shell scope. Do not route to V2, real Save/Add/Edit, Guided Measurement, AI/OCR/CV, source search, URL import, or canonical mutation from this closeout.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/TECHNICIAN_FIRST_MEASURE_SHEET_SCOPE_LOCK_CLOSEOUT_PASS.md`

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
- Source search, URL import, datasheet parser, or web scrape
- Event-writing
- Generated artifacts
- Assets or samples
- Platform folders
- Tags or release objects
- Prototype HTML/CSS/JS/screenshots

## Locked implementation boundary carried forward

Future pass `TECHNICIAN_FIRST_MEASURE_SHEET_READONLY_SHELL_IMPL_PASS` may implement only a read-only/display shell for the technician-first Measure Sheet concept.

Allowed future slice:

- technician-first layout structure,
- safe copy and labels,
- non-writing visual hierarchy,
- disabled/non-functional save affordance only if needed for visual context,
- neutral status-dot / recorded-reading semantics,
- measured/reference/candidate/note visual hierarchy,
- accessibility minimums,
- narrow-window fallback behavior,
- tests proving no writing/editing/canonical mutation affordance exists.

Forbidden future slice:

- real Save Measurement,
- Add Component,
- Edit Component,
- event-writing,
- canonical fact creation,
- schema changes,
- `known_facts.json` mutation,
- materializer changes,
- Project ZIP behavior changes,
- Board Canvas write/edit behavior,
- AI/OCR/CV,
- source search,
- URL import,
- datasheet parser,
- localStorage behavior,
- copied prototype implementation patterns.

## Core hard boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains materialized projection.
- Renderer/view writes nothing unless explicitly scoped.
- `board_graph.json` and `view_state.json` remain forbidden V1 artifacts.
- Reference/source/candidate/note values remain non-canonical.
- Reference Images remain local sidecar only, non-canonical, outside Project ZIP/events/known_facts/materializer/Board Canvas/AI/OCR/CV/URL import.
- Board Canvas remains read-only.
- Real Measure Sheet Save/Add/Edit/event-writing behavior must wait for separately accepted V2 event-writing architecture.