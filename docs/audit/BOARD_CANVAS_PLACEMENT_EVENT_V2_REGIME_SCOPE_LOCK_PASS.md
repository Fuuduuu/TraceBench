# BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS

## Mode

Docs-only protected-surface scope-lock.

## Goal

Lock the future V2 event-envelope regime for `component_visual_placement_confirmed` before any placement writer/editor implementation.

## Baseline verification

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Latest closeout verified from git log: `b059278` (`docs: close out placement editor architecture decision`).
- Route before this pass: `NEEDS_USER_DECISION`.
- Tracked and cached diffs were clean before this docs-only scope-lock.

## Source review recorded

`ROUTE_REVIEW_COMPONENT_ADD_PLACEMENT_VISUAL_CONTACT_LAYOUT`

Findings recorded:

- `component_created` exists and confirms identity/existence only.
- `component_visual_placement_confirmed` is scaffolded in schema/materializer/validator.
- There is no Dart placement writer and no sample event.
- Existing V2 writers use `actor.type = human` with source/confirmation blocks.
- Existing placement materializer path currently expects `actor.type = user`.
- This creates an actor/envelope contradiction that must be resolved before implementation.

## V2 regime decision summary

`component_visual_placement_confirmed` must align to the V2 event regime in a future protected implementation pass.

Locked direction:

- Use `schema_version: 2.0-draft`.
- Use `actor.type: human`.
- Use a source block.
- Use `confirmation.confirmed: true`.
- Use `client_operation_id` / idempotency precedent where applicable.
- Do not build a new V1 placement writer using `actor.type = user` plus `sequence` / `status`.
- Materializer must not silently drop V2 human-authored placement events.
- This decision does not implement the migration.

## Current V1 scaffold clarification

- Current schema/validator/materializer code remains unchanged by this pass.
- Current `schemas/events.schema.json` still declares a V1 envelope with required `sequence` and `status` fields.
- Existing placement projection behavior remains accepted repo behavior until a protected implementation changes it.
- The current V1 scaffold versus pending V2/human migration is now recorded as an implementation prerequisite.

## Future protected surfaces

Likely future implementation surfaces, subject to a separate active-lock sync and exact allowlist:

- `schemas/events.schema.json`
- `schemas/known_facts.schema.json`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- V2 event-type owner(s), if separate from validator/schema
- writer service and future Dart placement writer files
- focused validator/materializer/writer tests
- samples only if explicitly scoped

## Placement event semantics

`component_visual_placement_confirmed` should represent:

- `component_id`
- board side
- coordinate space
- center position
- `rotation_deg`
- `width` + `height` as primary visual envelope size model
- optional `template_id` / visual family reference
- human confirmation metadata

It must not represent:

- electrical connectivity
- net identity
- measurement pin identity
- confirmed contact layout
- AI-authored fact
- visual contact/pad layout

## Visual contact boundary

- Visual contact layout remains a separate future scope/event/projection.
- Contacts/pads/legs must not be folded into `component_visual_placement_confirmed`.
- Visual contact confirmation is not electrical confirmation.

## AI marker boundary

- AI/photo marker remains an unconfirmed proposal only.
- Human confirmation through the placement editor creates the canonical placement event.
- AI never authors canonical placement.

## Route state

- Current route: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`
- Next route: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`

## Boundary confirmation

- No runtime edits.
- No test edits.
- No schema edits.
- No tool edits.
- No writer edits.
- No materializer edits.
- No validator edits.
- No projection edits.
- No sample edits.
- No router edits.
- No `_incoming` staging or runtime dependency.
- No event implementation.
- No placement writer.
- No Confirm/Edit UI.
- No AI marker implementation.
- No broad staging, commit, or push by this pass.

## Validation commands

- `git status --short --branch`
- `git log --oneline --decorate -5`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit record

- `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`
- Pushed commit: `df6a64329544e5966847ff9c8b56818046259885` (`docs: lock placement event V2 regime`)
- Safe staging set from Claude:
  - `docs/CURRENT_STATE.md`
  - `docs/PASS_QUEUE.md`
  - `docs/ACTIVE_SCOPE_LOCK.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/TRUTH_INDEX.md`
  - `docs/PROJECT_MEMORY.md`
  - `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
  - `docs/audit/BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS.md`
- `RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`

## Audit marker

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
