# BoardFact Measure Sheet prototype source

## Purpose

This folder holds visual/product workflow input for the technician-first UX design pass. It is for the BoardFact Measure Sheet prototype bundle only.

## Status

Design source only, not production Flutter source. Files in this folder are not runtime app source and do not authorize implementation.

## Folder purpose

Use `docs/sources/ideelabor/boardfact_measure_sheet/` to collect the prototype bundle before `TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`.

Expected placement:

- `BoardFact Measure Sheet example.html`
- `measure.css`
- `measure.js`
- `screenshots/*`
- `recordings/*`

The `screenshots/` and `recordings/` directories are placeholders until the user provides visual evidence.

## Forbidden use rules

Do not:

- copy HTML/CSS/JS directly into Flutter,
- copy localStorage persistence behavior into the evidence workflow,
- treat prototype Save behavior as event-writing permission,
- add event-writing UI,
- add Save Measurement / Add Component / Edit Component runtime,
- infer schema changes from the prototype,
- create canonical facts,
- mutate `events.jsonl` or `known_facts.json`,
- add files to assets or samples,
- include this source bundle in Project ZIP behavior,
- start UX design from this folder without the dedicated UX design pass,
- start implementation from this folder without a separate implementation scope.

## Behavior note

Behavior note: Use the prototype as visual + workflow direction only. Interactions may be reviewed as UX intent, but behavior must not be preserved as production logic. Do not copy localStorage, Save behavior, event-writing, schema assumptions, or runtime implementation patterns.

## Next pass

`TECHNICIAN_FIRST_MEASURE_SHEET_UX_DESIGN_PASS`

That pass remains gated until the user provides the prototype bundle:

- HTML,
- CSS,
- JS,
- screenshots or screen recording if available,
- behavior-vs-visual note.

## Warning

This folder does not authorize Save Measurement, Add Component, Edit Component, event-writing, schema changes, canonical facts, or runtime UI implementation.
