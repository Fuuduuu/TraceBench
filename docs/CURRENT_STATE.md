# Current State

## Current pass

`V2_EDIT_COMPONENT_PASS`

## Next recommended pass

`V2_EDIT_COMPONENT_POST_AUDIT_PASS`

## Latest accepted route

`V2_EDIT_COMPONENT_SCOPE_LOCK_CLOSEOUT_PASS` closed out the accepted/pushed Edit Component scope lock and routed implementation to `V2_EDIT_COMPONENT_PASS`.

## Current implementation summary

`V2_EDIT_COMPONENT_PASS` implements the scoped V2 Edit Component UI write-flow:

- creates only `component_updated`;
- targets an existing component only and does not create a new component;
- uses the accepted writer-service adapter pattern;
- never appends directly to `events.jsonl` from Flutter UI/service code;
- preserves `actor.type = human`;
- preserves `source.type = explicit_user_confirmation`;
- preserves `confirmation.confirmed = true`;
- keeps template, footprint, package, photo, helper, candidate, vector, and AI context as hints only;
- makes no automatic identity confirmation, pin mapping, net, measurement, fault proof, diagnosis, or probability claims;
- leaves Save Measurement and Add Component accepted behavior unchanged.

## Boundaries

- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper output never authors canonical events/facts.
- No Save Measurement or Add Component behavior change.
- No Project ZIP, Activity Timeline, Measure Momentum, Board Canvas write/edit, Reference Images runtime, AI/OCR/CV, Photo Markup, Repair Map, Visual Trace Shape Assist, validator, materializer, schema, asset/sample, generated artifact, platform, tag, or release work.

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Implementation audit: `docs/audit/V2_EDIT_COMPONENT_PASS.md`
