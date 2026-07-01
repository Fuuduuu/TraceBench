# PLACEMENT_V2_REGIME_DOCS_TRUTH_SYNC_PASS

## Mode

Tiny docs-only truth sync.

## Goal

Sync canonical docs with the accepted/pushed V2 placement event regime implementation and record newly discovered placement projection ordering/invalidation risks as known future work.

## Baseline verification

- Repository: C:\Users\Kasutaja\Desktop\TraceBench
- Branch: main
- Current route verified before this pass: `NEEDS_USER_DECISION`
- Latest closeout verified: `2c83a5c` (`docs: close out placement event V2 regime`)
- Recent accepted implementation verified: `fa85231045c8dadc3543a914ca173829a3272c4d` (`feat: support V2 placement event regime`)
- Tracked and cached diffs were clean before this docs-only truth sync, aside from known untracked scratch artifacts.

## Source audit recorded

`TRACEBENCH_FULL_APP_READONLY_AUDIT`

Key findings recorded:

- Baseline healthy: route `NEEDS_USER_DECISION`, lock released, tests green.
- V2 `component_visual_placement_confirmed` now validates and materializes.
- `schemas/events.schema.json` was not changed and remains V1-envelope schema.
- `docs/TRUTH_INDEX.md` and `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md` contained stale wording implying validator/materializer V2 placement migration was not implemented.
- Claude audit condition found remaining stale placement V2 regime wording in `docs/PROJECT_MEMORY.md`; fixed in this same pass.
- New protected risk found: mixed V1/V2 placement latest-wins can let older V1 sequence placements beat newer V2 human confirmations.
- New protected decision needed: whether `event_invalidated` should retract placement, or whether placement correction is only by writing a newer placement.
- No placement writer exists yet.
- No Board Canvas write/Confirm/Edit UI exists yet.

## Changed files / safe set

- `docs/TRUTH_INDEX.md`
- `docs/BOARD_VECTOR_CANVAS_AND_FOOTPRINT_LIBRARY_SPEC.md`
- `docs/PROJECT_MEMORY.md`
- `docs/AUDIT_INDEX.md`
- `docs/audit/PLACEMENT_V2_REGIME_DOCS_TRUTH_SYNC_PASS.md`

## Truth sync summary

- Updated stale placement V2 regime wording.
- Recorded that validator/materializer are now V2-capable for `component_visual_placement_confirmed`.
- Recorded that `schemas/events.schema.json` remains V1-envelope-only by design/current state.
- Recorded the same placement V2 regime status in `docs/PROJECT_MEMORY.md`.
- Recorded that no Dart placement writer exists yet.
- Recorded that no placement Confirm/Edit UI exists yet.
- Recorded that Board Canvas remains read-only.

## Open protected risks

- Mixed V1/V2 placement latest-wins ordering can drop a newer V2 human-authored placement when an older V1 placement has a higher `sequence`.
- `event_invalidated` currently does not retract `component_visual_placements`; future protected scope must decide whether placement invalidation is supported or correction is only by writing a newer placement confirmation.

## Route state

- Current route remains: `NEEDS_USER_DECISION`
- Next route remains: `NEEDS_USER_DECISION`
- No implementation is armed by this pass.

## Boundary confirmation

- No runtime edits.
- No test edits.
- No schema edits.
- No tool/materializer/validator edits.
- No writer edits.
- No sample/project fixture edits.
- No `_incoming` edits or staging.
- No implementation changes.
- No broad staging, commit, or push by this pass.

## Validation commands

- `git status --short --branch`
- `git log --oneline --decorate -5`
- `git diff --name-status`
- `git diff --cached --name-status`
- `git diff --check`
- `python tools/validate_all.py`

## Audit marker

`RETRO_CLAUDE_READY / DO_NOT_CLAIM_CLAUDE_REVIEW`
