# Current State

## Current pass

`V2_EDIT_COMPONENT_SCOPE_LOCK_PASS`

## Next recommended pass

`V2_EDIT_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`

## Purpose

Docs-only scope lock for the future V2 Edit Component UI write-flow.

Future Edit Component implementation must create only `component_updated`, use the accepted writer-service adapter pattern, and never append directly to `events.jsonl`.

## Locked Edit Component boundary

- Editing patches or updates an existing component only; it must not create a new component.
- Human confirmation is required: `actor.type = human`, `source.type = explicit_user_confirmation`, and `confirmation.confirmed = true`.
- Template, footprint, package, photo, helper, candidate, vector, and AI context remain hint/context only.
- No automatic identity confirmation, pin mapping, net, measurement, fault proof, diagnosis, or probability.
- Save Measurement and Add Component accepted behavior must remain unchanged.

## Route decision

`V2_EDIT_COMPONENT_SCOPE_LOCK_PASS` routes next to `V2_EDIT_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`.

Do not route directly to `V2_EDIT_COMPONENT_PASS` before the scope lock is post-audited and closed out.

## Boundaries

- Docs-only scope lock.
- No Flutter runtime, tests, tools, validator, materializer, schema, Project ZIP, Board Canvas, Reference Images, AI/OCR/CV, Activity Timeline, Measure Momentum, assets, samples, generated artifacts, platform folders, tags, or releases.
- No Add Component or Save Measurement behavior changes.
- No completed pass history reopened or pruned.

## Binding sources

- `docs/AUDIT_CONTRACT.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_ADD_COMPONENT_PASS.md`
- `docs/audit/V2_ADD_COMPONENT_CLOSEOUT_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`

## Pointers

- Active scope: `docs/ACTIVE_SCOPE_LOCK.md`
- Queue: `docs/PASS_QUEUE.md`
- Audit ledger: `docs/AUDIT_INDEX.md`
- Scope-lock audit: `docs/audit/V2_EDIT_COMPONENT_SCOPE_LOCK_PASS.md`
