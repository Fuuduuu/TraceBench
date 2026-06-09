# V2_ADD_COMPONENT_SCOPE_LOCK_PASS

## Pass

- PASS_ID: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Lane: `CODEX / DOCS_SCOPE_LOCK`
- Type: scope-lock
- Previous accepted pass: `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`

## MODEL_ROUTING_CHECK

PASS. Codex is appropriate for this repo-local docs-only scope lock. No code, tests, schemas, validators, materializers, writer service, Project ZIP logic, Flutter runtime, assets, samples, generated artifacts, tags, or releases are modified.

## Startup state

- Branch: `main`.
- Latest accepted commit at startup: `5b2c8e7 docs: close out save measurement path hardening`.
- Tracked working tree was clean before this pass.
- Known unrelated local untracked paths may remain.
- Route before this pass was current `V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS`, next `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`.

## Scope drift check

PASS. This pass is docs-only and locks a future implementation boundary. It does not implement Add Component and does not modify runtime/source/test/tool/schema/materializer/writer/ZIP/UI behavior.

## Verdict

PASS. Future Add Component is locked as the next V2 canonical write surface, but implementation remains blocked until post-audit accepts this scope lock.

## Binding sources

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/spec/V2_EVENT_SCHEMA_SPEC.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PASS.md`
- `docs/audit/V2_SAVE_MEASUREMENT_PATH_CANONICALIZATION_HARDENING_CLOSEOUT_PASS.md`
- `tools/event_writer_service.py`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`

## Locked future Add Component scope

Future implementation must:

- create only `component_created`;
- use the accepted writer service adapter pattern;
- never append directly to `events.jsonl` from UI/provider code;
- preserve `actor.type = human`;
- preserve `source.type = explicit_user_confirmation`;
- preserve `confirmation.confirmed = true`;
- keep `template_id`, footprint, package, vector, visual, photo, reference, helper, candidate, and AI context as hints/context only;
- avoid automatic component identity confirmation from any non-human-confirmed context;
- preserve accepted Save Measurement behavior unchanged.

`template_id` / footprint / package family remains a visual or geometry hint, not electrical identity.

## Future implementation allowlist

Future implementation may touch only:

- minimal Add Component UI/service/provider files required for human-confirmed `component_created`;
- minimal writer-adapter integration if needed;
- focused Add Component widget/unit tests;
- governance/audit docs.

## Future forbidden surfaces

Future implementation must not touch:

- Save Measurement behavior except shared safe integration if explicitly needed;
- Edit Component;
- Project ZIP;
- Activity Timeline;
- Measure Momentum;
- Board Canvas write/edit;
- Reference Images runtime;
- AI/OCR/CV;
- Photo Markup / Repair Map / Visual Trace Shape Assist;
- validator behavior;
- materializer behavior;
- schema or JSON schema files;
- `tools/event_writer_service.py` behavior unless separately scoped;
- platform/generated/assets/samples/tags/releases.

## Required future tests

Future implementation must add focused tests proving:

- Add button is disabled until required human-entered/confirmed component fields exist.
- Valid Add Component calls writer once.
- Generated event is only `component_created`.
- Actor/source/confirmation are correct.
- Candidate/template/photo/helper values do not auto-confirm identity.
- Package/footprint/template hints remain hints only.
- Writer validation failure shows not saved.
- Writer append/path/lock failure shows not saved.
- Idempotent existing result does not duplicate local UI state.
- No diagnosis/probability/verified/good/correct wording is introduced.
- No Board Canvas / Reference Images / Guided Helper write path exists.
- No Project ZIP changes occur.

## Boundaries preserved

- Human is the sensor. AI is the graph engine.
- `events.jsonl` remains canonical truth.
- `known_facts.json` remains projection/cache.
- AI/helper never authors canonical events/facts.
- No direct UI append to `events.jsonl`.
- No Add Component implementation in this pass.
- No Edit Component implementation.
- No Project ZIP changes.
- No Activity Timeline implementation.
- No Measure Momentum implementation.
- No Board Canvas write/edit path.
- No Reference Images runtime changes.
- No AI/OCR/CV, URL import, or source search.
- No schema, validator, materializer, or writer service behavior changes.
- No `board_graph.json` or `view_state.json` generation or acceptance.
- No diagnosis/probability/confidence/fault ranking.
- No net inference.
- No component identity confirmation from template, footprint, package, photo, visual, reference, helper, candidate, or AI context.
- No automatic second event.

## Route decision

- Current pass: `V2_ADD_COMPONENT_SCOPE_LOCK_PASS`
- Next recommended pass: `V2_ADD_COMPONENT_SCOPE_LOCK_POST_AUDIT_PASS`

Do not route directly to `V2_ADD_COMPONENT_PASS`.

## Validation plan

- `py -3 tools\validate_all.py`
- `git status --short --branch`
- `git diff --name-only`
- `git diff --check`
- artifact scan for forbidden `board_graph.json` / `view_state.json`

## Safe for commit/push

Pending validation.