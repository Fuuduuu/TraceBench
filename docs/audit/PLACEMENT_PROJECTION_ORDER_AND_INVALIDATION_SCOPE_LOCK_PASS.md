# PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS

## Pass metadata

- PASS_ID: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`
- Mode: docs-only protected-surface scope-lock
- Route before pass: `NEEDS_USER_DECISION`
- Route after pass:
  - Current: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS`
  - Next: `PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Baseline commit: `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`)

## Source audits / context recorded

- `TRACEBENCH_FULL_APP_READONLY_AUDIT`
- `TRACEBENCH_MARKDOWN_GOVERNANCE_AND_MEMORY_SYSTEM_AUDIT`
- `PLACEMENT_V2_REGIME_DOCS_TRUTH_SYNC_PASS`
- `TRACEBENCH_FILE_MAP_PASS`

## FILE_MAP audit-ledger sync

`TRACEBENCH_FILE_MAP_PASS` is recorded in `docs/AUDIT_INDEX.md` as accepted/pushed/audited:

- Commit: `dd0024450deb674dbb55d7ec71103f366f02a313` (`docs: add TraceBench file map`)
- Claude audit: `AUDIT_VERDICT: ACCEPT_AS_IS`
- `SAFE_FOR_STAGING: YES`
- Safe staging set:
  - `docs/FILE_MAP.md`
  - `docs/TRUTH_INDEX.md`
  - `docs/MEMORY_REGISTRY.yml`
  - `docs/SOURCES_INDEX_CURRENT.md`
  - `docs/AUDIT_INDEX.md`
  - `docs/audit/TRACEBENCH_FILE_MAP_PASS.md`

## Known facts locked

- V2 `component_visual_placement_confirmed` validator/materializer support is implemented.
- V2 placement events validate and materialize under:
  - `schema_version: 2.0-draft`
  - `actor.type: human`
  - `source.type: explicit_user_confirmation`
  - `confirmation.confirmed: true`
  - `client_operation_id`
  - width + height as the primary visual envelope size model
- `schemas/events.schema.json` remains V1-envelope-only by design/current state.
- No Dart placement writer exists yet.
- No placement Confirm/Edit UI exists yet.
- Board Canvas remains read-only.
- Visual contact layout remains separate future scope.
- AI never authors canonical placement events.

## Protected risks recorded

1. Mixed V1/V2 latest-wins risk: materializer behavior must not let an older V1 placement with a real `sequence` beat a newer V2 human-authored placement solely because V2 has no sequence.
2. Placement invalidation gap: `event_invalidated` must retract targeted placement events from `component_visual_placements` projection after implementation.
3. Future placement writer, Confirm UI, edit-placement flow, visual-contact layout, and AI marker conversion must not ship until these semantics are implemented and audited.

## Human decisions recorded

- Legacy V1 placement events remain first-class legacy events.
- The materializer must interleave V1 and V2 placement confirmations deterministically.
- Projection latest-wins uses stream order as the primary cross-regime ordering source, not V1 `sequence` alone.
- A later event in `events.jsonl` supersedes an earlier placement for the same component when both are valid accepted/human-confirmed placements.
- V1 `sequence` must not beat a later V2 human confirmation solely because V2 has no sequence.
- `event_invalidated` retracts a confirmed placement event if it targets that placement event.
- A retracted placement event no longer contributes to `component_visual_placements`.
- If a newer non-invalidated placement exists for the same component, projection uses that newest valid placement.
- If no valid non-invalidated placement remains, that component has no projected placement.
- Placement correction remains append-only through newer `component_visual_placement_confirmed` events.
- Do not create a new placement-updated event type for this fix.
- Do not fold contact layout, electrical connectivity, pin identity, net identity, AI-authored facts, pads, contacts, or visual-contact layout into placement projection.

## Future implementation allowlist

Likely future implementation allowlist:

- `tools/materialize_known_facts.py`
- `tests/test_materialize_known_facts.py`

Optional validator/test owner only if a later active-lock sync proves validator behavior must change. Default expectation is materializer + materializer tests only.

## Future implementation test requirements

- Later V2 placement beats earlier V1 placement for the same component.
- Later V1 placement still beats earlier V2 when stream order says so.
- `event_invalidated` retracts a targeted placement event.
- Invalidating an older placement does not remove a newer valid placement.
- Invalidating the newest placement falls back to the previous valid placement or removes projected placement if none remains.
- Materializer uses deterministic stream order / event index for placement latest-wins across V1 and V2.
- Materializer accounts for `event_invalidated` targeting placement event IDs.

## Forbidden surfaces

- No runtime Dart edits.
- No Board Canvas UI edits.
- No placement writer.
- No Confirm/Edit UI.
- No router edits.
- No schema edits.
- No `tools/validate_events_jsonl.py` edits in this scope-lock.
- No `known_facts` schema edits.
- No visual contact layout.
- No contacts/pads/legs rendering.
- No AI marker implementation.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No FILE_MAP redesign.
- No broad docs cleanup.
- No audit file moves/deletes.
- No implementation.
- No broad staging, commit, or push.

## Changed files

- `docs/CURRENT_STATE.md`
- `docs/PASS_QUEUE.md`
- `docs/ACTIVE_SCOPE_LOCK.md`
- `docs/TRUTH_INDEX.md`
- `docs/PROJECT_MEMORY.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_PROJECTION_ORDER_AND_INVALIDATION_SCOPE_LOCK_PASS.md`

## Validation plan

- `git status --short --branch`
- `git log --oneline --decorate -10`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Claude audit packet marker

RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW
