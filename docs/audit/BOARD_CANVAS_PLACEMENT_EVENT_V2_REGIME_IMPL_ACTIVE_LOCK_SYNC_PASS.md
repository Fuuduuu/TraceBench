# BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS

## Mode

Docs-only active-lock sync.

## Goal

Arm the implementation allowlist for `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`.

## Baseline verification

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Expected HEAD verified: `62853c674790bb82469d65497a7b6e7d569e22ce` (`docs: record placement event V2 regime audit`)
- Route before this pass: current `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_SCOPE_LOCK_PASS`, next `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Scope-lock audit recorded in repo docs: `AUDIT_VERDICT: ACCEPT_AS_IS`; `SAFE_FOR_STAGING: YES`
- Tracked and cached diffs were clean before this docs-only active-lock sync.

## Implementation pass armed

`BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Implementation allowlist

- `schemas/events.schema.json`
- `tools/validate_events_jsonl.py`
- `tools/materialize_known_facts.py`
- `tests/test_validate_events_jsonl.py`
- `tests/test_materialize_known_facts.py`

## Implementation goal

Migrate `component_visual_placement_confirmed` to the V2/human event regime and prevent materializer drop of V2 human-authored placement events.

## Implementation boundaries

- Event-regime/projection plumbing only.
- Does not create a placement writer.
- Does not expose placement Confirm UI.
- Does not change Board Canvas renderer behavior.
- Visual contact layout remains separate future scope.
- AI never authors canonical placement events.
- `component_visual_placement_confirmed` must not represent electrical connectivity, net identity, measurement pin identity, confirmed contact layout, AI-authored fact, or visual contact/pad layout.

## Forbidden surfaces

- No Dart runtime edits.
- No Board Canvas UI edits.
- No Add Component writer edits.
- No placement writer service.
- No Confirm/Edit UI.
- No router edits.
- No `known_facts` schema change unless separately justified and stopped for human approval.
- No visual contact layout.
- No AI marker implementation.
- No `_incoming` staging.
- No sample/project fixture edits unless separately approved.

## Route state

- Current route: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_ACTIVE_LOCK_SYNC_PASS`
- Next route: `BOARD_CANVAS_PLACEMENT_EVENT_V2_REGIME_IMPL_PASS`

## Boundary confirmation

- No implementation changes.
- No runtime/test/schema/tool/materializer/validator/projection edits outside docs in this sync.
- No implementation allowlist beyond the five listed files.
- No staging, commit, or push by this pass.

## Validation commands

- `git status --short --branch`
- `git log --oneline --decorate -5`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Audit marker

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
