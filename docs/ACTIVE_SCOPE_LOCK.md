# ACTIVE_SCOPE_LOCK.md

## Current pass

`REFERENCE_VALUES_PANEL_SCOPE_LOCK_CLOSEOUT_PASS`

## Lane

`CODEX / DOCS_SYNC_CLOSEOUT`

## Mode

Docs-only closeout. Do not modify runtime code, tests, schemas, validators, tools, materializer, Project ZIP logic, Board Canvas runtime, Reference Images runtime, AI/OCR/CV, URL import, event-writing, generated artifacts, assets, samples, platform folders, tags, or release objects.

## Goal

Record the accepted and pushed `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` and its Claude Code / Opus post-audit result.

## Next recommended pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PREP_PASS`

This is a docs-only prep route because `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS` is gated on the user providing the full prototype bundle. The prep pass should record the bundle request and handoff expectations without starting design, implementation, or runtime work.

## Write allowlist

- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/AUDIT_INDEX.md`
- `docs/WORK_INTAKE_INDEX.md`
- `docs/DEFERRED_FEATURES.md`
- `docs/audit/REFERENCE_VALUES_PANEL_SCOPE_LOCK_CLOSEOUT_PASS.md`

## Forbidden surfaces

- Runtime code
- Tests
- Schemas or validators
- Tools or materializer
- Project ZIP logic
- Board Canvas runtime
- Reference Images runtime
- AI/OCR/CV
- URL import
- Event-writing
- Generated artifacts
- Assets or samples
- Platform folders
- Tags or release objects

## Accepted closeout state

- `REFERENCE_VALUES_PANEL_SCOPE_LOCK_PASS` completed as a docs-only scope lock and was pushed.
- Claude Code / Opus post-audit returned `ACCEPT_AS_IS`.
- No blocker, high, or medium findings were recorded.
- LOW prior route-review status tidy was applied before commit.
- `py -3 tools\validate_all.py` passed with 236 tests OK; optional missing-photo warnings remained non-blocking.

## Locked reference-values boundary

- Reference Values Panel scope is display/provenance only.
- Future panel displays values and writes nothing.
- Renderer writes: none.
- Measured values remain visually highest priority.
- Reference/source/candidate/note values remain visually subordinate.
- Non-measured values must never look measured.
- Distinction must be obvious to a repair tech without schema/event/projection/sidecar knowledge.
- Values are non-canonical unless separately human-confirmed through a scoped workflow.
- Reference/source/candidate/note values are not measurements, confirmed component facts, nets, diagnoses, probability claims, or proof.
- Future panel work must not mutate `events.jsonl`, `known_facts.json`, materializer output, Project ZIP contract, or Board Canvas evidence rendering.
- No AI/OCR/CV, source search, URL import, web scrape, datasheet parsing, event-writing, or runtime implementation is added by this closeout.
- `REFERENCE_VALUES_PANEL_IMPL_PASS` remains deferred/not started.
