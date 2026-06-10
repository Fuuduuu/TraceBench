# Current State

## Current pass

`V2_EDIT_COMPONENT_CLOSEOUT_PASS`

## Next recommended pass

`V2_MEASURE_SHEET_UX_STRATEGY_CAPTURE_PASS`

## Latest accepted route

`V2_EDIT_COMPONENT_PASS` is accepted, post-audited/rechecked as `ACCEPT_AS_IS`, committed, and pushed as `ea99ed4 feat: add V2 component editing flow`.

## Closeout summary

`V2_EDIT_COMPONENT_CLOSEOUT_PASS` records Edit Component as the third accepted V2 canonical UI write-flow after Save Measurement and Add Component:

- creates only `component_updated`;
- edits existing components only and does not create components;
- uses the accepted writer-service adapter pattern;
- never appends directly to `events.jsonl` from Flutter UI/service code;
- preserves `actor.type = human`;
- preserves `source.type = explicit_user_confirmation`;
- preserves `confirmation.confirmed = true`;
- keeps template, footprint, package, photo, helper, candidate, vector, and AI context as hints only;
- leaves Save Measurement and Add Component accepted behavior unchanged.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- No Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, validator, materializer, schema, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Closeout audit: `docs/audit/V2_EDIT_COMPONENT_CLOSEOUT_PASS.md`
